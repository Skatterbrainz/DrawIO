function Add-DrawIOShape {
    <#
    .SYNOPSIS
        Adds a shape to a Draw.io diagram.
    .DESCRIPTION
        Adds a vertex (shape) mxCell to the diagram with the specified type, position, and label.
        The -Type parameter maps to a predefined Draw.io style string.
    .PARAMETER Diagram
        The diagram object returned by New-DrawIODiagram.
    .PARAMETER Label
        Text displayed inside the shape.
    .PARAMETER Type
        Shape type. Each maps to a Draw.io style. Default: Rectangle.
    .PARAMETER X
        Horizontal position in pixels (0 = left edge).
    .PARAMETER Y
        Vertical position in pixels (0 = top edge).
    .PARAMETER Width
        Shape width in pixels. Default: 120.
    .PARAMETER Height
        Shape height in pixels. Default: 60.
    .PARAMETER Style
        Additional style properties to append or override (semicolon-separated key=value pairs).
    .PARAMETER ParentId
        Parent cell ID. Default: "1" (default layer). Use a swimlane or group ID for containment.
    .PARAMETER Id
        Explicit cell ID. Auto-generated if omitted.
    .EXAMPLE
        $shape = Add-DrawIOShape -Diagram $d -Label "Discover User" -Type Process -X 100 -Y 200
    .EXAMPLE
        $decision = Add-DrawIOShape -Diagram $d -Label "Has Manager?" -Type Decision -X 300 -Y 200 -Width 100 -Height 80
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][PSCustomObject]$Diagram,
        [Parameter(Mandatory)][string]$Label,
        [ValidateSet(
            "Rectangle", "RoundedRectangle", "Process", "Decision", "Document",
            "Ellipse", "Circle", "Cylinder", "Cloud", "Triangle", "Hexagon",
            "Parallelogram", "Trapezoid", "Note", "Card", "ManualInput",
            "DataStorage", "InternalStorage", "OffPageConnector", "Delay",
            "Display", "Subprocess", "Start", "End", "Terminator", "Text"
        )]
        [string]$Type = "Rectangle",
        [double]$X = 0,
        [double]$Y = 0,
        [double]$Width = 120,
        [double]$Height = 60,
        [string]$Style,
        [string]$ParentId = "1",
        [string]$Id
    )

    $styleMap = @{
        Rectangle        = "whiteSpace=wrap;html=1;"
        RoundedRectangle = "rounded=1;whiteSpace=wrap;html=1;"
        Process          = "shape=process;whiteSpace=wrap;html=1;"
        Decision         = "rhombus;whiteSpace=wrap;html=1;perimeter=rhombusPerimeter;"
        Document         = "shape=document;whiteSpace=wrap;html=1;"
        Ellipse          = "ellipse;whiteSpace=wrap;html=1;"
        Circle           = "ellipse;whiteSpace=wrap;html=1;aspect=fixed;"
        Cylinder         = "shape=cylinder3;whiteSpace=wrap;html=1;"
        Cloud            = "ellipse;shape=cloud;whiteSpace=wrap;html=1;"
        Triangle         = "triangle;whiteSpace=wrap;html=1;perimeter=trianglePerimeter;"
        Hexagon          = "shape=hexagon;whiteSpace=wrap;html=1;perimeter=hexagonPerimeter2;"
        Parallelogram    = "shape=parallelogram;whiteSpace=wrap;html=1;perimeter=parallelogramPerimeter;"
        Trapezoid        = "shape=trapezoid;whiteSpace=wrap;html=1;perimeter=trapezoidPerimeter;"
        Note             = "shape=note;whiteSpace=wrap;html=1;"
        Card             = "shape=card;whiteSpace=wrap;html=1;"
        ManualInput      = "shape=manualInput;whiteSpace=wrap;html=1;"
        DataStorage      = "shape=dataStorage;whiteSpace=wrap;html=1;"
        InternalStorage  = "shape=internalStorage;whiteSpace=wrap;html=1;"
        OffPageConnector = "shape=offPageConnector;whiteSpace=wrap;html=1;"
        Delay            = "shape=delay;whiteSpace=wrap;html=1;"
        Display          = "shape=display;whiteSpace=wrap;html=1;"
        Subprocess       = "shape=process;whiteSpace=wrap;html=1;"
        Start            = "ellipse;whiteSpace=wrap;html=1;fillColor=#000000;fontColor=#FFFFFF;"
        End              = "ellipse;whiteSpace=wrap;html=1;shape=doubleEllipse;"
        Terminator       = "rounded=1;whiteSpace=wrap;html=1;arcSize=50;"
        Text             = "text;html=1;align=center;verticalAlign=middle;whiteSpace=wrap;"
    }

    $baseStyle = $styleMap[$Type]
    if ($Style) {
        $baseStyle = $baseStyle + $Style.TrimEnd(";") + ";"
    }

    $params = @{
        Diagram  = $Diagram
        Style    = $baseStyle
        Value    = $Label
        ParentId = $ParentId
        X        = $X
        Y        = $Y
        Width    = $Width
        Height   = $Height
    }
    if ($Id) { $params.Id = $Id }

    New-DrawIOCell @params
}
