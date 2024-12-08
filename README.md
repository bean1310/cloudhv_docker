## Cloudhypervisor on Docker

## Build the image
```bash
docker build -t cloudhv:latest .
```

## Run the image
```bash
docker run -it --rm --privileged -v /dev/kvm:/dev/kvm cloudhv:latest bash
```