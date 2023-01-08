#!/usr/bin/python3
import re
import time

output = ""

if __name__=="__main__" :

    max = 275

    with open( ".spaceclock.txt", 'r+' ) as file:
        line = file.read( )
        line = line.strip( )

        output = int(line)*' ' 
        output += ' '
        int_line = int( line )
        int_line = int_line+1

        if int_line > max :
            int_line = 0

        file.seek( 0 )
        file.write( str( int_line ) )
        file.truncate( )
        file.close( )
        print( output )

