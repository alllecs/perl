#!/usr/bin/perl
$shh = $smm = $shm = $smh = $sh = $sm = 0;
$lhh = $lmm = $lhm = $lmh = $lh = $lm = 0;
$sit1 = $sit2 = $sit3 = $sit4 =$sit5 = 0;
$d1 = $d2 = $d3 = $d4 = $d5 = 0;
$s1 = $s2 = $s3 = $s4 = $s5 = 0;
$i = $j = $k = 0;
$dif = $sum = 0;
$x = 0;
@summ = ();
@diff = ();

$dec = $inc = 0;
$m = -1;
$next = 1;
$instr2 = -1;

$p  = 0;
$b = $bne = $j = $beq = $bal = $jal = $jr = $beql = $bgez = $blez = $jalr = 0;

while (<STDIN>) {
	if (/(\d+).*(dcache|scache).*(store|load).*(hit|miss).*(VA=)(.{16}).*(PA=)(.{8}).*/) {
	       	$uninstr = $instr; #write previous number instruction
	       	$instr = $1; #write number instruction
		$sca = $dca;
		$dca = $2;
       		$uns_l = $s_l; # write previous store|load
	       	$s_l = $3; # write store|load
	       	$unh_m = $h_m; #write previous hit|miss
	       	$h_m = $4; # write hit|miss
	       	$unva = $va; #write previous VA
	       	$va = $6; #write VA
	       	$unpa = $pa; #write previous PA
	       	$pa = $8; #write PA
		if ($dca eq 'dcache' and $s_l eq 'load' and $h_m eq 'miss') {
			$m++;
			$buf_addr[$m] = hex($va);
			if ($m >= 3 and $next == 0 and $buf_addr[$m - 3] - $buf_addr[$m - 2] != 0x20 and $buf_addr[$m - 2] - $buf_addr[$m - 1] != 0x20 and $buf_addr[$m + 1] - $buf_addr[$m] != 0x20) {
                                $next = 1;
                                $inc++;
                        } elsif ($next == 1 and $buf_addr[$m - 3] - $buf_addr[$m] == 0x60 and $buf_addr[$m - 2] - $buf_addr[$m] == 0x40 and $buf_addr[$m - 1] - $buf_addr[$m] == 0x20) {
                                $next = 0;
                                $dec++;
                        }
		} elsif ($dca eq 'scache' and $s_l eq 'store' and $h_m eq 'miss') {
			$m++;
			$buf_addr[$m] = hex($va);
			if ($m >= 3 and $next == 0 and $buf_addr[$m - 3] - $buf_addr[$m - 2] != 0x20 and $buf_addr[$m - 2] - $buf_addr[$m - 1] != 0x20 and $buf_addr[$m + 1] - $buf_addr[$m] != 0x20) {
                                $next = 1;
                                $inc++;
                        } elsif ($next == 1 and $buf_addr[$m - 3] - $buf_addr[$m] == 0x60 and $buf_addr[$m - 2] - $buf_addr[$m] == 0x40 and $buf_addr[$m - 1] - $buf_addr[$m] == 0x20) {
                                $next = 0;
                                $dec++;
                        }
			

		}
		if ($uninstr eq $instr) {
			if ($uns_l eq 'store' and $s_l eq 'store') {
				if ($unh_m eq 'hit' and $h_m eq 'hit') {
		  			$shh++;
	       				$x++;
					$s_l = 0;
					$h_m = 0;
				} elsif ($unh_m eq 'miss' and $h_m eq 'miss') {
					$smm++;
					$x++;
					$s_l = 0;
					$h_m = 0;
				} elsif ($unh_m eq 'hit' and $h_m eq 'miss') {
					$shm++;
					$x++;
					$s_l = 0;
					$h_m = 0;
				} elsif ($unh_m eq 'miss' and $h_m eq 'hit') {
					$smh++;
					$x++;
					$s_l = 0;
					$h_m = 0;
				}
			} elsif ($uns_l eq 'load' and $s_l eq 'load') {
				if ($unh_m eq 'miss' and $h_m eq 'miss') {
					$lmm++;
					$x++;
					$s_l = 0;
					$h_m = 0;
				} elsif ($unh_m eq 'miss' and $h_m eq 'hit') {
					$lmh++;
					$x++;
					$s_l = 0;
					$h_m = 0;
				}
			}
		} elsif (($s_l eq 'store') and ($uninstr ne $instr)) {
			if ($h_m eq 'hit') {
				$sh++;
				$x++;
			} elsif ($h_m eq 'miss') {
				$sm++;
				$x++;
			}
		} elsif ($s_l eq 'load') {
			if ($h_m eq 'hit') {
				$lh++;
				$x++;
			} elsif ($h_m eq 'miss') {
				$lm++;
				$x++;
			}
		}
			#перевод 16 в 10 систему и наоборот
			$y1 = hex($unva);
			$y1 = $y1 + 0x20;
			$y1 = sprintf("%x", $y1);		
	
			$y2 = hex($unva);
			$y2 = $y2 - 0x20;
			$y2 = sprintf("%x", $y2);		
	
		if ($va eq $y1) {
			$sum++;
			if ($dif != 0) {
				$k++;
				$diff[$k] = $dif;
				$dif = 0;
			}
		} elsif ($va eq $y2) {
			$dif++;
			if ($sum != 0) {
				$j++;
				$summ[$j] = $sum;
				$sum = 0;
			}
		}
	}
	if ($i == 0 and (/(\d+).*(scache).*(miss).*(PA=)(.{8}).*/)) {
		$num1 = $1;
		$pa1 = $5;
		$str = <STDIN>;
		$_ = $str;
		if (m/.*(addr=)(.{8}).*/) {
			$addr1 = $2;
			$str = <STDIN>;
			$_ = $str;
			if (m/.*(dmemacc).*/) {
				$i = 1;
			}
		}
	}
	if ($i == 1 and ((/(\d+).*(scache).*(miss).*(PA=)(.{8}).*/))) {
		$num2 = $1;
		$pa2 = $5;
		$str = <STDIN>;
		$_= $str;
		$i = 0;
		if (m/.*(addr=)(.{8}).*/ and $num2 == $num1 + 1) {
			$addr2 = $2;
			$str = <STDIN>;
			$_ = $str;
			if (m/.*(dmemacc).*/) {
				if ($addr1 eq $pa2) {
					if ($pa1 eq $addr2) {
						$sit4 += 1;
					} else {
						$sit1 += 1;
					}
				} elsif ($addr1 eq $addr2) {
					$sit2 += 1;
				} elsif ($pa1 eq $addr2 and $addr1 ne $pa2) {
					$sit3 += 1;
				} else {
					$sit5 += 5;
				}
			}	
		}
	}
}
$z = 1;
@summ = sort { $a <=> $b } @summ; #sort increment
for ($i = 1; $i <=$#summ; $i++) {
	if ($summ[$i] == $summ[$i + 1]) {
		$z++;
	} elsif ($summ[$i] != $summ[$i + 1]) {
		print("In a row increment= $summ[$i], repeat = $z\n");
		$z = 1;
	}
}
$z = 1;
@diff = sort { $a <=> $b } @diff; #sort decrement
for ($i = 1; $i <=$#diff; $i++) {
	if ($diff[$i] == $diff[$i + 1]) {
		$z++;
	} elsif ($diff[$i] != $diff[$i + 1]) {
		print("In a row decrement= $diff[$i], repeat = $z\n");
		$z = 1;
	}
}
$x = $x - $shh - $smm - $lmm;
$sh = $sh - $shh;
$sm = $sm - $smm;
$lm = $lm - $lmm;

print("\n");
print("store hit, store hit =\t $shh, ");
printf("%.1f%\n", ($shh / $x) * 100);
print("store miss, store miss = $smm, \t");
printf("%.1f%\n", ($smm / $x) * 100);
print("store hit, store miss =\t $shm, \t");
printf("%.1f%\n", ($shm / $x) * 100);
print("store miss, store hit =\t $smh, \t");
printf("%.1f%\n", ($smh / $x) * 100);
print("load  miss, load miss =\t $lmm, \t");
printf("%.1f%\n", ($lmm / $x) * 100);
print("load  miss, load hit =\t $lmh, \t");
printf("%.1f%\n", ($lmh / $x) * 100);
print("store  hit =\t $sh, \t\t");
printf("%.1f%\n", ($sh / $x) * 100);
print("store miss =\t $sm, \t\t");
printf("%.1f%\n", ($sm / $x) * 100);
print("load   hit =\t $lh, \t");
printf("%.1f%\n", ($lh / $x) * 100);
print("load  miss =\t $lm, \t\t");
printf("%.1f%\n", ($sm / $x) * 100);
print("All load and store = $x\t");
printf("%.1f%\n", ($x / $x) * 100);

print("\n");
print("Writeback:\n");
print"sw A - wb B | sw B - wb C = $sit1\n";
print"sw A - wb B | sw C - wb B = $sit2\n";
print"sw A - wb B | sw C - wb A = $sit3\n";
print"sw A - wb B | sw B - wb A = $sit4\n";
print"sw A - wb B | sw C - wb D = $sit5\n";
print("\n");
printf ("Количество попаданий в буфера inc = %d, dec = %d\n", $inc, $dec);

close(STDIN);
