#!/usr/bin/perl
#--------------------------------------
# name: init_graph.pl
# version 0.12
# date 11-08-2013
# Trust@FHH
#--------------------------------------

use strict;
use warnings;
use File::Spec;
use File::Basename;

my $project = 'ifmapcli-distribution';
my $scenario_dir = File::Spec->rel2abs(File::Spec->updir, dirname(__FILE__));

opendir(SCENARIO, $scenario_dir)
	or die "Could not open directory $scenario_dir: $! \n";
	
my @dirs = grep {/^$project-/} readdir(SCENARIO);

unless (@dirs == 1){
  die "ERROR, cannot find directory for $project!\n";
}

my $ifmapcli_dir = File::Spec->catdir($scenario_dir, $dirs[0]);

my $AR = "111:33";
my $ARMAC = "aa:bb:cc:dd:ee:ff";
my $ARIP = "10.0.0.1";
my $PDP = "pdp1";
my $USER = "Bob";

$ENV{'IFMAP_USER'} = 'pdp';
$ENV{'IFMAP_PASS'} = 'pdp';

chdir($ifmapcli_dir) or die "Could not open directory $ifmapcli_dir: $! \n";

system("java -jar ar-ip.jar update $AR $ARIP");
system("java -jar ar-mac.jar update $AR  $ARMAC");
system("java -jar auth-by.jar update $AR $PDP");
system("java -jar auth-as.jar update $AR $USER");