import json

data = []

with open('file1.json', 'r') as f:
  data.append(json.load(f))
with open('file2.json', 'r') as f:
  data.append(json.load(f))
with open('file3.json', 'r') as f:
  data.append(json.load(f))
with open('file4.json', 'r') as f:
  data.append(json.load(f))

restaurants = []

count = 0
for row in data:
  for query in row:
    key = "code"
    if key not in query:
      for restaurant in query['restaurants']:
        restaurant['restaurant'].pop('offers', None)
        restaurant['restaurant'].pop('zomato_events', None)
        restaurant['restaurant'].pop('establishment_types', None)
        restaurant['restaurant'].pop('events_url', None)
        restaurants.append(restaurant['restaurant'])
    else:
        continue  

for key in restaurants[0]:
  print(key)

with open('parsed.json', 'w') as f:
    json.dump(restaurants, f)
# print(len(restaurants))