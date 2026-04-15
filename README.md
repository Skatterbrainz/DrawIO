# DrawIO

PowerShell module for programmatically generating Draw.io (.drawio) diagram files

![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue)
![Platform](https://img.shields.io/badge/platform-Windows-blue)
![Platform](https://img.shields.io/badge/platform-MacOS-green)
![Platform](https://img.shields.io/badge/platform-Linux-orange)
![License](https://img.shields.io/badge/license-MIT-green)

Create Draw.io diagrams entirely in PowerShell without requiring the Draw.io application or Visio. The module generates valid `.drawio` XML files that can be opened in Draw.io desktop, the VS Code extension, or [app.diagrams.net](https://app.diagrams.net).

## 🎯 Overview

This module provides 8 public functions for building Draw.io diagrams programmatically. It supports 26 shape types, swim lane containers, groups, multi-page diagrams, and fully customizable styles. Output files are standard `.drawio` XML, which can also be exported to `.vsdx`, PDF, SVG, or PNG from within Draw.io.

## ✨ Features

- 🔷 **Shape Creation** - 26 built-in shape types: Rectangle, Process, Decision, Document, Ellipse, Cylinder, Cloud, and more
- 🔗 **Connectors** - Orthogonal edge routing with optional labels and custom styles
- 🏊 **Swim Lanes** - Horizontal or vertical swim lane containers with configurable headers
- 📄 **Multi-Page** - Add multiple pages/tabs to a single diagram
- 🎨 **Full Styling** - Colors, fonts, borders, gradients — anything Draw.io supports
- 📦 **Groups** - Invisible containers for logically grouping shapes
- 💾 **Save** - Write to `.drawio` files with directory auto-creation

## Requirements

- PowerShell 5.1 or higher (tested with 7.4 and 7.5)
- No external dependencies — Draw.io is only needed to *view* the output

## Installation

### From PowerShell Gallery

```powershell
Install-PSResource DrawIO
```

### From GitHub

1. **Clone the repository**
   ```bash
   git clone https://github.com/Skatterbrainz/DrawIO.git
   cd DrawIO
   ```

2. **Import the module**
   ```powershell
   Import-Module ./DrawIO.psd1
   ```

## Usage

```powershell
# Import the module
Import-Module DrawIO

# Create a new diagram
$d = New-DrawIODiagram -Name "My Flowchart"

# Add shapes
$start = Add-DrawIOShape -Diagram $d -Label "Start" -Type RoundedRectangle -X 100 -Y 100
$step1 = Add-DrawIOShape -Diagram $d -Label "Process Data" -Type Process -X 100 -Y 200
$decision = Add-DrawIOShape -Diagram $d -Label "Valid?" -Type Decision -X 100 -Y 320 -Width 100 -Height 80

# Connect shapes
Add-DrawIOEdge -Diagram $d -From $start.Id -To $step1.Id
Add-DrawIOEdge -Diagram $d -From $step1.Id -To $decision.Id

# Save
Save-DrawIODiagram -Diagram $d -Path "./flowchart.drawio"
```

### 🏊 Swim Lanes

```powershell
$d = New-DrawIODiagram -Name "Process Flow"

# Vertical header on the left side
$lane1 = Add-DrawIOSwimLane -Diagram $d -Label "Input" -X 0 -Y 0 -Width 800 -Height 150 -Horizontal $false
$lane2 = Add-DrawIOSwimLane -Diagram $d -Label "Processing" -X 0 -Y 150 -Width 800 -Height 300 -Horizontal $false

# Place shapes inside lanes using -ParentId (coordinates are relative to the lane)
$s1 = Add-DrawIOShape -Diagram $d -Label "Receive Request" -Type Process -X 60 -Y 40 -ParentId $lane1.Id
$s2 = Add-DrawIOShape -Diagram $d -Label "Validate" -Type Process -X 60 -Y 40 -ParentId $lane2.Id

Add-DrawIOEdge -Diagram $d -From $s1.Id -To $s2.Id
Save-DrawIODiagram -Diagram $d -Path "./swimlanes.drawio"
```

### 🎨 Custom Styling

```powershell
# Apply colors via the -Style parameter (semicolon-separated key=value pairs)
Add-DrawIOShape -Diagram $d -Label "Important" -Type Process -X 100 -Y 100 `
    -Style "fillColor=#77B753;fontColor=#FFFFFF;strokeColor=#5A9A3C;fontSize=14;"
```

## 📖 Function Reference

### Diagram

| Function | Description |
|---|---|
| `New-DrawIODiagram` | Create a new diagram object with configurable page size and grid |
| `Save-DrawIODiagram` | Write the diagram to a `.drawio` file |
| `Add-DrawIOPage` | Add a new page/tab to the diagram |
| `Set-DrawIODiagramProperty` | Set mxGraphModel properties (grid, shadow, page dimensions) |

### Shapes

| Function | Description |
|---|---|
| `Add-DrawIOShape` | Add a shape (vertex) with one of 26 built-in types and optional custom styling |
| `Add-DrawIOEdge` | Add a connector between two shapes with optional label |
| `Add-DrawIOSwimLane` | Add a swim lane container with configurable header orientation and size |
| `Add-DrawIOGroup` | Add an invisible group container for logical grouping |

### Supported Shape Types

Rectangle, RoundedRectangle, Process, Decision, Document, Ellipse, Circle, Cylinder, Cloud, Triangle, Hexagon, Parallelogram, Trapezoid, Note, Card, ManualInput, DataStorage, InternalStorage, OffPageConnector, Delay, Display, Subprocess, Start, End, Terminator, Text

## Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new shape types or features
- Improve documentation
- Submit pull requests

Please open an [issue](https://github.com/Skatterbrainz/DrawIO/issues) or submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Version History

- 1.0.0 - 2026-04-15
  - Initial release
  - 8 public functions: New-DrawIODiagram, Add-DrawIOShape, Add-DrawIOEdge, Add-DrawIOSwimLane, Add-DrawIOGroup, Add-DrawIOPage, Set-DrawIODiagramProperty, Save-DrawIODiagram
  - 26 shape types with predefined Draw.io styles
  - Swim lane and group container support
  - Multi-page diagram support
