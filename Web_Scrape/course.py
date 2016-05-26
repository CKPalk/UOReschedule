import re

class Course( object ):

	def __init__( self, rows ):
		self.interpretRows( rows )

	''' BUILT-IN '''
	def __repr__( self ):
		return "{} : {:8} > {}".format( self.crn, self.subcode, self.classname )

	''' HELPER '''
	def interpretRows( self, rows ):
		self.interpretRowHeader( rows[0] )
		self.interpretRowData  ( rows[1] )
	
	def interpretRowHeader( self, row ):
		# 'CTG 213 Intro Accounting II 4.00 cr.', 
		words = row.split()
		self.subcode   = ' '.join( words[  : 2] )
		self.classname = ' '.join( words[ 2:-2] )
		self.credits   = ' '.join( words[-2:  ] )
		return
		
	def interpretRowData( self, row ):
		# '10050 20 80 1200-1350 tr 220 HED Turner D AU'
		# '+ Lab 10104 12 26 0800-0850 r 373 MCK tba A'
		words = row.split()
		print( words )
		if re.match( '[1-9][0-9]{4}', words[ 0 ] ):
			self.tag = None
			self.crn = words[ 0 ]
			next_idx = 1
		else:
			if words[0] is '+':
				self.tag = ' '.join( words[ :1 ] )
				self.crn = words[ 2 ]
				next_idx = 3
			else:
				self.tag = words[ 0 ]
				self.crn = words[ 1 ]
				next_idx = 2
		self.avail_seats = words[ next_idx 	   ]
		self.max_seats   = words[ next_idx + 1 ]
		self.time		 = words[ next_idx + 2 ]
		self.days 		 = self.readDayString( \
							words[ next_idx + 3 ] )
		if re.match( '[0-9]+', words[ next_idx + 4 ] ):
			self.location   = ' '.join( words[ next_idx + 4 : next_idx + 6 ] )
			self.instructor = ' '.join( words[ next_idx + 6 : -1 ] )
		else:
			self.location   = words[ next_idx + 4 ]
			self.instructor = ' '.join( words[ next_idx + 5 : -1 ] )
		self.notes = words[ -1 ]
		return

	def readDayString( self, string ):
		if string is 'tba': return None
		days = []
		for day in list( string ):
			if day is 'm': days.append( 'Monday' 	); continue
			if day is 't': days.append( 'Tuesday' 	); continue
			if day is 'w': days.append( 'Wednesday' ); continue
			if day is 'r': days.append( 'Thursday' 	); continue
			if day is 'f': days.append( 'Friday' 	); continue
			if day is 's': days.append( 'Saturday' 	); continue
			if day is 'u': days.append( 'Sunday' 	); continue
		return days


if __name__ == '__main__':
	c = Course( [ "CTG 213 Intro Accounting II 4.00 cr.", \
				  "10050 20 80 1200-1350 tr 220 HED Turner D AU" ] )

	c2 = Course( [ "PEAQ 351 Lifeguard Certificate 1.00 cr.", \
				   "14733 13 23 1400-1520 t 10/25-11/22 87 SRC Vearrier R APV" ] )

	print( c.subcode )
	print( c.classname )
	print( c.credits )
	print( c.tag )
	print( c.crn )
	print( c.avail_seats )
	print( c.max_seats )
	print( c.time )
	print( c.days )
	print( c.location )
	print( c.instructor )
	print( c.notes )
