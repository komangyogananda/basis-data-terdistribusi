import {
  searchQuery,
  createNew,
  deleteOneDocument,
  updateDocument,
  ratingGreaterThan,
  avgPricePerCity,
  mostVotesPerCity
} from "../db/restaurants";

export default class restaurantsController {
  static searchQuery(req, res) {
    searchQuery(req.query, (err, result) => {
      if (err) {
        res.status(404).json({
          message: err
        });
      } else {
        result.sort(
          (a, b) =>
            parseFloat(b["user_rating"]["aggregate_rating"]) -
            parseFloat(a["user_rating"]["aggregate_rating"])
        );
        res.status(200).json({
          message: "success",
          count: result.length,
          name: result.map(restaurant => restaurant["name"]),
          location: result.map(restaurant => restaurant["location"]["city"]),
          rating: result.map(
            restaurant => restaurant["user_rating"]["aggregate_rating"]
          ),
          payload: result
        });
      }
    });
  }

  static createNew(req, res) {
    console.log("TCL: restaurantsController -> createNew -> req", req.body);
    createNew(req.body, createdDocument => err => {
      if (err) {
        res.status(500).json(err);
      } else {
        res.status(200).json({
          message: "success",
          instance: createdDocument
        });
      }
    });
  }

  static deleteInstance(req, res) {
    let id = req.params.id;
    console.log(
      "TCL: restaurantsController -> deleteInstance -> req.params",
      req.params
    );
    deleteOneDocument(id, err => {
      if (err) {
        res.status(400).json(err);
      } else {
        res.status(200).json({
          message: "Document with ID: " + id + "has been deleted."
        });
      }
    });
  }

  static updateInstance(req, res) {
    updateDocument(req.params.id, req.body, (err, instance) => {
      if (err) {
        res.status(400).json(err);
      } else {
        res.status(200).json({
          message: "Document with successfully updated",
          instance
        });
      }
    });
  }

  static ratingGreaterThan(req, res) {
    ratingGreaterThan(req.params.rating, (err, instance) => {
      if (err) {
        res.status(400).json(err);
      } else {
        res.status(200).json({
          message: "Success",
          payload: instance
        });
      }
    });
  }

  static avgPerCity(req, res) {
    avgPricePerCity((err, result) => {
      if (err) {
        res.status(400).json(err);
      } else {
        res.status(200).json({
          message: "Success",
          payload: result
        });
      }
    });
  }

  static mostVotesPerCity(req, res) {
    mostVotesPerCity(req.query.city, (err, result) => {
      if (err) {
        res.status(400).json(err);
      } else {
        res.status(200).json({
          message: "Success",
          payload: result
        });
      }
    });
  }
}
