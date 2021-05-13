# BeforeAll defines a series of steps to perform at the beginning of the current container, Context or Describe block.
BeforeAll { 
    function Get-Planet ([string]$Name = '*') {
        $planets = @(
            @{ Name = 'Mercury' }
            @{ Name = 'Venus'   }
            @{ Name = 'Earth'   }
            @{ Name = 'Mars'    }
            @{ Name = 'Jupiter' }
            @{ Name = 'Saturn'  }
            @{ Name = 'Uranus'  }
            @{ Name = 'Neptune' }
        ) | ForEach-Object { [PSCustomObject] $_ }

        $planets | Where-Object { $_.Name -like $Name }
    }
}

# Describe creates a logical group of tests. A Describe block may contain any number of Context and It blocks.
Describe 'Get-Planet' {
# It validates the results of a test inside of a Describe block. The body of the It block is the appropriate location for an assert.
    It 'Given no parameters, it lists all 8 planets' {
        $allPlanets = Get-Planet
        $allPlanets.Count | Should -Be 8
    }
    It 'Earth is the third planet in our Solar System' {
        $allPlanets = Get-Planet
        $allPlanets[2].Name | Should -Be 'Earth'
    }
    It 'Pluto is not part of our Solar System' {
        $allPlanets = Get-Planet
        $plutos = $allPlanets | Where-Object Name -EQ 'Pluto'
        $plutos.Count | Should -Be 0
    }
    It 'Planets have this order: Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune' {
        $allPlanets = Get-Planet
        $planetsInOrder = $allPlanets.Name -join ', ' 
        $planetsInOrder | Should -Be 'Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune'
    } 

    # AfterAll: The typical usage is to clean up state or temporary used in tests.
    AfterAll {

    }
}

