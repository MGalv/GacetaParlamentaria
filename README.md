# [Gaceta Parlamentaria](http://gaceta.diputados.gob.mx/)

## Objetivo

Gaceta Parlamentaria es un proyecto creado para el evento de [OpenDataMX](http://opendata.mx/), el cuál tiene como objetivo el facilitar el acceso a la información contenida en la gaceta, de manera que esta sea digerible y entendible.

## La aplicación

Esta se encuentra dividida en dos partes.

* La primera, se refiere a una serie de tareas las cuales te permiten cargar la información contenida en la gaceta parlamentaria del año 2009 al 2011.

Estas tareas son:

rake opendata:commissions # Tepermite cargar las comisiones del pleno.
rake opendata:gazettes # Esta tarea carga las gacetas divididas por secciones.
rake opendata:pronouncements # Esta tarea te permite cargar los dictamenes que se incluyen en la gaceta, junto con sus respectivos estados y resoluciones.


* La segunda, es una API ligera la cual te regresa la información de las gacetas procesada en formato JSON.

Esta se solicita de la siguiente manera mediante una petición de tipo GET:

http://gacetaparlamentaria.heroku.com/gacetas.json

Puedes visitar la aplicación en Heroku [aquí](http://gacetaparlamentaria.heroku.com/). 

# ToDo

La funcionalidad que quedó pendiente es la siguiente:

* Cargar la información relacionada con Proposiciones, Acuerdos, Actas, Informes, Planes, Asistencias mediante tareas de carga de datos.
* Generar mas plantillas de consulta dentro de la API (Por dictamenes, restringir por fechas).
* Representación gráfica de los datos mediante el uso de herramientas estadísticas.