# Skeleton LandingPage

[![N|Solid](http://www.i-programmer.info/images/stories/News/2016/Oct/A/yarnicon.jpg)](https://yarnpkg.com/)

Este Skeleton está usando [Yarn][Yarn] como manejador de paquetes y [Gulp][Gulp] como gestor de tareas

> Se esta usando Yarn como gestor de dependencias por la velocidad y manejo de modulos offline(cache) a comparacion de Npm.

### Dependencias
* Pug
* Sass
* CoffeScript
* ECMAScript 2015
* ImagenMin
* Browser-sync
* EditorConfig (para Sublime Text3, Atom, Brackets instalar el [plugin](http://editorconfig.org/#download) oficial previamente)

### Plugins
* [jQuery] - version: 1.11.3
* [Modernizr] - version 2.6.3
* [Owl Carousel][owl] - version 1.3.2
* [Bootstrap][bootstrap] - version 3.3.5
* [jQuery Validate][jvalidate] - version 1.13.1
* [jQuery Alphanum][alphanum]

### Instalacion

Instalar [Yarn](https://nodejs.org/) de manera global siguiendo los pasos del
[Instalador](https://yarnpkg.com/en/docs/install) oficial para macOS, Windows, Linux

**Para agregar o remover dependencias**
```sh
$ yarn add [package]
$ yarn remove [package]
$ yarn add [package] --dev
```
**Para pasar a produccion usar la variable de entorno --env=prod**

```sh
$ gulp --env=prod
```

> Se puede trabajar con **npm-instal** de la manera normal, pero, es algo lento =D

Para mayor detalle verificar `package.json` y `gulpfile.js` para saber las tareas existentes.

**Server Local generado**

```sh
http://localhost:3030
```



License
----

MIT



**by Javier Castro**

   [git-repo-url]: <https://github.com/joemccann/dillinger.git>
   [bootstrap]: <http://getbootstrap.com/>
   [jQuery]: <http://jquery.com>
   [modernizr]: <https://modernizr.com/>
   [Gulp]: <http://gulpjs.com>
   [Yarn]: <https://yarnpkg.com/>
   [owl]: <http://owlgraphic.com/owlcarousel/>
   [jvalidate]: <https://jqueryvalidation.org/>
   [alphanum]: <http://github.com/KevinSheedy/jquery.alphanum>
