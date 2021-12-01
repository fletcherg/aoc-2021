$puzzle = Get-Content input.txt

# Part 1
$increase = 0
for ($i = 0; $i -lt $puzzle.length; $i++) {
    if ([int]$puzzle[$i] -lt [int]$puzzle[$i + 1] ) {
        $increase++
    }
}

# Part 2
$newpuzzle = @()
$increase = 0
for ($i = 0; $i -lt ($puzzle.length - 2); $i++) {
     [int]$puzzle[$i] + [int]$puzzle[$i+ 1] + [int]$puzzle[$i+ 2]    
        $newpuzzle += [int]$puzzle[$i] + [int]$puzzle[$i+ 1] + [int]$puzzle[$i+ 2]
}

for ($i = 0; $i -lt $newpuzzle.length; $i++) {
    if ($newpuzzle[$i] -lt $newpuzzle[$i + 1] ) {
        $increase++
    }
}
