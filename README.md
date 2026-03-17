Screen region filter
========================

A small portable utility for applying colour filters to a specific region of your screen, based on the [Windows Magnification Sample program](github.com/microsoft/Windows-classic-samples/tree/main/Samples/Magnification).

Define a rectangle with two mouse clicks, then toggle inversion, grayscale, and brightness using keyboard controls. 

Save up to 10 regions with their settings and recall them instantly with a numbered shortcut. Useful if you work in dark mode but regularly encounter bright content you can't control: shared screens in video calls, legacy apps, PDFs, e-learning platforms. This is a portable app - just run the executable. Shortcuts are configurable via a plain text file.

## Development

Open `cpp/MagnifierSample.sln` in Visual Studio 2022. Build and run from there — the debugger works normally. The executable lands in `cpp/x64/Debug/ScreenFilterWindow.exe`.

Requirements:
- Visual Studio 2022 with the C++ desktop workload
- Windows 10 SDK (build 17763 or later)


## Releasing

Releases are built and published automatically by GitHub Actions when a semver tag is pushed. Use the included script to tag and push:

```bash
./release.sh          # bump patch version (e.g. v1.0.4 → v1.0.5)
./release.sh minor    # bump minor version
./release.sh major    # bump major version
```

The script checks that the working copy is clean, shows you the new version, asks for confirmation, then creates an annotated tag and pushes it. The Actions workflow builds the Release binary and publishes a GitHub Release with the executable attached.
