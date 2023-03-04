#!/usr/bin/env perl
use warnings;
use LWP::Simple;
use utf8;
use strict;
use IO::Compress::Gzip qw(gzip $GzipError) ;

# https://www.gov.spb.ru/covid-19/

my @files = qw( ../downloads/gov.spb.ru.covid-19.raw.txt ../downloads/gov.spb.ru.covid-19.single_line.txt ../downloads/gov.spb.ru.covid-19.new_lines.txt );
unlink @files;
# unlink @files or die "Could not delete all of the files in @files\n";

# Fetching webpage;

# open(RAW, '>>../downloads/gov.spb.ru.covid-19.raw.txt') or die $!;
# 	print RAW get("https://www.gov.spb.ru/covid-19/");
# close RAW;

system("wget 'https://www.gov.spb.ru/covid-19/' -o wget.log -O ../downloads/gov.spb.ru.covid-19.raw.txt");

open(SRC00, '<../downloads/gov.spb.ru.covid-19.raw.txt') or die $!;
open(TGT00, '>>../downloads/gov.spb.ru.covid-19.single_line.txt') or die $!;
	while(<SRC00>){
		s/\n|\r//g;
		print TGT00 $_;
	}
close TGT00;
close SRC00;

# Preparing for data extraction and archiving;

open(SRC010, '<../downloads/gov.spb.ru.covid-19.single_line.txt') or die $!;
open(TGT011, '>>../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(TGT012, '>>../downloads/gov.spb.ru.covid-19.archived.txt') or die $!;
	while(<SRC010>){
		s/.*\<div class\=\"block content\"\>|\<section class\=\"col-lg-6\"\>.*//g;
		s/(?<=\d)\xe2\x80\xaf(?=\d)|(?<=\d) (?=\d)| (?=\<\/b\>)//g;
		s/\&nbsp\;/ /g;
		s/\&\#8209\;/\-/g;
		print TGT011 $_;
		s/\<.*?\>/ /g;
		print TGT012 $_, "\n";
	}
close TGT012;
close TGT011;
close SRC010;

my $DD = "";
my $MM = "";
my $YYYY = "";

# my $PCRLABS = "";
# my $PCRPOINTS = "";
# my $PCRTESTS = "";

# Extracting variables one by one;

open(SRC020, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(DATE, '>>../downloads/gov.spb.ru.covid-19.extracted.DATE.txt') or die $!;
	while(<SRC020>){
		if($_ =~ m/(\d\d).(\d\d).(\d\d\d\d)\<\/b\>\<\/h1\>/){
		$DD = $1;
		$MM = $2;
		$YYYY = $3;
		print DATE $YYYY, '-', $MM, '-', $DD, "\n";
		}
		else{
		print DATE "NA\n";
		}
	}
close DATE;
close SRC020;

open(SRC021, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(CONFIRMED, '>>../downloads/gov.spb.ru.covid-19.extracted.CONFIRMED.txt') or die $!;
	while(<SRC021>){
		if($_ =~ m/\<b\>(\d+)\<\/b\>\<\/span\> \<span style\=\"font\-size\: 18px\;\"\>\xd0\xb7\xd0\xb0\xd0\xb1\xd0\xbe\xd0\xbb\xd0\xb5\xd0\xbb\xd0\xbe/){
		print CONFIRMED $1, "\n";
		}
		else{
		print CONFIRMED "NA\n";
		}
	}
close CONFIRMED;
close SRC021;

open(SRC022, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(RECOVERED, '>>../downloads/gov.spb.ru.covid-19.extracted.RECOVERED.txt') or die $!;
	while(<SRC022>){
		if($_ =~ m/\<b\>(\d+)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\; padding\-top\: 16px\;\"\>\xd0\xb2\xd1\x8b\xd0\xb7\xd0\xb4\xd0\xbe\xd1\x80\xd0\xbe\xd0\xb2/){
		print RECOVERED $1, "\n";
		}
		else{
		print RECOVERED "NA\n";
		}
	}
close RECOVERED;
close SRC022;

open(SRC023, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(DEATHS, '>>../downloads/gov.spb.ru.covid-19.extracted.DEATHS.txt') or die $!;
	while(<SRC023>){
		if($_ =~ m/\<b\>(\d+)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\; padding\-top\: 16px\;\"\>\xd1\x83\xd0\xbc\xd0\xb5\xd1\x80\xd0\xbb\xd0\xbe/){
		print DEATHS $1, "\n";
		}
		else{
		print DEATHS "NA\n";
		}
	}
close DEATHS;
close SRC023;

open(SRC024, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(RT, '>>../downloads/gov.spb.ru.covid-19.extracted.RT.txt') or die $!;
	while(<SRC024>){
		if($_ =~ m/\<b\>(\d+)\,(\d+)\<\/b\>\<\/span\> \<span style\=\"font\-size\: 18px\;  padding\-top\: 16px\;\"\>\xd0\xba\xd0\xbe\xd1\x8d\xd1\x84\xd1\x84\xd0\xb8\xd1\x86\xd0\xb8/){
		print RT $1, '.', $2, "\n";
		}
		else{
		print RT "NA\n";
		}
	}
close RT;
close SRC024;

open(SRC025, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(YACT, '>>../downloads/gov.spb.ru.covid-19.extracted.YACT.txt') or die $!;
	while(<SRC025>){
		if($_ =~ m/\<b\>(\d+?)\%\<\/b\>\<\/span\> \<span style\=\"font\-size\: 18px\;  padding\-top\: 16px\;\"\>\xd0\xb0\xd0\xba\xd1\x82\xd0\xb8\xd0\xb2\xd0\xbd\xd0\xbe\xd1\x81/){
		print YACT $1, "\n";
		}
		else{
		print YACT "NA\n";
		}
	}
close YACT;
close SRC025;

open(SRC026, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(HOSPITALS, '>>../downloads/gov.spb.ru.covid-19.extracted.HOSPITALS.txt') or die $!;
	while(<SRC026>){
		if($_ =~ m/\<b\>(\d+)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\s*\xd0\xb3\xd0\xbe\xd1\x80\xd0\xbe\xd0\xb4\xd1\x81\xd0\xba\xd0\xb8\xd1\x85\x20\xd1\x81\xd1\x82\xd0\xb0\xd1\x86\xd0\xb8\xd0\xbe\xd0\xbd\xd0\xb0\xd1\x80\xd0\xbe\xd0\xb2\x20\xd1\x80\xd0\xb0\xd0\xb1\xd0\xbe\xd1\x82\xd0\xb0\xd0\xb5\xd1\x82/){
		print HOSPITALS $1, "\n";
		}
		else{
		print HOSPITALS "NA\n";
		}
	}
close HOSPITALS;
close SRC026;

open(SRC027, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(BEDS, '>>../downloads/gov.spb.ru.covid-19.extracted.BEDS.txt') or die $!;
	while(<SRC027>){
		if($_ =~ m/\<b\>(\d+)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xba\xd0\xbe\xd0\xb5\xd0\xba\x20\xd1\x80\xd0\xb0\xd0\xb7\xd0\xb2\xd0\xb5\xd1\x80\xd0\xbd\xd1\x83\xd1\x82\xd0\xbe/){
		print BEDS $1, "\n";
		}
		else{
		print BEDS "NA\n";
		}
	}
close BEDS;
close SRC027;

open(SRC028, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(FREEBEDS, '>>../downloads/gov.spb.ru.covid-19.extracted.FREEBEDS.txt') or die $!;
	while(<SRC028>){
		if($_ =~ m/\<b\>(\d+),(\d+)\%\<\/b\>\<\/span\> \<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd1\x81\xd0\xb2\xd0\xbe\xd0\xb1\xd0\xbe\xd0\xb4\xd0\xbd\xd1\x8b/){
		print FREEBEDS $1, '.', $2, "\n";
		}
		else{
		print FREEBEDS "NA\n";
		}
	}
close FREEBEDS;
close SRC028;

open(SRC029, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(HOSPITALIZED, '>>../downloads/gov.spb.ru.covid-19.extracted.HOSPITALIZED.txt') or die $!;
	while(<SRC029>){
		if($_ =~ m/\<b\>(\d+)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xbd\xd0\xb0\x20\xd0\xbb\xd0\xb5\xd1\x87\xd0\xb5\xd0\xbd\xd0\xb8\xd0\xb8\x20\xd0\xb2\x20\xd1\x81\xd1\x82\xd0\xb0\xd1\x86\xd0\xb8\xd0\xbe\xd0\xbd\xd0\xb0\xd1\x80\xd0\xb0\xd1\x85/){
		print HOSPITALIZED $1, "\n";
		}
		else{
		print HOSPITALIZED "NA\n";
		}
	}
close HOSPITALIZED;
close SRC029;

open(SRC030, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(HOSPITALIZED_TODAY, '>>../downloads/gov.spb.ru.covid-19.extracted.HOSPITALIZED_TODAY.txt') or die $!;
	while(<SRC030>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\> \xd0\xbf\xd0\xbe\xd1\x81\xd1\x82\xd1\x83\xd0\xbf\xd0\xb8\xd0\xbb\xd0\xbe\<\/p\>/){
		print HOSPITALIZED_TODAY $1, "\n";
		}
		else{
		print HOSPITALIZED_TODAY "NA\n";
		}
	}
close HOSPITALIZED_TODAY;
close SRC030;

open(SRC031, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(RELEASED, '>>../downloads/gov.spb.ru.covid-19.extracted.RELEASED.txt') or die $!;
	while(<SRC031>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\> \xd0\xb2\xd1\x8b\xd0\xbf\xd0\xb8\xd1\x81\xd0\xb0\xd0\xbd\xd0\xbe\<\/p\>/){
		print RELEASED $1, "\n";
		}
		else{
		print RELEASED "NA\n";
		}
	}
close RELEASED;
close SRC031;

open(SRC032, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(INTENSIVECARE, '>>../downloads/gov.spb.ru.covid-19.extracted.INTENSIVECARE.txt') or die $!;
	while(<SRC032>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\> \xd0\xb2 \xd1\x80\xd0\xb5\xd0\xb0\xd0\xbd\xd0\xb8\xd0\xbc\xd0\xb0\xd1\x86\xd0\xb8\xd0\xb8\<\/p\>/){
		print INTENSIVECARE $1, "\n";
		}
		else{
		print INTENSIVECARE "NA\n";
		}
	}
close INTENSIVECARE;
close SRC032;

open(SRC033, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(VENT, '>>../downloads/gov.spb.ru.covid-19.extracted.VENT.txt') or die $!;
	while(<SRC033>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\> \xd0\xbf\xd0\xbe\xd0\xb4\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd\xd0\xbe\x20\xd0\xba\x20\xd0\x98\xd0\x92\xd0\x9b\<\/p\>/){
		print VENT $1, "\n";
		}
		else{
		print VENT "NA\n";
		}
	}
close VENT;
close SRC033;

open(SRC034, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(LENEXPO, '>>../downloads/gov.spb.ru.covid-19.extracted.LENEXPO.txt') or die $!;
	while(<SRC034>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\> \xd0\xb2\xd1\x80\xd0\xb5\xd0\xbc\xd0\xb5\xd0\xbd\xd0\xbd\xd1\x8b\xd0\xb9 \xd0\xb3\xd0\xbe.*?\xd0\x9b\xd0\xb5\xd0\xbd\xd1\x8d\xd0\xba\xd1\x81\xd0\xbf\xd0\xbe.*?\<\/p\>/){
		print LENEXPO $1, "\n";
		}
		else{
		print LENEXPO "NA\n";
		}
	}
close LENEXPO;
close SRC034;

open(SRC035, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(ZARYA, '>>../downloads/gov.spb.ru.covid-19.extracted.ZARYA.txt') or die $!;
	while(<SRC035>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\> \xd0\xbf\xd0\xb0\xd0\xbd\xd1\x81\xd0\xb8\xd0\xbe\xd0\xbd\xd0\xb0\xd1\x82.*?\xd0\x97\xd0\xb0\xd1\x80\xd1\x8f.*?\<\/p\>/){
		print ZARYA $1, "\n";
		}
		else{
		print ZARYA "NA\n";
		}
	}
close ZARYA;
close SRC035;

open(SRC036, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(AMB, '>>../downloads/gov.spb.ru.covid-19.extracted.AMB.txt') or die $!;
	while(<SRC036>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xbd\xd0\xb0 \xd0\xb0\xd0\xbc\xd0\xb1\xd1\x83\xd0\xbb\xd0\xb0\xd1\x82\xd0\xbe\xd1\x80\xd0\xbd\xd0\xbe\xd0\xbc/){
		print AMB $1, "\n";
		}
		else{
		print AMB "NA\n";
		}
	}
close AMB;
close SRC036;

open(SRC037, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(OBSERV, '>>../downloads/gov.spb.ru.covid-19.extracted.OBSERV.txt') or die $!;
	while(<SRC037>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xb2 \xd0\xbe\xd0\xb1\xd1\x81\xd0\xb5\xd1\x80\xd0\xb2\xd0\xb0\xd1\x86\xd0\xb8\xd0\xb8/){
		print OBSERV $1, "\n";
		}
		else{
		print OBSERV "NA\n";
		}
	}
close OBSERV;
close SRC037;

open(SRC038, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(QUARANTINE, '>>../downloads/gov.spb.ru.covid-19.extracted.QUARANTINE.txt') or die $!;
	while(<SRC038>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xbd\xd0\xb0 \xd0\xba\xd0\xb0\xd1\x80\xd0\xb0\xd0\xbd\xd1\x82\xd0\xb8\xd0\xbd\xd0\xb5/){
		print QUARANTINE $1, "\n";
		}
		else{
		print QUARANTINE "NA\n";
		}
	}
close QUARANTINE;
close SRC038;

open(SRC039, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(VSTATIONS, '>>../downloads/gov.spb.ru.covid-19.extracted.VSTATIONS.txt') or die $!;
	while(<SRC039>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\"\>\xd0\xbf\xd1\x83\xd0\xbd\xd0\xba\xd1\x82\xd0\xbe\xd0\xb2\x20\xd0\xb2\xd0\xb0\xd0\xba\xd1\x86\xd0\xb8\xd0\xbd\xd0\xb0\xd1\x86\xd0\xb8\xd0\xb8\x20\xd0\xbe\xd1\x82 COVID-19 \(\xd0\xb4\xd0\xbb\xd1\x8f\x20\xd0\xb2\xd0\xb7\xd1\x80\xd0\xbe\xd1\x81\xd0\xbb\xd0\xbe\xd0\xb3\xd0\xbe/a){
		print VSTATIONS $1, "\n";
		}
		else{
		print VSTATIONS "NA\n";
		}
	}
close VSTATIONS;
close SRC039;

open(SRC040, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(V1CS, '>>../downloads/gov.spb.ru.covid-19.extracted.V1CS.txt') or die $!;
	while(<SRC040>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xbf\xd1\x80\xd0\xb8\xd0\xb2\xd0\xb8\xd1\x82\xd0\xbe\x20\xd0\xbf\xd0\xb5\xd1\x80\xd0\xb2\xd0\xb8\xd1\x87\xd0\xbd\xd0\xbe/){
		print V1CS $1, "\n";
		}
		else{
		print V1CS "NA\n";
		}
	}
close V1CS;
close SRC040;

open(SRC041, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(V1TODAY, '>>../downloads/gov.spb.ru.covid-19.extracted.V1TODAY.txt') or die $!;
	while(<SRC041>){
		if($_ =~ m/\<p style\=\"font\-size\: 18px\; margin\-top\: 0\; margin\-bottom\: 0\.65rem\;\" class\=\"mobile-mb-15\"\>\xd0\xb7\xd0\xb0\x20\xd1\x81\xd1\x83\xd1\x82\xd0\xba\xd0\xb8\: \<b\>(\d+)\<\/b\> \<\/p\>/){
		print V1TODAY $1, "\n";
		}
		else{
		print V1TODAY "NA\n";
		}
	}
close V1TODAY;
close SRC041;

# Non-functional but vitally important for now
open(SRC042, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(V12CS, '>>../downloads/gov.spb.ru.covid-19.extracted.V12CS.txt') or die $!;
	while(<SRC042>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xb7\xd0\xb0\xd0\xba\xd0\xbe\xd0\xbd\xd1\x87\xd0\xb8\xd0\xbb\xd0\xb8\x20\xd1\x86\xd0\xb8\xd0\xba\xd0\xbb\x20\xd0\xb2\xd0\xb0\xd0\xba\xd1\x86\xd0\xb8\xd0\xbd\xd0\xb0\xd1\x86\xd0\xb8\xd0\xb8/){
		print V12CS $1, "\n";
		}
		else{
		print V12CS "NA\n";
		}
	}
close V12CS;
close SRC042;

# Non-functional but vitally important for now
open(SRC043, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(V12TODAY, '>>../downloads/gov.spb.ru.covid-19.extracted.V12TODAY.txt') or die $!;
	while(<SRC043>){
		if($_ =~ m/\xd0\xb7\xd0\xb0\xd0\xba\xd0\xbe\xd0\xbd\xd1\x87\xd0\xb8\xd0\xbb\xd0\xb8.* \<p style\=\"font\-size\: 18px\; margin\-top\: 0\; margin\-bottom\: 0.65rem\;\" class\=\"mobile\-mb\-15\"\>\xd0\xb7\xd0\xb0\x20\xd1\x81\xd1\x83\xd1\x82\xd0\xba\xd0\xb8\: \<b\>(\d+)\<\/b\> \<\/p\>/){
		print V12TODAY $1, "\n";
		}
		else{
		print V12TODAY "NA\n";
		}
	}
close V12TODAY;
close SRC043;

open(SRC044, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(V2CS, '>>../downloads/gov.spb.ru.covid-19.extracted.V2CS.txt') or die $!;
	while(<SRC044>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\> \<span style\=\"font\-size\: 18px\;  padding\-top\: 16px\;\"\>\xd0\xb7\xd0\xb0\xd0\xba\xd0\xbe\xd0\xbd\xd1\x87\xd0\xb8\xd0\xbb\xd0\xb8/){
		print V2CS $1, "\n";
		}
		else{
		print V2CS "NA\n";
		}
	}
close V2CS;
close SRC044;


open(SRC045, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(V2TODAY, '>>../downloads/gov.spb.ru.covid-19.extracted.V2TODAY.txt') or die $!;
	while(<SRC045>){
		if($_ =~ m/\xd0\xb7\xd0\xb0\xd0\xba\xd0\xbe\xd0\xbd\xd1\x87\xd0\xb8\xd0\xbb\xd0\xb8.*?\>\xd0\xb7\xd0\xb0 \xd1\x81\xd1\x83\xd1\x82\xd0\xba\xd0\xb8\: (\d+?)\</){
		print V2TODAY $1, "\n";
		}
		else{
		print V2TODAY "NA\n";
		}
	}
close V2TODAY;
close SRC045;

open(SRC046, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(VREMAINING, '>>../downloads/gov.spb.ru.covid-19.extracted.VREMAINING.txt') or die $!;
	while(<SRC046>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xb4\xd0\xbe\xd0\xb7/){
		print VREMAINING $1, "\n";
		}
		else{
		print VREMAINING "NA\n";
		}
	}
close VREMAINING;
close SRC046;

open(SRC047, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(PCRLABS, '>>../downloads/gov.spb.ru.covid-19.extracted.PCRLABS.txt') or die $!;
	while(<SRC047>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xbb\xd0\xb0\xd0\xb1\xd0\xbe\xd1\x80\xd0\xb0\xd1\x82\xd0\xbe\xd1\x80\xd0\xb8\xd0\xb9/){
		print PCRLABS $1, "\n";
		}
		else{
		print PCRLABS "NA\n";
		}
	}
close PCRLABS;
close SRC047;

open(SRC048, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(PCRPOINTS, '>>../downloads/gov.spb.ru.covid-19.extracted.PCRPOINTS.txt') or die $!;
	while(<SRC048>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd0\xbf\xd1\x83\xd0\xbd\xd0\xba\xd1\x82\xd0\xbe\xd0\xb2 \xd0\xb7/){
		print PCRPOINTS $1, "\n";
		}
		else{
		print PCRPOINTS "NA\n";
		}
	}
close PCRPOINTS;
close SRC048;

open(SRC049, '<../downloads/gov.spb.ru.covid-19.new_lines.txt') or die $!;
open(PCRTESTS, '>>../downloads/gov.spb.ru.covid-19.extracted.PCRTESTS.txt') or die $!;
	while(<SRC049>){
		if($_ =~ m/\<b\>(\d+?)\<\/b\>\<\/span\>\s+\<span style\=\"font\-size\: 18px\;\s+padding\-top\: 16px\;\"\>\xd1\x82\xd0\xb5\xd1\x81\xd1\x82/){
		print PCRTESTS $1, "\n";
		}
		else{
		print PCRTESTS "NA\n";
		}
	}
close PCRTESTS;
close SRC049;
