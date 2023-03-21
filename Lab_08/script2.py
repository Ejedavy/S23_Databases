# create db
# psql -d template1
import psycopg2
from time import sleep
import pandas as pd


#def update_

# https://stackabuse.com/working-with-postgresql-in-python/
con = psycopg2.connect(database="dvdrental", user="postgres",
                       password="pragya56", host="127.0.0.1", port="5432")

cursor = con.cursor()
parameters = [24,40]
cursor.callproc('retrievecustomers',parameters)
result = cursor.fetchall()
df = pd.DataFrame(result)
df.columns = ["customer_id", "store_id", "first_name", "last_name", "email", "address_id", "activebool", "create_date", "last_updaate", "active"]
print(df)
