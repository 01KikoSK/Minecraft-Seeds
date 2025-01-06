@echo off
setlocal enabledelayedexpansion

:: Function to generate random seed
set /a seed=%random% * %random%

:: Function to get random biome
set biomes=Forest Desert Taiga Jungle Savanna Plains Swamp Mountains
for /f "tokens=*" %%i in ('echo %biomes%') do set /a num_biomes+=1
set /a random_biome_index=!random! %% !num_biomes!
for /f "tokens=* delims= " %%i in ('echo %biomes%') do (
    set "biome=%%i"
    for /l %%j in (0,1,!random_biome_index!) do shift
)

:: Function to get random structures
set structures=Village Dungeon Temple MineShaft Stronghold Mansion Monument
for /f "tokens=*" %%i in ('echo %structures%') do set /a num_structures+=1
set /a random_structures_count=!random! %% !num_structures!
setlocal disabledelayedexpansion
for /f "tokens=* delims= " %%i in ('echo %structures%') do (
    set "structure=%%i"
    for /l %%j in (1,1,!random_structures_count!) do (
        setlocal enabledelayedexpansion
        if not defined structures_selected (
            set "structures_selected=!structure!"
        ) else (
            set "structures_selected=!structures_selected!, !structure!"
        )
        endlocal
    )
)

:: Display generated seed info
echo Generated Seed Info:
echo Seed: %seed%
echo Biome: %biome%
echo Structures: %structures_selected%

pause
