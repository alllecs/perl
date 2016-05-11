#!/bin/bash

str=$1
if [[ $str == *log1a.txt ]]
then
	test_addr=$str
else
	test_addr=$1/*/log1a.txt
fi

#echo $test_addr

/home/alllecs/perl/working/buf.pl $test_addr 2>&1 | tee stat_buf.txt
#/home/alllecs/perl/buf/scan_buf_V5.pl $test_addr >> stat.txt
/home/alllecs/perl/working/storeload_hm.pl $test_addr 2>&1 | tee stat_loadstore.txt
/home/alllecs/perl/working/writeback.pl $test_addr 2>&1 | tee stat_writeback.txt
/home/alllecs/perl/working/branch_jump.pl $test_addr 2>&1 | tee stat_branch.txt

cat stat_buf.txt > stat.txt
cat stat_loadstore.txt >> stat.txt
cat stat_writeback.txt >> stat.txt
cat stat_branch.txt >> stat.txt
rm stat_buf.txt stat_loadstore.txt stat_writeback.txt stat_branch.txt

#echo "The end"
