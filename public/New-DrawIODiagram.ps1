function New-DrawIODiagram {
    <#
    .SYNOPSIS
        Creates a new Draw.io diagram.
    .DESCRIPTION
        Creates the XML document structure for a Draw.io diagram and returns a diagram object
        used by all other DrawIO module functions.
    .PARAMETER Name
        Display name for the diagram page. Default: "Page-1".
    .PARAMETER PageWidth
        Page width in pixels. Default: 1100.
    .PARAMETER PageHeight
        Page height in pixels. Default: 850.
    .PARAMETER Grid
        Show grid. Default: $true.
    .PARAMETER GridSize
        Grid cell size in pixels. Default: 10.
    .EXAMPLE
        $diagram = New-DrawIODiagram -Name "My Flowchart"
    #>
    [CmdletBinding()]
    param(
        [string]$Name = "Page-1",
        [int]$PageWidth = 1100,
        [int]$PageHeight = 850,
        [bool]$Grid = $true,
        [int]$GridSize = 10
    )

    $gridVal = if ($Grid) { "1" } else { "0" }
    $diagramId = "page-" + [guid]::NewGuid().ToString("N").Substring(0, 8)

    [xml]$xml = @"
<mxfile host="DrawIO-PowerShell" modified="$(Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffZ')" agent="DrawIO-PowerShell-Module" version="1.0" type="device">
  <diagram id="$diagramId" name="$Name">
    <mxGraphModel dx="0" dy="0" grid="$gridVal" gridSize="$GridSize" guides="1" tooltips="1" connect="1" arrows="1" fold="1" page="1" pageScale="1" pageWidth="$PageWidth" pageHeight="$PageHeight" math="0" shadow="0">
      <root>
        <mxCell id="0" />
        <mxCell id="1" parent="0" />
      </root>
    </mxGraphModel>
  </diagram>
</mxfile>
"@

    $root = $xml.SelectSingleNode("//mxfile/diagram/mxGraphModel/root")

    [PSCustomObject]@{
        PSTypeName  = "DrawIO.Diagram"
        XmlDocument = $xml
        Root        = $root
        NextId      = 2
        Name        = $Name
    }
}
