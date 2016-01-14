#!/usr/bin/perl -w



use strict;

print "\n Enter a sequence and press return.\n";

my $seq = <>;

chomp $seq;

print "\nThe length of the sequence is : ", length($seq), "\n";

my $compSeq = "";

my %comp = (
     A => "T",
     C => "G",
     G => "C",
     T => "A",
     N => "N"
);

for (my $i = 0; $i < length($seq); $i++) {

    my $base = substr($seq, $i, 1);
    my $compBase = $comp{$base};
    
    $compSeq .= $compBase;
}

print "\nThe full complement sequence is : ", $compSeq, "\n";

my $revComp = reverse($compSeq);

print "\nThe reverse complement of the sequence is :\n";
print "\n $revComp \n";
