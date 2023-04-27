import { Router } from "https://deno.land/x/oak/mod.ts";
import getTours from "../../controllers/tour/index.ts";

const router = new Router();

router.get("/tours", getTours);
