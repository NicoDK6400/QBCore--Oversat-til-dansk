# QB Core---Oversat-til-dansk
Dette er QB Core oversat, fra os til jer! &lt;3

Har ud nogen problemer med disse scripts, fejl, problemer med opsætning eller andet?  
> Så kom forbi https://fivem.dk/discord og få hjælp, eller du kan få engelsk rådgivning hos QB Core (https://discord.gg/qbcore)

## Indhold
- Bob74_IPL (alle maps, med mulighed for at ændre interior)
- Nyeste build (Cayo Perico)
- Breze Cardealer
- Dansk tema (danske flag, dansk valuta osv.)
- EUP (Tak til synix)
- LoadningScreen (let at ændre, et mini-game imens man venter)
- PolitiTablet (https://github.com/GhzGarage/mdt)
- QB Target (tilføjet til enkelte ting)
- PMA Voice (bygget på MumbleVOIP, bare opdateret)

## Installation
1. Download filerne, og placer dem hvor du vil have din server til at ligge.
2. Importer qbcore.sql filen til en database navngivet efter dit valg.
3. Rediger server.cfg filen, du skal indsætte din egen license key ved "sv_licenseKey" (Den får du fra https://keymaster.fivem.net/), og du skal indsætte din Steam API key (https://steamcommunity.com/login/home/?goto=%2Fdev%2Fapikey). Her kan du også ændre dit server navn & beskrivelse ved sv_projectName og sv_projectDesc.
4. Husk at tilføje dine webhooks! Du kan finde de fleste i qb-logs og et vigtigt webhook skal tilføjes i qb-phone/server/main.lua linje 11, ellers virker billeder ikke på mobilen!

## Opdatering
1. Download den seneste artifact fra https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/
2. Slet alle filer inden i "artifact" mappen
3. Åben zip filen du downloaded i step 1, og overfør alle filerne ind i "artifact" mappen
4. Din server er nu opdateret!
5. Start serveren ved at køre StartServer.bat
6. Efter serveren er startet op (kun første gang), skal den genstartes. VIGTIGT!!

## Credits
- https://github.com/qbcore-framework (Framework)
- NicoDK6400 (Oversættelse, tilføjesler af maps samt scripts)
- Walter (Fixes til fejl)
- Znowy (Fixes til fejl)
- Mohr (Fixes til fejl)
- Momsey (Flag, bænke)
- Synix (Tilføjet sit eget EUP)
- M1raculous (Ændringer til loadingscreen)