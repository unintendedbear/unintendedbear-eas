#!usr/bin/perl

use 5.012;
use warnings;
use Algorithm::Evolutionary::Simple qw( random_chromosome );
use Carp qw(croak);
use Time::HiRes qw(gettimeofday tv_interval);


my $long = shift || croak "Introduce la longitud del cromosoma";
my $tamanio = shift || croak "Indica un tamaño de población";

my @poblacion = ();
my @otra_poblacion = ();
my $cromosoma;
my @otro_cromosoma;

my ($s0, $us0) = [gettimeofday];
for my $cada_uno (0 .. $tamanio) {
	$cromosoma = random_chromosome($long);
	push (@poblacion, $cromosoma);
}
my ($s1, $us1) = [gettimeofday];
# 10 es el número de genes que codifican al cromosoma, es una cadena de texto
my $tiempo_generacion_cromosoma = tv_interval (($s0, $us0), ($s1, $us1));

my ($s2, $us2) = [gettimeofday];
for my $cada_uno (0 .. $tamanio) {
	@otro_cromosoma = mi_cromosoma($long);
	push (@otra_poblacion, @otro_cromosoma);
}
my ($s3, $us3) = [gettimeofday];
my $tiempo_generacion_otro_cromosoma = tv_interval (($s2, $us2), ($s3, $us3));

print "Comparativa:\n============\n1. $cromosoma\n2. @otro_cromosoma\n";
print "Tiempos:\n=======\n1. $tiempo_generacion_cromosoma\n2. $tiempo_generacion_otro_cromosoma\n";

sub mi_cromosoma {
	my $longitud = shift;
	my @cadena = ();
	for my $i (0 .. $longitud) {
		$cadena[$i] = int(rand(2));
	}
	return @cadena;
}
