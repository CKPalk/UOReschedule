import metadata
import sys
import requests
import lxml.html as lh
import re
import random
from course import Course



def isClassHeader( row ):
	return re.search( metadata.CLASS_ID_REGEX, row.text_content() ) is not None
#

def getCRNRows( idx, rows ):
	return [ ' '.join( rows[idx].text_content().split() ) for idx in [0,idx] ]
#
	
def getClassMap( rows ):
	Classes = dict()

	class_rows = []
	rows = filter( lambda x: x.text_content().strip(), rows )
	for row in rows:
		if isClassHeader( row ) and class_rows:
			for idx, crn in enumerate( getCRNS( class_rows ) ):
				crn_rows = getCRNRows( idx + metadata.CRN_START_INDEX, class_rows )
				if re.search( 'cancelled', crn_rows[1], re.IGNORECASE ):
					continue
				Classes[ crn ] = Course( crn_rows )
			class_rows = []
		class_rows.append( row )

	return Classes
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





''' MAIN '''
def main( argv ):
	page = requests.get( metadata.url )
	print( page )

	data = lh.fromstring( page.content )
	
	rows = getTable( data )

	Classes = getClassMap( rows )


	for key, val in Classes.items():
		print( val )

	print( len( Classes.keys() ) )
#




if __name__ == '__main__':
	main( sys.argv )
#
