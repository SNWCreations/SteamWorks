#!/bin/bash
set -e

echo "=========================================="
echo "Setting up SteamWorks Build Environment"
echo "=========================================="

# Update package list
echo "Updating package list..."
sudo apt-get update

# Install essential build tools
echo "Installing build tools..."
sudo apt-get install -y \
    build-essential \
    gcc \
    g++ \
    gcc-multilib \
    g++-multilib \
    libstdc++6 \
    lib32stdc++6 \
    git \
    wget \
    curl \
    unzip \
    vim \
    nano \
    ca-certificates

# Install Python and pip
echo "Installing Python dependencies..."
sudo apt-get install -y \
    python3 \
    python3-pip \
    python3-venv

# Install AMBuild 2.2
echo "Installing AMBuild 2.2..."
cd /tmp
if [ ! -d "ambuild" ]; then
    git clone https://github.com/alliedmodders/ambuild.git
    cd ambuild
    python3 setup.py install --user
else
    echo "AMBuild already cloned"
fi

# Add Python user bin to PATH if not already there
if ! grep -q "export PATH=\"\$HOME/.local/bin:\$PATH\"" ~/.bashrc; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
fi

# Create directories for dependencies
echo "Creating dependency directories..."
mkdir -p ~/dependencies
cd ~/dependencies

# Clone HL2SDK (SDK2013 for 64-bit support)
echo "Cloning HL2SDK-SDK2013..."
if [ ! -d "hl2sdk-sdk2013" ]; then
    git clone https://github.com/alliedmodders/hl2sdk.git -b sdk2013 hl2sdk-sdk2013
else
    echo "HL2SDK-SDK2013 already exists"
fi

# Clone Metamod:Source
echo "Cloning Metamod:Source..."
if [ ! -d "mmsource-1.10" ]; then
    git clone https://github.com/alliedmodders/metamod-source.git -b 1.10-dev mmsource-1.10
else
    echo "Metamod:Source already exists"
fi

# Clone SourceMod
echo "Cloning SourceMod..."
if [ ! -d "sourcemod-1.10" ]; then
    git clone https://github.com/alliedmodders/sourcemod.git -b 1.10-dev sourcemod-1.10
else
    echo "SourceMod already exists"
fi

# Download SteamWorks SDK (you'll need to get this manually from Valve)
echo ""
echo "=========================================="
echo "IMPORTANT: SteamWorks SDK Required"
echo "=========================================="
echo "You need to manually download the Steamworks SDK from:"
echo "https://partner.steamgames.com/doc/sdk"
echo ""
echo "Extract it to: ~/dependencies/steamworks-sdk"
echo ""
echo "The expected structure is:"
echo "  ~/dependencies/steamworks-sdk/"
echo "    ├── public/"
echo "    │   └── steam/"
echo "    └── redistributable_bin/"
echo "        ├── linux64/libsteam_api.so"
echo "        └── linux32/libsteam_api.so"
echo ""

# Set up environment variables
echo "Setting up environment variables..."
cat >> ~/.bashrc << 'EOF'

# SteamWorks Build Environment
export HL2SDK2013="$HOME/dependencies/hl2sdk-sdk2013"
export MMSOURCE110="$HOME/dependencies/mmsource-1.10"
export SOURCEMOD110="$HOME/dependencies/sourcemod-1.10"
export STEAMWORKS="$HOME/dependencies/steamworks-sdk"
EOF

echo ""
echo "=========================================="
echo "Setup Complete!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Download and extract SteamWorks SDK to ~/dependencies/steamworks-sdk"
echo "2. Restart your terminal or run: source ~/.bashrc"
echo "3. Navigate to the project directory"
echo "4. For 64-bit build, run:"
echo "   python3 configure.py --target=x86_64 --enable-optimize --sdks=sdk2013"
echo "5. Then run: ambuild"
echo ""
echo "For 32-bit build (original), run:"
echo "   python3 configure.py --enable-optimize --sdks=sdk2013"
echo ""
