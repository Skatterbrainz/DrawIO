function Add-DrawIOSwimLane {
    <#
    .SYNOPSIS
        Adds a swim lane container to a Draw.io diagram.
    .DESCRIPTION
        Creates a swimlane container shape. Child shapes placed inside this container
        should use the returned Id as their -ParentId and use coordinates relative to
        the swimlane's origin.
    .PARAMETER Diagram
        The diagram object returned by New-DrawIODiagram.
    .PARAMETER Label
        Header text for the swim lane.
    .PARAMETER X
        Horizontal position in pixels.
    .PARAMETER Y
        Vertical position in pixels.
    .PARAMETER Width
        Swim lane width in pixels. Default: 800.
    .PARAMETER Height
        Swim lane height in pixels. Default: 200.
    .PARAMETER Horizontal
        If $true (default), the header is at the top. If $false, the header is on the left side.
    .PARAMETER HeaderSize
        Header bar height (or width if vertical) in pixels. Default: 30.
    .PARAMETER Collapsible
        Whether the swim lane can be collapsed. Default: $false.
    .PARAMETER FillColor
        Background color in #RRGGBB format. Omit for default.
    .PARAMETER FontStyle
        Font style bitmask: 0=normal, 1=bold, 2=italic, 4=underline.
    .PARAMETER ParentId
        Parent cell ID. Default: "1".
    .PARAMETER Id
        Explicit cell ID. Auto-generated if omitted.
    .EXAMPLE
        $lane = Add-DrawIOSwimLane -Diagram $d -Label "Processing" -X 0 -Y 100 -Width 1000 -Height 300
        Add-DrawIOShape -Diagram $d -Label "Step 1" -Type Process -X 20 -Y 40 -ParentId $lane.Id
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][PSCustomObject]$Diagram,
        [Parameter(Mandatory)][string]$Label,
        [double]$X = 0,
        [double]$Y = 0,
        [double]$Width = 800,
        [double]$Height = 200,
        [bool]$Horizontal = $true,
        [int]$HeaderSize = 30,
        [bool]$Collapsible = $false,
        [string]$FillColor,
        [int]$FontStyle = -1,
        [string]$ParentId = "1",
        [string]$Id
    )

    $horizVal = if ($Horizontal) { "1" } else { "0" }
    $collapseVal = if ($Collapsible) { "1" } else { "0" }

    $style = "swimlane;html=1;startSize=$HeaderSize;horizontal=$horizVal;collapsible=$collapseVal;whiteSpace=wrap;"
    if ($FillColor) { $style += "fillColor=$FillColor;" }
    if ($FontStyle -ge 0) { $style += "fontStyle=$FontStyle;" }

    $params = @{
        Diagram     = $Diagram
        Style       = $style
        Value       = $Label
        ParentId    = $ParentId
        X           = $X
        Y           = $Y
        Width       = $Width
        Height      = $Height
        IsContainer = $true
    }
    if ($Id) { $params.Id = $Id }

    New-DrawIOCell @params
}
