

import os
import csv
import requests

# Ordinarily I would access this via the Socrata Open Data API, but that requires an app token for full access.
# For expediency and to avoid the need to create a data.wa.gov account right now, I'm accessing the direct download link.
student_enrollment_csv_url = 'https://data.wa.gov/api/views/nvpc-yr7b/rows.csv?accessType=DOWNLOAD'

student_enrollment_csv = os.path.join(os.path.dirname(__file__), '../source_files/student_enrollment.csv')

student_enrollment_data = requests.get(student_enrollment_csv_url)

with open(student_enrollment_csv, 'wb') as f:
    f.write(student_enrollment_data.content)

