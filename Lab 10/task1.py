from pymongo import MongoClient

client = MongoClient("mongodb://localhost")

db = client['test']



def query_irish():
    cursor = db.restaurants.find({'cuisine' : "Irish"})
    for element in cursor:
        print(element)


def query_irish_or_Russian():
    cursor = db.restaurants.find({"cuisine": {"$in": ["Irish", "Russian"]}})
    for element in cursor:
        print(element)

def find_restaurant():
    cursor = db.restaurants.find({'address.building': "284", 'address.street': 'Prospect Park West', 'address.zipcode': "11215"})
    for element in cursor:
        print(element)

find_restaurant()

