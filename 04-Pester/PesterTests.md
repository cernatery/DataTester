# Adventure Works Cycles - Production

## Pester testy

Po zkontrolování procedur tSQLt testy a kontrole dat pomocí JC.Unitu celý testovací proces automatizujeme. K tomu v našem případě slouží Pester framework. 

Pester se nejčastěji používá pro psaní unit a integračních testů, ale může se využít pro celou řadu dalších ověřování.

Více o Pesteru se můžete dozvědět [zde](https://pester.dev/docs/quick-start).

Struktura Pester testu k nahlédnutí [zde](https://github.com/cernatery/DataTester/blob/main/04-Pester/Template_Get-Planet.Tests.ps1).

V případě Adventure Works testujeme existenci databáze a tabulek, spouštíme tSQLt testy a JC.Unit testy, a vytváříme scenario test stejně jako v tSQLt.

Níže jsou uvedeny informace o vytvořených testech.

| Testovací požadavek | Název testu | Popis |
|---|---|---|
| Kontrola existence AdventureWorks2019 databáze| 01-DatabaseExists.Tests.ps1 | Pomocí Get-SqlDatabase a connection stringu lze zjistit, zda vybraná databáze existuje. ‘Should -Be‘ ověří, že tomu tak je. |
| Kontrola existence tabulek 'WorkOrder', 'WorkOrderRouting' v databázi AdventureWorks2019 | 02-ObjectExist.Tests.ps1|Invoke-Sqlcmd spustí SQL query v databázi, která vypíše seznam existujících tabulek. ‘Should -Contain’ otestuje, že tyto tabulky databáze skutečně obsahuje. |
| Spuštění tSQLt Test_WorkOrderRouting_Fake TestClass a kontrola výsledků | 03-RuntSQLt.Tests.ps1 | Invoke-Sqlcmd spustí tSQLt testy. ‘Should -Be‘ kontroluje, jestli má nějaký test v tabulce TestResults status ‘failure’. |
| Spuštění Scenario testu - exekuce procedury [Production].[CreateWorkOrder] a kontrola výsledků | 04-ScenarioCreateWorkOrder.Tests.ps1 | V bloku ‘BeforeAll’ je spuštěna uložená procedura Production.CreateWorkOrder v databázi. ‘Should -Be’ testuje, že se tímto vytvořil právě 1 nový řádek v tabulce, a že obsahuje dané hodnoty. V bloku ‘AfterAll’ je pak vložený řádek smazán. |
| Spuštění Scenario testu - exekuce procedury [Production].[MoveWorkOrder] a kontrola výsledků | 05-ScenarioMoveWorkOrder.Tests.ps1 | V bloku ‘BeforeAll’ je spuštěna uložená procedura Production.CreateWorkOrder a Production.MoveWorkOrder v databázi. ‘Should -Be’ testuje, že se tímto vytvořil nový řádek v tabulce, a že obsahuje dané hodnoty. V bloku ‘AfterAll’ jsou vložené řádky smazány. |
| Spuštění Scenario testu - exekuce procedury [Production].[FinishWorkOrder] a kontrola výsledků | 06-ScenarioFinishWorkOrder.Tests.ps1 | V bloku ‘BeforeAll’ je spuštěna uložená procedura Production.CreateWorkOrder a Production.FinishWorkOrder v databázi. ‘Should -Be’ testuje, že se tímto vytvořil nový řádek v tabulce, a že obsahuje dané hodnoty. V bloku ‘AfterAll’ jsou vložené řádky smazány. |
| Spuštění JC.Unitu a kontrola výsledků testů Power BI reportu | 07-RunPBITests.Tests.ps1 | V bloku ‘BeforeAll’ je spuštěn PowerBI report a JC.Unit testy. ‘Should -Be’ otestuje, že se spustilo právě 12 JC.Unit testů, a také zkontroluje jejich výsledky. V bloku ‘AfterAll’ je zavřen Power BI report, a výsledky JC.Unit testů jsou nahrány do databáze. |
<br>

> Úkol:

| Testovací požadavek | Název testu | Popis |
|---|---|---|
| Spuštění tSQLt Test_WorkOrderRouting_Ukol TestClass a kontrola výsledků | 08-RuntSQLt_Ukol.Tests.ps1 | Invoke-Sqlcmd spustí tSQLt testy. ‘Should -Be‘ kontroluje, jestli má nějaký test v tabulce TestResults status ‘failure’. |

