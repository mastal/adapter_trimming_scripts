#!/usr/bin/perl -w 

# Maria Stalteri
# 19/09/2013
# findAdapters.pl

# automate finding and counting adapter sequences in Illumina
# fastq files using grep;

# 1. read in the adapter sequences from a file:
# 2. specify file to print the results to;
# 3. get list of fastq files to scan from the command line;
#    for trimmomatic output there should be 4 files, for 
#    palindrome trimming there may be only 3 files;


use strict;

unless (scalar(@ARGV == 6)) {
     die "\nUsage: $0 file_with_adapter_seqs output_file fastq_files\n\n"; 
 
}



# get command line parameters:

my $adaptInFile =  $ARGV[0];
my $resultsFile = $ARGV[1];

# my $read1Paired = $ARGV[2];
# my $read2Paired = $ARGV[3];
# my $readiUnp = $ARGV[4];
# my $read2Unp = $ARGV[5];

my @fastqFiles;
$fastqFiles[0] = $ARGV[2];
$fastqFiles[1] = $ARGV[3];
$fastqFiles[2] = $ARGV[4];
$fastqFiles[3] = $ARGV[5];
# $fastqFiles[4] = $ARGV[2];
# $fastqFiles[5] = $ARGV[3];
# $fastqFiles[6] = $ARGV[4];
# $fastqFiles[7] = $ARGV[5];

# open Filehandle for reading adapters  
open(ADAPTIN, "<$adaptInFile")
    or die "\nUnable to open input file $adaptInFile\n\n";


# open filehandle for printing
open(OUT, ">$resultsFile")
    or die "\nUnable to open input file $resultsFile\n\n";

# print header lines;
print OUT "Adapter_seq\tSeq_len\tR1P\tR2P\tR1U\tR2U\t";
print OUT "5'_R1P\t5'_R2P\t5'R1U\t5'_R2U\n";   

my @adapters;

while (my $line = <ADAPTIN>){
    chomp $line;
    my $adaptLen = length($line);
    $line .= "_$adaptLen";
    push @adapters, $line;
}

# close filehandle for reading adapters;
close(ADAPTIN)
    or die "\nUnable to close input file $adaptInFile\n\n";


# this works;
# print to screen so I know it is running the right sequences;
foreach my $seq (@adapters){
    print "$seq\n";
}

# do the grep on each sequence:
foreach my $adapterSeq (@adapters){
    # remove the sequence length
    my @searchSeq = split /_/, $adapterSeq, 2;
    print OUT  "$searchSeq[0]\t$searchSeq[1]\t";
    
    # note that the values returned by grep end with a \n    
    foreach my $fastq (@fastqFiles) {
        my $noOfMatches = `grep -c ${searchSeq[0]} ${fastq}`;
        chomp $noOfMatches;
        print "The number of adapters found is: $noOfMatches\n";
        print OUT "$noOfMatches\t";

    }

    # now do grep for matches at 5' end of sequence
    foreach my $fastq (@fastqFiles) {
        my $noOfMatchesAtStart = `grep -c ^${searchSeq[0]}  ${fastq}`;
        chomp $noOfMatchesAtStart;
        print "The number of adapters found is: $noOfMatchesAtStart\n";
        print OUT "$noOfMatchesAtStart\t";

    }
    
    print OUT "\n";
}

# close filehandle for output
close(OUT)
    or die "\nUnable to close output file $resultsFile\n\n";

