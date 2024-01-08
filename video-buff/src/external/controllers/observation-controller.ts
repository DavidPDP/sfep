
import { FastifyInstance } from "fastify";
import { ObservationRange } from "../../internal/entities/observation";
import { observationFactory } from "../../internal/observation/observation-factory";
import observationSchema from '../../api/schemas/observation-range-schema.json';
import { ObservationCreationFailedError } from "../../internal/errors/observation";

export async function observationRoutes(fastify: FastifyInstance) {
    fastify.route({
        method: 'POST',
        url: '/observations/create',
        schema: observationSchema,
        handler: createObservation,
    });

    fastify.setErrorHandler(observationsErrorController);
}

async function createObservation(request: any) {
    const observationRange = request.body as ObservationRange;
    const observationContext = await observationFactory.create(observationRange);
    return observationContext;
}

function observationsErrorController(error: Error, request:any, reply: any) {
    if (error instanceof ObservationCreationFailedError) {
        reply.status(404);
    }
    reply.send(error);
}
