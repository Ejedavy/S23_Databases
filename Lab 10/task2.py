from pymongo import MongoClient
import datetime

client = MongoClient("mongodb://localhost")

db = client['test']

def insert_restaurant():
    db.restaurants.insert_one(
    {'address': {
        'street': 'Sportivnaya',
        'building': 126,
        'zipcode': 420500,
        'coord': [-73.9557413, 40.7720266]
    },
    'borough': 'Innopolis',
    'cuisine': 'Serbian',
    'name': 'The Best Restaurant',
    'id': 41712354,
    'grades': [{
        'date': datetime.datetime.strptime("2023-04-04T10:53:53.000Z", "%Y-%m-%dT%H:%M:%S.000Z"),
        'grade': 'A',
        'score': 11
    }] 
    }
    )
    cursor = db.restaurants.find({'cuisine' : "Serbian"})
    for element in cursor:
        print(element)

insert_restaurant()