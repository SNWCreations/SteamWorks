SteamWorks
==========

Exposing SteamWorks functions to SourcePawn.

## About This Fork

This fork is an attempt to get the SteamWorks extension to compile and run on 64-bit Source engine game servers. The original extension was designed for 32-bit servers, but with the transition to 64-bit servers, several modifications were needed to support the new architecture.

### Changes Made for 64-bit Support

- Updated build configuration to target x86_64 architecture
- Changed Steam API library paths to use 64-bit versions (linux64, win64)
- Added Position Independent Code (-fPIC) flag required for 64-bit shared libraries
- Upgraded C++ standard from C++11 to C++14 for compatibility with newer dependencies
- Fixed pointer casting issues for 64-bit compatibility
- Added virtual destructors and compiler warning suppressions

## Building

### Requirements

To build this extension, you need the following dependencies in the workspace root:

- **hl2sdk-sdk2013** - Half-Life 2 SDK (sdk2013 branch)
  - Clone from: https://github.com/alliedmodders/hl2sdk
  - Branch: `sdk2013`
  
- **mmsource-1.10** - Metamod:Source
  - Clone from: https://github.com/alliedmodders/metamod-source
  - Branch: `1.10-dev`
  
- **sourcemod-1.11** - SourceMod (with submodules)
  - Clone from: https://github.com/alliedmodders/sourcemod
  - Branch: `1.11-dev`
  - Run: `git submodule update --init --recursive`
  
- **steamworks-sdk** - SteamWorks SDK
  - Download from: https://partner.steamgames.com/downloads/steamworks_sdk_162.zip
  - Extract the `sdk` folder and rename it to `steamworks-sdk`

### Build Commands

#### 64-bit (Linux)
```bash
python3 configure.py \
    --target=x86_64 \
    --enable-optimize \
    --hl2sdk-root=/workspace \
    --mms-path=/workspace/mmsource-1.10 \
    --sm-path=/workspace/sourcemod-1.11 \
    --steamworks-path=/workspace/steamworks-sdk \
    --sdks=sdk2013

cd objdir
ambuild
```

#### 32-bit (Linux)
```bash
python3 configure.py \
    --target=x86 \
    --enable-optimize \
    --hl2sdk-root=/workspace \
    --mms-path=/workspace/mmsource-1.10 \
    --sm-path=/workspace/sourcemod-1.11 \
    --steamworks-path=/workspace/steamworks-sdk \
    --sdks=sdk2013

cd objdir
ambuild
```

### Output

The compiled extension will be located at:
```
objdir/package/addons/sourcemod/extensions/SteamWorks.ext.so
```

