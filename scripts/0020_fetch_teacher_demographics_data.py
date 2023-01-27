

import os
import csv
import requests

# Ordinarily I would access this via the Socrata Open Data API, but that requires an app token for full access.
# For expediency and to avoid the need to create a data.wa.gov account right now, I'm accessing the direct download link.
teacher_demographics_csv_url = 'https://data.wa.gov/api/views/y59b-6pu8/rows.csv?accessType=DOWNLOAD'

teacher_demographics_csv = os.path.join(os.path.dirname(__file__), '../source_files/teacher_demographics.csv')

teacher_demographics_data = requests.get(teacher_demographics_csv_url)

with open(teacher_demographics_csv, 'wb') as f:
    f.write(teacher_demographics_data.content)
