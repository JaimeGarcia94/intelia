Este repositorio permite a los usuarios subir imágenes para ser procesadas en segundo plano, aplicándoles un filtro de escala de grises con una tarea que se ejecuta de manera asíncrona usando RabbutMQ.

<h1>Infraestructura usada</h1>
<ul>
  <li>Symfony 6.4</li>
  <li>Docker</li>
  <ul>
    <li>PHP 8.2</li>
    <li>NGINX</li>
    <li>MySQL 8</li>
    <li>RabbitMQ</li>
  </ul>
</ul>

<h1>Instalación</h1>
Para ejecutar el proyecto en local con docker tendrá que lanzar los siguientes comandos:
<ul>
  <li>Usar <code>docker-compose</code></li>
  <ul>
    <li>Añadir el parametro <code>-d</code> para que el proceso corra en segundo plano</li>
    <li>Añadir el parametro <code>--build</code> la <strong>primera vez</strong> para construir las imágenes</li>
    <li>Añadir la clave <code>down</code> para detener los contenedores</li>
  </ul>
</ul>

<code># Build & up. Ejecutar el comando desde la carpeta raíz del proyecto
docker-compose up -d --build
</code>

Para acceder al contenedor habría que usar el siguiente comando (el nombre del contenedor está definido en el fichero <strong>docker-compose.yml</strong>)
<code>docker exec -it $container_name bash</code>

<h1>¿Cómo funciona?</h1>
Tienes hasta 4 contenedores ejecutandose: PHP, NGINX, MySQL y RABBITMQ. Para comprobar que los contenedores están corriendo puedes usar el siguiente comando:
<code>docker ps</code>
<p><a href="http://localhost/login">Página de bienvenida de la aplicación</a></p>
<p>Bien si se utilizan los usuarios ya creados. En este caso solo tiene datos la BD el usuario: "pruebas@gmail.com" con contraseña: "12345678". Sino siempre se puede crear un nuevo usuario en 
la pantalla de registro.</p>
<p>Para ejecutar el mensaje asíncrono de RabbitMQ tendrás que acceder al contenedor de PHP y lanzar el siguiente comando: php bin/console messenger:consume async -vv. Y para acceder
a la interfaz gráfica de RabbitMQ tendrías que <a href="http://localhost:15672">clickar aquí</a> con el usuario: "guest" y contraseña: "guest"</p>
