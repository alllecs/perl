F = open('number.txt')
i = 0

while i < 7:
	line = F.readline()
	line = line.strip()
#	print (len(line))
	if (len(line) <= 6):
		continue
	elif (len(line) == 14):
		print line[6:]
#	elif (len(line) == 22):
#		print line[14:]
	else:
		print line[14:]
	i += 1

while i < 13:
	line = F.readline()
	line = line.strip()
#	print (len(line))
	if i == 7:
		x = line[-40:]
		print x
	elif i == 8:
		print line[-40:-8]
	elif i == 9:
		print line[-32:-8]
	elif i == 10:
		print line[-32:-16]
	elif i == 11:
		print line[-24:-16]
	elif i == 12:
		print line[-32:-24]
	i += 1


line = F.readline()
print line[30:-42]
