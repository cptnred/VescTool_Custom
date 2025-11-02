# Custom VESC Tool Build

Dies ist eine angepasste Version des VESC Tools mit reduzierten Funktionen.

## Kompilieren

### Voraussetzungen

**Windows:**
- Qt 5.15.x mit MinGW (oder MSVC)
- Installierte Qt Module: qtbase, qtserialport, qtconnectivity, qtquick, qtquickcontrols2, qtbluetooth, qtserialbus, qtpositioning, qtgamepad, qtsvg

### Build-Anweisungen

#### Methode 1: Mit PowerShell-Script (empfohlen)

```powershell
# Qt in PATH hinzufügen (Beispiel, Pfad anpassen!)
$env:PATH = "C:\Qt\5.15.2\mingw81_64\bin;$env:PATH"

# Build mit Firmware
.\build_custom.ps1

# Build ohne Firmware (schneller)
.\build_custom.ps1 -ExcludeFW
```

#### Methode 2: Mit Qt Creator

1. Qt Creator öffnen
2. Projekt öffnen: `vesc_tool.pro`
3. In der `.pro` Datei folgende Zeile aktivieren:
   ```
   CONFIG += build_custom
   ```
4. Build starten (Ctrl+B)

#### Methode 3: Manuell mit qmake

```powershell
# Qt in PATH hinzufügen
$env:PATH = "C:\Qt\5.15.2\mingw81_64\bin;$env:PATH"

# Mit Firmware
qmake -config release "CONFIG+=build_custom"
mingw32-make -j8

# Ohne Firmware (schneller)
qmake -config release "CONFIG+=build_custom exclude_fw"
mingw32-make -j8
```

Die fertige Executable befindet sich in: `build/win/vesc_tool_6.06.exe`

## Anpassungen

Diese Custom-Version unterscheidet sich vom Original durch:

- **Logo/Icon**: Eigene Grafiken in `res/version/custom_*.svg/png`
- **Branding**: Als "Custom Version" im About-Dialog gekennzeichnet
- **Funktionen**: Reduzierte Feature-Set mit Fokus auf FOC-Motoren

### Entfernte Features

**Motor Settings:**
- ❌ BLDC (BLDC-Motor-Konfiguration)
- ❌ DC (DC-Motor-Konfiguration)
- ❌ GPDrive (General Purpose Drive)
- ❌ PID Controllers (Regelkreise)

**App Settings:**
- ❌ PPM (RC-Empfänger)
- ❌ ADC (Analog-Input)
- ❌ VESC Remote (Fernbedienung/Nunchuk)
- ❌ Nrf (Wireless)
- ❌ PAS (Pedal Assist)

**Development Tools:**
- ❌ Display Tool

### Verfügbare Features

**Motor Settings:**
- ✅ General (Allgemeine Motor-Einstellungen)
- ✅ **FOC** (Field-Oriented Control) - Hauptfokus
- ✅ Additional Info
- ✅ Experiments

**App Settings:**
- ✅ General (Allgemeine App-Einstellungen)
- ✅ **UART** (Serielle Kommunikation) - Hauptsteuerung
- ✅ IMU (Bewegungssensor)

**Weitere Features:**
- ✅ Welcome & Wizards
- ✅ Connection
- ✅ Firmware
- ✅ VESC Packages
- ✅ Data Analysis (RT Data, Sampled Data, Log Analysis)
- ✅ Terminal, Scripting, LispBM
- ✅ CAN Analyzer, BMS
- ✅ Programmer-Tools (SWD, ESP)

## Weitere Anpassungen

### Logo/Icon ändern

Die Grafiken befinden sich in:
- `res/version/custom_v.svg` - Icon (Dark Theme)
- `res/version/custom_vesc_tool.png` - Logo (Dark Theme)
- `res/+theme_light/version/custom_v.svg` - Icon (Light Theme)
- `res/+theme_light/version/custom_vesc_tool.png` - Logo (Light Theme)

### Funktionen entfernen

Funktionen werden in späteren Schritten aus der UI entfernt, indem entsprechende Widgets und Menüeinträge deaktiviert werden.

## Lizenz

Diese Software basiert auf VESC Tool und unterliegt der GNU General Public License v3.0.
Siehe LICENSE Datei für Details.

## Wichtige Hinweise

- Dies ist keine offizielle VESC Tool Version
- VESC® ist ein eingetragenes Warenzeichen von Benjamin Vedder
- Siehe [VESC Trademark Policies](https://vesc-project.com/trademark_policies) für weitere Informationen
