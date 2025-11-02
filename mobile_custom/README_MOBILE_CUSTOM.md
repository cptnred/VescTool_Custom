# Mobile Custom - Angepasste QML Dateien

Dieser Ordner enthält die angepassten QML-Dateien für die Custom VESC Tool Version.

## Änderungen gegenüber Original

### ConfigPageMotor.qml
**Entfernte Features:**
- BLDC Detection (DetectBldc Dialog + MenuItem)

**Behalten:**
- ✅ FOC Parameter Detection
- ✅ FOC Hall Sensor Detection  
- ✅ FOC Encoder Detection
- ✅ FOC Offsets Measurement
- ✅ Direction Setup

### ConfigPageApp.qml
**Entfernte Features:**
- PPM Mapping (Dialog + MenuItem)
- ADC Mapping (Dialog + MenuItem)
- NRF Pairing (Dialog + MenuItem)

**Behalten:**
- ✅ UART Configuration
- ✅ IMU Configuration
- ✅ General App Settings

## Verwendung

Die Dateien in diesem Ordner werden automatisch beim Custom-Build mit Mobile UI verwendet.

### Build mit Custom Mobile UI:
```powershell
.\build_custom.ps1 -IncludeMobile -ExcludeFW
```

### Build ohne Mobile UI (nur Desktop):
```powershell
.\build_custom.ps1 -ExcludeFW
```

## Wie es funktioniert

Das Build-Script `build_custom.ps1` führt automatisch einen Ordner-Swap durch:

1. **Vor dem Build:**
   - `mobile` → `mobile_original` (Backup)
   - `mobile_custom` → `mobile` (Custom-Version aktiv)

2. **Build durchführen**

3. **Nach dem Build (automatisch):**
   - `mobile` löschen
   - `mobile_original` → `mobile` (Wiederherstellung)

Dadurch bleiben die Original-Dateien unverändert und andere Builds funktionieren weiterhin.

## Anpassungen vornehmen

1. Dateien in `mobile_custom/` bearbeiten
2. Build mit `.\build_custom.ps1 -IncludeMobile`
3. Testen

Der `mobile/` Ordner bleibt immer im Original-Zustand!
