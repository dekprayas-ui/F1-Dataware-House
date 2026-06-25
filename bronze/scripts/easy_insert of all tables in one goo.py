import os
import pandas as pd
from sqlalchemy import create_engine

# 1. Connect to your local SQL Server Express using Windows Authentication
connection_string = (
    "mssql+pyodbc://@.\\SQLEXPRESS/F1"
    "?driver=ODBC+Driver+17+for+SQL+Server"
    "&trusted_connection=yes"
)
engine = create_engine(connection_string)

# 2. Path to your F1 CSV folder
folder_path = r'C:\Users\princ\Desktop\Coding\PYTHON\data_cleaning\F1'

# 3. Loop through and import every CSV file
for file in os.listdir(folder_path):
    if file.endswith('.csv'):
        file_path = os.path.join(folder_path, file)
        
        # Get table name from file name (e.g., 'circuits.csv' -> 'circuits')
        table_name = os.path.splitext(file)[0]
        
        print(f"Importing {file} into SQL Server table 'bronze.{table_name}'...")
        
        # Read the CSV
        df = pd.read_csv(file_path)
        
        # Push to the 'bronze' schema. If table exists, it will overwrite it.
        df.to_sql(name=table_name, schema='bronze', con=engine, if_exists='replace', index=False)

print("\n Success! All 14 CSV files have been imported into your SQL Server database.")