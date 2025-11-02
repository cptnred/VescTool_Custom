# Custom VESC Tool - Feature Management Guide

Dieses Dokument erklärt, wie das Feature-Management-System funktioniert und wie du weitere Features hinzufügen oder entfernen kannst.

## Übersicht

Das Custom VESC Tool verwendet ein zentrales Feature-Konfigurations-System basierend auf der Datei `custom_features.h`. Features können dort ein- oder ausgeschaltet werden, ohne Code löschen zu müssen.

## Feature-Flags

Alle Features werden über `#define` Direktiven in `custom_features.h` gesteuert:

```cpp
#define FEATURE_MOTOR_FOC       1  // Aktiviert
#define FEATURE_MOTOR_BLDC      0  // Deaktiviert
```

### Aktuell deaktivierte Features

Die folgenden Features sind in der Custom-Version deaktiviert (`0`):

**Motor Settings:**
- `FEATURE_MOTOR_BLDC` - BLDC Motor-Steuerung
- `FEATURE_MOTOR_DC` - DC Motor-Steuerung  
- `FEATURE_MOTOR_GPDRIVE` - General Purpose Drive
- `FEATURE_MOTOR_PID` - PID Controller-Einstellungen

**App Settings:**
- `FEATURE_APP_PPM` - RC-Empfänger (PPM)
- `FEATURE_APP_ADC` - Analog-Digital-Wandler
- `FEATURE_APP_VESCREMOTE` - VESC Remote / Nunchuk
- `FEATURE_APP_NRF` - NRF Wireless
- `FEATURE_APP_PAS` - Pedal Assist System

**Tools:**
- `FEATURE_DISPLAY_TOOL` - Display Configuration Tool

## Ein Feature entfernen

Um ein weiteres Feature zu entfernen, z.B. "Motor Comparison":

### 1. Feature-Flag hinzufügen

In `custom_features.h`:

```cpp
#ifdef VER_CUSTOM
    // ... existing flags
    #define FEATURE_MOTOR_COMPARISON    0  // NEU: deaktiviert
#else
    // ... existing flags
    #define FEATURE_MOTOR_COMPARISON    1  // in anderen Versionen aktiv
#endif
```

### 2. Header-Include schützen

In `mainwindow.h`:

```cpp
#if FEATURE_MOTOR_COMPARISON
#include "pages/pagemotorcomparison.h"
#endif
```

### 3. Pointer-Deklaration schützen

Ebenfalls in `mainwindow.h`:

```cpp
#if FEATURE_MOTOR_COMPARISON
    PageMotorComparison *mPageMotorComparison;
#endif
```

### 4. Page-Initialisierung schützen

In `mainwindow.cpp`:

```cpp
#if FEATURE_MOTOR_COMPARISON
    mPageMotorComparison = new PageMotorComparison(this);
    mPageMotorComparison->setVesc(mVesc);
    ui->pageWidget->addWidget(mPageMotorComparison);
    addPageItem(tr("Motor Comparison"), theme + "icons/Compare-96.png", "", true);
    mPageNameIdList.insert("motor_comparison", ui->pageList->count() - 1);
#endif
```

## Ein Feature wieder aktivieren

Um ein deaktiviertes Feature wieder zu aktivieren:

1. Öffne `custom_features.h`
2. Setze das entsprechende Flag von `0` auf `1`:
   ```cpp
   #define FEATURE_APP_PPM    1  // jetzt aktiviert
   ```
3. Neu kompilieren

Keine weiteren Änderungen nötig - der Code ist bereits vorbereitet!

## Vorteile dieses Systems

- ✅ **Kein Code-Löschen**: Originaler Code bleibt erhalten
- ✅ **Einfaches Umschalten**: Features mit einem Flag aktivieren/deaktivieren
- ✅ **Kleinere Binary**: Deaktivierte Features werden nicht kompiliert
- ✅ **Wartbarkeit**: Updates vom Original leichter zu übernehmen
- ✅ **Mehrere Versionen**: Unterschiedliche Feature-Sets für verschiedene Builds

## Feature-Kategorien

### Core Features (sollten aktiv bleiben)
- `FEATURE_WELCOME` - Welcome Screen & Wizards
- `FEATURE_CONNECTION` - Verbindungsmanagement
- `FEATURE_FIRMWARE` - Firmware-Upload
- `FEATURE_MOTOR_GENERAL` - Grundlegende Motor-Einstellungen
- `FEATURE_MOTOR_FOC` - FOC-Steuerung (Hauptfokus)
- `FEATURE_APP_GENERAL` - App-Grundeinstellungen
- `FEATURE_APP_UART` - UART-Kommunikation

### Optional Features
- `FEATURE_PACKAGES` - VESC Package Manager
- `FEATURE_DATA_ANALYSIS` - Datenanalyse-Tools
- `FEATURE_RT_DATA` - Echtzeit-Daten
- `FEATURE_TERMINAL` - Terminal/Konsole
- `FEATURE_SCRIPTING` - QML Scripting
- `FEATURE_LISP` - LispBM Programmierung

### Advanced Features
- `FEATURE_LOG_ANALYSIS` - Log-Analyse
- `FEATURE_MOTOR_COMPARISON` - Motor-Vergleich
- `FEATURE_CAN_ANALYZER` - CAN-Bus Analyzer
- `FEATURE_BMS` - Battery Management System
- `FEATURE_ESP_PROG` - ESP Programmer
- `FEATURE_SWD_PROG` - SWD Programmer

## Build-Prozess

Das Feature-System wird automatisch beim Kompilieren angewendet:

```bash
# Custom-Version mit reduzierten Features
qmake -config release "CONFIG+=build_custom"
mingw32-make

# Original-Version mit allen Features
qmake -config release "CONFIG+=build_original"
mingw32-make
```

## Troubleshooting

### Kompilierungsfehler nach Feature-Deaktivierung

Wenn nach dem Deaktivieren eines Features Kompilierungsfehler auftreten:

1. **Suche nach Abhängigkeiten**: Andere Code-Teile referenzieren das Feature
2. **Schütze Zugriffe**: Umgebe Zugriffe auf das Feature mit `#if FEATURE_XXX`
3. **Beispiel**: Wenn ein Signal/Slot auf die Page zugreift:
   ```cpp
   #if FEATURE_APP_PPM
       connect(sender, SIGNAL(xyz()), mPageAppPpm, SLOT(abc()));
   #endif
   ```

### Feature ist deaktiviert, erscheint aber trotzdem

1. Führe einen Clean-Build durch:
   ```bash
   mingw32-make clean
   qmake -config release "CONFIG+=build_custom"
   mingw32-make
   ```

2. Stelle sicher, dass `custom_features.h` korrekt eingebunden ist

## Weitere Informationen

- `custom_features.h` - Zentrale Feature-Konfiguration
- `README_CUSTOM.md` - Build-Anleitung und Feature-Übersicht
- `vesc_tool.pro` - Qt-Projekt-Konfiguration

Bei Fragen oder Problemen: Prüfe die Compiler-Ausgabe und stelle sicher, dass alle `#if FEATURE_XXX` Blöcke korrekt geschlossen sind mit `#endif`.
