# see https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comment_based_help?view=powershell-5.1 for help comments
function local:PascalName($name) {
    $parts = $name.Split(" ")
    for ($i = 0 ; $i -lt $parts.Length ; $i++) {
        $parts[$i] = [char]::ToUpper($parts[$i][0]) + $parts[$i].SubString(1).ToLower();
    }
    $parts -join ""
}
function local:GetHeaderBreak($headerRow, $startPoint = 0) {
    $i = $startPoint
    while ( $i + 1 -lt $headerRow.Length) {
        if ($headerRow[$i] -eq ' ' -and $headerRow[$i + 1] -eq ' ') {
            return $i
            break
        }
        $i += 1
    }
    return -1
}
function local:GetHeaderNonBreak($headerRow, $startPoint = 0) {
    $i = $startPoint
    while ( $i + 1 -lt $headerRow.Length) {
        if ($headerRow[$i] -ne ' ') {
            return $i
            break
        }
        $i += 1
    }
    return -1
}
function local:GetColumnInfo($headerRow) {
    $lastIndex = 0
    $i = 0
    while ($i -lt $headerRow.Length) {
        $i = GetHeaderBreak $headerRow $lastIndex
        if ($i -lt 0) {
            $name = $headerRow.Substring($lastIndex)
            New-Object PSObject -Property @{ HeaderName = $name; Name = PascalName $name; Start = $lastIndex; End = -1}
            break
        }
        else {
            $name = $headerRow.Substring($lastIndex, $i - $lastIndex)
            $temp = $lastIndex
            $lastIndex = GetHeaderNonBreak $headerRow $i
            New-Object PSObject -Property @{ HeaderName = $name; Name = PascalName $name; Start = $temp; End = $lastIndex}
        }
    }
}
function local:ParseRow($row, $columnInfo) {
    $values = @{}
    $columnInfo | ForEach-Object {
        if ($_.End -lt 0) {
            $len = $row.Length - $_.Start
        }
        else {
            $len = $_.End - $_.Start
        }
        $values[$_.Name] = $row.SubString($_.Start, $len).Trim()
    }
    New-Object PSObject -Property $values
}

function ConvertFrom-Tabular() {
    <#
    .SYNOPSIS
    Converts tabular output from CLIs to PowerShell objects.

    .PARAMETER input
    The output CLI output

    .EXAMPLE
    Suppose you had the following output from `docker images`:

    REPOSITORY                                             TAG                    IMAGE ID            CREATED             SIZE
    microsoft/powershell                                   latest                 b47c44138f7c        2 weeks ago         381MB
    acs-engine                                             latest                 68545367d656        7 weeks ago         3.17GB
    microsoft/dotnet                                       2.0.0-runtime-jessie   62eaf678c267        2 months ago        233MB
    microsoft/dotnet                                       2.0.0-runtime          83c5700eb926        2 months ago        219MB
    microsoft/dotnet                                       1.1.2-runtime          5cb21e06fdda        3 months ago        251MB
    elasticsearch                                          2.4.4                  2232dfa6321a        5 months ago        345MB

    Then `docker images | ConvertFrom-Tabular | Format-Table` would give:

    Repository                                           ImageId      Created       Tag                  Size  
    ----------                                           -------      -------       ---                  ----  
    microsoft/powershell                                 b47c44138f7c 2 weeks ago   latest               381MB 
    acs-engine                                           68545367d656 7 weeks ago   latest               3.17GB
    microsoft/dotnet                                     62eaf678c267 2 months ago  2.0.0-runtime-jessie 233MB 
    microsoft/dotnet                                     83c5700eb926 2 months ago  2.0.0-runtime        219MB 
    microsoft/dotnet                                     5cb21e06fdda 3 months ago  1.1.2-runtime        251MB 
    elasticsearch                                        2232dfa6321a 5 months ago  2.4.4                345MB 

    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $input 
    )
    
    begin {
        $positions = $null;
    }
    process {
        if ($positions -eq $null) {
            # header row => determine column positions
            $positions = GetColumnInfo -headerRow $_  #-propertyNames $propertyNames
        }
        else {
            # data row => output!
            ParseRow -row $_ -columnInfo $positions
        }
    }
    end {
    }
}
# e.g. :
# docker --tls ps -a --no-trunc | ConvertFrom-Docker | ft


function ConvertFrom-Base64() {
    <#
    .SYNOPSIS
    Converts text from Base64
    
    .DESCRIPTION
    Converts a string from Base64 representation. Defaults to UTF8, but encoding can be specified
    
    .PARAMETER Value
    The value to decode
    
    .PARAMETER Encoding
    The Encoding to use (defaults to [System.Text.Encoding]::UTF8)
    
    .EXAMPLE
    ConvertFrom-Base64 "dGVzdA=="
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string] 
        $Value,

        [Parameter(Mandatory = $false)]
        [System.Text.Encoding] 
        $Encoding = [System.Text.Encoding]::UTF8
    )
    $bytes = [System.Convert]::FromBase64String($Value)
    return $Encoding.GetString($bytes)
}
function ConvertTo-Base64() {
    <#
    .SYNOPSIS
    Converts text to Base64
    
    .DESCRIPTION
    Converts a string to Base64 representation. Defaults to UTF8, but encoding can be specified
    
    .PARAMETER Value
    The value to encode
    
    .PARAMETER Encoding
    The Encoding to use (defaults to [System.Text.Encoding]::UTF8)
    
    .EXAMPLE
    ConvertTo-Base64 "test"
    
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)]
        [string] 
        $Value,

        [Parameter(Mandatory = $false)]
        [System.Text.Encoding] 
        $Encoding = [System.Text.Encoding]::UTF8
    )
    $bytes = $Encoding.GetBytes($Value)
    return [System.Convert]::ToBase64String($bytes)
}