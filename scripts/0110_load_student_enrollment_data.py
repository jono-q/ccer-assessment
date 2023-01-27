from dotenv import load_dotenv
import os
import psycopg2

table_create_script = os.path.join(os.path.dirname(__file__), '../scripts/create_raw_student_enrollment.sql')
student_enrollment_csv = os.path.join(os.path.dirname(__file__), '../source_files/student_enrollment.csv')

db_host = '0.0.0.0'
db_port = '5432'
db_name = 'ccer'

load_dotenv()

db_user = os.environ.get('db_user')
db_password = os.environ.get('db_password')

conn = psycopg2.connect(host = db_host, port = db_port, database = db_name, user = db_user, password = db_password)
conn.autocommit = True

cursor = conn.cursor()

with open(table_create_script) as f:
    sql = f.read()

cursor.execute(sql)

sql = "COPY demo.raw_student_enrollment FROM STDIN WITH HEADER CSV NULL 'NULL'"

with open(student_enrollment_csv) as f:
    cursor.copy_expert(sql, f)

#cursor.execute(sql)

conn.commit
conn.close