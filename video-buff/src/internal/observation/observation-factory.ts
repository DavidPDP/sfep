import { ObservationContext, ObservationRange } from "../entities/observation";
import { videoProcessor } from "../../external/video-processor/processor";

async function create(observationRange: ObservationRange): Promise<ObservationContext> {
    const videoPath = await videoProcessor.mergeVideoClips(observationRange);
    return new ObservationContext(observationRange, videoPath);
}

export const observationFactory = {
    create
};