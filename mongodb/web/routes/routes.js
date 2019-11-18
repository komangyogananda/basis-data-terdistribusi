import express from "express";
import restaurantsController from "../controllers/restaurantsController";

const router = express.Router();

router.route("/api/restaurants").get(restaurantsController.searchQuery);
router
  .route("/api/restaurants/aggregate/rating")
  .get(restaurantsController.ratingGreaterThan);
router
  .route("/api/restaurants/aggregate/average")
  .get(restaurantsController.avgPerCity);
router
  .route("/api/restaurants/aggregate/mostvotes")
  .get(restaurantsController.mostVotesPerCity);
router
  .route("/api/restaurants/:id")
  .delete(restaurantsController.deleteInstance)
  .put(restaurantsController.updateInstance);

router.route("/api/restaurants/new").post(restaurantsController.createNew);

//   .put(restaurantsController.updateById)
//   .delete(restaurantsController.deleteInstance);
export default router;
