import metadata
import sys
import requests
import lxml.html as lh
import re
import random
from course import Course



def isCourseHeader( row ):
	return re.search( metadata.CLASS_ID_REGEX, row.text_content() ) is not None
#

def getCRNRows( idx, rows ):
	return [ rows[idx] for idx in [0,idx] ]
#

def cleanRows( rows ):
	return [ [ ' '.join( cell.text_content().split() ) for cell in row ] \
			for row in rows ]
#

def cleanForCSV( val ):
	return '|'.join( val.split( ',' ) )

def rowsToDict( rows ):
	rows = cleanRows( rows )
	vals = re.split( r'(?<=[0-9]) +(?=[A-Z])', rows[0][0] ) + rows[0][1:]
	vals.extend( rows[1] )
	return { key : cleanForCSV( val ) for key,val in zip( Course.COURSE_KEYS, vals ) }
#
	
def getCourseMap( html ):

	Courses = dict()

	data = lh.fromstring( html )
	rows = getTable( data )

	if 'No classes were found' in rows[0].text_content():
		return None

	course_rows = []
	rows = filter( lambda x: x.text_content().strip(), rows )
	for row in rows:
		if isCourseHeader( row ) and course_rows:
			for idx, crn in enumerate( getCRNS( course_rows ) ):
				crn_rows = getCRNRows( idx + metadata.CRN_START_INDEX, course_rows )
				if re.search( 'cancelled', crn_rows[1].text_content(), re.IGNORECASE ):
					continue
				course_dictionary = rowsToDict( crn_rows )
				if len( course_dictionary.keys() ) != len( Course.COURSE_KEYS ):
					continue
				Courses[ crn ] = Course( course_dictionary )
			course_rows = []
		course_rows.append( row )

	return Courses
#

def getName( rows ):
	return re.search( metadata.CLASS_ID_REGEX, rows[0].text_content() ).group(0)
#

def getCRNS( rows ):
	matches = []
	for row in rows[ metadata.CRN_START_INDEX: ]:
		match = re.search( metadata.CLASS_CRN_REGEX, row.text_content() )
		if match is not None:
			matches.append( match.group(0) )
	return matches
#

def getTable( data ):
	return data.cssselect( 'table' )[ metadata.table_index ] \
			   .cssselect( 'tr'    )
#

def writeCSV( csv_filename, Courses ):
	with open( csv_filename, 'w+' ) as csv:
		csv.write( Course.getCSVHeader() )
		for course in Courses.values():
			csv.write( course.csvPrintable() )
#

def nextURL( new_page_index ):
	return metadata.URL_FORMAT.format( metadata.TERM_CODE, new_page_index * metadata.COURSES_PER_PAGE )

''' MAIN '''
def main( argv ):
	
	Courses = dict()

	page_index = 0
	url = nextURL( page_index )
	page = requests.get( url )
	while( page.status_code == 200 ):

		# Successful request, read new pages courses
		CourseMap = getCourseMap( page.content )
		if CourseMap:
			Courses.update( getCourseMap( page.content ) )
			page_index += 1
			print( "Courses:", len( Courses.keys() ) )
			url = nextURL( page_index )
			page = requests.get( url )
		else:
			break



	csv_filename = argv[ 1 ]
	writeCSV( csv_filename, Courses )



	print( "COURSES FOUND:", len( Courses.keys() ) )
	print( '\n--- END ---\n' )
#




if __name__ == '__main__':
	main( sys.argv )
#
