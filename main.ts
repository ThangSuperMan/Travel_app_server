import { Application } from "https://deno.land/x/oak/mod.ts";
import { APP_HOST, APP_PORT } from "./config.ts";
import database from "./db/database.ts";

console.log("APP_PORT :>> ", APP_PORT);

console.log("database :>> ", database);
