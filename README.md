SteamWorks
==========

Exposing SteamWorks functions to SourcePawn.

## About This Fork

This fork adds support for both 32-bit and 64-bit Source engine game servers. The original extension was designed for 32-bit only. The default build target is **x86_64** (64-bit). To build for 32-bit, you must explicitly pass `--target x86` to `configure.py` when configuring build.

### Changes Made

- Build configuration supports both x86 and x86_64 via `--target` flag
- Steam API library paths are selected automatically based on target architecture
- Added Position Independent Code (-fPIC) flag for shared libraries
- Upgraded C++ standard from C++11 to C++14
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

#### 64-bit (Linux, default)
```bash
python3 configure.py \
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

#### Windows
```bat
python configure.py -s sdk2013 ^
    --target x86 ^
    --hl2sdk-root path\to\sdks ^
    --sm-path path\to\sourcemod ^
    --mms-path path\to\metamod-source ^
    --steamworks-path path\to\steamworks-sdk

cd objdir
ambuild
```

Replace `--target x86` with `--target x86_64` for a 64-bit Windows build.

### Output

The compiled extension will be located at:
```
objdir/package/addons/sourcemod/extensions/SteamWorks.ext.so    (Linux)
objdir/package/addons/sourcemod/extensions/SteamWorks.ext.dll   (Windows)
```

