<?php

namespace App\MessageHandler;

use App\Message\ProcessImageMessage;
use App\Repository\ImageRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Messenger\Handler\MessageHandlerInterface;
use DateTime;

class ProcessImageHandler implements MessageHandlerInterface
{
    private $imageRepository;
    private $em;

    public function __construct(ImageRepository $imageRepository, EntityManagerInterface $em)
    {
        $this->imageRepository = $imageRepository;
        $this->em = $em;
    }

    public function __invoke(ProcessImageMessage $message)
    {
        $image = $this->imageRepository->find($message->getImageId());

        if (!$image) {
            return;
        }

        $imagePath = __DIR__ . '/../../public/uploads/' . $image->getFileName();

        if (!file_exists($imagePath)) {
            return;
        }

        // Abrir la imagen
        $img = imagecreatefromstring(file_get_contents($imagePath));
        if (!$img) {
            return;
        }

        // Aplicar filtro de escala de grises
        imagefilter($img, IMG_FILTER_GRAYSCALE);

        // Guardar la imagen
        $grayscaleImagePath = __DIR__ . '/../../public/uploads/grayscale_' . $image->getFileName();
        imagejpeg($img, $grayscaleImagePath);
        imagedestroy($img);

        // Actualizar el estado de la imagen en la base de datos
        $image->setStatus('Completed');
        $image->setModifiedAt(new DateTime());
        $this->em->persist($image);
        $this->em->flush();
    }
}