function Set-DrawIODiagramProperty {
    <#
    .SYNOPSIS
        Sets a property on the current diagram page's mxGraphModel.
    .DESCRIPTION
        Modifies mxGraphModel-level attributes such as grid, shadow, page dimensions, etc.
    .PARAMETER Diagram
        The diagram object returned by New-DrawIODiagram.
    .PARAMETER Property
        The mxGraphModel attribute name to set.
    .PARAMETER Value
        The value to assign.
    .EXAMPLE
        Set-DrawIODiagramProperty -Diagram $d -Property "shadow" -Value "1"
    .EXAMPLE
        Set-DrawIODiagramProperty -Diagram $d -Property "pageWidth" -Value "1700"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][PSCustomObject]$Diagram,
        [Parameter(Mandatory)]
        [ValidateSet(
            "dx", "dy", "grid", "gridSize", "guides", "tooltips", "connect",
            "arrows", "fold", "page", "pageScale", "pageWidth", "pageHeight",
            "math", "shadow"
        )]
        [string]$Property,
        [Parameter(Mandatory)][string]$Value
    )

    $model = $Diagram.Root.ParentNode
    $model.SetAttribute($Property, $Value)
}
