import * as child_process from 'child_process';
import { promisify } from 'util';
import { ObservationRange } from "../../internal/entities/observation";
import { ObservationCreationFailedError } from '../../internal/errors/observation';

const MERGE_VIDEO_ERROR = "Error during video merge process: ";
const EXEC_FILE_ERROR = "Error executing file: ";

const INPUT_VIDEO_CLIP_PATH = process.env.INPUT_VIDEO_CLIP_PATH;
const OUTPUT_VIDEO_CLIP_PATH = process.env.OUTPUT_VIDEO_CLIP_PATH;
const MERGE_FLOW_FILE_PATH = process.env.MERGE_FLOW_FILE_PATH;

const EXEC_FILE = promisify(child_process.exec);

function mergeVideoClips(observationRange: ObservationRange): Promise<string> {
    const processor_env = {
        inputVideoClipPath: INPUT_VIDEO_CLIP_PATH,
        outputVideoClipPath: OUTPUT_VIDEO_CLIP_PATH,
        startRange: observationRange.startClipRangeTime.toString(),
        endRange: observationRange.endClipRangeTime.toString()
    };

    return EXEC_FILE(MERGE_FLOW_FILE_PATH, { env: processor_env })
    .then((result) => {
        if(result.stderr) {
            throw new ObservationCreationFailedError(MERGE_VIDEO_ERROR + result.stderr);
        }
        return OUTPUT_VIDEO_CLIP_PATH
    }).catch((error: Error) => {
        throw new ObservationCreationFailedError(EXEC_FILE_ERROR + error.message);
    });
}

export const videoProcessor = {
    mergeVideoClips
}