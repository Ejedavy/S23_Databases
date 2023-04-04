from pymongo import MongoClient

client = MongoClient("mongodb://localhost")

db = client['test']


def delete_Brooklyn():
    cursor = db.restaurants.delete_one({"borough": "Brooklyn"})
    

def delete_all_Thai():
    cursor = db.restaurants.delete_many({'cuisine' : "Thai"})

delete_Brooklyn()
delete_all_Thai()
