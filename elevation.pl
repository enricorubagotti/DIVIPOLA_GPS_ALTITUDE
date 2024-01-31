use strict;
my $input='DIVIPOLA_GPS.csv';
my $output='DIVIPOLA_GPS_ALTITUDE.csv';

open (input,"<$input") or print "$input does not exist\n";
open (output,">$output") or print "$output does not exist\n";

my $skip=<input>;
$skip=~s/\n|\r//g;
print output $skip.";altitude\n";

while (my $line=<input>)
	{
	$line =~ s/\n|\r//g;
        $line=~ s/,/\./g;
        print output $line;
	my @line=split(/;/,$line);
	
	my $commandAltitude='curl -H "Accept: application/json" -X GET    https://maps.googleapis.com/maps/api/elevation/json?locations='.$line[7].'%2C'.$line[8].'\&key=<GoogleKey>  | grep  elevation   ';
        print $commandAltitude."\n";
	my $altitude  = `$commandAltitude`; #These are backticks, to collect the output of the command into the $altitude variable
	print $altitude."\n";
	my @altitude=split(/:/,$altitude);
	$altitude[1]=~s/,//g;
	$altitude[1]=~ s/^\s+|\s+$//g;
	print $altitude[1]."\n";
	print output ";".$altitude[1]."\n";
	}
close output;
