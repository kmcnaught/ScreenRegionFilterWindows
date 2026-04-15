Screen region filter
========================

A small portable utility for applying colour filters to a specific region of your screen, based on the [Windows Magnification Sample program](github.com/microsoft/Windows-classic-samples/tree/main/Samples/Magnification).

Define a rectangle with two mouse clicks, then toggle inversion, grayscale, and brightness using keyboard controls. 

Save up to 10 regions with their settings and recall them instantly with a numbered shortcut. Useful if you work in dark mode but regularly encounter bright content you can't control: shared screens in video calls, legacy apps, PDFs, e-learning platforms. This is a portable app - just run the executable. Shortcuts are configurable via a plain text file.

## Usage

### Defining a region

When the app launches it goes full-screen in selection mode (crosshair cursor). Click two points — top-left then bottom-right — to define the filter region. No click-and-drag required.

### Filter controls

These keys are active once a region has been selected. The window must have focus (i.e. not be pinned — see below).

| Key | Action |
|-----|--------|
| `I` | Toggle inversion on/off |
| `C` | Toggle colour/grayscale |
| `W` | Cycle brightness level: 100% → 80% → 60% → 40% → 100% |

These can be combined - for example, inversion + 60% brightness, or grayscale + inversion. 

### Pinning (click-through mode)

| Key | Action |
|-----|--------|
| `Ctrl+Shift+P` | Toggle pin/unpin (global hotkey, works even when the window doesn't have focus) |

When **pinned**, the filter overlay becomes transparent to mouse and keyboard input — you can interact normally with whatever is underneath. The title bar remains draggable so you can reposition the window while pinned. When **unpinned**, focus returns to the filter window so you can adjust settings.

### Saving and loading presets

Presets store the region position, size, and all filter settings (inversion, grayscale, brightness level).

| Key | Action |
|-----|--------|
| `Ctrl+1` – `Ctrl+9` | Save current region and settings to slot 1–9 |
| `1` – `9` | Load preset from slot 1–9 (after launching the EXE) |
| `0` | Cycle through all saved presets in order |

Any preset rectangle settings persist between settings in `saved_rects.txt` which is written to the **working directory** at the time the app is launched - this may differ from the directory the executable lives in, depending how you invoke it (shortcut, AHK macro, etc). Multiple running instances share the same preset file.

### Multiple instances

| Key | Action |
|-----|--------|
| `Ctrl+N` | Launch a new instance to define an additional filter region |

Each instance operates independently with its own filter settings. Run as many as you need for different regions simultaneously.

### Customising shortcuts

All shortcuts except the number keys and `Ctrl+N` are configurable via `shortcuts.txt` in the same directory as the executable. The file is created with defaults on first run. Changes take effect after restarting the app.

```
ToggleInvertKey=I
ToggleGrayscaleKey=C
CycleWhiteLevelKey=W
GlobalHotkeyKey=P
GlobalHotkeyModifiers=CTRL+SHIFT   # combine with +, e.g. CTRL+ALT
```
