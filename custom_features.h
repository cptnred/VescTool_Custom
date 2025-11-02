/*
    Custom VESC Tool Feature Configuration
    
    This file defines which features are enabled in the custom build.
    Features are disabled by setting their define to 0.
*/

#ifndef CUSTOM_FEATURES_H
#define CUSTOM_FEATURES_H

// Feature flags - only active for VER_CUSTOM builds
#ifdef VER_CUSTOM

    // Motor Settings Features
    #define FEATURE_MOTOR_GENERAL       1
    #define FEATURE_MOTOR_BLDC          0  // DISABLED in custom version
    #define FEATURE_MOTOR_DC            0  // DISABLED in custom version
    #define FEATURE_MOTOR_FOC           1  // Main focus - FOC only
    #define FEATURE_MOTOR_GPDRIVE       0  // DISABLED in custom version
    #define FEATURE_MOTOR_PID           0  // DISABLED in custom version
    #define FEATURE_MOTOR_INFO          1
    #define FEATURE_MOTOR_EXPERIMENTS   1

    // App Settings Features
    #define FEATURE_APP_GENERAL         1
    #define FEATURE_APP_PPM             0  // DISABLED in custom version
    #define FEATURE_APP_ADC             0  // DISABLED in custom version
    #define FEATURE_APP_UART            1  // Main control interface
    #define FEATURE_APP_VESCREMOTE      0  // DISABLED in custom version (Nunchuk)
    #define FEATURE_APP_NRF             0  // DISABLED in custom version
    #define FEATURE_APP_PAS             0  // DISABLED in custom version
    #define FEATURE_APP_IMU             1

    // Advanced Tools
    #define FEATURE_DISPLAY_TOOL        0  // DISABLED in custom version
    
    // Other Features (keep enabled for now)
    #define FEATURE_WELCOME             1
    #define FEATURE_CONNECTION          1
    #define FEATURE_FIRMWARE            1
    #define FEATURE_PACKAGES            1
    #define FEATURE_DATA_ANALYSIS       1
    #define FEATURE_RT_DATA             1
    #define FEATURE_SAMPLED_DATA        1
    #define FEATURE_TERMINAL            1
    #define FEATURE_LOG_ANALYSIS        1
    #define FEATURE_MOTOR_COMPARISON    1
    #define FEATURE_SETUP_CALCULATORS   1
    #define FEATURE_SCRIPTING           1
    #define FEATURE_LISP                1
    #define FEATURE_DEBUG_PRINT         1
    #define FEATURE_CAN_ANALYZER        1
    #define FEATURE_IMU_CALIBRATION     1
    #define FEATURE_BMS                 1
    #define FEATURE_ESP_PROG            1
    #define FEATURE_SWD_PROG            1

#else
    // For all other build versions, enable all features
    #define FEATURE_MOTOR_GENERAL       1
    #define FEATURE_MOTOR_BLDC          1
    #define FEATURE_MOTOR_DC            1
    #define FEATURE_MOTOR_FOC           1
    #define FEATURE_MOTOR_GPDRIVE       1
    #define FEATURE_MOTOR_PID           1
    #define FEATURE_MOTOR_INFO          1
    #define FEATURE_MOTOR_EXPERIMENTS   1
    
    #define FEATURE_APP_GENERAL         1
    #define FEATURE_APP_PPM             1
    #define FEATURE_APP_ADC             1
    #define FEATURE_APP_UART            1
    #define FEATURE_APP_VESCREMOTE      1
    #define FEATURE_APP_NRF             1
    #define FEATURE_APP_PAS             1
    #define FEATURE_APP_IMU             1
    
    #define FEATURE_DISPLAY_TOOL        1
    
    #define FEATURE_WELCOME             1
    #define FEATURE_CONNECTION          1
    #define FEATURE_FIRMWARE            1
    #define FEATURE_PACKAGES            1
    #define FEATURE_DATA_ANALYSIS       1
    #define FEATURE_RT_DATA             1
    #define FEATURE_SAMPLED_DATA        1
    #define FEATURE_TERMINAL            1
    #define FEATURE_LOG_ANALYSIS        1
    #define FEATURE_MOTOR_COMPARISON    1
    #define FEATURE_SETUP_CALCULATORS   1
    #define FEATURE_SCRIPTING           1
    #define FEATURE_LISP                1
    #define FEATURE_DEBUG_PRINT         1
    #define FEATURE_CAN_ANALYZER        1
    #define FEATURE_IMU_CALIBRATION     1
    #define FEATURE_BMS                 1
    #define FEATURE_ESP_PROG            1
    #define FEATURE_SWD_PROG            1
#endif

#endif // CUSTOM_FEATURES_H
