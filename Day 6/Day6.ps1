
$puzzle = get-content .\input.txt

## Part 1
$lanternfish = [int[]]::New(9)
$puzzle.split(",") | % { $lanternfish[$_]++ }

(1..80)  | % {
    $n = [int[]]::New(9)
    (0..8) | % {
        ($_ -eq 6) ? $($n[$_] = $lanternfish[$_ + 1] + $lanternfish[0]) `
            : $($n[$_] = $lanternfish[($_ + 1) % 9])
    }
    $lanternfish = $n
}
($lanternfish | Measure-Object -Sum).Sum

## Part 2
$lanternfish = [double[]]::New(9)
$puzzle.split(",") | % { $lanternfish[$_]++ }

(1..256)  | % {
    $n = [double[]]::New(9)
    (0..8) | % {
        ($_ -eq 6) ? $($n[$_] = $lanternfish[$_ + 1] + $lanternfish[0]) `
            : $($n[$_] = $lanternfish[($_ + 1) % 9])
    }
    $lanternfish = $n
}
($lanternfish | Measure-Object -Sum).Sum