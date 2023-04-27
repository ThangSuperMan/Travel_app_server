import { Client } from "https://deno.land/x/postgres/mod.ts";

class Database {
  client: Client | undefined;

  constructor() {
    this.connect();
  }

  async connect() {
    this.client = new Client({
      user: "root",
      database: "travel_airbnb",
      hostname: "localhost",
      password: "1",
      port: 5432,
    });
  }
}

export default new Database().client;
