$puzzle = get-content input.txt

# Part 1
$hpos = $depth = 0

$puzzle | % { 
    $action,$x = $_.split(" ")
    switch($action) {
        forward { $hpos += $x }
        up {$depth -= $x}
        down {$depth += $x}
    }
}

$hpos * $depth

# Part 2
$hpos = $depth = $aim = 0

$puzzle | % { 
    $action,$x = $_.split(" ")
    switch($action) {
        down { $aim += $x}
        up { $aim -= $x}
        forward { $hpos += $x ; $depth += [int]$x * $aim}
    }
}
$hpos * $depth
