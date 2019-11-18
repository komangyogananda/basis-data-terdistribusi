import mongoose from "mongoose";

let restaurantsSchema = mongoose.Schema({
  has_online_delivery: Number,
  photos_url: String,
  url: String,
  price_range: Number,
  apikey: String,
  user_rating: {
    rating_text: String,
    rating_color: String,
    votes: Number,
    aggregate_rating: String
  },
  R: {
    res_id: Number
  },
  name: String,
  cuisines: String,
  is_delivering_now: Number,
  deeplink: String,
  menu_url: String,
  average_cost_for_two: Number,
  book_url: String,
  switch_to_orer_menu: Number,
  has_table_booking: Number,
  location: {
    latitude: String,
    address: String,
    city: String,
    country_id: Number,
    locality_verbose: String,
    city_id: Number,
    zipcode: String,
    longitude: String,
    locality: String
  },
  featured_image: String,
  currency: String,
  id: String,
  thumb: String
});

const location = ["address", "city", "locality"];
const schema = [
  "has_online_delivery",
  "name",
  "cuisines",
  "is_delivering_now",
  "switch_to_orer_menu",
  "has_table_booking",
  "currency"
];
const regex = [
  "location.address",
  "location.city",
  "location.locality",
  "name",
  "cuisines",
  "currency"
];

export const Restaurants = mongoose.model("restaurants", restaurantsSchema);

export const searchQuery = (query, callback) => {
  let queryDb = {};
  console.log("TCL: searchQuery -> query", query);
  let start = query.start ? query.start : 0;
  console.log("TCL: searchQuery -> start", start);
  let pagesize = query.pagesize ? query.pagesize : 10;
  console.log("TCL: searchQuery -> pagesize", pagesize);
  delete query["start"];
  delete query["pagesize"];
  Object.keys(query).map(key => {
    console.log("TCL: searchQuery -> key", key);
    if (schema.includes(key) || location.includes(key)) {
      let value = query[key];
      if (location.includes(key)) key = "location." + key;
      if (regex.includes(key)) {
        let regex = RegExp(".*" + value + ".*");
        queryDb[key] = regex;
      } else {
        queryDb[key] = value;
      }
    }
  });
  if (query["id"]) queryDb["_id"] = query["id"];
  console.log("TCL: searchQuery -> queryDb", queryDb);
  Restaurants.find(queryDb, callback)
    .skip(Number(start))
    .limit(Number(pagesize));
};

export const createNew = (document, callback) => {
  let newInstance = new Restaurants(document);
  newInstance.save(callback(newInstance));
};

export const deleteOneDocument = (id, callback) => {
  Restaurants.deleteOne({ _id: mongoose.Types.ObjectId(id) }, callback);
};

export const updateDocument = (id, document, callback) => {
  delete document[id];
  Restaurants.updateOne(
    { _id: mongoose.Types.ObjectId(id) },
    document,
    callback
  );
};

export const ratingGreaterThan = (rating, callback) => {
  Restaurants.aggregate([
    {
      $project: {
        _id: 1,
        name: 1,
        rating: { $gt: ["$user_rating.aggregate_rating", 2] },
        _id: 0
      }
    }
  ]).exec(callback);
};

export const avgPricePerCity = callback => {
  Restaurants.aggregate([
    {
      $group: {
        _id: "$location.city",
        avg: { $avg: "$average_cost_for_two" }
      }
    }
  ]).exec(callback);
};

export const mostVotesPerCity = (value, callback) => {
  let regex = RegExp(".*" + value + ".*");
  console.log("TCL: mostVotesPerCity -> regex", regex);
  Restaurants.aggregate([
    {
      $match: {
        "location.city": regex
      }
    },
    {
      $group: {
        _id: "_id",
        votes: { $max: "$user_rating.aggregate_rating" }
      }
    }
  ]).exec(callback);
};
