Sesión del 03-04-14
==================

Cuando queremos hacer un `fork` de un repositorio:

1. En la página de https://github.com del repositorio, le damos a `fork`. El repositorio quedará así copiado en nuestra cuenta de GitHub.
2. Como cualquier repositorio nuestro, obtenemos el enlace para clonarlo (por HTTPS o por SSH).
3. Ya en nuestro directorio de git local, hacemos `git clone` con la dirección que hemos obtenido.
4. Realizamos los cambios necesarios, hacemos `git commit` y `git push`.
5. Después hacemos `pull request` para que el creador del repositorio del que hicimos los cambios, nos autorice los nuestros.

Pero, ¿qué pasa cuando otros usuarios o el propio creador del repositorio hacen cambios?
Primero, con la siguiente orden:

`git remote add upstream https://github.com/JJ/implementacion-eas.git`

Le estaríamos diciendo a git que queremos añadir un repositorio remoto que llamamos _upstream_ y que tiene la dirección que le hemos puesto, que en este caso es la dirección del repositorio del que hemos hecho el `fork`.

Y a continuación hacemos lo siguiente:

`git pull upstream master`

Para decirle a git que haca un pull pero teniendo en cuenta que el repositorio master es el que hemos definido anteriormente.
