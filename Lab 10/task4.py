from pymongo import MongoClient
import datetime

client = MongoClient("mongodb://localhost")

db = client['test']


def check_number_of_A_grade(restaurant):
    grades = restaurant.grades
    return len([x for x in grades if x.grade == 'A'])

def execute_task():
    cursor = db.restaurant.find({"address.street" : "Prospect Park West"})
    for restaurant in cursor:
        if check_number_of_A_grade(restaurant=restaurant) > 1:
            db.restaurant.delete_one(restaurant)
        else:
            new = {'date': datetime.datetime.now(), 'grade': 'A', 'score': 11}
            db.restuarant.update_one(restaurant, {"$push": { 'grades': new }})

execute_task()