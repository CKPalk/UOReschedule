import re
import metadata

class Course( object ):

	COURSE_KEYS = [ 'coursecode', 	'coursename', 	'credits',
					'tag', 			'crn', 			'avail_seats', 	
					'max_seats', 	'time', 		'day', 
					'location', 	'instructor', 	'notes' ]

	def __init__( self, _data_map ):
		self.coursecode  = _data_map[ self.COURSE_KEYS[ 0] ]
		self.coursename  = _data_map[ self.COURSE_KEYS[ 1] ]
		self.credits 	 = _data_map[ self.COURSE_KEYS[ 2] ]
		self.tag 		 = _data_map[ self.COURSE_KEYS[ 3] ]
		self.crn 		 = _data_map[ self.COURSE_KEYS[ 4] ]
		self.avail_seats = _data_map[ self.COURSE_KEYS[ 5] ]
		self.max_seats 	 = _data_map[ self.COURSE_KEYS[ 6] ]
		self.time 		 = _data_map[ self.COURSE_KEYS[ 7] ]
		self.day 		 = _data_map[ self.COURSE_KEYS[ 8] ]
		self.location 	 = _data_map[ self.COURSE_KEYS[ 9] ]
		self.instructor  = _data_map[ self.COURSE_KEYS[10] ]
		self.notes 		 = _data_map[ self.COURSE_KEYS[11] ]
	#

	''' BUILT-IN '''
	def __repr__( self ):
		return "{} : {:8} > {:24} by {}".format( 
					self.crn, 
					self.coursecode, 
					self.classname,
					self.instructor
				)

	''' HELPER '''
	def readDayString( self, string ):
		if string is 'tba': return None
		else: return string
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
	print( "Nothing to run" )
