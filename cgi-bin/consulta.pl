#!/usr/bin/perl
use strict;
use warnings;
use CGI;
use Text::CSV;

# Configurar encabezado para contenido HTML
print "Content-type: text/html\n\n";

# Obtener datos del formulario
my $cgi = CGI->new;
my $nombre_universidad = $cgi->param("nombre_universidad") || '';
my $periodo_licenciamiento = $cgi->param("periodo_licenciamiento") || '';
my $departamento_local = $cgi->param("departamento_local") || '';
my $denominacion_programa = $cgi->param("denominacion_programa") || '';

# Procesar el archivo CSV con Text::CSV
my $csv = Text::CSV->new({ binary => 1, auto_diag => 1, eol => $/ });
open my $fh, "<", "Programas de Universidades.csv" or die "No se puede abrir el archivo CSV: $!";

while (my $row = $csv->getline($fh)) {
    if (
        $row->[0] =~ /$nombre_universidad/i &&
        $row->[1] =~ /$periodo_licenciamiento/i &&
        $row->[2] =~ /$departamento_local/i &&
        $row->[3] =~ /$denominacion_programa/i
    ) {
        # Imprimir resultados
        print "<p>Nombre Universidad: $row->[0]</p>";
        print "<p>Periodo Licenciamiento: $row->[1]</p>";
        print "<p>Departamento Local: $row->[2]</p>";
        print "<p>Denominación Programa: $row->[3]</p>";
        print "<hr>";
    }
}

# Cerrar el archivo CSV
close $fh;