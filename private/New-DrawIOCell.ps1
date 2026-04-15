function New-DrawIOCell {
    <#
    .SYNOPSIS
        Internal helper to create an mxCell XML element.
    .DESCRIPTION
        Creates an mxCell element with optional geometry and appends it to the diagram root.
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][PSCustomObject]$Diagram,
        [Parameter(Mandatory)][string]$Style,
        [string]$Value = "",
        [string]$ParentId = "1",
        [string]$Id,
        [double]$X = 0,
        [double]$Y = 0,
        [double]$Width = 120,
        [double]$Height = 60,
        [switch]$IsEdge,
        [string]$SourceId,
        [string]$TargetId,
        [switch]$RelativeGeometry,
        [switch]$IsContainer
    )

    $xml = $Diagram.XmlDocument

    if ([string]::IsNullOrEmpty($Id)) {
        $Id = [string]$Diagram.NextId
        $Diagram.NextId++
    }

    $cell = $xml.CreateElement("mxCell")
    $cell.SetAttribute("id", $Id)
    $cell.SetAttribute("value", $Value)
    $cell.SetAttribute("style", $Style)
    $cell.SetAttribute("parent", $ParentId)

    if ($IsEdge) {
        $cell.SetAttribute("edge", "1")
        if ($SourceId) { $cell.SetAttribute("source", $SourceId) }
        if ($TargetId) { $cell.SetAttribute("target", $TargetId) }
    } else {
        $cell.SetAttribute("vertex", "1")
    }

    if ($IsContainer) {
        $cell.SetAttribute("connectable", "0")
    }

    $geo = $xml.CreateElement("mxGeometry")

    if ($RelativeGeometry) {
        $geo.SetAttribute("relative", "1")
    } else {
        $geo.SetAttribute("x", [string]$X)
        $geo.SetAttribute("y", [string]$Y)
        $geo.SetAttribute("width", [string]$Width)
        $geo.SetAttribute("height", [string]$Height)
    }

    $geo.SetAttribute("as", "geometry")
    $cell.AppendChild($geo) | Out-Null
    $Diagram.Root.AppendChild($cell) | Out-Null

    [PSCustomObject]@{
        Id         = $Id
        XmlElement = $cell
    }
}
