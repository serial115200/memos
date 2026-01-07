#!/bin/bash

# Function to generate Dockerfile
generate_dockerfile() {
    local version=$1
    cat > "Dockerfile.ubuntu${version}" << EOF
FROM ubuntu:${version}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \\
    && apt-get install --no-install-recommends -y \\
EOF

    # Get package list, removing comments and empty lines
    PKGS=$(cat software/ubuntu.conf software/ubuntu_${version}.conf | sed -e 's/#.*$//' -e '/^$/d')

    # Add packages to Dockerfile
    for pkg in $PKGS; do
        echo "                $pkg \\" >> "Dockerfile.ubuntu${version}"
    done

    cat >> "Dockerfile.ubuntu${version}" << EOF
    && apt-get autoremove \\
    && apt-get clean \\
    && rm -rf /var/lib/apt/lists/*

RUN ln -sf /bin/bash /bin/sh

WORKDIR /build

CMD ["bash"]
EOF
}

# Function to generate installation script
generate_install_script() {
    local version=$1
    # Get package list, removing comments and empty lines
    PKGS=$(cat software/ubuntu.conf software/ubuntu_${version}.conf | sed -e 's/#.*$//' -e '/^$/d')

    cat > "install_packages_ubuntu${version}.sh" << EOF
#!/bin/bash

# Update package list
sudo apt-get update

# Install packages
sudo apt-get install --no-install-recommends -y \\
EOF

    # Add packages to installation script
    for pkg in $PKGS; do
        echo "    $pkg \\" >> "install_packages_ubuntu${version}.sh"
    done

    cat >> "install_packages_ubuntu${version}.sh" << EOF
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
