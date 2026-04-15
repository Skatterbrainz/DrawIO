function Save-DrawIODiagram {
    <#
    .SYNOPSIS
        Saves a Draw.io diagram to a .drawio file.
    .DESCRIPTION
        Writes the diagram XML document to disk. The output file can be opened in
        Draw.io desktop, the VS Code extension, or app.diagrams.net.
    .PARAMETER Diagram
        The diagram object returned by New-DrawIODiagram.
    .PARAMETER Path
        Output file path. Should end in .drawio.
    .PARAMETER Force
        Overwrite the file if it already exists.
    .EXAMPLE
        Save-DrawIODiagram -Diagram $d -Path "./mydiagram.drawio"
    .EXAMPLE
        Save-DrawIODiagram -Diagram $d -Path "/tmp/flow.drawio" -Force
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][PSCustomObject]$Diagram,
        [Parameter(Mandatory)][string]$Path,
        [switch]$Force
    )

    $resolvedPath = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
    $directory = [System.IO.Path]::GetDirectoryName($resolvedPath)

    if ($directory -and -not (Test-Path $directory)) {
        New-Item -ItemType Directory -Path $directory -Force | Out-Null
    }

    if ((Test-Path $resolvedPath) -and -not $Force) {
        throw "File already exists: $resolvedPath. Use -Force to overwrite."
    }

    $settings = [System.Xml.XmlWriterSettings]::new()
    $settings.Indent = $true
    $settings.IndentChars = "  "
    $settings.OmitXmlDeclaration = $true
    $settings.Encoding = [System.Text.UTF8Encoding]::new($false)

    $writer = [System.Xml.XmlWriter]::Create($resolvedPath, $settings)
    try {
        $Diagram.XmlDocument.WriteTo($writer)
    } finally {
        $writer.Dispose()
    }

    Write-Verbose "Diagram saved to: $resolvedPath"
    Get-Item $resolvedPath
}
