

$puzzle = Get-Content input.txt
$size = 5

$numbers = $puzzle[0].split(",")

class Bingocard{
    [int[,]]$numbers
    [System.Boolean]$won = $FALSE
    [System.Collections.ArrayList]$lines
}

$bingocards = @()
for ($i = 2;$i -lt $puzzle.length;$i = $i + 6) {
    $bingocard = [Bingocard]::new()
    $bingocard.numbers = New-Object 'Int[,]' 5,5
    $lines = New-Object 'Int[,]' 10,5
    $bingocard.lines = [System.Collections.ArrayList]::new()
    for ($j = 0; $j -lt $size; $j++) {
        for ($k = 0; $k -lt $size; $k++) {
            $bingocard.numbers[$j,$k] = ([int[]]($puzzle[$i + $j].split(" ").trim() | ? {$_}))[$k]
            $lines[$j,$k] = ([int[]]($puzzle[$i + $j].split(" ").trim() | ? {$_}))[$k]
            $lines[($k + $size),$j] = ([int[]]($puzzle[$i + $j].split(" ").trim() | ? {$_}))[$k]
        }
    }
    foreach ($line in (1.. ($size * 2))) { 
        [void]$bingocard.lines.add( $((1..$size) | % { $lines[($line - 1),($_ - 1)] } ) )
    }
    $bingoCards += $bingocard
}

### Part 1
$winner = $FALSE
for ($b = 0; $b -lt $numbers.length -AND !($winner); $b++) {
    $picked = (0..$b) | % { $numbers[$_] }    
    for ($i = 0; $i -lt $bingocards.length -AND !($winner) ;$i++) {
         $bingocards[$i].lines | % {
            if((($_ | ? {$picked -contains $_ }) | Measure-object).count -eq $size) {
                 Write-Host "Bingo!"
                 $winner=$TRUE
            }
        }
    }
}

[int]($picked | select -last 1) * ($bingocards[$i-1].numbers | ? {$picked -notcontains $_ } | measure-object  -sum).sum

### Part 2
$winners = $b = 0
while ($winners -lt $bingocards.length) {
    $picked = (0..$b) | % { $numbers[$_] }   
    
    for ($i = 0; $i -lt $bingocards.length;$i++) {
        if (! $bingocards[$i].won) {
            $bingo = $false
            foreach ($line in $bingocards[$i].lines) {
                if ((($line | ? {$picked -contains $_ }) | Measure-object).count -eq $size) {
                    $bingo = $true
                }
            }
            if ($bingo) {
                $bingocards[$i].won = $true
                $winners++
                Write-Host "Card $($i), round $($b)"
                $score = [int]($picked | select -last 1) * `
                        ($bingocards[$i].numbers | ? {$picked -notcontains $_ } | measure-object  -sum).sum
            }
        }
    }
    $b++
}

$score
