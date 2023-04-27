import client from "../db/database.ts";
import Tour from "../models/tour.ts";

class TourService {
  create(tour: Tour) {
    const sql = `insert into tours (title, )`;
    return client?.queryArray(``);
  }
}
