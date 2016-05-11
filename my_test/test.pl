#!/usr/bin/perl

@num = (1, 4, 7, 3, 3, 2, 9, 4, 4, 4, 2);
$max = 0;
$sum = 0;

#список слов и количество повторений
for (sort { $num[$i] <=> $num[$i+1] } 0..$#num) {
	print "$num\n";
}

#поиск наибольшего числа
for ($i = 0; $i <=$#num; $i++) {
	if (($num[$i] > $num[$i + 1]) and ($num[$i] > $max)) {
		$max = $num[$i];
	}
}

#print($num);
#print($#num);
#%hash = map { $_, _ } @num;
#print(%hash);



#print($host{$addr});


#Количество повторений каждого элемента массива
print(sort(@num));
$n = 1;
@num = sort(@num);
for ($i = 0; $i <=$#num; $i++) {
	if ($num[$i] == $num[$i + 1]) {
		$n++;
	}
	if ($num[$i] != $num[$i + 1]) {
		print("i = $num[$i], sum = $n\n");
		$n = 1;
	}
}


#Цикл вывода цифр и количество их повторений
