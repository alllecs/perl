#!/usr/bin/perl

open (FILE, $ARGV[0]) or die $!;
while (<FILE>) {
	if (/(^\s+)(.{6})\s+(.{6})\s+(.{6})\s+(.{6})\s+(.{6})\s+(.{6})\s+(.{6})\s+(.{6}).*/) {
		print "$2, $3, $4, $5, $6, $7, $8, $9\n";
#		$x = $2 * 1;
#		$y = $2 + 0;
#		print "----$y------$x\n";
		if ($2 != 0) {
#			print "12341241\n";
		} elsif ($2 == 0) {
#			print "------\n";
		
		}
		if ($5 != 0 and $2 == 0 and $6 == 0) {
			print "1---\n";
			$line = 1;
			$x = 1;
		} elsif ($5 + 0 == $5 and $6 + 0 == $6 and $4 + 0 != $4) {
			print "2---\n";
			$line = 2;
			$x++;
		} elsif ($5 + 0 == $5 and $6 + 0 == $6 and $4 + 0 == $4 and $7 + 0 != $7 and $2 + 0 != $2) {
			print "3---\n";
			$line = 3;
			$x++;
		} elsif ($5 + 0 == $5 and $6 + 0 == $6 and $4 + 0 == $4 and $7 + 0 == $7 and $2 + 0 != $2) {
			print "4---\n";
			$line = 4;
			$x++;
		} elsif ($2 + 0 == $2 and $3 + 0 == $3 and $4 + 0 == $4 and $5 + 0 == $5 and $6 + 0 != $6) {
			print "5---\n";
			$line = 5;
			$x++;
		} elsif ($2 + 0 == $2 and $3 + 0 == $3 and $4 + 0 == $4 and $5 + 0 == $5 and $6 + 0 == $6 and $7 + 0 != $7) {
			print "6---\n";
			$line = 6;
			$x++;
		} elsif ($2 + 0 == $2 and $3 + 0 == $3 and $4 + 0 == $4 and $5 + 0 == $5 and $6 + 0 == $6 and $7 + 0 == $7 and $8 + 0 != $8) {
			print "7---\n";
			$line = 7;
			$x++;
		} elsif ($2 + 0 == $2 and $3 + 0 == $3 and $4 + 0 == $4 and $5 + 0 == $5 and $6 + 0 == $6 and $7 + 0 == $7 and $8 + 0 == $8 and $9 + 0 != $9) {
			print "8---\n";
			$line = 8;
			$x++;
		} elsif ($2 * 1 != 0 and $3 + 0 != 0 and $4 + 0 != 0 and $5 + 0 != 0 and $6 + 0 != 0 and $7 + 0 != 0 and $8 + 0 != 0 and $9 + 0 != 0) {
			print "9---\n";
			$line = 9;
			$x++;
		}
		
		if ($line == 2 and $x == 2) {
			print "\t\t\t\t$6\n";

		} elsif ($line == 3 and $x == 3) {
			print "\t\t\t\t $6\n";
		} elsif ($line == 4 and $x == 4) {
			print "\t\t\t\t$6\t$7\n";
		} elsif ($line == 5 and $x == 5) {
			print "\t\t\t\t $5\t $6\n";
		} elsif ($line == 6 and $x == 6) {
			print "\t\t\t\t$5\t$6\t$7\n";
		} elsif ($line == 7 and $x == 7) {
			print "\t\t\t\t $6\t $7\t $8\n";
		} elsif ($line == 8 and $x == 8) {
			print "\t\t\t\t$6\t$7\t$8\t$9\n";

		}

#		if ($2 + 0 == $2) {
#			$str[$i] = $2;
#			$i++;
	}
}
