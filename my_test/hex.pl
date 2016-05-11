#!/usr/bin/perl

$x = 'ffffffffa2000190';

$y = hex($x);
$yy = $y + 0x20;
$yy = $y - 0x20;
$xx = sprintf("%x", $yy);
print("$y,== $x,== $yy,== $xx\n");
