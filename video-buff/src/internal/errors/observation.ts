export class ObservationCreationFailedError extends Error {
    constructor(message: string) {
        super(message);
        this.name = "ObservationCreationFailedError";
    }
}
