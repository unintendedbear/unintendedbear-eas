#!usr/bin/perl

use 5.012;
use warnings;
use Algorithm::Evolutionary::Simple qw( random_chromosome max_ones 
                                        get_pool_roulette_wheel produce_offspring single_generation);
use Carp qw(croak);
use Time::HiRes qw(gettimeofday tv_interval);


my $long = shift || croak "Introduce la longitud del cromosoma";
my $tamanio = shift || croak "Indica un tamaño de población";

my @poblacion = ();
my @otra_poblacion = ();
my $cromosoma;
my @otro_cromosoma;

my ($s0, $us0) = [gettimeofday];
for my $cada_uno (1 .. $tamanio) {
	$cromosoma = random_chromosome($long);
	push (@poblacion, $cromosoma);
}
my ($s1, $us1) = [gettimeofday];
# 10 es el número de genes que codifican al cromosoma, es una cadena de texto
my $tiempo_generacion_cromosoma = tv_interval (($s0, $us0), ($s1, $us1));

my ($s2, $us2) = [gettimeofday];
for my $cada_uno (1 .. $tamanio) {
	@otro_cromosoma = mi_cromosoma($long);
	push (@otra_poblacion, @otro_cromosoma);
}
my ($s3, $us3) = [gettimeofday];
my $tiempo_generacion_otro_cromosoma = tv_interval (($s2, $us2), ($s3, $us3));

print "Comparativa:\n============\n1. random_chromosome() \n2. mi_cromosoma()\n";
print "Tiempos:\n=======\n1. $tiempo_generacion_cromosoma\n2. $tiempo_generacion_otro_cromosoma\n";

# Elegimos random_chromosome()
# Cálculo fitness

my @fitness = ();
my @otro_fitness = ();

my ($s4, $us4) = [gettimeofday];
foreach my $cada_uno (@poblacion) {
	push (@fitness, max_ones($cada_uno));
}
my ($s5, $us5) = [gettimeofday];
my $tiempo_fitness = tv_interval (($s4, $us4), ($s5, $us5));

my ($s6, $us6) = [gettimeofday];
foreach my $cada_uno (@poblacion) {
	my @c = mi_fitness($cada_uno);
	push (@otro_fitness, $#c+1);
}
my ($s7, $us7) = [gettimeofday];
my $tiempo_mi_fitness = tv_interval (($s6, $us6), ($s7, $us7));

print "Fitness:\n============\n1. max_ones() @fitness\n2. mi_fitness() @otro_fitness\n";
print "Tiempos:\n=======\n1. $tiempo_fitness\n2. $tiempo_mi_fitness\n";


sub mi_cromosoma {
	my $longitud = shift;
	my @cadena = ();
	for my $i (0 .. $longitud) {
		$cadena[$i] = int(rand(2));
	}
	return @cadena;
}

sub mi_fitness {
	my $cadena = shift;
	my @contador = ($cadena =~ /1/g);
	return @contador;
}


#Generación = iteración del bucle.

