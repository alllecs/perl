#!/usr/bin/perl

open (FILE, $ARGV[0]) or die $!;
while (<FILE>) {
	if (/(\d+).*(dcache).*(VA=)(.{16}.*)/) {
		$instr = $1;
		$va = $4;
		
		$va = hex($va); #translation to obtain the number of rows
		$va = sprintf("%x", $va);

		$buf_instr[$i] = $instr; #write number instruction
		$buf_addr[$i] = $va; # and virtual address


		if ($i >= 4) { #if save 5 VA and more
#comparison first VA with other four
			for ($k = ($i - 4), $j = ($i - 3); $j <= $i; $j++) {
#search for the greatest number
				if ($buf_addr[$j] < $buf_addr[$k]) {
					$addr = $buf_addr[$k] - $buf_addr[$j];
#verification step
					if ($addr < 0x80) {
						$dec++;
						$j = $i + 1;
					}
				} elsif ($buf_addr[$j] >= $buf_addr[$k]) { 
					$addr = $buf_addr[$j] - $buf_addr[$k];
					if ($addr < 0x80) {
						$in++;
						$j = $i + 1;
					}
				}
			}
#add verification 4 last VA!!!
		}
		$i++;
	}
}
$n = 3;
for ($k = ($i - $n), $j = ($i - $n + 1); $n >= 0; $n--, $j++) {
	if ($buf_addr[$j] < $buf_addr[$k]) {
		$addr = $buf_addr[$k] - $buf_addr[$j];
		if ($addr < 0x80) {
			$dec++;
			$j = $i + 1;
		}
	} elsif ($buf_addr[$j] >= $buf_addr[$k]) { 
		$addr = $buf_addr[$j] - $buf_addr[$k];
		if ($addr < 0x80) {
			$in++;
			$j = $i + 1;
		}
	}

}

printf ("Количество попаданий в буфера = %d, dec = %d\n", $in, $dec);
