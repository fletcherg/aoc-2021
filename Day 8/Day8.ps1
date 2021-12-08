

$puzzle = get-content input.txt

## Part 1
($puzzle | % { $_.split("|")[1].trim()} | % { $_.split(" ") } | % { $_.length} | group-object | ? { "2","7","4","3" -contains $_.name } | % { $_.count} | Measure-Object -Sum).Sum

## Part 2
foreach ($line in $puzzle) {
    $pInput,$pOutput = $line.split(" | ")
    $pInput = $pInput.split(" ")
    $known = @{}
    $known.add([string](($pInput | ? {$_.Length -eq 3}).ToCharArray() | `
            ? { ($pInput | ? {$_.length -eq 2}).ToCharArray() -notcontains $_ }), "a")
    $x = ($pInput | ? {$_.length -eq 4}).ToCharArray() + `
                ($pInput | ? {$_.length -eq 3}).ToCharArray() | Sort-Object | Get-Unique
    $known.Add([string]((($pInput | ? {$_.length -eq 6}) | `
                ? { (($_.ToCharArray() | ? {$x -notcontains $_}) | Measure-Object ).Count -eq 1}).ToCharArray() | `
                        ? {$x -notcontains $_ }),"g")
    $known.Add([string](($pInput | ? {$_.length -eq 6}).ToCharArray() | `
            ? {(($pInput | ? {$_.length -eq 4}).ToCharArray() + $known.keys) -notcontains $_ } | `
                    Sort-Object | Get-Unique),"e")
    $x = ($pInput | ? {$_.length -eq 5}).ToCharArray() | `
            ? {(($pInput | ? {$_.length -eq 3}).ToCharArray() + $known.keys) -notcontains $_ } | Group-Object
    $known.Add([string](($x | ? {$_.count -eq 1}).name),"b")
    $known.Add(([string]($x | ? {$_.count -eq 3}).name),"d")
    $x = ($pInput | ? {$_.length -eq 6}).ToCharArray() | ? {$known.keys -notcontains $_ } | Group-Object
    $known.Add([string](($x | ? {$_.count -eq 2}).name),"c")
    $known.Add([string](($pInput | ? {$_.length -eq 7}).ToCharArray() | ? {$known.keys -notcontains $_ }),"f")
$outputTotal += [int](($pOutput.Split(" ") | % { ($_.ToCharArray() `
        | % { $Known."$($_)" } | Sort-Object) -join "" } | % { Switch ($_) {
	        "abcefg" { 0 }
	        "cf" { 1 }
	        "acdeg" { 2 }
	        "acdfg" { 3 }
	        "bcdf" { 4 }
	        "abdfg" { 5 }
	        "abdefg" { 6 }
	        "acf" { 7 }
	        "abcdefg" { 8 }
	        "abcdfg" { 9 }
        } } ) -join "" )
}

$outputTotal