#!/usr/bin/perl

open (FILE, $ARGV[0]) or die $!;
while (<FILE>) {
	if (/(\d+).*(VA=)(.{16}.*)/) {
		$instr = $1;
		$va = $3;
		
		$va = hex($va);
		$va = sprintf("%x", $va);

		$buf_addr[$i] = $va;
		if ($i >= 4) {
			for ($k = $i; $k >= ($i - 4); $k--) {
				if ($buf_addr[$i] < $buf_addr[$k]) {
					$addr = $buf_addr[$k] - $buf_addr[$i];
					if ($addr < 0x80) {
						$n++;
					}
				} elsif ($buf_addr[$i] >= $buf_addr[$k]) { 
					$addr = $buf_addr[$i] - $buf_addr[$k];
					if ($addr < 0x80) {
						$n++;
					}
				}
			}
		}
		$i++;
	}
}
printf ("Количество попаданий в буфера = %d", $n/4);
