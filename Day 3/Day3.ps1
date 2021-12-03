

$puzzle = get-content input.txt
$length = $puzzle[0].length

## Part 1
$gamma = $epsilon = ""

for ($i = 0; $i -le $length; $i++) {
    $bits = @()
    $puzzle | % { $bits += $_[$i]}

    $gamma += (($bits | Group-Object | Sort-Object Count -Descending) | Select-Object -First 1).name
    $epsilon += (($bits | Group-Object | Sort-Object Count -Descending) | Select-Object -last 1).name
}

[Convert]::ToInt32($gamma,2) * [Convert]::ToInt32($epsilon,2)


## Part 2
$co2 = $o2 = $puzzle

for ($i = 0; $i -lt $length; $i++) {
    $o2bits = @(); $o2 | % { $o2bits += $_[$i] }
    $co2bits = @(); $co2 | % { $co2bits += $_[$i] }

    $x,$y = $o2bits | Group-Object
    if ($x.count -eq $y.count) {
        $o2bit = "1"
    } elseif ($x.count -gt $y.count) {
        $o2bit = $x.name
    } else {
        $o2bit = $y.name
    }

    $x,$y = $co2bits | Group-Object
    if ($x.count -eq $y.count) {
        $co2bit = "0"
    } elseif ($x.count -gt $y.count) {
        $co2bit = $y.name
    } else {
        $co2bit = $x.name
    }

    if (($o2 | Measure-Object).count -gt 1) { $o2 = $o2 | ? {$_[$i] -eq $o2bit} }
    if (($co2 | Measure-Object).count -gt 1) { $co2 = $co2 | ? {$_[$i] -eq $co2bit} }
}

[Convert]::ToInt32($o2,2) * [Convert]::ToInt32($co2,2)
