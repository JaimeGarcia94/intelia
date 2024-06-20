<?php

namespace App\Repository;

use App\Entity\Image;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @extends ServiceEntityRepository<Image>
 */
class ImageRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Image::class);
    }

    /**
    * @return Image[] Returns an array of Image objects
    */
    public function findByImages($user): array
    {
        return $this->createQueryBuilder('w')
                ->andWhere('w.user = :user')
                ->orderBy('w.id','asc')
                ->setParameter('user', $user)
                ->getQuery()
                ->getResult()
        ;
    }
}
