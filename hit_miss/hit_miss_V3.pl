#!/usr/bin/perl

#       file:   hit_miss_V3.pl
#       date    2015-03-18
#       by:     Smirnov Alexander, alllecs@cs.niisi.ras.ru
#       result: search VA and VA + 0x20 and display results
#

$shh = $smm = $shm = $smh = 0;
$sh = $sm = 0;
$lhh = $lmm = $lhm = $lmh = 0;
$lh = $lm = 0;
$d1 = $d2 = $d3 = $d4 = $d5 = 0;
$s1 = $s2 = $s3 = $s4 = $s5 = 0;
$i = $j = $k = 0;
$dif = $sum = 0;

@summ = ();
@diff = ();

open (FILE, $ARGV[0]) or die $!;
while (<FILE>) {
	if (/(\d+).*(store|load).*(hit|miss).*(VA=)(.{16}).*(PA=)(.{8}).*/) {
		$instr = $1;
		$s_l = $2;
		$h_m = $3;
		$unva = $va;
		$va = $5;
		$unpa = $pa;
		$pa = $7;

		#Перевод из 16 в 10 систему		
		$y1 = hex($unva);
		$y1 = $y1 + 0x20;
		$y1 = sprintf("%x", $y1);		

		$y2 = hex($unva);
		$y2 = $y2 - 0x20;
		$y2 = sprintf("%x", $y2);		

#		print("VA1=$unva, VA2=$va, y1=$y1, y2=$y2\n");
		if ($va eq $y1) {
#			print("$instr VA=$unva, VA(+0x20)=$va\n");
			$sum++;
			if ($dif != 0) {
				$k++;
				$diff[$k] = $dif;
#				print("$dif\n");
				$dif = 0;
			}
		} elsif ($va eq $y2) {
			$diff++;
			if ($sum != 0) {
				$j++;
				$summ[$j] = $sum;
#				print("$sum\n");
				$sum = 0;
			}
		}
	}
}
#print(sort(@summ));
#print(sort(@diff));

$n = 1;
#@summ = sort(@summ);
@summ = sort { $a <=> $b } @summ;
for ($i = 1; $i <=$#summ; $i++) {
        if ($summ[$i] == $summ[$i + 1]) {
                $n++;
        }
        if ($summ[$i] != $summ[$i + 1]) {
                print("successively increment= $summ[$i], repeat = $n\n");
                $n = 1;
        }
}

$n = 1;
@diff = sort { $a <=> $b } @diff;
for ($i = 1; $i <=$#diff; $i++) {
        if ($diff[$i] == $diff[$i + 1]) {
                $n++;
        }
        if ($diff[$i] != $diff[$i + 1]) {
                print("successively decrement= $diff[$i], repeat = $n\n");
                $n = 1;
        }
}

#print("VA-20=$unaddr0x20, VA+20=$addr0x20\n");
#print("Sum 1=$s1, 2=$s2, 3=$s3, 4=$s4, 5=$s5\n");
#print("Diff 1=$d1, 2=$d2, 3=$d3, 4=$d4, 5=$d5\n");
close(FILE);
