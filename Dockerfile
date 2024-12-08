# Use an official base image
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
qemu-utils mtools bridge-utils uml-utilities wget git dosfstools

# Set the working directory
WORKDIR /app
RUN wget https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img && \
qemu-img convert -p -f qcow2 -O raw focal-server-cloudimg-amd64.img focal-server-cloudimg-amd64.raw && \
wget https://github.com/cloud-hypervisor/rust-hypervisor-firmware/releases/download/0.5.0/hypervisor-fw

WORKDIR /usr/local/bin
RUN wget https://github.com/cloud-hypervisor/cloud-hypervisor/releases/download/v42.0/cloud-hypervisor-static && \
wget https://github.com/cloud-hypervisor/cloud-hypervisor/releases/download/v42.0/ch-remote-static && \
# setcap cap_net_admin+ep /usr/local/bin/cloud-hypervisor-static && \
chmod +x /usr/local/bin/cloud-hypervisor-static && \
chmod +x /usr/local/bin/ch-remote-static

WORKDIR /app
RUN git clone https://github.com/cloud-hypervisor/cloud-hypervisor.git && \
cd cloud-hypervisor/ && \
bash scripts/create-cloud-init.sh

# Define the command to run the application
CMD ["bash"]