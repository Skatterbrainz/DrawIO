function Add-DrawIOGroup {
    <#
    .SYNOPSIS
        Adds an invisible group container to a Draw.io diagram.
    .DESCRIPTION
        Creates a group container that visually groups child shapes without a visible border.
        Children use the returned Id as their -ParentId with relative coordinates.
    .PARAMETER Diagram
        The diagram object returned by New-DrawIODiagram.
    .PARAMETER X
        Horizontal position in pixels.
    .PARAMETER Y
        Vertical position in pixels.
    .PARAMETER Width
        Group width in pixels. Default: 400.
    .PARAMETER Height
        Group height in pixels. Default: 200.
    .PARAMETER ParentId
        Parent cell ID. Default: "1".
    .PARAMETER Id
        Explicit cell ID. Auto-generated if omitted.
    .EXAMPLE
        $group = Add-DrawIOGroup -Diagram $d -X 50 -Y 50 -Width 300 -Height 200
        Add-DrawIOShape -Diagram $d -Label "Inside" -Type Rectangle -X 10 -Y 10 -ParentId $group.Id
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][PSCustomObject]$Diagram,
        [double]$X = 0,
        [double]$Y = 0,
        [double]$Width = 400,
        [double]$Height = 200,
        [string]$ParentId = "1",
        [string]$Id
    )

    $params = @{
        Diagram     = $Diagram
        Style       = "group;container=1;pointerEvents=0;"
        Value       = ""
        ParentId    = $ParentId
        X           = $X
        Y           = $Y
        Width       = $Width
        Height      = $Height
        IsContainer = $true
    }
    if ($Id) { $params.Id = $Id }

    New-DrawIOCell @params | Out-Null
}
