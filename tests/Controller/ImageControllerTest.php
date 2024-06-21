<?php

declare(strict_types=1);

namespace App\Tests\Controller;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Response;

class ImageControllerTest extends WebTestCase
{
    public function testIndex()
    {
        $client = static::createClient();
        $client->request('GET', '/image');

        $this->assertSelectorTextContains('h5', 'Sube tu imagen');
        $this->assertSelectorTextContains('h6', 'Solo puedes subir imagenes con las siguientes extensiones: .jpg, .jpeg, .png');
        $this->assertResponseIsSuccessful();
    }

    public function testUpload()
    {
        $client = static::createClient();
        $file = new UploadedFile(
            __DIR__.'/../Fixtures/modal-667552c829737.png',
            null,
            true
        );

        $client->request('POST', '/upload', [], ['file-upload' => $file]);
        $this->assertResponseStatusCodeSame(Response::HTTP_OK);
    }

    public function testDownload()
    {
        $client = static::createClient();
        $client->request('GET', '/download', ['filename' => 'modal-667552c829737.png']);
        $this->assertResponseIsSuccessful();
        $response = $client->getResponse();
        $this->assertTrue($response->headers->contains('Content-Disposition', 'attachment; filename="modal-667552c829737.png"'));
    }
}