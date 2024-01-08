import { webServer } from './cmd/web-server';

async function startApp() {
    await webServer.registerRoutes();
    await webServer.start();
}

async function publishSwagger() {
}

const appActions = {
    startApp,
    publishSwagger
}

const arg = process.argv[2];

if (appActions[arg]) {
    appActions[arg]();
} else {
    console.error(`Invalid argument. Possible actions are: ${Object.keys(appActions).join(', ')}`);
    process.exit(1);
}