#!/bin/bash

#echo $test_addr
/home/alllecs/perl/script_sw/hit_miss_V7.pl > stat_amp.txt
#/home/alllecs/perl/buf/scan_buf_V5.pl $test_addr >> stat.txt
/home/alllecs/perl/buf/scan_buf_V4_amp.pl >> stat_amp.txt
/home/alllecs/perl/jump/branch_V3_amp.pl >> stat_amp.txt
#echo "The end"
