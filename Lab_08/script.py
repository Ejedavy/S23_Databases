# create db
# psql -d template1
import psycopg2
from faker import Faker
from geopy.geocoders import Nominatim
from time import sleep
import pandas as pd

from geopy.exc import GeocoderTimedOut

def do_geocode(address):
    geopy = Nominatim(user_agent="http", timeout=20)
    try:
        return geopy.geocode(address)
    except GeocoderTimedOut:
        return do_geocode(address)

#def update_

# https://stackabuse.com/working-with-postgresql-in-python/
con = psycopg2.connect(database="dvdrental", user="postgres",
                       password="pragya56", host="127.0.0.1", port="5432")

cursor = con.cursor()

# create the new columns
# cursor.execute('''alter table address add column latitude numeric(10, 2), add column longitude numeric(10, 2);''')
# con.commit()

cursor = con.cursor()
print("Database opened successfully")
cursor.callproc('get_addresses')

print("Fetching addresses")
result = cursor.fetchall()

df = pd.DataFrame(result[1])
df.columns = ['address']

print(df)

for row in result:
    location = do_geocode(row[1])
    longitude = 0
    latitude = 0 
    if location != None:
        longitude = location.longitude
        latitude = location.latitude
    longitude = round(longitude, 2)
    latitude = round(latitude, 2)
    row_id = row[0]
    # cursor = con.cursor()
    cursor.execute(f"Update address set latitude={latitude}, longitude={longitude} WHERE address_id={row_id};")
    con.commit()

con.commit()


# cursor = con.cursor()
# cursor.execute('''select count(*) from address''')
# size = cursor.fetchall()

# print(size)

# fake = Faker()

# cursor = con.cursor()
# cursor.execute("Insert into address(latitude, longitude) values() ")

#for i in range(1000):
 #   print(i)
   # cur.execute("INSERT INTO CUSTOMER (ID,Name,Address,review) VALUES ('"+ str(i)+"','"+fake.name()+"','"+fake.address()+"','"+fake.text()+"')")
  #  con.commit()
