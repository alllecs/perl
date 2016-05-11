#!/usr/bin/perl
#work for soc 5.0
$i = 1;
$x = 1;
for ($arg = 0; $arg <= $#ARGV; $arg++) {
open (FILE, $ARGV[$arg]) or die $!;
	while (<FILE>) {
		if (/(\d+).*(dcache).*(load  miss).*(VA=)(.{16}).*/) {
			$instr = $1;
			$va = $5;
			$i++;
			$buf_addr[$i] = hex($va);
			if ($x == 0 and $buf_addr[$i] - $buf_addr[$i - 3] == 0x60 and $buf_addr[$i] - $buf_addr[$i - 2] == 0x40 and $buf_addr[$i] - $buf_addr[$i - 1] == 0x20) {
				$x = 1;
				$in++;
#				print "instr$instr\n";
			} elsif ($x == 1 and $buf_addr[$i - 3] - $buf_addr[$i] == 0x60 and $buf_addr[$i - 2] - $buf_addr[$i] == 0x40 and $buf_addr[$i - 1] - $buf_addr[$i] == 0x20) {
				$x = 0;
				$dec++;
#				print "instr$instr\n";

			}
		}
	}
}
printf ("\nNumber of switching: inc = %d, dec = %d\n", $in, $dec);
