#!/usr/bin/perl

$shh = $smm = $shm = $smh = 0;
$sh = $sm = 0;
$lhh = $lmm = $lhm = $lmh = 0;
$lh = $lm = 0;
$x = 0;
open (FILE, $ARGV[0]) or die $!;
while (<FILE>) {
	if (/(\d+).*(store|load).*(hit|miss).*(VA=)(.{16}).*(PA=)(.{8}).*/) {
		$uninstr = $instr;
		$instr = $1;
		$uns_l = $s_l;
		$s_l = $2;
		$unh_m = $h_m;
		$h_m = $3;
		$va = $5;
		$pa = $7;
#		print("$instr, $s_l, $h_m, $va, $pa\n");
		&hit_miss;

	}
}
sub hit_miss {
	if ($uninstr eq $instr) {
		if ($uns_l eq 'store' and $s_l eq 'store') {
			if ($unh_m eq 'hit' and $h_m eq 'hit') {
				$shh++;
				$x++;
			} elsif ($unh_m eq 'miss' and $h_m eq 'miss') {
				$smm++;
				$x++;
			} elsif ($unh_m eq 'hit' and $h_m eq 'miss') {
				$shm++;
				$x++;
			} elsif ($unh_m eq 'miss' and $h_m eq 'hit') {
				$smh++;
				$x++;
			}
		} elsif ($uns_l eq 'load' and $s_l eq 'load') {
			if ($unh_m eq 'hit' and $h_m eq 'hit') {
				$lhh++;
				$x++;
			} elsif ($unh_m eq 'miss' and $h_m eq 'miss') {
				$lmm++;
				$x++;
			} elsif ($unh_m eq 'hit' and $h_m eq 'miss') {
				$lhm++;
				$x++;
			} elsif ($unh_m eq 'miss' and $h_m eq 'hit') {
				$lmh++;
				$x++;
			}
		}
	} elsif (($s_l eq 'store') and ($uninstr ne $instr)) {
		if ($unh_m eq 'hit' and $h_m eq 'hit') {
			$sh++;
			$x++;
		} elsif ($unh_m eq 'miss' and $h_m eq 'miss') {
			$sm++;
			$x++;
		}
	} elsif ($s_l eq 'load') {
		if ($unh_m eq 'hit' and $h_m eq 'hit') {
			$lh++;
			$x++;
		} elsif ($unh_m eq 'miss' and $h_m eq 'miss') {
			$lm++;
			$x++;
		}
	}
}


print("store hit,  store hit = $shh, \t");
printf("%.1f%\n", ($shh / $x) * 100);
print("store miss,store miss = $smm, \t");
printf("%.1f%\n", ($smm / $x) * 100);
print("store hit, store miss = $shm, \t");
printf("%.1f%\n", ($shm / $x) * 100);
print("store miss, store hit = $smh, \t");
printf("%.1f%\n", ($smh / $x) * 100);
print("load  hit,   load hit = $lhh, \t");
printf("%.1f%\n", ($lhh / $x) * 100);
print("load  miss, load miss = $lmm, \t");
printf("%.1f%\n", ($lmm / $x) * 100);
print("load  hit,  load miss = $lhm, \t");
printf("%.1f%\n", ($lhm / $x) * 100);
print("load  miss,  load hit = $lmh, \t");
printf("%.1f%\n", ($lmh / $x) * 100);
print("store  hit = $sh, \t\t");
printf("%.1f%\n", ($sh / $x) * 100);
print("store miss = $sm, \t\t");
printf("%.1f%\n", ($sm / $x) * 100);
print("load   hit = $lh, \t\t");
printf("%.1f%\n", ($lh / $x) * 100);
print("load  miss = $lm, \t\t");
printf("%.1f%\n", ($sm / $x) * 100);
print("All load and store = $x\t");
printf("%.1f%\n", ($x / $x) * 100);
#print("ss=$twos, ll=$twol, s=$s, l=$l \n");
#print("hh=$hh mm=$mm hm=$hm mh=$mh\n");
