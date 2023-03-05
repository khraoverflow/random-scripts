function Compress-File {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [string]$File,
        [Parameter(Mandatory=$true)]
        [string]$Output
    )
    try {
        $bytes = [System.IO.File]::ReadAllBytes($File)
        $compressedStream = New-Object System.IO.MemoryStream
        $deflateStream = New-Object System.IO.Compression.DeflateStream($compressedStream, [System.IO.Compression.CompressionMode]::Compress)
        $deflateStream.Write($bytes, 0, $bytes.Length)
        $deflateStream.Flush()
        $deflateStream.Close()
        [System.IO.File]::WriteAllBytes($Output+".compiled", $compressedStream.ToArray())
    }
    catch {
        Write-Error $_.Exception
    }
}