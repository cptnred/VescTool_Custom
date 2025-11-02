# VESC Tool Custom

**A streamlined fork of VESC Tool focused on FOC motor control and UART-based applications.**

This custom version removes unnecessary features to create a lighter, more focused tool for FOC (Field-Oriented Control) motor configurations.

> ⚠️ **Important:** This is a custom fork and is NOT affiliated with or endorsed by VESC Project. For the official VESC Tool, visit [vesc-project.com](https://vesc-project.com).

## 🎯 What's Different?

This custom build removes the following features:

### Motor Settings (Removed)
- ❌ BLDC motor configuration
- ❌ DC motor configuration
- ❌ GPDrive (General Purpose Drive)
- ❌ PID Controllers

### App Settings (Removed)
- ❌ PPM (RC receiver)
- ❌ ADC (Analog input)
- ❌ VESC Remote
- ❌ NRF (Wireless)
- ❌ PAS (Pedal Assist)

### Tools (Removed)
- ❌ Display Tool

### ✅ What's Included

**Motor Configuration:**
- ✅ **FOC Motor Setup** - Full FOC parameter configuration
- ✅ **FOC Detection** - Automatic parameter detection
- ✅ **FOC Hall Sensors** - Hall sensor configuration
- ✅ **FOC Encoder** - Encoder setup
- ✅ **Motor General Settings**
- ✅ **Motor Info**

**App Configuration:**
- ✅ **UART** - Serial communication
- ✅ **General App Settings**
- ✅ **IMU Configuration**

**All Other Features:**
- ✅ Firmware updates
- ✅ Real-time data monitoring
- ✅ Terminal
- ✅ Scripting (LispBM)
- ✅ Data analysis
- ✅ CAN bus tools
- ✅ BMS support
- ✅ And more...

## 🚀 Building

### Windows

**Prerequisites:**
- Qt 5.15.x (MinGW or MSVC)
- MinGW 8.1 or MSVC compiler

**Build Commands:**

```powershell
# Desktop only (recommended)
.\build_custom.ps1 -ExcludeFW

# Desktop + Mobile UI
.\build_custom.ps1 -IncludeMobile -ExcludeFW
```

The build script automatically:
- Sets up Qt environment
- Compiles the custom version
- Handles mobile UI folder swapping (if enabled)
- Restores original files after build

**Build Options:**
- `-ExcludeFW` - Build without firmware files (faster, smaller)
- `-IncludeMobile` - Include custom mobile UI

### Linux / macOS

See [README_VESC_ORIGINAL.md](./README_VESC_ORIGINAL.md) for general build instructions, but use:

```bash
qmake -config release "CONFIG+=build_custom exclude_fw"
make -j8
```

## 📁 Project Structure

```
vesc_tool-release_6_06/
├── custom_features.h        # Feature flags for conditional compilation
├── res_custom.qrc           # Custom resources (icons, logos)
├── build_custom.ps1         # Windows build script
├── mobile_custom/           # Custom mobile UI (FOC-focused)
├── README_CUSTOM.md         # Detailed custom build documentation
└── README_VESC_ORIGINAL.md  # Original VESC Tool README
```

## 🎨 Branding

This custom version uses:
- Custom application icons
- Custom branding ("Custom Version")
- Separate configuration from official VESC Tool

## 📜 License & Trademark

This project is based on [VESC Tool](https://github.com/vedderb/vesc_tool) by Benjamin Vedder.

**License:** GPLv3 (same as original VESC Tool)

**VESC® Trademark:** VESC is a registered trademark of Benjamin Vedder. This custom fork complies with the [VESC trademark policies](https://vesc-project.com/trademark_policies) by:
- Removing all VESC branding
- Using custom icons and labels
- Clearly stating it is NOT an official VESC Tool release
- Not distributing binaries with VESC trademark

## ⚠️ Disclaimer

This is an **unofficial** custom build. For official support and releases, please use the original VESC Tool from [vesc-project.com](https://vesc-project.com).

## 🔗 Links

- **Original VESC Tool:** https://github.com/vedderb/vesc_tool
- **VESC Project:** https://vesc-project.com
- **Firmware Repository:** https://github.com/vedderb/bldc

## 📝 Contributing

This is a personal custom build. For contributions to the main VESC Tool project, please contribute to the [official repository](https://github.com/vedderb/vesc_tool).

---

**Built with focus. Designed for FOC.**
