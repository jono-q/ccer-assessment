from dotenv import load_dotenv
import os
import pandas as pd
import psycopg2
from psycopg2 import extras
from io import StringIO
import numpy

db_host = '0.0.0.0'
db_port = '5432'
db_name = 'ccer'

load_dotenv()

db_user = os.environ.get('db_user')
db_password = os.environ.get('db_password')

table_create_script = os.path.join(os.path.dirname(__file__), '../scripts/create_raw_school_list.sql')
school_list_txt = os.path.join(os.path.dirname(__file__), '../source_files/RoadMapProjectSchoolList.txt')

field_names = [
'academic_year', 
'school_code', 
'district_code',
'd_road_map_region_flag',
'elementary_school_flag', 
'middle_school_flag', 
'high_school_flag', 
'street_address',                                                                                        
'city',                                                                                                 
'state', 
'zip',   
'lat',                                     
'long'
]

col_specs = [(0,12), (13,23), (24,36), (37,38), (56,57), (77,78), (94,95), (109,209), (210,310), (311,313), 
            (317,322), (323,362), (363,374)]

df = pd.read_fwf(school_list_txt, skiprows=2, skipfooter=6, index_col=False, names=field_names, colspecs=col_specs, \
                converters={x:str for x in field_names})

conn = psycopg2.connect(host = db_host, port = db_port, database = db_name, user = db_user, password = db_password)
conn.autocommit = True

cursor = conn.cursor()

with open(table_create_script) as f:
    sql = f.read()

cursor.execute(sql)


tuples = [tuple(x) for x in df.to_numpy()]
columns = ','.join(list(df.columns))
sql = 'INSERT INTO %s(%s) VALUES %%s' % ('demo.raw_school_list', columns)

extras.execute_values(cursor, sql, tuples)

cursor.close
conn.commit
conn.close
