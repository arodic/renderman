import sys,random
from math import sqrt,pow 
args = sys.stdin.readline()

while args:

	values = args.split()
	lenght = int(values[1])
	width = int(values[2])
	density = int(values[3])
	seed = int(values[4])
	random.seed(seed)
	
	f_lenght=float(lenght)
	f_width=float(width)
	
	print 'AttributeBegin'
		
	for i in range(density):
		print 'AttributeBegin'
		
		
		##width and shiftX
		random.seed(seed+1)
		randomWidth=random.randrange(-width, width, 1)
		print 'Translate %s 0 0' % (randomWidth)
		shiftX=f_lenght-(f_lenght*abs(randomWidth)/f_width)
		
		##depth and shiftZ
		random.seed(seed+2)
		randomDepth=random.randrange(-width, width, 1)
		print 'Translate 0 0 %s' % (randomDepth)
		shiftZ=f_lenght-(f_lenght*abs(randomDepth)/f_width)

		#height, local lenght and shiftY
		random.seed(seed+3)
		randomHeight=random.randrange(-5, 5, 1)
		
		local_lenght=int((shiftX+shiftZ)/1)
		
		shiftY=(shiftZ+shiftX)-8
		
		print 'Translate 0 %s 0' % (shiftY)
		
		##color
		#ShiftXZ=sqrt((abs(shiftX)**2)+(abs(shiftZ)**2))*sqrt(2)
		#color = (ShiftXZ)/f_width
		#print 'Color %s %s %s' % (color, color, color)
		
		random.seed(seed+4)
		print 'Rotate %s 1 0 0' % (random.randrange(-2, 2, 1))
		random.seed(seed+5)
		print 'Rotate %s 0 1 0' % (random.randrange(-360, 360, 1))
		random.seed(seed+6)
		print 'Rotate %s 0 0 1' % (random.randrange(-2, 2, 1))
		
		print 'ReadArchive "RIB_Archive/Start%s_lod.rib"' % (random.randrange(1, 5, 1))
			
		seed = seed+10
			
		for i in range(local_lenght):
			print 'AttributeBegin'
			print 'Translate 0 -10 0'
			random.seed(seed+1)
			print 'Rotate %s 0 1 0' % (random.randrange(-360, 360, 1))
			random.seed(seed+2)
			print 'ReadArchive "RIB_Archive/Segment%s_lod.rib"' % (random.randrange(1, 5, 1))
			seed += 3
			
		for i in range(local_lenght):
			print 'AttributeEnd'

		
		print 'AttributeEnd'	
	print 'AttributeEnd'
	
	sys.stdout.write('\377')
	sys.stdout.flush()	
	args = sys.stdin.readline()
