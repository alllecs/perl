#!/usr/bin/perl

#       file:   hit_miss_V5.pl
#       date    2015-03-18
#       by:     Smirnov Alexander, alllecs@cs.niisi.ras.ru
#       result: display store/load hit
#

$shh = $smm = $shm = $smh = 0;
$sh = $sm = 0;
$lhh = $lmm = $lhm = $lmh = 0;
$lh = $lm = 0;
$d1 = $d2 = $d3 = $d4 = $d5 = 0;
$s1 = $s2 = $s3 = $s4 = $s5 = 0;
$i = $j = $k = 0;
$dif = $sum = 0;
$x = 0;
@summ = ();
@diff = ();
#print ("$#ARGV\n");

if ($#ARGV >= 0) { #for file
	open (FILE, $ARGV[0]) or die $!;
	while (<FILE>) { #scan file
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
				$diff++;
				if ($sum != 0) {
					$j++;
					$summ[$j] = $sum;
					$sum = 0;
				}
			}
		}
	}
} else { #for STDIN
	while (<STDIN>) {
		if (/(\d+).*(store|load).*(hit|miss).*(VA=)(.{16}).*(PA=)(.{8}).*/) {
			$uninstr = $instr;
			$instr = $1;
			$uns_l = $s_l;
			$s_l = $2;
			$unh_m = $h_m;
			$h_m = $3;
			$unva = $va;
			$va = $5;
			$unpa = $pa;
			$pa = $7;
#			&hit_miss;
#sub hit_miss { #function score hit, miss
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
#}
			#Перевод из 16 в 10 систему		
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
				$diff++;
				if ($sum != 0) {
					$j++;
					$summ[$j] = $sum;
					$sum = 0;
				}
			}
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


print("\n");
print("store hit, store hit =\t $shh, ");
printf("%.1f%\n", ($shh / $x) * 100);
print("store miss, store miss = $smm, \t");
printf("%.1f%\n", ($smm / $x) * 100);
print("store hit, store miss =\t $shm, \t");
printf("%.1f%\n", ($shm / $x) * 100);
print("store miss, store hit =\t $smh, \t");
printf("%.1f%\n", ($smh / $x) * 100);
print("load  hit, load hit =\t $lhh, \t");
printf("%.1f%\n", ($lhh / $x) * 100);
print("load  miss, load miss =\t $lmm, \t");
printf("%.1f%\n", ($lmm / $x) * 100);
print("load  hit, load miss =\t $lhm, \t");
printf("%.1f%\n", ($lhm / $x) * 100);
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

