$puzzle = Get-Content input.txt

## Part 1
$points = $puzzle | % {
    $x1,$y1,$x2,$y2 = $_.split(" -> ").split(",")
    ($x1 -eq $x2) ? (($y1..$y2) | % { "$([int]$x1),$([int]$_)"} ) : `
        ( ($y1 -eq $y2) ? (($x1..$x2) | % { "$([int]$_),$([int]$y1)" }) : $null )
}
($points | group-object | ? {$_.count -gt 1} | Measure-object).count

## Part 2
$points = $puzzle | %  {
    $x1,$y1,$x2,$y2 = $_.split(" -> ").split(",")
    ($x1 -eq $x2) ? (($y1..$y2) | % {"$([int]$x1),$([int]$_)"} ) : `
        ( ($y1 -eq $y2) ? (($x1..$x2) | % { "$([int]$_),$([int]$y1)" }) : $( 
            $diag = ($x1..$x2),($y1..$y2)
            (0..($diag[0].length - 1)) | % { "$([int]$diag[0][$_]),$([int]$diag[1][$_])" }
         ) )
}
($points | group-object | ? {$_.count -gt 1} | Measure-object).count
