#!/usr/bin/perl
$i = -1;
for ($arg = 0; $arg <= $#ARGV; $arg++) {
open (FILE, $ARGV[$arg]) or die $!;
while (<FILE>) {
	if (/(\d+).*(dcache).*(load).*(VA=)(.{16}.*)/) {
		$instr = $1;
		$va = $5;
		$i++;
		$buf_addr[$i] = hex($va);
		$buf_instr[$i] = $instr;
#		print("$buf_addr[$i]\n");
		if ($i > 3) {		
			for ($k = $i - 3, $j = $i - 2; $j <= $i; $j++) {
				if (($buf_addr[$j] - $buf_addr[$k]) == 32) {
#					$x = 0;
					$buf_addr[$j] = 0;
					$j = $i + 1;
					$in++;
				} elsif (($buf_addr[$k] - $buf_addr[$j] == 32) and $buf_addr[$k] - $buf_addr[$j + 1] == 64 and $buf_addr[$k] - $buf_addr[$j + 2] == 96) {
#					$x++;
					$j = $i + 1;
#					if ($x == 4) {
					$dec++;
#						$x = 0;
#					}
#				} else {
#					$x = 0;
				}
			} 
		}
	}
}
}
printf ("Количество попаданий в буфера inc = %d, dec = %d\n", $in, $dec);
