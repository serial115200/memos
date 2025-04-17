#!/bin/bash

# Function to generate Dockerfile
generate_dockerfile() {
    local version=$1
    cat > "Dockerfile.ubuntu${version}" << EOF
FROM ubuntu:${version}

# Install basic utilities
RUN apt-get update && apt-get install -y apt-utils

# Copy package lists
COPY env_ubuntu.conf /tmp/common.conf
COPY env_ubuntu_${version}.conf /tmp/version.conf

# Install packages
RUN cat /tmp/common.conf /tmp/version.conf | grep -v '^#' | grep -v '^$' | xargs apt-get install -y

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
EOF
}

# Function to generate installation script
generate_install_script() {
    local version=$1
    cat > "install_packages_ubuntu${version}.sh" << EOF
#!/bin/bash

# Update package list
sudo apt-get update

# Install packages from common and version-specific lists
cat env_ubuntu.conf env_ubuntu_${version}.conf | grep -v '^#' | grep -v '^$' | xargs sudo apt-get install -y

# Clean up
sudo apt-get clean
EOF
    chmod +x "install_packages_ubuntu${version}.sh"
}

# Generate files for each version
for version in 20.04 22.04 24.04; do
    echo "Generating files for Ubuntu ${version}..."
    generate_dockerfile "${version}"
    generate_install_script "${version}"
done

echo "All files generated successfully!"
