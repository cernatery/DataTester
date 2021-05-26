# V části 'BeforeAll' definujeme kroky, které se mají provést před samotným testem jako příprava na testování.
BeforeAll { 
    # Definujeme funkci Get-Planet, která obsahuje názvy všech planet naší sluneční soustavy.
    function Get-Planet ([string]$Name = '*') {
        $planets = @(
            @{ Name = 'Merkur' }
            @{ Name = 'Venuse'   }
            @{ Name = 'Zeme'   }
            @{ Name = 'Mars'    }
            @{ Name = 'Jupiter' }
            @{ Name = 'Saturn'  }
            @{ Name = 'Uran'  }
            @{ Name = 'Neptun' }
        ) | ForEach-Object { [PSCustomObject] $_ }

        $planets | Where-Object { $_.Name -like $Name }
    }
}

# Blok 'Describe' slouží jako Test Case, tvoří logickou sadu testů.
Describe 'Get-Planet' {
# Blok 'It' je samotný test.
    It 'Funkce obsahuje 8 planet' {
        $allPlanets = Get-Planet
        $allPlanets.Count | Should -Be 8
    }
    It 'Země je třetí planetou v seznamu' {
        $allPlanets = Get-Planet
        $allPlanets[2].Name | Should -Be 'Zeme'
    }
    It 'Seznam planet neobsahuje Pluto' {
        $allPlanets = Get-Planet
        $plutos = $allPlanets | Where-Object Name -EQ 'Pluto'
        $plutos.Count | Should -Be 0
    }
    It 'Funkce vrací planety v tomto pořadí: Merkur, Venuse, Zeme, Mars, Jupiter, Saturn, Uran, Neptun' {
        $allPlanets = Get-Planet
        $planetsInOrder = $allPlanets.Name -join ', ' 
        $planetsInOrder | Should -Be 'Merkur, Venuse, Zeme, Mars, Jupiter, Saturn, Uran, Neptun'
    } 

    # V bloku 'AfterAll' se mažou všechny dočasné změny vytvořené za účelem testování.
    AfterAll {

    }
}

