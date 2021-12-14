

$puzzle = get-content .\input2.txt

## Part 1

$rules=@{};$puzzle | ?{$_ -like "*->*"} | % { $rules.add($_.split(" -> ")[0],$_.split(" -> ")[1]) }

$a = $puzzle[0].trim()

foreach ($step in (1..10)) {
$a2 = ""
for ($i=0;$i -lt $a.length; $i++) {
    if ($rules."$($a[$i])$($a[$i+1])") {
        $a2 += $a[$i] + $rules."$($a[$i])$($a[$i+1])"
    } else {
        $a2 += $a[$i]
    }
    
}
write-host "Step $($step) - $($a2)"
    #$a2
    $a = $a2
}

 $sorted = $a.tochararray() | group-object | Sort-object -Property count
($sorted | select-object -last 1).Count - ($sorted | select-object -first 1).Count


## Part 2

$rules=@{};$puzzle | ?{$_ -like "*->*"} | % { $rules.add($_.split(" -> ")[0],$_.split(" -> ")[1]) }
$totals=@{};$rules.keys | SOrt-Object | % { $totals.add("$_",0) }

$a = $puzzle[0].trim()
1..($a.Length-1) | % { ,($a[$_-1], $a[$_]) } | % { $_ -join "" } | % { 
    $totals.$_ ++
}

foreach ($step in (1..40)) {
    $k = @{}
    foreach ($t in ($totals.GetEnumerator() | ? { $_.Value -ne 0})) {
        $i1 = "$($t.name[0])$($rules.($t.name))"
        $i2 = "$($rules.($t.name))$($t.name[1])"
        if ($k.$i1) {
            $k.$i1 += $t.value
        } else {
            $k.add($i1,$t.value)
        }
        if ($k.$i2) {
            $k.$i2 += $t.value
        } else {
            $k.add($i2,$t.value)
        }
    }
    $totals = $k
}

## Count
$count = @{}
foreach ($t in ($totals.GetEnumerator())) {
    if ($count.($t.name[0])) {
        $count.($t.name[0]) += $t.value
    } else {
        $count.Add($t.name[0],$t.value)
    }
    if ($count.($t.name[1])) {
        $count.($t.name[1]) += $t.value
    } else {
        $count.Add($t.name[1],$t.value)
    }
}

$count.($a[0]) ++
$count.($a[$a.length -1]) ++

$cmin = [Double]::Maxvalue
$cmax = 0
$count.GetEnumerator() | % { 
    if ($cmin -gt $_.value) { $cmin = $_.value}
    if ($cmax -lt $_.value) { $cmax = $_.value}
}
($cmax /2) - ($cmin /2)
