#!/usr/bin/perl
#       file:   stat_amp.pl
#       date    2015-04-7
#       by:     Smirnov Alexander, alllecs@cs.niisi.ras.ru
#       result: 
#

$shh = $smm = $shm = $smh = 0;
$sh = $sm = 0;
$lhh = $lmm = $lhm = $lmh = 0;
$lh = $lm = 0;
$d1 = $d2 = $d3 = $d4 = $d5 = 0;
$s1 = $s2 = $s3 = $s4 = $s5 = 0;
$i = $j = $k = 0;
$dif = $sum = 0;
$sit1 = $sit2 = $sit3 = $sit4 =$sit5 = 0;
$x = 0;
$i = 0;
$y = 1;
$p  = 0;
$b = $bne = $j = $beq = $bal = $jal = $jr = $beql = $bgez = $blez = $jalr = 0;
@summ = ();
@diff = ();
while (<STDIN>) {
	if (/(\d+).*(store|load).*(hit|miss).*(VA=)(.{16}).*(PA=)(.{8}).*/) {
	       	$uninstr = $instr; #write previous number instruction
	       	$instr = $1; #write number instruction
       		$uns_l = $s_l; # write previous store|load
	       	$s_l = $2; # write store|load
	       	$unh_m = $h_m; #write previous hit|miss
	       	$h_m = $3; # write hit|miss
	       	$unva = $va; #write previous VA
	       	$va = $5; #write VA
	       	$unpa = $pa; #write previous PA
	       	$pa = $7; #write PA
#		&hit_miss; #function hit_miss
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
#		$num2 = $num1 + 1;
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
#Сортировка по маскам
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
	if (/(\d+).*(dcache).*(load  miss).*(VA=)(.{16}).*/) {
		$instr = $1;
		$va = $5;
		$i++;
		$buf_addr[$i] = hex($va);
		if ($y == 0 and $buf_addr[$i - 3] - $buf_addr[$i - 2] != 0x20 and $buf_addr[$i - 2] - $buf_addr[$i - 1] != 0x20 and $buf_addr[$i + 1] - $buf_addr[$i] != 0x20) {
			$y = 1;
			$in++;
		} elsif ($y == 1 and $buf_addr[$i - 3] - $buf_addr[$i] == 0x60 and $buf_addr[$i - 2] - $buf_addr[$i] == 0x40 and $buf_addr[$i - 1] - $buf_addr[$i] == 0x20) {
			$y = 0;
			$dec++;
		}
	} elsif (/(\d+).*(dcache).*(store miss).*(VA=)(.{16}).*/) {
		$instr = $1;
		$str=<STDIN>;
		$_= $str ;
		if (/($instr).*(scache).*(store miss).*(VA=)(.{16}).*/) {
			$va = $5;
			$i++;
			$buf_addr[$i] = hex($va);
			if ($y == 0 and $buf_addr[$i - 3] - $buf_addr[$i - 2] != 0x20 and $buf_addr[$i - 2] - $buf_addr[$i - 1] != 0x20 and $buf_addr[$i + 1] - $buf_addr[$i] != 0x20) {
				$y = 1;
				$in++;
			} elsif ($y == 1 and $buf_addr[$i - 3] - $buf_addr[$i] == 0x60 and $buf_addr[$i - 2] - $buf_addr[$i] == 0x40 and $buf_addr[$i - 1] - $buf_addr[$i] == 0x20) {
				$y = 0;
				$dec++;
			}
		}
	}
	if (/(\d+).*(PC=0x)(.{16}).*( b | bal | beq | beql | bgez | blez | bne | bnel | j | jal | jalr | jr | blezl ).*(0x)(.{16}).*/) {
#		print "pc $3, add $6\n";
		$n = $4;
		$inst = $1;
		$inst2 = $inst + 2;
		$pc = $3;
		$addr2 = $addr;
		$addr = $6;
		if (hex($addr) < hex($pc)) {
			if (hex($addr2) == hex($addr)) {
				$x = $x;	
			} elsif (hex($pc) - hex($addr) < 0x38 and hex($pc) - hex($addr) != 0) {
				$ago++;
  	                        $short++; 
			} elsif (hex($pc) - hex($addr) > 0x38) {
				$ago++;
                                $long++;
  	                }
		} else {
			$forward++;
		}
#		if (hex($addr) - hex($pc) < 0x38 and hex($addr) - hex($pc) > 0) {
		if ($n eq ' bne ') {
			$bne++;
			$p  = 1;
		} elsif ($n eq ' j ') {
			$j++;
		} elsif ($n eq ' b ') {
			$b++;
		} elsif ($n eq ' beq ') {
			$beq++;
		} elsif ($n eq ' beql ') {
			$beql++;
		} elsif ($n eq ' bgez ') {
			$bgez++;
		} elsif ($n eq ' blezl ') {
			$blezl++;
		} elsif ($n eq ' jal ') {
			$jal++;
		}
	} elsif (/(\d+).*(PC=0x)(.{16}).*( b | jalr | jr | blez | bal ).*/) {

		$n = $4;
		$inst = $1;
		$inst2 = $inst + 2;
		$pc = $3;
		if ($n eq ' blez ') {
			$blez++;
		} elsif ($n eq ' jalr ') {
			$jalr++;
		} elsif ($n eq ' bal ') {
			$bal++;
		} elsif ($n eq ' jal ') {
			$jal++;
		} elsif ($n eq ' jr ') {
			$jr++;
		}
	}
	if ($p == 1 and /($inst2).*(PC=0x)(.{16}).*/) {
		$addr2 = $3;
		$p = 0;
		if ($addr eq $addr2) {
			$ye++;
		} else {
			$no++;
		}
	}
}

$n = 1;
@summ = sort { $a <=> $b } @summ; #sort increment
for ($i = 1; $i <=$#summ; $i++) {
	if ($summ[$i] == $summ[$i + 1]) {
		$n++;
	}
	if ($summ[$i] != $summ[$i + 1]) {
		print("In a row increment= $summ[$i], repeat = $n\n");
		$n = 1;
	}
}
$n = 1;
@diff = sort { $a <=> $b } @diff; #sort decrement
for ($i = 1; $i <=$#diff; $i++) {
	if ($diff[$i] == $diff[$i + 1]) {
		$n++;
	}
	if ($diff[$i] != $diff[$i + 1]) {
		print("In a row decrement= $diff[$i], repeat = $n\n");
		$n = 1;
	}
}
$x = $x - $shh - $smm - $lmm;
$sh = $sh - $shh;
$sm = $sm - $smm;
$lm = $lm - $lmm;


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
printf ("Количество попаданий в буфера inc = %d, dec = %d\n", $in, $dec);

print ("\n b=$b,\n bne=$bne,\n j=$j,\n beq=$beq,\n bal=$bal,\n blezl=$blezl,\n jal=$jal,\n jr=$jr,\n beql=$beql,\n bgez=$bgez,\n blez=$blez,\n jalr=$jalr\n");
print ("Jump direction: forward=$forward, back=$ago\n");
print ("Cycle short(addr<0x38) =$short, long=$long\n");
print ("Taken:$ye, not taken:$no\n");
