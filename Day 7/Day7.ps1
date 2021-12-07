
$puzzle = Get-Content sample.txt
$list = $puzzle.split(",") | % { [int]$_ } | sort-object

## Part 1
$d = [Int]::MaxValue
for ($i = ($list | select-object -First 1); $i -le ($list | select-object -Last 1); $i++) {
    $m = ($list | % { [Math]::Abs($_ - $i) } | Measure-Object -sum).sum
    if ($m -lt $d) { $d = $m }
}
$d

## Part 2
$d = [Int]::MaxValue
for ($i = ($list | select-object -First 1); $i -le ($list | select-object -Last 1); $i++) {
    $m = ($list | % { ([Math]::Abs($_ - $i) * ([Math]::Abs($_ - $i)+1))/2 } | Measure-Object -sum).sum
    if ($m -lt $d) { $d = $m }
}
$d