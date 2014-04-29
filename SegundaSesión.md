Sesión del 10-04-14
==================

He instalado [Algorithm::Evolutionary::Simple] (http://search.cpan.org/~jmerelo/Algorithm-Evolutionary-Simple-0.1.1/lib/Algorithm/Evolutionary/Simple.pm) para Perl.

En mi script: `EA_Paloma.pl` realizo una comparativa entre el módulo anterior y mi propia manera de generar cromosomas y poblaciones.

El módulo genera cromosomas de un determinado número de genes (a elegir) y lo devuelve en forma de cadena de caracteres. Por otro lado, yo he decidido crear un array del tamaño de genes y en cada posición un gen que aleatoriamente es 0 ó 1.

###### Algorithm::Evolutionary::Simple

```perl
sub random_chromosome {
  my $length = shift;
  my $string = '';
  for (1..$length) {
    $string .= (rand >0.5)?1:0;	
  }
  $string;
}
```

###### Implementación Paloma

```perl
sub mi_cromosoma {
  my $longitud = shift;
  my @cadena = ();
  for my $i (0 .. $longitud) {
    $cadena[$i] = int(rand(2));
  }
  return @cadena;
}
```

Los tiempos de generación se han medido así:

```perl
my ($s0, $us0) = [gettimeofday];
#Generación de población
my ($s1, $us1) = [gettimeofday];
my $tiempo_generacion_cromosoma = tv_interval (($s0, $us0), ($s1, $us1));
```

Entonces, el programa se llama de la manera: `EA_Paloma.pl numero_genes tamaño_población` y se obtienen dos poblaciones de individuos, de tamaño `tamaño_población` y con `numero_genes` genes.

Los tiempos que se obtienen son:

 Tamaño población | Algorithm::Evolutionary::Simple    | Implementación Paloma
------------------|------------------------------------|------------------------
 	100 	  |		0.000294 segundos      | 0.000442 segundos 
 	1000 	  |  		0.00216 segundos       | 0.004022 segundos 
 	10000	  |  		0.022526 segundos      | 0.037748 segundos 

Como conclusión, se obtienen tiempos más grandes cuando se generan las poblaciones con los individuos expresados como arrays.

Sesión del 29-04-14
==================

Fitness es la función que definimos para escoger qué individuos son mejores. En este caso estamos eligiendo como mejor individuo aquel que se genere con un mayor número de unos. Vamos a enfrentar dos maneras de calcular `MAX_ONE`, la propia de `Algorithm::Evolutionary::Simple` y una segunda propuesta por mí. 

###### Algorithm::Evolutionary::Simple

```perl
sub max_ones {
  my $str=shift;
  my $count = 0;
  while ($str) {
    $count += chop($str);
  }
  $count;
}
```

###### Implementación Paloma

```perl
sub mi_fitness {
  my $cadena = shift;
  my @contador = ($cadena =~ /1/g);
  return @contador;
}
```

Se ha comprobado los tiempos en medir el fitness de una población en su generación. La población es de 100 individuos y lo que se va cambiando es la cantidad de genes del individuo.

Los tiempos que se obtienen son:

 Tamaño cromosoma | Algorithm::Evolutionary::Simple    | Implementación Paloma
------------------|------------------------------------|------------------------
 	10 	  |		0.000133 segundos      | 0.000244 segundos 
 	100 	  |		0.00081 segundos       | 0.001553 segundos 
 	1000 	  |  		0.008078 segundos      | 0.015832 segundos 
 	10000	  |  		0.091047 segundos      | 0.151987 segundos 

Por tanto, el uso de expresiones regulares, aunque haga el método más corto, hace que suba el tiempo de ejecución.





