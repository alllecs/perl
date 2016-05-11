#!/usr/bin/perl
#work!

$p  = 0;
$b = $bne = $j = $beq = $bal = $jal = $jr = $beql = $bgez = $blez = $jalr = 0;
while (<STDIN>) {
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

print ("\n b=$b,\n bne=$bne,\n j=$j,\n beq=$beq,\n bal=$bal,\n blezl=$blezl,\n jal=$jal,\n jr=$jr,\n beql=$beql,\n bgez=$bgez,\n blez=$blez,\n jalr=$jalr\n");
print ("Jump direction: forward=$forward, back=$ago\n");
print ("Cycle short(addr<0x38) =$short, long=$long\n");
print ("Taken:$ye, not taken:$no\n");

