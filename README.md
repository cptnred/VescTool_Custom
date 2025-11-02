# VESC Tool Custom

**A streamlined fork of VESC Tool focused on FOC motor control and UART-based applications.**

This custom version removes unnecessary features to create a lighter, more focused tool for FOC (Field-Oriented Control) motor configurations.

> ⚠️ **Important:** This is a custom fork and is NOT affiliated with or endorsed by VESC Project. For the official VESC Tool, visit [vesc-project.com](https://vesc-project.com).

[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Based on VESC Tool 6.06](https://img.shields.io/badge/Based%20on-VESC%20Tool%206.06-green.svg)](https://github.com/vedderb/vesc_tool)

---

## 📋 Table of Contents

- [What's Different?](#-whats-different)
- [Quick Start](#-quick-start)
- [Building from Source](#-building-from-source)
- [Keeping Up-to-Date](#-keeping-up-to-date)
- [Project Structure](#-project-structure)
- [Customization](#-customization)
- [License](#-license)

---

## 🎯 What's Different?

### Removed Features

**Motor Settings:**
- ❌ BLDC motor configuration
- ❌ DC motor configuration
- ❌ GPDrive (General Purpose Drive)
- ❌ PID Controllers

**App Settings:**
- ❌ PPM (RC receiver)
- ❌ ADC (Analog input)
- ❌ VESC Remote
- ❌ NRF (Wireless)
- ❌ PAS (Pedal Assist)

**Tools:**
- ❌ Display Tool

### ✅ Included Features

**Motor Configuration (FOC-focused):**
- ✅ **FOC Motor Setup** - Full FOC parameter configuration
- ✅ **FOC Detection Tools** - Automatic parameter detection, Hall sensors, Encoder
- ✅ **Motor General Settings** & Info
- ✅ **Experiments** - Advanced tuning

**App Configuration:**
- ✅ **UART** - Serial communication (primary control)
- ✅ **General App Settings**
- ✅ **IMU Configuration**

**Complete Toolset:**
- ✅ Firmware updates & VESC Packages
- ✅ Real-time data monitoring & analysis
- ✅ Terminal & Scripting (LispBM)
- ✅ CAN bus tools & BMS support
- ✅ Wizards & connection management
- ✅ Programmer tools (SWD, ESP)

**Mobile UI:**
- ✅ Custom mobile interface (FOC-only, no BLDC/PPM/ADC/NRF)
- ✅ Automatic folder swapping during build

---

## 🚀 Quick Start

### Prerequisites

- **Qt 5.15.x** (MinGW or MSVC)
- **Git** (for cloning and updates)
- **MinGW 8.1** or MSVC compiler

### Clone & Build

```powershell
# Clone repository
git clone https://github.com/cptnred/VescTool_Custom.git
cd VescTool_Custom

# Build (Windows - Desktop only, no firmware)
.\build_custom.ps1 -ExcludeFW

# Build with Mobile UI
.\build_custom.ps1 -IncludeMobile -ExcludeFW
```

**Output:** `build/win/vesc_tool_6.06.exe`

---

## 🔨 Building from Source

### Method 1: PowerShell Script (Recommended)

```powershell
# Add Qt to PATH (adjust path to your Qt installation)
$env:PATH = "C:\Qt\5.15.2\mingw81_64\bin;$env:PATH"

# Desktop only (fast, no firmware)
.\build_custom.ps1 -ExcludeFW

# Desktop + Mobile UI
.\build_custom.ps1 -IncludeMobile -ExcludeFW

# With firmware (larger build)
.\build_custom.ps1
```

### Method 2: Qt Creator

1. Open `vesc_tool.pro` in Qt Creator
2. Uncomment in `.pro` file:
   ```qmake
   CONFIG += build_custom
   ```
3. Build (Ctrl+B)

### Method 3: Manual qmake

```bash
# Windows
qmake -config release "CONFIG+=build_custom exclude_fw"
mingw32-make -j8

# Linux/macOS
qmake -config release "CONFIG+=build_custom exclude_fw"
make -j8
```

### Build Options

| Option | Description |
|--------|-------------|
| `-ExcludeFW` | Skip firmware packaging (faster builds) |
| `-IncludeMobile` | Include custom mobile UI (uses `mobile_custom/` folder) |
| (none) | Full build with all firmwares |

---

## 🔄 Keeping Up-to-Date

This fork tracks the **stable `release_6_06` branch** from the official VESC Tool repository.

### Setup (Already Done)

```bash
git remote add upstream https://github.com/vedderb/vesc_tool.git
git fetch upstream release_6_06
```

### Update Process

```bash
# Fetch latest updates from official release branch
git fetch upstream release_6_06

# Check what's new
git log HEAD..upstream/release_6_06 --oneline
git diff HEAD..upstream/release_6_06 --stat

# Merge updates
git merge upstream/release_6_06 -m "Merge upstream release_6_06 updates"

# Push to your fork
git push origin main
```

**⚠️ Important Files During Merge:**
- `custom_features.h` - Your feature flag configuration
- `mainwindow.cpp/h` - Contains `#if FEATURE_XXX` guards
- `mobile_custom/*` - Your custom mobile UI
- `build_custom.ps1` - Build automation script

---

## 📁 Project Structure

```
VescTool_Custom/
├── custom_features.h              # Feature flags (#define FEATURE_XXX)
├── res_custom.qrc                 # Custom icons & branding
├── build_custom.ps1               # Automated build script
├── mobile_custom/                 # Custom mobile QML (FOC-focused)
│   ├── ConfigPageMotor.qml       # No BLDC detection
│   └── ConfigPageApp.qml         # No PPM/ADC/NRF
├── mainwindow.cpp/h               # Modified with feature flags
├── README.md                      # This file
└── README_VESC_ORIGINAL.md        # Original VESC Tool README
```

### Key Files

| File | Purpose |
|------|----------|
| `custom_features.h` | Central feature flag configuration |
| `build_custom.ps1` | Automated build with mobile folder swapping |
| `mobile_custom/` | Custom mobile UI (original `mobile/` untouched) |
| `res_custom.qrc` | Custom icons (no VESC branding) |

---

## 🎨 Customization

### Feature Flags

Edit `custom_features.h` to enable/disable features:

```cpp
#define FEATURE_MOTOR_FOC    1  // Keep FOC
#define FEATURE_MOTOR_BLDC   0  // Remove BLDC
#define FEATURE_APP_PPM      0  // Remove PPM
// ... etc
```

### Custom Branding

Icons and logos in:
- `res/version/custom_v.svg` - Application icon
- `res/version/custom_vesc_tool.png` - Logo

### Mobile UI

Edit files in `mobile_custom/` folder:
- `ConfigPageMotor.qml` - Motor configuration page
- `ConfigPageApp.qml` - App configuration page

---

## 📜 License

**License:** GPL-3.0 (same as original VESC Tool)

This project is based on [VESC Tool](https://github.com/vedderb/vesc_tool) by Benjamin Vedder.

### VESC® Trademark Notice

VESC is a registered trademark of Benjamin Vedder. This custom fork complies with the [VESC trademark policies](https://vesc-project.com/trademark_policies):

- ✅ No VESC branding used
- ✅ Custom icons and labels
- ✅ Clearly marked as unofficial fork
- ✅ No binary distribution with VESC trademark

### Disclaimer

This is an **unofficial** custom build. For official support:
- **Official VESC Tool:** https://vesc-project.com
- **Support:** https://vesc-project.com/support

---

## 🔗 Links

- **Original VESC Tool:** https://github.com/vedderb/vesc_tool
- **VESC Firmware:** https://github.com/vedderb/bldc
- **VESC Project:** https://vesc-project.com
- **Trademark Policies:** https://vesc-project.com/trademark_policies

---

## 🤝 Contributing

This is a personal custom fork. To contribute to the main VESC Tool project:
- Visit: https://github.com/vedderb/vesc_tool
- Follow the official contribution guidelines

---

**Built with focus. Designed for FOC.** 🚀
