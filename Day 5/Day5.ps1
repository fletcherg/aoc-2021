$puzzle = Get-Content input.txt

## Part 1
$points = @(); $puzzle | % {
    $x1,$y1,$x2,$y2 = $_.replace(" ->","").split(" ").split(",")
    ($x1 -eq $x2) ? (($y1..$y2) | % {$points += "$([int]$x1),$([int]$_)"} ) : `
        ( ($y1 -eq $y2) ? (($x1..$x2) | % {$points += "$([int]$_),$([int]$y1)" }) : $null )
}
($points | group-object | ? {$_.count -gt 1} | Measure-object).count

## Part 2
$points = $puzzle | % -Parallel {
    $x1,$y1,$x2,$y2 = $_.replace(" ->","").split(" ").split(",")
    ($x1 -eq $x2) ? (($y1..$y2) | % {"$([int]$x1),$([int]$_)"} ) : `
        ( ($y1 -eq $y2) ? (($x1..$x2) | % { "$([int]$_),$([int]$y1)" }) : $( 
            $diag = ($x1..$x2),($y1..$y2)
            for ($i=0;$i-lt $diag[0].length;$i++) { "$([int]$diag[0][$i]),$([int]$diag[1][$i])" }
         ) )
}
($points | group-object | ? {$_.count -gt 1} | Measure-object).count

