export class ObservationRange {
    constructor(
        public readonly videoId: string,
        public readonly startClipRangeTime: number,
        public readonly endClipRangeTime: number,
    ) {}
}

export class ObservationContext {
    constructor(
        public readonly videoRange: ObservationRange,
        public readonly videoPath: string,
    ) {}
}
