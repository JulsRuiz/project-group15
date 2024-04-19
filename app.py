#! /usr/bin/python3

"""
This is an example Flask | Python | Psycopg2 | PostgreSQL
application that connects to the 7dbs database from Chapter 2 of
_Seven Databases in Seven Weeks Second Edition_
by Luc Perkins with Eric Redmond and Jim R. Wilson.
The CSC 315 Virtual Machine is assumed.

John DeGood
degoodj@tcnj.edu
The College of New Jersey
Spring 2020

----

One-Time Installation

You must perform this one-time installation in the CSC 315 VM:

# install python pip and psycopg2 packages
sudo pacman -Syu
sudo pacman -S python-pip python-psycopg2 python-flask

----

Usage

To run the Flask application, simply execute:

export FLASK_APP=app.py 
flask run
# then browse to http://127.0.0.1:5000/

----

References

Flask documentation:  
https://flask.palletsprojects.com/  

Psycopg documentation:
https://www.psycopg.org/

This example code is derived from:
https://www.postgresqltutorial.com/postgresql-python/
https://scoutapm.com/blog/python-flask-tutorial-getting-started-with-flask
https://www.geeksforgeeks.org/python-using-for-loop-in-flask/
"""

import psycopg2
from config import config
import matplotlib.pyplot as plt
import numpy as np

import matplotlib as mpl
#from flask import Flask, render_template, request

# Connect to the PostgreSQL database server
def connect(query):
    conn = None
    try:
        # read connection parameters
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the %s database...' % (params['database']))
        conn = psycopg2.connect(**params)
        print('Connected.')
      
        # create a cursor
        cur = conn.cursor()
        
        # execute a query using fetchall()
        cur.execute(query)
        rows = cur.fetchall()

        # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
    # return the query result from fetchall()
    return rows

def read_file_to_string(filename):
	file = open(filename, 'r')
	content = file.read()
	return content
 
if __name__ == '__main__':
	#read queries into string
	query = read_file_to_string('query.txt')
	row = connect(query)
	
	data = []
	for i in range(0, len(row)):
		if(row[i][0] is not None and row[i][0].days is not None and row[i][0].days > 0):
			data.append(row[i][0].days)

	nPoints = len(data)
	nBins = 40
	fig, axs = plt.subplots(1, 1, sharey=True, tight_layout=True)
	axs.hist(data, bins=nBins)
	plt.show()

	#second query
	query = read_file_to_string('query2.txt')
	year1 = input("Enter year 1: \n")
	year2 = input("Enter year 2: \n")
	
	print(connect(query + " SELECT * FROM averages WHERE Year=" + year1 + " OR Year=" + year2 + ";"))
