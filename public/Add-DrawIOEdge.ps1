function Add-DrawIOEdge {
    <#
    .SYNOPSIS
        Adds a connector (edge) between two shapes in a Draw.io diagram.
    .DESCRIPTION
        Creates an edge mxCell connecting a source shape to a target shape.
        Every edge includes a child mxGeometry element as required by Draw.io.
    .PARAMETER Diagram
        The diagram object returned by New-DrawIODiagram.
    .PARAMETER From
        The ID of the source shape.
    .PARAMETER To
        The ID of the target shape.
    .PARAMETER Label
        Optional text label on the connector.
    .PARAMETER Style
        Custom edge style. Default: orthogonal edge with rounded corners.
    .PARAMETER ParentId
        Parent cell ID. Default: "1".
    .PARAMETER Id
        Explicit cell ID. Auto-generated if omitted.
    .EXAMPLE
        Add-DrawIOEdge -Diagram $d -From $shape1.Id -To $shape2.Id
    .EXAMPLE
        Add-DrawIOEdge -Diagram $d -From "3" -To "5" -Label "Yes"
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][PSCustomObject]$Diagram,
        [Parameter(Mandatory)][string]$From,
        [Parameter(Mandatory)][string]$To,
        [string]$Label = "",
        [string]$Style = "edgeStyle=orthogonalEdgeStyle;rounded=1;orthogonalLoop=1;jettySize=auto;html=1;",
        [string]$ParentId = "1",
        [string]$Id
    )

    $params = @{
        Diagram          = $Diagram
        Style            = $Style
        Value            = $Label
        ParentId         = $ParentId
        IsEdge           = $true
        SourceId         = $From
        TargetId         = $To
        RelativeGeometry = $true
    }
    if ($Id) { $params.Id = $Id }

    New-DrawIOCell @params | Out-Null
}
