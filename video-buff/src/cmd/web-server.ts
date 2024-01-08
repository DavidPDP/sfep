import Fastify from "fastify";
import { observationRoutes } from '../external/controllers/observation-controller';

const WEB_SERVER = Fastify({ logger: true });

async function registerRoutes() {
    await WEB_SERVER.register(observationRoutes);
}

async function start() {
    await WEB_SERVER.listen({ port: 3000 });
}

export const webServer = {
    registerRoutes,
    start
}