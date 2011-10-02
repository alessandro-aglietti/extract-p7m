#!/usr/bin/perl
#
#    extract-pdf-p7m.pl
#    Copyright (C) 2011  Nicola Inchingolo
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

use strict;
use warnings;

##COSTANTI/PARAMETRI
my $BUFFER_SIZE = 65536;

my $current_dir;
opendir ($current_dir, ".") or die $!;
while (my $file = readdir($current_dir)) {

    if ($file =~ /(.*\.pdf)(\.p7m)*/) {    
        my $nomefile_pdf = $1;
        my $nomefile_p7m = $file;
        extractPdfFile($nomefile_p7m, $nomefile_pdf);
    }

}
closedir $current_dir;

print "\n";
print "+-----------------------------------------------------+\n";
print "| ESTRAZIONE COMPLETATA (premere un tasto per uscire) |\n";
print "+-----------------------------------------------------+\n";
<STDIN>;

sub findLastEOF {
    my $file_input;
    my $file_input_name = shift;
    my $file_input_size = -s $file_input_name;
    
    open $file_input, "<$file_input_name";
    binmode $file_input;
    
    my $pos = 5;
    
    while ($pos < $file_input_size) {
        seek $file_input, -$pos, 2; #seek from end of file
        my $eof_buffer;
        read($file_input, $eof_buffer, 5);
        
        if ($eof_buffer eq "%%EOF") {
            my $start_pos = $pos - 5;
            #print "----$eof_buffer--pos:$start_pos\n";
            return $start_pos;
        }
        
        $pos++;
    }
    
    close $file_input;
}

sub findFirstPDF {
    my $file_input;
    my $file_input_name = shift;
    my $file_input_size = -s $file_input_name;
    
    open $file_input, "<$file_input_name";
    binmode $file_input;
    
    my $pos = 4;
    
    while ($pos < $file_input_size) {
        seek $file_input, $pos, 0;
        my $pdf_buffer;
        read($file_input, $pdf_buffer, 4);
        
        if ($pdf_buffer eq "%PDF") {
            #print "----$pdf_buffer--pos:$pos\n";
            return $pos;
        }
        
        $pos++;
    }
    
    close $file_input;
}

sub extractPdfFile {
    my $file_input_name = shift;  # a.pdf.p7m
    my $file_output_name = shift; # a.pdf
    
    my $skip_start = findFirstPDF($file_input_name);
    my $skip_end = findLastEOF($file_input_name);
    
    if ($skip_start > 1 && $skip_end > 4) {
        ##print "Estrazione file: $file_input_name....";
        print ">$file_output_name<\n";
        
        my $file_input_size = -s $file_input_name;
        my $file_output_size = ($file_input_size - $skip_start - $skip_end);
        my ($file_input, $file_output, $buffer);
        open $file_input, "<$file_input_name";
        open $file_output, ">$file_output_name";
        
        binmode $file_input;
        binmode $file_output;
        
        ##print "SIZEEEEEEEEE: $file_input_size\n";
        
        read($file_input, $buffer, $skip_start); # read in (up to) 64k chunks, write
            
        my $blocks_copied = 0;
        my $blocks_number = int ( $file_output_size / $BUFFER_SIZE );
        
        #il read non lo deve fare se supero il numero di blocchi, lo metto come seconda condizione
        while ($blocks_copied < $blocks_number && read ($file_input, $buffer, $BUFFER_SIZE)) {	# read in (up to) 64k chunks
            print $file_output $buffer;
            $blocks_copied++;
            ##print "COPIED: $blocks_copied, NUM: $blocks_number\n";
        };
        
        my $last_BUFFER_SIZE = ($file_output_size - ($blocks_copied * $BUFFER_SIZE));
        read ($file_input, $buffer, $last_BUFFER_SIZE);
        print $file_output $buffer;
        ##print "LAAST_::: $last_BUFFER_SIZE\n";
        
        close $file_output;
        close $file_input;
        #cancello il file di input
        unlink $file_input_name;
        ##print " OK\n";

    }
}
