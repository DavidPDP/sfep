## Build

```sh
podman build -t safefleet.net/ffmpeg:6.1.1 -f vendors/ffmpeg/Dockerfile
podman build -t safefleet.net/video-buff:1.0.0 -f deployments/Dockerfile .
```

debian:bullseye-slim = 84.04 MB (base)
ffmpeg:6.1.1 = 89.73 MB (final)
app relative size = 5.69 MB

node:20.10.0-buster-slim = 201.09 MB (base)
video-buff:1.0.0 = 237.08 MB (final)
app relative size = 35.99 MB

## Performance

### System Specifications
- **Processor:** 11th Gen Intel® Core™ i3-1115G4 @ 3.00GHz 2.90 GHz (2 cores)
- **RAM:** 8.00 GB (7.65 GB usable)
- **Operating System:** Windows 11 22H2

### Video Merging Scenario
- **Number of Video Clips:** 21
- **Format:** .mp4
- **Average Size per Clip:** 1.3KB
- **Total Size of Merged Video:** 24.32KB
- **Issue:** One of the video clips is corrupted.

```sh
podman stats --format "table {{.Name}},{{.CPUPerc}},{{.MemUsage}}" video-buff-test >> "video-buff-stats.csv"
```

[report](./test/performance/performance-report.html)

Footprint: 18.6 MB - 46.52 %

![cpu-usage](./test/performance/cpu-usage.png)
![memory-usage](./test/performance/memory-usage.png)
