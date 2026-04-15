function Add-DrawIOPage {
    <#
    .SYNOPSIS
        Adds a new page (tab) to a Draw.io diagram.
    .DESCRIPTION
        Creates an additional diagram page and switches the diagram object's Root
        to the new page. Subsequent shape/edge calls will target the new page.
    .PARAMETER Diagram
        The diagram object returned by New-DrawIODiagram.
    .PARAMETER Name
        Display name for the new page tab.
    .PARAMETER PageWidth
        Page width in pixels. Default: 1100.
    .PARAMETER PageHeight
        Page height in pixels. Default: 850.
    .EXAMPLE
        Add-DrawIOPage -Diagram $d -Name "Page 2"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][PSCustomObject]$Diagram,
        [Parameter(Mandatory)][string]$Name,
        [int]$PageWidth = 1100,
        [int]$PageHeight = 850
    )

    $xml = $Diagram.XmlDocument
    $mxfile = $xml.SelectSingleNode("//mxfile")
    $diagramId = "page-" + [guid]::NewGuid().ToString("N").Substring(0, 8)

    $diagramEl = $xml.CreateElement("diagram")
    $diagramEl.SetAttribute("id", $diagramId)
    $diagramEl.SetAttribute("name", $Name)

    $model = $xml.CreateElement("mxGraphModel")
    $model.SetAttribute("dx", "0")
    $model.SetAttribute("dy", "0")
    $model.SetAttribute("grid", "1")
    $model.SetAttribute("gridSize", "10")
    $model.SetAttribute("guides", "1")
    $model.SetAttribute("tooltips", "1")
    $model.SetAttribute("connect", "1")
    $model.SetAttribute("arrows", "1")
    $model.SetAttribute("fold", "1")
    $model.SetAttribute("page", "1")
    $model.SetAttribute("pageScale", "1")
    $model.SetAttribute("pageWidth", [string]$PageWidth)
    $model.SetAttribute("pageHeight", [string]$PageHeight)
    $model.SetAttribute("math", "0")
    $model.SetAttribute("shadow", "0")

    $root = $xml.CreateElement("root")

    $cell0 = $xml.CreateElement("mxCell")
    $cell0.SetAttribute("id", "0")
    $root.AppendChild($cell0) | Out-Null

    $cell1 = $xml.CreateElement("mxCell")
    $cell1.SetAttribute("id", "1")
    $cell1.SetAttribute("parent", "0")
    $root.AppendChild($cell1) | Out-Null

    $model.AppendChild($root) | Out-Null
    $diagramEl.AppendChild($model) | Out-Null
    $mxfile.AppendChild($diagramEl) | Out-Null

    $Diagram.Root = $root
    $Diagram.Name = $Name
    $Diagram.NextId = 2
}
