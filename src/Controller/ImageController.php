<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Doctrine\ORM\EntityManagerInterface;
use DateTime;
use App\Entity\Image;
use App\Message\ProcessImageMessage;
use Symfony\Component\Messenger\MessageBusInterface;

class ImageController extends AbstractController
{
    private $em;
    private $bus;

    public function __construct(EntityManagerInterface $em, MessageBusInterface $bus)
    {
        $this->em = $em;
        $this->bus = $bus;
    }

    #[Route('/image', name: 'app_image')]
    public function index(): Response
    {
        return $this->render('image/index.html.twig', [
            'controller_name' => 'ImageController',
        ]);
    }

    #[Route('/upload', name: 'app_upload_image')]
    public function upload(Request $request): Response
    {
        $user = $this->getUser();
        $image = new Image();
        $file = $request->files->get('file-upload');
        
        if (!$file instanceof UploadedFile) {
            return new Response('No file uploaded or invalid file.', Response::HTTP_BAD_REQUEST);
        }

        $allowedExtensions = ['jpg', 'jpeg', 'png'];
        $extension = $file->guessExtension();

        if (!in_array($extension, $allowedExtensions)) {
            return new Response('Invalid file type.', Response::HTTP_BAD_REQUEST);
        }

        $uploadDir = $this->getParameter('upload_directory');
        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = transliterator_transliterate('Any-Latin; Latin-ASCII; [^A-Za-z0-9_] remove; Lower()', $originalFilename);
        $newFilename = $safeFilename.'-'.uniqid().'.'.$extension;

        try {
            $file->move($uploadDir, $newFilename);
        } catch (FileException $e) {
            return new Response('Failed to upload file.', Response::HTTP_INTERNAL_SERVER_ERROR);
        }

        $image->setUser($user);
        $image->setFileName($newFilename);
        $image->setStatus('Pending');
        $image->setCreatedAt(new DateTime());
        $image->setModifiedAt(null);
        $this->em->persist($image);
        $this->em->flush();

        // Enviar el mensaje para procesar la imagen
        $this->bus->dispatch(new ProcessImageMessage($image->getId()));

        return new Response('File successfully uploaded.', Response::HTTP_OK);
    }
}
