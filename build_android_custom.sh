#!/bin/bash
# Build script for Android Custom Version (Linux)

set -e

echo "============================================"
echo " VESC Tool Custom - Android Build (Linux)"
echo "============================================"
echo ""

# Configuration - Adjust these paths to your Linux setup
export ANDROID_HOME=~/Android/Sdk
export ANDROID_NDK_ROOT=$ANDROID_HOME/ndk/23.1.7779620
export ANDROID_SDK_ROOT=$ANDROID_HOME
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export QT_PATH=~/Qt/5.15.2/android

# Add to PATH
export PATH=$QT_PATH/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/tools:$JAVA_HOME/bin:$PATH

echo "Configuration:"
echo "  Qt:         $QT_PATH"
echo "  Android SDK: $ANDROID_SDK_ROOT"
echo "  Android NDK: $ANDROID_NDK_ROOT"
echo "  Java:       $JAVA_HOME"
echo ""

# Check requirements
if [ ! -d "$QT_PATH" ]; then
    echo "ERROR: Qt for Android not found at: $QT_PATH"
    echo "Please install Qt 5.15.2 for Android"
    exit 1
fi

if [ ! -d "$ANDROID_SDK_ROOT" ]; then
    echo "ERROR: Android SDK not found at: $ANDROID_SDK_ROOT"
    echo "Please install Android SDK"
    exit 1
fi

if [ ! -d "$ANDROID_NDK_ROOT" ]; then
    echo "ERROR: Android NDK not found at: $ANDROID_NDK_ROOT"
    echo "Please install Android NDK 23.1.7779620"
    exit 1
fi

# Clean previous build
echo "Cleaning previous build..."
rm -rf build/android/*
mkdir -p build/android

echo ""
echo "============================================"
echo " Building VESC Tool Custom Mobile (Android)"
echo "============================================"
echo ""

# Build for Android
echo "Running qmake..."
qmake -config release "CONFIG+=release_android build_custom build_mobile exclude_fw" ANDROID_ABIS="arm64-v8a" -spec android-clang

echo ""
echo "Running make clean..."
make clean

echo ""
echo "Compiling (this may take 10-20 minutes)..."
make -j8

echo ""
echo "Installing to build directory..."
make install INSTALL_ROOT=build/android/build

echo ""
echo "Creating APK..."
androiddeployqt --gradle --no-gdbserver --output build/android/build --input android-vesc_tool-deployment-settings.json --android-platform android-33

# Move APK
if [ -f "build/android/build/build/outputs/apk/debug/build-debug.apk" ]; then
    mv build/android/build/build/outputs/apk/debug/build-debug.apk build/android/vesc_tool_custom_mobile.apk
    echo ""
    echo "============================================"
    echo " BUILD SUCCESSFUL!"
    echo "============================================"
    echo ""
    echo "APK Location: build/android/vesc_tool_custom_mobile.apk"
    APK_SIZE=$(du -h build/android/vesc_tool_custom_mobile.apk | cut -f1)
    echo "APK Size: $APK_SIZE"
    echo ""
    echo "To install on Android device:"
    echo "  adb install -r build/android/vesc_tool_custom_mobile.apk"
    echo ""
else
    echo ""
    echo "============================================"
    echo " BUILD FAILED!"
    echo "============================================"
    echo ""
    echo "APK file not created. Check output above for errors."
    exit 1
fi

# Cleanup
rm -rf build/android/build
rm -rf build/android/obj
rm -f build/android/libvesc_tool*

echo "Cleanup complete."
echo ""
