#!/usr/bin/perl

$shh = $smm = $shm = $smh = 0;
$sh = $sm = 0;
$lhh = $lmm = $lhm = $lmh = 0;
$lh = $lm = 0;
$d1 = $d2 = $d3 = $d4 = $d5 = 0;
$s1 = $s2 = $s3 = $s4 = $s5 = 0;


open (FILE, $ARGV[0]) or die $!;
while (<FILE>) {
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

		#Перевод из 16 в 10 систему		
		$y1 = hex($unva);
		$y1 = $y1 + 0x20;
		$y1 = sprintf("%x", $y1);		

		$y2 = hex($unva);
		$y2 = $y2 - 0x20;
		$y2 = sprintf("%x", $y2);		

#		print("VA1=$unva, VA2=$va, y1=$y1, y2=$y2\n");
		if ($va eq $y1) {
			print("$instr VA=$unva, VA(+0x20)=$va\n");
			$addr0x20++;
			$sum++;
			if ($diff == 1) {
				$d1++;
			} elsif ($diff == 2) {
				$d2++;
			} elsif ($diff == 3) {
				$d3++;
			} elsif ($diff == 4) {
				$d4++;
			} elsif ($diff == 5) {
				$d5++;
			}
			$i++;
			$dif[$i] = $diff;
			$diff = 0;
		} elsif ($va eq $y2) {
			print("$instr VA=$unva, VA(-0x20)=$va\n");
			$unaddr0x20++;
			$diff++;
			if ($sum == 1) {
				$s1++;
			} elsif ($sum == 2) {
				$s2++;
			} elsif ($sum == 3) {
				$s3++;
			} elsif ($sum == 4) {
				$s4++;
			} elsif ($sum == 5) {
				$s5++;
			}
			$j++;
			$summ[$j] = $sum;
			$sum = 0;
		}

		&hit_miss;
	}
}
sub hit_miss {
	if ($uninstr eq $instr) {
		if ($uns_l eq 'store' and $s_l eq 'store') {
			if ($unh_m eq 'hit' and $h_m eq 'hit') {
				$shh++;
			} elsif ($unh_m eq 'miss' and $h_m eq 'miss') {
				$smm++;
			} elsif ($unh_m eq 'hit' and $h_m eq 'miss') {
				$shm++;
			} elsif ($unh_m eq 'miss' and $h_m eq 'hit') {
				$smh++;
			}
		} elsif ($uns_l eq 'load' and $s_l eq 'load') {
			if ($unh_m eq 'hit' and $h_m eq 'hit') {
				$lhh++;
			} elsif ($unh_m eq 'miss' and $h_m eq 'miss') {
				$lmm++;
			} elsif ($unh_m eq 'hit' and $h_m eq 'miss') {
				$lhm++;
			} elsif ($unh_m eq 'miss' and $h_m eq 'hit') {
				$lmh++;
			}
		}
	} elsif ($s_l eq 'store') {
		if ($unh_m eq 'hit' and $h_m eq 'hit') {
			$sh++;
		} elsif ($unh_m eq 'miss' and $h_m eq 'miss') {
			$sm++;
		}
	} elsif ($s_l eq 'load') {
		if ($unh_m eq 'hit' and $h_m eq 'hit') {
			$lh++;
		} elsif ($unh_m eq 'miss' and $h_m eq 'miss') {
			$lm++;
		}
	}
}
#print("store hit, store hit=$shh,\nstore miss, store miss=$smm \n");
#print("store hit, store miss=$shm,\nstore miss, store hit=$smh \n");
#print("load hit, load hit=$lhh,\nload miss, load miss=$lmm \n");
#print("load hit, load miss=$lhm,\nload miss, load hit=$lmh \n");
#print("store hit=$sh,\nstore miss=$sm \n");
#print("load hit=$lh,\nload miss=$lm \n");
print("VA-20=$unaddr0x20, VA+20=$addr0x20\n");
print("Sum 1=$s1, 2=$s2, 3=$s3, 4=$s4, 5=$s5\n");
print("Diff 1=$d1, 2=$d2, 3=$d3, 4=$d4, 5=$d5\n");

#print("ss=$twos, ll=$twol, s=$s, l=$l \n");
#print("hh=$hh mm=$mm hm=$hm mh=$mh\n");
close(FILE);
