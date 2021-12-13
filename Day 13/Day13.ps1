
$puzzle = Get-Content input.txt

### Part 1
($puzzle | ? {$_ -AND $_ -notlike "fold*"} | % { $x,$y = $_.split(",") | % { [int]$_ };
     if($x -gt 655){$x=655-($x-655) };$x,$y -join ","} | Sort-Object | Get-Unique | Measure-Object).count

### Part 2

$points = $puzzle | ? {$_ -like "*,*"}
$folds = $puzzle | ? {$_ -like "fold*"}

foreach ($fold in $folds) {
    $a,$pos = $fold.split(" ")[2].split("=")
    if ($a -eq "x") {
        $points = $points | % { 
            $x,$y = $_.split(",") | % { [int]$_ }
            if($x -gt [int]$pos) { $x = [int]$pos - ($x - [int]$pos)};$x,$y -join ","
        }
    } else { $points = $points | % { 
            $x,$y = $_.split(",") | % { [int]$_ }
            if($y -gt [int]$pos) { $y = [int]$pos - ($y - [int]$pos)};$x,$y -join "," 
        }
    } 
Write-Host "After folding along $($a)=$($pos), $(($points | Sort-Object | Get-unique | measure-object).Count) points remain"
}

$maxX = $points | % { [int]$_.split(",")[0] } | Sort-Object | Select -last 1
$maxY = $points | % { [int]$_.split(",")[1] } | Sort-Object | Select -last 1
for ($y=0;$y -le $maxY;$y++) {
    for ($x = 0;$x -le $maxX;$x++) {
        if ($points -contains "$($x),$($y)") {
            Write-Host "X" -nonewline -foregroundcolor green
        } else { Write-Host " " -nonewline }
    }
    Write-Host
}