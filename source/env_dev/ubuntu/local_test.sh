#!/bin/bash

# Function to test a specific Ubuntu version
test_version() {
    local version=$1
    echo "Testing Ubuntu ${version}..."

    # Generate Dockerfile
    ./env_ubuntu_gen.sh

    # Verify Dockerfile exists
    if [ ! -f "Dockerfile.ubuntu${version}" ]; then
        echo "Error: Dockerfile.ubuntu${version} not generated"
        exit 1
    fi

    # Build Docker image
    docker buildx build \
        --load \
        -f Dockerfile.ubuntu${version} \
        -t ubuntu-dev:${version}-test \
        .

    # Verify build success
    if [ $? -ne 0 ]; then
        echo "Error: Docker build failed for Ubuntu ${version}"
        exit 1
    fi

    echo "Successfully built Ubuntu ${version} image"
}

# Test all versions
for version in 20.04 22.04 24.04; do
    test_version "${version}"
done

# Clean up
rm Dockerfile.ubuntu* install_packages_ubuntu*.sh

echo "All tests passed successfully!"
