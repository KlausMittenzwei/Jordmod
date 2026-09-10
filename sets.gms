************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Definisjon av sets
*   Kommentarer:
*   Status:
*
************************************************************************
*
* Definer basisaar
*
     SET T Aar /1985*2025/;
     Parameter TRUN(T) Running year ;
     TRUN(T) = 1985 - 1 + ORD(T);

     SET PTST Tellinger i PTS /1995A,1996A,1997A,1998A,1999A,2000A,2001A,2002A,2003A,2004A,2005A,2006A,2007A,2008A,
                               1995B,1996B,1997B,1998B,1999B,2000B,2001B,2002B,2003B,2004B,2005B,2006B,2007B,2008B,
                               2009A,2009B,2010A,2010B,2011A,2011B,2012A,2012B,2013A,2013B,2014A,2014B,2015A,2015B,
                               2016A,2016B,2017A,2017B,2018A,2018B,2019A,2019B,2020A,2020B,2021A,2021B,2022A,2022B,
                               2023A,2023B,2024A,2024B,2025A,2025B/;
ALIAS (TT,T);

* Telling 30/6 (or 1/7 same year)
     SET PTSTA(PTST) A-Tellinger i PTS /1995A,1996A,1997A,1998A,1999A,2000A,2001A,2002A,2003A,2004A,2005A,2006A,2007A,2008A,
                                        2009A,2010A,2011A,2012A,2013A,2014A,2015A,2016A,2017A,2018A,2019A,2020A,2021A,2022A,
                                        2023A,2024A,2025A/;

* Telling 31/12 (or 1/1 next year)
     SET PTSTB(PTST) B-Tellinger i PTS /1995B,1996B,1997B,1998B,1999B,2000B,2001B,2002B,2003B,2004B,2005B,2006B,2007B,2008B,
                                        2009B,2010B,2011B,2012B,2013B,2014B,2015B,2016B,2017B,2018B,2019B,2020B,2021B,2022B,
                                        2023B,2024B,2025B/;
*
* Definere basisaar for kalibrering av raadata
  SET BASAAR(T) Basisaar      /2023*2025/;
  SET TBASAAR(T) Basisaar for tilskudd /2024/;
*
alias (TTBASAAR, TBASAAR);
*
* Aar med PTdata
  SET PTAAR(T) /1999*2025/;
*
*** Definerer kommuner
*
     SET K Kommuner /

       0101 Halden
       0104 Moss
       0105 Sarpsborg
       0106 Fredrikstad
       0111 Hvaler
       0118 Aremark
       0119 Marker
       0121 Rømskog
       0122 Trøgstad
       0123 Spydeberg
       0124 Askim
       0125 Eidsberg
       0127 Skiptvet
       0128 Rakkestad
       0135 Råde
       0136 Rygge
       0137 Våler (Østfold)
       0138 Hobøl
       0211 Vestby
       0213 Ski
       0214 Ås
       0215 Frogn
       0216 Nesodden
       0217 Oppegård
       0219 Bærum
       0220 Asker
       0221 Aurskog-Høland
       0226 Sørum
       0227 Fet
       0228 Rælingen
       0229 Enebakk
       0230 Lørenskog
       0231 Skedsmo
       0233 Nittedal
       0234 Gjerdrum
       0235 Ullensaker
       0236 Nes (Akershus)
       0237 Eidsvoll
       0238 Nannestad
       0239 Hurdal
       0301 Oslo
       0402 Kongsvinger
       0403 Hamar
       0412 Ringsaker
       0415 Løten
       0417 Stange
       0418 Nord-Odal
       0419 Sør-Odal
       0420 Eidskog
       0423 Grue
       0425 Åsnes og Våler
       0426 Våler (Hedmark)
       0427 Elverum
       0428 Trysil
       0429 Åmot
       0430 Stor-Elvdal
       0432 Rendalen
       0434 Engerdal
       0436 Tolga
       0437 Tynset
       0438 Alvdal
       0439 Folldal
       0441 Os (Hedmark)
       0501 Lillehammer
       0502 Gjøvik
       0511 Dovre
       0512 Lesja
       0513 Skjåk
       0514 Lom
       0515 Vågå
       0516 Heidal Nord-Fron
       0517 Sel
       0519 Volda Sør-Fron
       0520 Ringebu
       0521 Øyer
       0522 Gausdal
       0528 Østre Toten
       0529 Vestre Toten
       0532 Jevnaker
       0533 Lunner
       0534 Gran
       0536 Land Søndre Land
       0538 Nordre Land
       0540 Sør-Aurdal
       0541 Etnedal
       0542 Nord-Aurdal
       0543 Vestre Slidre
       0544 Øystre Slidre
       0545 Vang
       0602 Drammen
       0604 Kongsberg
       0605 Ringerike
       0612 Hole
       0615 Flå
       0616 Nes
       0617 Gol
       0618 Hemsedal
       0619 Ål
       0620 Hol
       0621 Sigdal
       0622 Krødsherad
       0623 Modum
       0624 Øvre Eiker
       0625 Nedre Eiker
       0626 Lier
       0627 Røyken
       0628 Hurum
       0631 Flesberg
       0632 Rollag
       0633 Nore og Uvdal
       0701 Borre
       0702 Holmestrand
       0704 Åsgårdstrand
       0706 Sandefjord
       0709 Larvik
       0710 Sandefjord
       0711 Svelvik
       0712 Larvik
       0713 Sande (Vestfold)
       0714 Hof
       0715 Hof
       0716 Re
       0718 Ramnes
       0719 Andebu
       0720 Stokke
       0722 Nøtterøy
       0723 Tjøme
       0728 Lardal
       0729 Færder
       0805 Porsgrunn
       0806 Skien
       0807 Notodden
       0811 Siljan
       0814 Bamble
       0815 Kragerø
       0817 Drangedal
       0819 Nome
       0821 Bø
       0822 Sauherad
       0826 Tinn
       0827 Hjartdal
       0828 Seljord
       0829 Kviteseid
       0830 Nissedal
       0831 Fyresdal
       0833 Lardal
       0834 Vinje
       0901 Risør
       0904 Grimstad
       0906 Arendal
       0911 Gjerstad
       0912 Vegårshei
       0914 Tvedestrand
       0919 Froland
       0926 Lillesand
       0928 Birkenes
       0929 Åmli
       0935 Iveland
       0937 Evje
       0938 Bygland
       0940 Valle
       0941 Bykle
       1001 Kristiansand
       1002 Mandal
       1003 Farsund
       1004 Flekkefjord
       1014 Vennelsa
       1017 Songdalen
       1018 Søgne
       1021 Marnadal
       1026 Åseral
       1027 Audnedal
       1029 Lindesnes
       1032 Lyngdal
       1034 Hægebostad
       1037 Kvinesdal
       1046 Sirdal
       1101 Egersund
       1102 Sandnes
       1103 Stavanger
       1106 Haugesund
       1108 Sandnes
       1111 Sokndal
       1112 Lund
       1114 Bjerkreim
       1119 Hå
       1120 Klepp
       1121 Time
       1122 Gjesdal
       1124 Sola
       1127 Randaberg
       1129 Forsand
       1130 Strand
       1133 Hjelmeland
       1134 Suldal
       1135 Sauda
       1141 Finnøy
       1142 Rennesøy
       1144 Kvitsøy
       1145 Bokn
       1146 Tysvær
       1149 Karmøy
       1151 Utsira
       1154 Vindafjord
       1159 Ølen
       1160 Ølen
       1201 Bergen
       1211 Etne
       1214 Ølen
       1216 Sveio
       1219 Bømlo
       1221 Stord
       1222 Fitjar
       1223 Tysnes
       1224 Kvinnherad
       1227 Jondal
       1228 Odda
       1231 Ullensvang
       1232 Eidfjord
       1233 Ulvik
       1234 Granvin
       1235 Voss
       1238 Kvam
       1241 Fusa
       1242 Samnanger
       1243 Os (Hordaland)
       1244 Austevoll
       1245 Sund
       1246 Fjell
       1247 Askøy
       1251 Vaksdal
       1252 Modalen
       1253 Hosanger
       1256 Meland
       1259 Øygarden
       1260 Bømlo
       1263 Lindås
       1264 Austrheim
       1265 Fedje
       1266 Masfjorden
       1401 Flora
       1411 Gulen
       1412 Solund
       1413 Hyllestad
       1416 Høyanger
       1417 Vik
       1418 Balestrand
       1419 Leikanger
       1420 Sogndal
       1421 Aurland
       1422 Lærdal
       1424 Årdal
       1426 Luster
       1428 Askvoll
       1429 Fjaler
       1430 Gaular
       1431 Jølster
       1432 Førde
       1433 Naustdal
       1438 Bremanger
       1439 Vågsøy
       1441 Selje
       1443 Eid
       1444 Hornindal
       1445 Gloppen
       1449 Stryn
       1502 Molde
       1504 Ålesund
       1505 Kristiansund
       1506 Molde
       1507 Ålesund
       1508 Ålesund  
       1511 Vanylven
       1514 Sande
       1515 Herøy
       1516 Ulstein
       1517 Hareid
       1519 Volda
       1520 Ørsta
       1523 Ørskog
       1524 Norddal
       1525 Stranda
       1526 Stordal
       1528 Sykkylven
       1529 Skodje
       1531 Sula
       1532 Giske
       1534 Haram
       1535 Vestnes
       1539 Rauma
       1543 Nesset
       1545 Midsund
       1546 Sandøy
       1547 Aukra
       1548 Fræna
       1551 Eide
       1554 Averøy
       1556 Frei
       1557 Gjemnes
       1560 Tingvoll
       1563 Sunndal
       1566 Surnadal
       1567 Rindal
       1569 Aure
       1571 Halsa
       1572 Tustna
       1573 Smøla
       1576 Aure
       1577 Volda
       1578 Fjord
       1579 Eide
       1580 Haram 
       1601 Trondheim
       1612 Hemne
       1613 Snillfjord
       1617 Hitra
       1620 Frøya
       1621 Ørland
       1622 Agdenes
       1624 Rissa
       1627 Bjugn
       1630 Åfjord
       1632 Roan
       1633 Osen
       1634 Oppdal
       1635 Rennebu
       1636 Meldal
       1638 Orkdal
       1640 Midtre Gauldal
       1644 Ålen
       1648 Støren
       1653 Melhus
       1657 Skaun
       1662 Klæbu
       1663 Malvik
       1664 Selbu
       1665 Tydal
       1702 Steinkjer
       1703 Namsos
       1711 Meråker
       1714 Stjørdal
       1717 Frosta
       1718 Leksvik
       1719 Skogn
       1721 Verdal
       1723 Mosvik
       1724 Verran
       1725 Namdalseid
       1729 Inderøy
       1736 Snåsa
       1738 Lierne
       1739 Røyrvik
       1740 Namsskogan
       1742 Grong
       1743 Høylandet
       1744 Overhalla
       1748 Fosnes
       1749 Flatanger
       1750 Vikna
       1751 Nærøy
       1755 Leka
       1756 Inderøy
       1804 Bodø
       1805 Narvik
       1806 Ballangen
       1811 Bindal
       1812 Sømna
       1813 Velfjord
       1815 Vega
       1816 Vevelstad
       1818 Herøy
       1820 Alstahaug
       1822 Leirfjord
       1824 Vefsn
       1825 Grane
       1826 Hattfjelldal
       1827 Dønna
       1828 Nesna
       1832 Hemnes
       1833 Mo i Rana
       1834 Lurøy
       1835 Træna
       1836 Rådøy
       1837 Meløy
       1838 Gildeskål
       1839 Beiarn
       1840 Saltdal
       1841 Fauske
       1842 Skjerstad
       1845 Sørfold
       1848 Steigen
       1849 Hamarøy
       1850 Tysfjord
       1851 Lødingen
       1852 Tjeldsund
       1853 Evenes
       1854 Ballangen
       1856 Røst
       1857 Værøy
       1859 Flakstad
       1860 Vestvågøy
       1865 Vågan
       1866 Hadsel
       1867 Bø (Nordland)
       1868 Øksnes
       1870 Sortland
       1871 Andøy
       1874 Moskenes
       1875 Hamarøy
       1901 Harstad
       1902 Tromsø
       1903 Harstad
       1911 Kvæfjord
       1913 Skånland
       1915 Sand
       1917 Ibestad
       1919 Gratangen
       1920 Lavangen
       1922 Bardu
       1923 Salangen
       1924 Målselv
       1925 Sørreisa
       1926 Dyrøy
       1927 Tranøy
       1928 Torsken
       1929 Berg
       1931 Lenvik
       1933 Balsfjord
       1936 Karlsøy
       1938 Lyngen
       1939 Storfjord
       1940 Kåfjord
       1941 Skjervøy
       1942 Nordreisa
       1943 Kvænangen
       2002 Vardø
       2003 Vadsø
       2004 Hammerfest
       2011 Kautokeino
       2012 Alta
       2014 Loppa
       2015 Hasvik
       2017 Nesseby
       2018 Båtsfjord
       2019 Nordkapp
       2020 Porsanger
       2021 Karasjok
       2022 Lebesby
       2023 Gamvik
       2024 Berlevåg
       2025 Tana
       2027 Nesseby
       2028 Båtsfjord
       2030 Sør-Varanger
       3001 Halden
       3002 Moss
       3003 Sarpsborg
       3004 Fredrikstad
       3005 Drammen
       3006 Kongsberg
       3007 Ringerike
       3011 Hvaler
       3012 Aremark
       3013 Marker
       3014 Indre Østfold
       3015 Skiptvet
       3016 Rakkestad
       3017 Råde
       3018 Våler (Østfold)
       3019 Vestby
       3020 Ski
       3021 Ås
       3022 Frogn
       3023 Nesodden
       3024 Bærum
       3025 Asker
       3026 Aurskog-Høland
       3027 Rælingen
       3028 Enebakk
       3029 Lærenskog
       3030 Lillestrøm
       3031 Nittedal
       3032 Gjerdrum
       3033 Ullensaker
       3034 Nes (Akershus)
       3035 Eidsvoll
       3036 Nannestad
       3037 Hurdal
       3038 Hole
       3039 Flå
       3040 Nesbyen
       3041 Gol
       3042 Hemsedal
       3043 Ål
       3044 Hol
       3045 Sigdal
       3046 Krødsherad
       3047 Modum
       3048 Øvre Eiker
       3049 Lier
       3050 Flesberg
       3051 Rollag
       3052 Nore og Uvdal
       3053 Jevnaker
       3054 Lunner
       3101 Halden
       3103 Moss
       3105 Sarpsborg
       3107 Fredrikstad
       3110 Hvaler
       3112 Råde
       3114 Våler
       3116 Skiptvet
       3118 Indre Østfold
       3120 Rakkestad
       3122 Marker
       3124 Aremark
       3201 Bærum
       3203 Asker
       3205 Lillestrøm
       3207 Nordre Follo
       3209 Ullensaker
       3212 Nesodden
       3214 Frogn
       3216 Vestby
       3218 Ås
       3220 Enebakk
       3222 Lørenskog
       3224 Rælingen
       3226 Aurskog-Høland
       3228 Nes
       3230 Gjerdrum
       3232 Nittedal
       3234 Lunner
       3236 Jevnaker
       3238 Nannestad
       3240 Eidsvoll
       3242 Hurdal
       3301 Drammen
       3303 Kongsberg
       3305 Ringerike
       3310 Hole
       3312 Lier
       3314 Øvre Eiker
       3316 Modum
       3318 Krødsherad
       3320 Flå
       3322 Nesbyen
       3324 Gol
       3326 Hemsedal
       3328 Ål
       3330 Hol
       3332 Sigdal
       3334 Flesberg
       3336 Rollag
       3338 Nore og Uvdal
       3401 Kongsvinger
       3403 Hamar
       3405 Lillehammer
       3407 Gjøvik
       3411 Ringsaker
       3412 Løten
       3413 Stange
       3414 Nord-Odal
       3415 Sør-Odal
       3416 Eidskog
       3417 Grue
       3418 Åsnes
       3419 Våler (Hedmark)
       3420 Elverum
       3421 Trysil
       3422 Åmot
       3423 Stor-Elvdal
       3424 Rendalen
       3425 Engerdal
       3426 Tolga
       3427 Tynset
       3428 Alvdal
       3429 Folldal
       3430 Os (Hedmark)
       3431 Dovre
       3432 Lesja
       3433 Skjåk
       3434 Lom
       3435 Vågå
       3436 Nord-Fron
       3437 Sel
       3438 Sør-Fron
       3439 Ringebu
       3440 Øyer
       3441 Gausdal
       3442 Østre Toten
       3443 Vestre Toten
       3446 Gran
       3447 Søndre Land
       3448 Nordre Land
       3449 Sør-Aurdal
       3450 Etnedal
       3451 Nord-Aurdal
       3452 Vestre Slidre
       3453 Øystre Slidre
       3454 Vang
       3801 Horten
       3802 Hof
       3803 Tønsberg
       3804 Sandefjord
       3805 Larvik
       3806 Porsgrunn
       3807 Skien
       3808 Notodden
       3811 Tjøme
       3812 Siljan
       3813 Bamble
       3814 Kragerø
       3815 Drangedal
       3816 Nome
       3817 Midt-Telemark
       3818 Tinn
       3819 Hjartdal
       3820 Seljord
       3821 Kviteseid
       3822 Nissedal
       3823 Fyresdal
       3824 Tokke
       3825 Vinje
       3901 Horten
       3903 Holmestrand
       3905 Tønsberg
       3907 Sandefjord
       3909 Larvik
       3911 Færder
       4001 Porsgrunn
       4003 Skien
       4005 Notodden
       4010 Siljan
       4012 Bamble
       4014 Kragerø
       4016 Drangedal
       4018 Nome
       4020 Midt-Telemark
       4022 Seljord
       4024 Hjartdal
       4026 Tinn
       4028 Kviteseid
       4030 Nissedal
       4032 Fyresdal
       4034 Tokke
       4036 Vinje
       4201 Risør
       4202 Grimstad
       4203 Arendal
       4204 Kristiansand
       4205 Lindesnes
       4206 Farsund
       4207 Flekkefjord
       4211 Gjerstad
       4212 Vegårshei
       4213 Tvedestrand
       4214 Froland
       4215 Lillesand
       4216 Birkenes
       4217 Åmli
       4218 Iveland
       4219 Evje og Hornnes
       4220 Bygland
       4221 Valle
       4222 Bykle
       4223 Vennesla
       4224 Åseral
       4225 Lyngdal
       4226 Hægebostad
       4227 Kvinesdal
       4228 Sirdal
       4601 Bergen
       4602 Kinn
       4611 Etne
       4612 Sveio
       4613 Bømlo
       4614 Stord
       4615 Fitjar
       4616 Tysnes
       4617 Kvinnherad
       4618 Odda
       4619 Eidfjord
       4620 Ulvik
       4621 Voss
       4622 Kvam
       4623 Samnanger
       4624 Fusa
       4625 Austevoll
       4626 Fjell
       4627 Askøy
       4628 Vaksdal
       4629 Modalen
       4630 Osterøy
       4631 Lindås
       4632 Austrheim
       4633 Fedje
       4634 Masfjorden
       4635 Gulen
       4636 Solund
       4637 Hyllestad
       4638 Høyanger
       4639 Vik
       4640 Sogndal
       4641 Aurland
       4642 Lærdal
       4643 Årdal
       4644 Luster
       4645 Askvoll
       4646 Fjaler
       4647 Førde
       4648 Bremanger
       4649 Eid
       4650 Gloppen
       4651 Stryn
       5001 Trondheim
       5004 Steinkjer
       5005 Namsos
       5006 Verran
       5007 Namsos
       5011 Hemne
       5012 Snillfjord
       5013 Hitra
       5014 Frøya
       5015 Ørland
       5016 Agdenes
       5017 Bjugn
       5018 Åfjord
       5019 Roan
       5020 Osen
       5021 Oppdal
       5022 Rennebu
       5023 Meldal
       5024 Orkdal
       5025 Røros
       5026 Holtålen
       5027 Midtre Gauldal
       5028 Melhus
       5029 Skaun
       5030 Klæbu
       5031 Malvik
       5032 Selbu
       5033 Tydal
       5034 Meråker
       5035 Stjørdal
       5036 Frosta
       5037 Levanger
       5038 Verdal
       5039 Verran
       5040 Namdalseid
       5041 Snåsa
       5042 Lierne
       5043 Røyrvik
       5044 Namsskogan
       5045 Grong
       5046 Høylandet
       5047 Overhalla
       5048 Fosnes
       5049 Flatanger
       5050 Vikna
       5051 Nærøy
       5052 Leka
       5053 Inderøy
       5054 Indre Fosen
       5055 Heim
       5056 Hitra
       5057 Ørland
       5058 Åfjord
       5059 Orkland
       5060 Nærøy
       5061 Rindal
       5401 Tromsø
       5402 Harstad
       5403 Alta
       5404 Vardø
       5405 Vadsø
       5406 Hammerfest
       5411 Kvæfjord
       5412 Tjeldsund
       5413 Ibestad
       5414 Gratangen
       5415 Lavangen
       5416 Bardu
       5417 Salangen
       5418 Målselv
       5419 Sørreisa
       5420 Dyrøy
       5421 Lenvik
       5422 Balsfjord
       5423 Karlsøy
       5424 Lyngen
       5425 Storfjord
       5426 Kåfjord
       5427 Skjervøy
       5428 Nordreisa
       5429 Kvænangen
       5430 Kautokeino
       5434 Måsøy
       5436 Porsanger
       5437 Karasjok
       5438 Lebesby
       5439 Gamvik
       5440 Berlevåg
       5441 Tana
       5442 Nesseby
       5444 Sør-Varanger
       5501 Tromsø
       5503 Harstad
       5510 Kvæfjord
       5512 Tjeldsund
       5514 Ibestad
       5516 Gratangen
       5518 Loabák - Lavangen
       5520 Bardu
       5522 Salangen
       5524 Målselv
       5526 Sørreisa
       5528 Dyrøy
       5530 Senja
       5532 Balsfjord
       5534 Karlsøy
       5536 Lyngen
       5538 Storfjord - Omasvuotna - Omasvuono
       5540 Gáivuotna - Kåfjord - Kaivuono
       5542 Skjervøy
       5544 Nordreisa
       5546 Kvænangen
       5601 Alta
       5603 Hammerfest
       5605 Sør-Varanger
       5607 Vadsø
       5610 Kárásjohka - Karasjok
       5612 Guovdageaidnu - Kautokeino
       5616 Hasvik
       5618 Måsøy
       5622 Porsanger - Porsángu - Porsanki 
       5624 Lebesby
       5626 Gamvik
       5628 Deatnu-Tana
       5630 Berlevåg
       5634 Vardø
       5636 Unjárga-Nesseby

/;
ALIAS (KK, K);
*
*** Definerer regioner
*
*   Regioner i Jordmod
*
     SET RAll All regions /
       NORGE        'NORGE'
       NO000000     'NORWAY'
       011101       'Fredrikstad'
       021101       'Oslo'
       021103       'Skedsmo'
       041101       'Ringsaker'
       041203       'Elverum'
       04125A       'Trysil'
       051103       'Gjoevik'
       05125A       'NordreLand'
       061101       'Drammen'
       06125A       'Aal'
       071101       'Larvik'
       081103       'Skien'
       081203       'Bamble'
       08125A       'Notodden'
       09225A       'Arendal'
       10225A       'Kristiansand'
       112102       'Stavanger'
       112203       'Strand'
       11215B       'Rennesoey'
       11225B       'Karmoey'
       12325B       'Bergen'
       14325B       'Flora'
       15325B       'Aelesund'
       164104       'Trondheim'
       164204       'Skaun'
       16425A       'Oppdal'
       174104       'Steinkjer'
       17425A       'Namsos'
       185206       'Bodoe'
       195206       'Tromsoe'
       195207       'Nordreisa'
       205207       'Alta'
/;
ALIAS (RRAll,RAll);
*
*   Regioner i Jordmod
*
     SET R(RAll) Production regions /
       011101       'Fredrikstad'
       021101       'Oslo'
       021103       'Skedsmo'
       041101       'Ringsaker'
       041203       'Elverum'
       04125A       'Trysil'
       051103       'Gjoevik'
       05125A       'NordreLand'
       061101       'Drammen'
       06125A       'Aal'
       071101       'Larvik'
       081103       'Skien'
       081203       'Bamble'
       08125A       'Notodden'
       09225A       'Arendal'
       10225A       'Kristiansand'
       112102       'Stavanger'
       112203       'Strand'
       11215B       'Rennesoey'
       11225B       'Karmoey'
       12325B       'Bergen'
       14325B       'Flora'
       15325B       'Aelesund'
       164104       'Trondheim'
       164204       'Skaun'
       16425A       'Oppdal'
       174104       'Steinkjer'
       17425A       'Namsos'
       185206       'Bodoe'
       195206       'Tromsoe'
       195207       'Nordreisa'
       205207       'Alta'
/;
alias (RR,R);

* Regioner for EUs nitratdirektiv:
SET NITRATDIR(R) /011101, 021101, 021103, 041101/;
* Regioner for Nordsj�avtale
SET NORDSJOE(R) /061101, 071101, 081203, 09225A, 10225A, 112102, 11225B/;

*
*   Fylker
*
    SET F Fylker /
       010000       'Oestfold'
       020300       'OsloAkershus'
       040000       'Hedmark'
       050000       'Oppland'
       060000       'Buskerud'
       070000       'Vestfold'
       080000       'Telemark'
       090000       'OestAgder'
       100000       'VestAgder'
       110000       'Rogaland'
       120000       'Hordlanad'
       140000       'SognFjordane'
       150000       'MoereRomsdal'
       160000       'SoerTroendelag'
       170000       'NordTroendelag'
       180000       'Nordland'
       190000       'Troms'
       200000       'Finnmark'
/;
*
*   AK-soner
*
   SET S Soner for Areal og kulturlandskapstilskudd /
       000001       'AKsone 1'
       000002       'AKsone 2'
       000003       'AKsone 3'
       000004       'AKsone 4'
       00005A       'AKsone 5A'
       00005B       'AKsone 5B'
       000006       'AKsone 6'
       000007       'AKsone 7'
/;
*
*   Jordbruksregioner i driftsgranskingene
*
     SET DG DGreginoer /
       001100       'Oestlandets flatbygder'
       001200       'Oestlandets andre bygder'
       002100       'Jaeren'
       002200       'Rogaland andre bygder'
       003200       'Vestlandet'
       004100       'Troendelags flatbygder'
       004200       'Troendelags andre bygder'
       005200       'Nordland'
/;
*
*   Markedsregioner
*
     SET M Markedsregioner /
       NORD       'Nord-Norge Tromsoe'
       MIDT       'Midt-Norge Trondheim'
       VEST       'Vestlandet Bergen'
       SOER       'Soer-Norge Stavanger'
       OEST       'Oestlandet Oslo'
/;
ALIAS(M,MM);
*
*   Sentrale stroek og distrikter
*
     SET SD DGregioner /
       000100       'Sentrale stroek'
       000200       'Distrikter'
/;
*
*
*   Hele landet
*
     SET NORGE Norge /NORGE/;
*
*** Definer regionale koblinger
*
*** Kobling mellom kommuner og Jordmodregioner
*
     Set K_TIL_R(K,R) Tilordning kommuner til regioner /
      0101.011101
      0104.011101
      0105.011101
      0106.011101
      0111.011101
      0118.011101
      0119.011101
      0121.011101
      0122.011101
      0123.011101
      0124.011101
      0125.011101
      0127.011101
      0128.011101
      0135.011101
      0136.011101
      0137.011101
      0138.011101
      0211.021101
      0213.021101
      0214.021101
      0215.021101
      0216.021101
      0217.021101
      0219.021101
      0220.021101
      0221.021103
      0226.021103
      0227.021103
      0228.021103
      0229.021103
      0230.021103
      0231.021103
      0233.021103
      0234.021103
      0235.021103
      0236.021103
      0237.021103
      0238.021103
      0239.021103
      0301.021101
      0402.041203
      0403.041101
      0412.041101
      0415.041101
      0417.041101
      0418.041203
      0419.041203
      0420.041203
      0423.041203
      0425.041203
      0426.041203
      0427.041203
      0428.04125A
      0429.04125A
      0430.04125A
      0432.04125A
      0434.04125A
      0436.04125A
      0437.04125A
      0438.04125A
      0439.04125A
      0441.04125A
      0501.051103
      0502.051103
      0511.05125A
      0512.05125A
      0513.05125A
      0514.05125A
      0515.05125A
      0516.05125A
      0517.05125A
      0519.05125A
      0520.05125A
      0521.05125A
      0522.05125A
      0528.051103
      0529.051103
      0532.051103
      0533.051103
      0534.051103
      0536.05125A
      0538.05125A
      0540.05125A
      0541.05125A
      0542.05125A
      0543.05125A
      0544.05125A
      0545.05125A
      0602.061101
      0604.061101
      0605.061101
      0612.061101
      0615.06125A
      0616.06125A
      0617.06125A
      0618.06125A
      0619.06125A
      0620.06125A
      0621.06125A
      0622.06125A
      0623.061101
      0624.061101
      0625.061101
      0626.061101
      0627.061101
      0628.061101
      0631.06125A
      0632.06125A
      0633.06125A
      0701.071101
      0702.071101
      0704.071101
      0706.071101
      0709.071101
      0710.071101
      0711.071101
      0712.071101
      0713.071101
      0714.071101
      0715.071101
      0716.071101
      0718.071101
      0719.071101
      0720.071101
      0722.071101
      0723.071101
      0728.071101
      0729.071101
      0805.081103
      0806.081103
      0807.08125A
      0811.081203
      0814.081203
      0815.08125A
      0817.08125A
      0819.081203
      0821.081203
      0822.081103
      0826.08125A
      0827.08125A
      0828.08125A
      0829.08125A
      0830.08125A
      0831.08125A
      0833.08125A
      0834.08125A
      0901.09225A
      0904.09225A
      0906.09225A
      0911.09225A
      0912.09225A
      0914.09225A
      0919.09225A
      0926.09225A
      0928.09225A
      0929.09225A
      0935.09225A
      0937.09225A
      0938.09225A
      0940.09225A
      0941.09225A
      1001.10225A
      1002.10225A
      1003.10225A
      1004.10225A
      1014.10225A
      1017.10225A
      1018.10225A
      1021.10225A
      1026.10225A
      1027.10225A
      1029.10225A
      1032.10225A
      1034.10225A
      1037.10225A
      1046.10225A
      1101.11225B
      1102.112102
      1103.112102
      1106.11225B
      1108.112102
      1111.11225B
      1112.11225B
      1114.112203
      1119.112102
      1120.112102
      1121.112102
      1122.112203
      1124.112102
      1127.112102
      1129.11225B
      1130.112203
      1133.11225B
      1134.11225B
      1135.11225B
      1141.11215B
      1142.11215B
      1144.11215B
      1145.11225B
      1146.11225B
      1149.11225B
      1151.11225B
      1154.11225B
      1159.11225B
      1160.11225B
      1201.11225B
      1211.12325B
      1214.11225B
      1216.12325B
      1219.12325B
      1221.12325B
      1222.12325B
      1223.12325B
      1224.12325B
      1227.12325B
      1228.12325B
      1231.12325B
      1232.12325B
      1233.12325B
      1234.12325B
      1235.12325B
      1238.12325B
      1241.12325B
      1242.12325B
      1243.12325B
      1244.12325B
      1245.12325B
      1246.12325B
      1247.12325B
      1251.12325B
      1252.12325B
      1253.12325B
      1256.12325B
      1259.12325B
      1260.12325B
      1263.12325B
      1264.12325B
      1265.12325B
      1266.12325B
      1401.14325B
      1411.14325B
      1412.14325B
      1413.14325B
      1416.14325B
      1417.14325B
      1418.14325B
      1419.14325B
      1420.14325B
      1421.14325B
      1422.14325B
      1424.14325B
      1426.14325B
      1428.14325B
      1429.14325B
      1430.14325B
      1431.14325B
      1432.14325B
      1433.14325B
      1438.14325B
      1439.14325B
      1441.14325B
      1443.14325B
      1444.14325B
      1445.14325B
      1449.14325B
      1502.15325B
      1504.15325B
      1505.15325B
      1506.15325B
      1507.15325B
      1508.15325B
      1511.15325B
      1514.15325B
      1515.15325B
      1516.15325B
      1517.15325B
      1519.15325B
      1520.15325B
      1523.15325B
      1524.15325B
      1525.15325B
      1526.15325B
      1528.15325B
      1529.15325B
      1531.15325B
      1532.15325B
      1534.15325B
      1535.15325B
      1539.15325B
      1543.15325B
      1545.15325B
      1546.15325B
      1547.15325B
      1548.15325B
      1551.15325B
      1554.15325B
      1556.15325B
      1557.15325B
      1560.15325B
      1563.15325B
      1566.15325B
      1567.15325B
      1569.15325B
      1571.15325B
      1572.15325B
      1573.15325B
      1576.15325B
      1577.15325B
      1578.15325B
      1579.15325B
      1580.15325B
      1601.164104
      1612.16425A
      1613.16425A
      1617.16425A
      1620.16425A
      1621.164104
      1622.16425A
      1624.164104
      1627.164204
      1630.16425A
      1632.16425A
      1633.16425A
      1634.16425A
      1635.16425A
      1636.164204
      1638.164104
      1640.16425A
      1644.16425A
      1648.16425A
      1653.164104
      1657.164204
      1662.164204
      1663.164104
      1664.16425A
      1665.16425A
      1702.174104
      1703.17425A
      1711.17425A
      1714.174104
      1717.174104
      1718.17425A
      1719.174104
      1721.174104
      1723.17425A
      1724.17425A
      1725.17425A
      1729.174104
      1736.174104
      1738.17425A
      1739.17425A
      1740.17425A
      1742.17425A
      1743.17425A
      1744.17425A
      1748.17425A
      1749.17425A
      1750.17425A
      1751.17425A
      1755.17425A
      1756.17425A
      1804.185206
      1805.185206
      1806.185206
      1811.185206
      1812.185206
      1813.185206
      1815.185206
      1816.185206
      1818.185206
      1820.185206
      1822.185206
      1824.185206
      1825.185206
      1826.185206
      1827.185206
      1828.185206
      1832.185206
      1833.185206
      1834.185206
      1835.185206
      1836.185206
      1837.185206
      1838.185206
      1839.185206
      1840.185206
      1841.185206
      1842.185206
      1845.185206
      1848.185206
      1849.185206
      1850.185206
      1851.185206
      1852.185206
      1853.185206
      1854.185206
      1856.185206
      1857.185206
      1859.185206
      1860.185206
      1865.185206
      1866.185206
      1867.185206
      1868.185206
      1870.185206
      1871.185206
      1874.185206
      1875.185206
      1901.195206
      1902.195206
      1903.195206
      1911.195206
      1913.195206
      1915.195206
      1917.195206
      1919.195206
      1920.195206
      1922.195206
      1923.195206
      1924.195206
      1925.195206
      1926.195206
      1927.195206
      1928.195206
      1929.195206
      1931.195206
      1933.195206
      1936.195206
      1938.195206
      1939.195206
      1940.195207
      1941.195207
      1942.195207
      1943.195207
      2002.205207
      2003.205207
      2004.205207
      2011.205207
      2012.205207
      2014.205207
      2015.205207
      2017.205207
      2018.205207
      2019.205207
      2020.205207
      2021.205207
      2022.205207
      2023.205207
      2024.205207
      2025.205207
      2027.205207
      2028.205207
      2030.205207
      3001.011101
      3002.011101
      3003.011101
      3004.011101
      3005.061101
      3006.061101
      3007.061101
      3011.011101
      3012.011101
      3013.011101
      3014.011101
      3015.011101
      3016.011101
      3017.011101
      3018.011101
      3019.021101
      3020.021101
      3021.021101
      3022.021101
      3023.021101
      3024.021101
      3025.021101
      3026.021101
      3027.021103
      3028.021103
      3029.021103
      3030.021103
      3031.021103
      3032.021103
      3033.021103
      3034.021103
      3035.021103
      3036.021103
      3037.021103
      3038.061101
      3039.06125A
      3040.06125A
      3041.06125A
      3042.06125A
      3043.06125A
      3044.06125A
      3045.06125A
      3046.06125A
      3047.061101
      3048.061101
      3049.061101
      3050.06125A
      3051.06125A
      3052.06125A
      3053.051103
      3054.051103
      3101.011101
      3103.011101
      3105.011101
      3107.011101
      3110.011101
      3112.011101
      3114.041203
      3116.011101
      3118.011101
      3120.011101
      3122.011101
      3124.011101
      3201.021101
      3203.021101
      3205.021103
      3207.021103
      3209.021103
      3212.021101
      3214.021101
      3216.021101
      3218.021101
      3220.021103
      3222.021103
      3224.021103
      3226.021101
      3228.021103
      3230.021103
      3232.021103
      3234.051103
      3236.051103
      3238.021103
      3240.021103
      3242.021103
      3301.061101
      3303.061101
      3305.061101
      3310.061101
      3312.061101
      3314.061101
      3316.061101
      3318.06125A
      3320.06125A
      3322.06125A
      3324.06125A
      3326.06125A
      3328.06125A
      3330.06125A
      3332.06125A
      3334.06125A
      3336.06125A
      3338.06125A
      3401.041203
      3403.041101
      3405.051103
      3407.051103
      3411.041101
      3412.041101
      3413.041101
      3414.041203
      3415.041203
      3416.041203
      3417.041203
      3418.041203
      3419.041203
      3420.041203
      3421.04125A
      3422.04125A
      3423.04125A
      3424.04125A
      3425.04125A
      3426.04125A
      3427.04125A
      3428.04125A
      3429.04125A
      3430.04125A
      3431.05125A
      3432.05125A
      3433.05125A
      3434.05125A
      3435.05125A
      3436.05125A
      3437.05125A
      3438.05125A
      3439.05125A
      3440.05125A
      3441.05125A
      3442.051103
      3443.051103
      3446.051103
      3447.05125A
      3448.05125A
      3449.05125A
      3450.05125A
      3451.05125A
      3452.05125A
      3453.05125A
      3454.05125A
      3801.071101
      3802.071101
      3803.071101
      3804.071101
      3805.071101
      3806.081103
      3807.081103
      3808.08125A
      3811.071101
      3812.081203
      3813.081203
      3814.08125A
      3815.08125A
      3816.081203
      3817.081203
      3818.08125A
      3819.08125A
      3820.08125A
      3821.08125A
      3822.08125A
      3823.08125A
      3824.08125A
      3825.08125A
      3901.08125A
      3903.071101
      3905.071101
      3907.071101
      3909.071101
      3911.071101
      4001.081103
      4003.081103
      4005.08125A
      4010.081203
      4012.081203
      4014.08125A
      4016.08125A
      4018.081203
      4020.081203
      4022.08125A
      4024.08125A
      4026.08125A
      4028.08125A
      4030.08125A
      4032.08125A
      4034.08125A
      4036.08125A
      4201.09225A
      4202.09225A
      4203.09225A
      4204.10225A
      4205.10225A
      4206.10225A
      4207.10225A
      4211.09225A
      4212.09225A
      4213.09225A
      4214.09225A
      4215.09225A
      4216.09225A
      4217.09225A
      4218.09225A
      4219.09225A
      4220.09225A
      4221.09225A
      4222.09225A
      4223.10225A
      4224.10225A
      4225.10225A
      4226.10225A
      4227.10225A
      4228.10225A
      4601.11225B
      4602.15325B
      4611.12325B
      4612.12325B
      4613.12325B
      4614.12325B
      4615.12325B
      4616.12325B
      4617.12325B
      4618.12325B
      4619.12325B
      4620.12325B
      4621.12325B
      4622.12325B
      4623.12325B
      4624.15325B
      4625.12325B
      4626.12325B
      4627.12325B
      4628.12325B
      4629.12325B
      4630.12325B
      4631.15325B
      4632.12325B
      4633.12325B
      4634.12325B
      4635.14325B
      4636.14325B
      4637.14325B
      4638.14325B
      4639.14325B
      4640.14325B
      4641.14325B
      4642.14325B
      4643.14325B
      4644.14325B
      4645.14325B
      4646.14325B
      4647.14325B
      4648.14325B
      4649.15325B
      4650.14325B
      4651.14325B
      5001.164104
      5004.174104
      5005.17425A
      5006.17425A
      5007.17425A
      5011.16425A
      5012.16425A
      5013.16425A
      5014.16425A
      5015.164104
      5016.16425A
      5017.164204
      5018.16425A
      5019.16425A
      5020.16425A
      5021.16425A
      5022.16425A
      5023.164204
      5024.164104
      5025.16425A
      5026.16425A
      5027.16425A
      5028.164104
      5029.164204
      5030.164204
      5031.164104
      5032.16425A
      5033.16425A
      5034.17425A
      5035.174104
      5036.174104
      5037.174104
      5038.174104
      5039.17425A
      5040.17425A
      5041.174104
      5042.17425A
      5043.17425A
      5044.17425A
      5045.17425A
      5046.17425A
      5047.17425A
      5048.17425A
      5049.17425A
      5050.17425A
      5051.17425A
      5052.17425A
      5053.17425A
      5054.164104
      5055.164104
      5056.164104
      5057.164104
      5058.164104
      5059.164104
      5060.17425A
      5061.15325B
      5401.195206
      5402.195206
      5403.205207
      5404.205207
      5405.205207
      5406.205207
      5411.195206
      5412.185206
      5413.195206
      5414.195206
      5415.195206
      5416.195206
      5417.195206
      5418.195206
      5419.195206
      5420.195206
      5421.195206
      5422.195206
      5423.195206
      5424.195206
      5425.195206
      5426.195207
      5427.195207
      5428.195207
      5429.195207
      5430.205207
      5434.205207
      5436.205207
      5437.205207
      5438.205207
      5439.205207
      5440.205207
      5441.205207
      5442.205207
      5444.205207
      5501.195206
      5503.195206
      5510.195206
      5512.185206
      5514.195206
      5516.195206
      5518.195206
      5520.195206
      5522.195206
      5524.195206
      5526.195206
      5528.195206
      5530.08125A
      5532.195206
      5534.195206
      5536.195206
      5538.195206
      5540.195207
      5542.195207
      5544.195207
      5546.195207
      5601.205207
      5603.205207
      5605.205207
      5607.205207
      5610.205207
      5612.205207
      5616.205207
      5618.205207
      5622.205207
      5624.205207
      5626.205207
      5628.205207
      5630.205207
      5634.205207
      5636.205207
/;
*
     Set K_TIL_F(K,F) Tilordning kommuner til fylker /
      0101.010000
      0104.010000
      0105.010000
      0106.010000
      0111.010000
      0118.010000
      0119.010000
      0121.010000
      0122.010000
      0123.010000
      0124.010000
      0125.010000
      0127.010000
      0128.010000
      0135.010000
      0136.010000
      0137.010000
      0138.010000
      0211.020300
      0213.020300
      0214.020300
      0215.020300
      0216.020300
      0217.020300
      0219.020300
      0220.020300
      0221.020300
      0226.020300
      0227.020300
      0228.020300
      0229.020300
      0230.020300
      0231.020300
      0233.020300
      0234.020300
      0235.020300
      0236.020300
      0237.020300
      0238.020300
      0239.020300
      0301.020300
      0402.040000
      0403.040000
      0412.040000
      0415.040000
      0417.040000
      0418.040000
      0419.040000
      0420.040000
      0423.040000
      0425.040000
      0426.040000
      0427.040000
      0428.040000
      0429.040000
      0430.040000
      0432.040000
      0434.040000
      0436.040000
      0437.040000
      0438.040000
      0439.040000
      0441.040000
      0501.050000
      0502.050000
      0511.050000
      0512.050000
      0513.050000
      0514.050000
      0515.050000
      0516.050000
      0517.050000
      0519.050000
      0520.050000
      0521.050000
      0522.050000
      0528.050000
      0529.050000
      0532.050000
      0533.050000
      0534.050000
      0536.050000
      0538.050000
      0540.050000
      0541.050000
      0542.050000
      0543.050000
      0544.050000
      0545.050000
      0602.060000
      0604.060000
      0605.060000
      0612.060000
      0615.060000
      0616.060000
      0617.060000
      0618.060000
      0619.060000
      0620.060000
      0621.060000
      0622.060000
      0623.060000
      0624.060000
      0625.060000
      0626.060000
      0627.060000
      0628.060000
      0631.060000
      0632.060000
      0633.060000
      0701.070000
      0702.070000
      0704.070000
      0706.070000
      0709.070000
      0710.070000
      0711.070000
      0712.070000
      0713.070000
      0714.070000
      0715.070000
      0716.070000
      0718.070000
      0719.070000
      0720.070000
      0722.070000
      0723.070000
      0728.070000
      0729.070000
      0805.080000
      0806.080000
      0807.080000
      0811.080000
      0814.080000
      0815.080000
      0817.080000
      0819.080000
      0821.080000
      0822.080000
      0826.080000
      0827.080000
      0828.080000
      0829.080000
      0830.080000
      0831.080000
      0833.080000
      0834.080000
      0901.090000
      0904.090000
      0906.090000
      0911.090000
      0912.090000
      0914.090000
      0919.090000
      0926.090000
      0928.090000
      0929.090000
      0935.090000
      0937.090000
      0938.090000
      0940.090000
      0941.090000
      1001.100000
      1002.100000
      1003.100000
      1004.100000
      1014.100000
      1017.100000
      1018.100000
      1021.100000
      1026.100000
      1027.100000
      1029.100000
      1032.100000
      1034.100000
      1037.100000
      1046.100000
      1101.110000
      1102.110000
      1103.110000
      1106.110000
      1108.110000
      1111.110000
      1112.110000
      1114.110000
      1119.110000
      1120.110000
      1121.110000
      1122.110000
      1124.110000
      1127.110000
      1129.110000
      1130.110000
      1133.110000
      1134.110000
      1135.110000
      1141.110000
      1142.110000
      1144.110000
      1145.110000
      1146.110000
      1149.110000
      1151.110000
      1154.110000
      1159.110000
      1160.110000
      1201.110000
      1211.120000
      1214.110000
      1216.120000
      1219.120000
      1221.120000
      1222.120000
      1223.120000
      1224.120000
      1227.120000
      1228.120000
      1231.120000
      1232.120000
      1233.120000
      1234.120000
      1235.120000
      1238.120000
      1241.120000
      1242.120000
      1243.120000
      1244.120000
      1245.120000
      1246.120000
      1247.120000
      1251.120000
      1252.120000
      1253.120000
      1256.120000
      1259.120000
      1260.120000
      1263.120000
      1264.120000
      1265.120000
      1266.120000
      1401.140000
      1411.140000
      1412.140000
      1413.140000
      1416.140000
      1417.140000
      1418.140000
      1419.140000
      1420.140000
      1421.140000
      1422.140000
      1424.140000
      1426.140000
      1428.140000
      1429.140000
      1430.140000
      1431.140000
      1432.140000
      1433.140000
      1438.140000
      1439.140000
      1441.140000
      1443.140000
      1444.140000
      1445.140000
      1449.140000
      1502.150000
      1504.150000
      1505.150000
      1506.150000
      1507.150000
      1508.150000
      1511.150000
      1514.150000
      1515.150000
      1516.150000
      1517.150000
      1519.150000
      1520.150000
      1523.150000
      1524.150000
      1525.150000
      1526.150000
      1528.150000
      1529.150000
      1531.150000
      1532.150000
      1534.150000
      1535.150000
      1539.150000
      1543.150000
      1545.150000
      1546.150000
      1547.150000
      1548.150000
      1551.150000
      1554.150000
      1556.150000
      1557.150000
      1560.150000
      1563.150000
      1566.150000
      1567.150000
      1569.150000
      1571.150000
      1572.150000
      1573.150000
      1576.150000
      1577.150000
      1578.150000
      1579.150000
      1580.150000
      1601.160000
      1612.160000
      1613.160000
      1617.160000
      1620.160000
      1621.160000
      1622.160000
      1624.160000
      1627.160000
      1630.160000
      1632.160000
      1633.160000
      1634.160000
      1635.160000
      1636.160000
      1638.160000
      1640.160000
      1644.160000
      1648.160000
      1653.160000
      1657.160000
      1662.160000
      1663.160000
      1664.160000
      1665.160000
      1702.170000
      1703.170000
      1711.170000
      1714.170000
      1717.170000
      1718.170000
      1719.170000
      1721.170000
      1723.170000
      1724.170000
      1725.170000
      1729.170000
      1736.170000
      1738.170000
      1739.170000
      1740.170000
      1742.170000
      1743.170000
      1744.170000
      1748.170000
      1749.170000
      1750.170000
      1751.170000
      1755.170000
      1756.170000
      1804.180000
      1805.180000
      1806.180000
      1811.180000
      1812.180000
      1813.180000
      1815.180000
      1816.180000
      1818.180000
      1820.180000
      1822.180000
      1824.180000
      1825.180000
      1826.180000
      1827.180000
      1828.180000
      1832.180000
      1833.180000
      1834.180000
      1835.180000
      1836.180000
      1837.180000
      1838.180000
      1839.180000
      1840.180000
      1841.180000
      1842.180000
      1845.180000
      1848.180000
      1849.180000
      1850.180000
      1851.180000
      1852.180000
      1853.180000
      1854.180000
      1856.180000
      1857.180000
      1859.180000
      1860.180000
      1865.180000
      1866.180000
      1867.180000
      1868.180000
      1870.180000
      1871.180000
      1874.180000
      1875.180000
      1901.190000
      1902.190000
      1903.190000
      1911.190000
      1913.190000
      1915.190000
      1917.190000
      1919.190000
      1920.190000
      1922.190000
      1923.190000
      1924.190000
      1925.190000
      1926.190000
      1927.190000
      1928.190000
      1929.190000
      1931.190000
      1933.190000
      1936.190000
      1938.190000
      1939.190000
      1940.190000
      1941.190000
      1942.190000
      1943.190000
      2002.200000
      2003.200000
      2004.200000
      2011.200000
      2012.200000
      2014.200000
      2015.200000
      2017.200000
      2018.200000
      2019.200000
      2020.200000
      2021.200000
      2022.200000
      2023.200000
      2024.200000
      2025.200000
      2027.200000
      2028.200000
      2030.200000
      3001.010000
      3002.010000
      3003.010000
      3004.010000
      3005.060000
      3006.060000
      3007.060000
      3011.010000
      3012.010000
      3013.010000
      3014.010000
      3015.010000
      3016.010000
      3017.010000
      3018.010000
      3019.020300
      3020.020300
      3021.020300
      3022.020300
      3023.020300
      3024.020300
      3025.020300
      3026.020300
      3027.020300
      3028.020300
      3029.020300
      3030.020300
      3031.020300
      3032.020300
      3033.020300
      3034.020300
      3035.020300
      3036.020300
      3037.020300
      3038.060000
      3039.060000
      3040.060000
      3041.060000
      3042.060000
      3043.060000
      3044.060000
      3045.060000
      3046.060000
      3047.060000
      3048.060000
      3049.060000
      3050.060000
      3051.060000
      3052.060000
      3053.050000
      3054.050000
      3101.010000
      3103.010000
      3105.010000
      3107.010000
      3110.010000
      3112.010000
      3114.040000
      3116.010000
      3118.010000
      3120.010000
      3122.010000
      3124.010000
      3201.020300
      3203.020300
      3205.020300
      3207.020300
      3209.020300
      3212.020300
      3214.020300
      3216.020300
      3218.020300
      3220.020300
      3222.020300
      3224.020300
      3226.020300
      3228.020300
      3230.020300
      3232.020300
      3234.050000
      3236.050000
      3238.020300
      3240.020300
      3242.020300
      3301.060000
      3303.060000
      3305.060000
      3310.060000
      3312.060000
      3314.060000
      3316.060000
      3318.060000
      3320.060000
      3322.060000
      3324.060000
      3326.060000
      3328.060000
      3330.060000
      3332.060000
      3334.060000
      3336.060000
      3338.060000
      3401.040000
      3403.040000
      3405.050000
      3407.050000
      3411.040000
      3412.040000
      3413.040000
      3414.040000
      3415.040000
      3416.040000
      3417.040000
      3418.040000
      3419.040000
      3420.040000
      3421.040000
      3422.040000
      3423.040000
      3424.040000
      3425.040000
      3426.040000
      3427.040000
      3428.040000
      3429.040000
      3430.040000
      3431.050000
      3432.050000
      3433.050000
      3434.050000
      3435.050000
      3436.050000
      3437.050000
      3438.050000
      3439.050000
      3440.050000
      3441.050000
      3442.050000
      3443.050000
      3446.050000
      3447.050000
      3448.050000
      3449.050000
      3450.050000
      3451.050000
      3452.050000
      3453.050000
      3454.050000
      3801.070000
      3802.070000
      3803.070000
      3804.070000
      3805.070000
      3806.080000
      3807.080000
      3808.080000
      3811.070000
      3812.080000
      3813.080000
      3814.080000
      3815.080000
      3816.080000
      3817.080000
      3818.080000
      3819.080000
      3820.080000
      3821.080000
      3822.080000
      3823.080000
      3824.080000
      3825.080000
      3901.080000
      3903.070000
      3905.070000
      3907.070000
      3909.070000
      3911.070000
      4001.080000
      4003.080000
      4005.080000
      4010.080000
      4012.080000
      4014.080000
      4016.080000
      4018.080000
      4020.080000
      4022.080000
      4024.080000
      4026.080000
      4028.080000
      4030.080000
      4032.080000
      4034.080000
      4036.080000
      4201.090000
      4202.090000
      4203.090000
      4204.100000
      4205.100000
      4206.100000
      4207.100000
      4211.090000
      4212.090000
      4213.090000
      4214.090000
      4215.090000
      4216.090000
      4217.090000
      4218.090000
      4219.090000
      4220.090000
      4221.090000
      4222.090000
      4223.100000
      4224.100000
      4225.100000
      4226.100000
      4227.100000
      4228.100000
      4601.110000
      4602.150000
      4611.120000
      4612.120000
      4613.120000
      4614.120000
      4615.120000
      4616.120000
      4617.120000
      4618.120000
      4619.120000
      4620.120000
      4621.120000
      4622.120000
      4623.120000
      4624.150000
      4625.120000
      4626.120000
      4627.120000
      4628.120000
      4629.120000
      4630.120000
      4631.150000
      4632.120000
      4633.120000
      4634.120000
      4635.140000
      4636.140000
      4637.140000
      4638.140000
      4639.140000
      4640.140000
      4641.140000
      4642.140000
      4643.140000
      4644.140000
      4645.140000
      4646.140000
      4647.140000
      4648.140000
      4649.150000
      4650.140000
      4651.140000
      5001.160000
      5004.170000
      5005.170000
      5006.170000
      5007.170000
      5011.160000
      5012.160000
      5013.160000
      5014.160000
      5015.160000
      5016.160000
      5017.160000
      5018.160000
      5019.160000
      5020.160000
      5021.160000
      5022.160000
      5023.160000
      5024.160000
      5025.160000
      5026.160000
      5027.160000
      5028.160000
      5029.160000
      5030.160000
      5031.160000
      5032.160000
      5033.160000
      5034.170000
      5035.170000
      5036.170000
      5037.170000
      5038.170000
      5039.170000
      5040.170000
      5041.170000
      5042.170000
      5043.170000
      5044.170000
      5045.170000
      5046.170000
      5047.170000
      5048.170000
      5049.170000
      5050.170000
      5051.170000
      5052.170000
      5053.170000
      5054.160000
      5055.160000
      5056.160000
      5057.160000
      5058.160000
      5059.160000
      5060.170000
      5061.150000
      5401.190000
      5402.190000
      5403.200000
      5404.200000
      5405.200000
      5406.200000
      5411.190000
      5412.180000
      5413.190000
      5414.190000
      5415.190000
      5416.190000
      5417.190000
      5418.190000
      5419.190000
      5420.190000
      5421.190000
      5422.190000
      5423.190000
      5424.190000
      5425.190000
      5426.190000
      5427.190000
      5428.190000
      5429.190000
      5430.200000
      5434.200000
      5436.200000
      5437.200000
      5438.200000
      5439.200000
      5440.200000
      5441.200000
      5442.200000
      5444.200000
      5501.190000
      5503.190000
      5510.190000
      5512.180000
      5514.190000
      5516.190000
      5518.190000
      5520.190000
      5522.190000
      5524.190000
      5526.190000
      5528.190000
      5530.190000
      5532.190000
      5534.190000
      5536.190000
      5538.190000
      5540.190000
      5542.190000
      5544.190000
      5546.190000
      5601.200000
      5603.200000
      5605.200000
      5607.200000
      5610.200000
      5612.200000
      5616.200000
      5618.200000
      5622.200000
      5624.200000
      5626.200000
      5628.200000
      5630.200000
      5634.200000
      5636.200000
/;
*
*** Kobling mellom Jordmodregioner og fylker
*
     SET R_TIL_F(F,R) Regioner til fylker /
       010000.011101
       020300.(021101, 021103)
       040000.(041101, 041203, 04125A)
       050000.(051103, 05125A)
       060000.(061101, 06125A)
       070000.(071101)
       080000.(081103, 081203, 08125A)
       090000.(09225A)
       100000.(10225A)
       110000.(112102, 112203, 11215B, 11225B)
       120000.(12325B)
       140000.(14325B)
       150000.(15325B)
       160000.(164104, 164204, 16425A)
       170000.(174104, 17425A)
       180000.(185206)
       190000.(195206, 195207)
       200000.(205207)
/;
*
*** Kobling mellom Jordmodregioner og AKsoner
*
     SET R_TIL_S(S,R) Regioner til AKsoner /
       000001.(011101, 021101, 041101, 061101, 071101)
       000002.(112102)
       000003.(021103, 041203, 051103, 081103, 081203, 112203)
       000004.(164104, 164204, 174104)
       00005A.(04125A, 05125A, 06125A, 08125A, 09225A, 10225A, 16425A, 17425A)
       00005B.(11215B, 11225B, 12325B, 14325B, 15325B)
       000006.(185206, 195206)
       000007.(195207, 205207)
/;
*
*   Kobling mellom Jordmodregioner og jordbruksregioner i driftsgranskingene
*
     SET R_TIL_DG(DG,R) Regioner til DGreginoer /
       001100.(011101, 021101, 021103, 041101, 051103, 061101, 071101, 081103)
       001200.(041203, 04125A, 05125A, 06125A, 081203, 08125A)
       002100.(112102, 11215B)
       002200.(09225A, 10225A, 112203, 11225B)
       003200.(12325B, 14325B, 15325B)
       004100.(164104, 174104)
       004200.(164204, 16425A, 17425A)
       005200.(185206, 195206, 195207, 205207)
/;
*
*   Kobling mellom Jordmodregioner og markedsregioner
*
     SET R_TIL_M(M,R) Regioner til markedsreginoer /
       OEST.(011101, 021101, 021103, 041101, 041203, 04125A, 051103, 05125A, 061101, 06125A, 071101)
       SOER.(081103, 081203, 08125A, 09225A, 10225A, 112102, 112203, 11215B, 11225B)
       VEST.(12325B, 14325B)
       MIDT.(15325B, 164104, 164204, 16425A, 174104, 17425A)
       NORD.(185206, 195206, 195207, 205207)
/;
*
*   Kobling mellom Jordmodregioner og sentrale stroek vs distrikter
*
     SET R_TIL_SD(SD,R) Regioner til sentrale stroek vs distrikter /
       000100.(011101, 021101, 021103, 041101, 051103, 061101, 071101, 081103, 112102, 11215B, 164104, 174104)
       000200.(041203, 04125A, 05125A, 06125A, 081203, 08125A, 09225A, 10225A, 112203, 11225B, 12325B, 14325B,
               15325B, 164204, 16425A, 17425A, 185206, 195206, 195207, 205207)
/;
*
*   Kobling mellom Jordmodregioner og hele landet
*
     SET R_TIL_NO(NORGE,R) Regioner til hele landet /
       NORGE.(011101, 021101, 021103, 041101, 051103, 061101, 071101, 081103, 112102, 11215B, 164104, 174104,
              041203, 04125A, 05125A, 06125A, 081203, 08125A, 09225A, 10225A, 112203, 11225B, 12325B, 14325B,
              15325B, 164204, 16425A, 17425A, 185206, 195206, 195207, 205207)
/;
*
* Soner for beregning av tilskudd
SET SONE        Soner for alle tilskudd /0*10/;
SET SSONE(SONE) Soner for regionale tilskudd /1*10/;
SET TTIL        Trappetrinn        /0*6/;
ALIAS(TTTIL,TTIL);
*
*** Definerer regnark fra PT
*
     SET RARKPTS Regnark fra Produksjonstilleggsregister /

1        EPLER
2        P�RER
3        PLOMMER
4        MORELLER
5        KIRSEB�R
6        EPLER P�RER TIL PRESS
10
11        JORDB�R
12        BRINGEB�R
13        SOLB�R
14        RIPS
16        HAGEBL�B�R
21        STIKKELSB�R
22        Industribaer av det totale antall baer
31        TOMAT
32        SLANGEAGURK
33        SALAT
60        POTETER
111        Voksne hester
113        Unghester under 2 �r
115        HESTER UNDER 3 �R
116        HESTER 3 �R OG ELDRE
117        - HERAV AVKOM AV KYR AV MINST 50% KJ�TTFERASE
118        - HERAV KYR AV MINST 50% KJ�TTFERASE
119        �VRIGE STORFE
120        MJ�LKEKYR
121        AMMEKYR FOR SPESIALISERT KJ�TTPROD.
130        VINTERFORA SAUER
132        Andre sauer og lam
133        UTEG�ENDE SAU
134        S�YER 1 �R OG ELDRE
135        V�RER 1 �R OG ELDRE
136        LAM UNDER 1 �R
137        VOKSNE SAUER OVER ETT �R
138        SAUER UNDER ETT �R
139        MELKESAU
140        MJ�LKEGEITER
142        AMMEGEITER FOR SPESIAL
144        BUKKER OG UNGDYR MEDREGNET KJE
145        S�YER 1 �R OG ELDRE
146        V�RER 1 �R OG ELDRE
147        UTEG�ENDE SAU 1 �R OG ELDRE (jan. 2008)
148        UTEG�ENDE SAU UNDER 1 �R (jan. 2008)
149        VOKSNE SAUER OVER 1 �R
154        SM�GRISER UNDER 2 MND
155        AVLSPURKER (PURKER Med MINST 1 KULL)
156        AVLSR�NER (R�NER SOM ER SATT INN I AVLEN)
157        ANTALL SLAKTEGRISER P� TELLEDATO
158        UNGPURKER FOR AVL
159        UNGR�NER FOR AVL
160        VERPEH�NER OVER 20 UKER
161        VERPEH�NER til konsumegg OVER 20 UKER fra 2019
168        ENDER KALKUNER OG GJESS TIL BRUKSDPR.
170        MINKTISPER OG ILDERTISPER
171        BL�REVTISPER OG S�LVREVTISPER
174        Annen fjoerfe
175        LIVKYLLINGER P�SETT TIL VERPEH�NS
176        Slaktekyllinger
180        KANINER
181        HJORTEOPPDRETT EGENPRODUSERT GROVFOR
182        Andre grovfordyr egenprodusert grovfor
183        Struts
184        GRIS SOLGT SLAKT SAMT LIVDYR
185        LIVKYLLINGER
186        KYLLINGER
187        ENDER
188        KALKUNER
189        GJESS
192        Esel
193        Hester i pensjon i beitesesongen
194        Bikuber i produksjon
196        Lama
197        Alpakka
210        Fulldyrket jord
211        Overflatedyrket jord
212        Grovfor paa innmarksbeite
213        Annen grovfor
223        Groenngjoedsling
230        Poteter
235        Engfroe til mondning
236        Annet froe og erter og
237        Oljevekster
238        Rug og rughvete
239        Korn til krossing
240        Vaarhvete
241        Rug
242        Bygg
243        Havre
245        Erter og boenner til konserves
246        ENGFR� OG ANNET FR� TIL MODNING
247        Hoesthvete
249        Rughvete
250        Annen veksthus
251        Veksthus
264        Groennsaker
271        Moreller
272        Epler
273        Paerer
274        Plommer
280        Jordbaer
281        Andre baer
282        Andre b�rarter
283        Andre fruktarter
285        Planteskoleareal og blomsterdyrking p� friland
290        Brakk areal
292        Fulldyrket jord ute av
293        Beite ute av drift
294        Areal i drift Ikke ber
295        Brattareal
365        Areal i avstand 5-15 km
380        Areal i avstand st�rre enn 15 km
410        Kyr pa utmarksbeite
411        Kyr p� beite
420        Ungdyr storfe pa utmar
422        Ungdyr storfe paa beit
430        SAUER VOKSNE OG LAM P� UTMARKSBEITE (- aug. 2002)
431        Sauer pa utmarksbeite
432        Lam pa utmarksbeite
440        Geit og kje pa utmarks
445        Geit og kje paa beite
450        Hester p� utmarksbeite
455        Hester p� beite 12 eller 16 uker
471        LAM SLAKTA 2012 KVALITET 0 ELLER BEDRE
473        LAM SLAKTA 2012 KVALITET O-
474        LAM SLAKTA 2012 KVALITET P+ ELLER D�RLIGERE
475        KJE SLAKTA 2012 SLAKTEVEKT OVER 3.5 KG
476        LAM SLAKTA 2012 IKKE KLASSIFIS�R
486        Hjort p� beite 12 eller 16 uker
487        Sauer paa beite
488        Lam paa beite
521        Salg av grovf�r h�y
522        Salg av grovf�r surfor
523        H�yensilasje
610        Seterdrift p� egen seter
620        Seterdrift p� fellesseter
720        ANTALL KYR AV BEVARINGSVERDIG RASE
721        ANTALL OKSER AV BEVARINGSVERDIG RASE
801        MELKEKYR
802        AMMEKYR
803        �VRIGE STORFE
810        MELKEGEITER
811        AMMEGEITER
820        �KOLOGISKE VINTERF�RA SAUER OG LAM (jan. 2003)
821        VOKSNE SAUER OVER ETT �R
822        LAM SLAKTA 2012 KVALITET O- ELLER BEDRE
823        LAM SLAKTA 2012 IKKE KLASSIFIS�R
830        AVLSGRISER
831        GRISER SLAKTET ELLER SOLGT SOM LIVDYR I 2012
832        Slaktegriser griser p�satt til avlsdyr
840        KYLLINGER SLAKTA I 2012
841        Verpeh�ner
850        OMLEGGINGSTILSKUDD 1. �R
851        OMLEGGINGSTILSKUDD 2. OG 3 �R
852        OMLEGGINGSTILSKUDD 2 �R GR�NNGJ�DSLING
855        AREALTILSKUDD KORN TIL MODNING
860        Arealstilskudd poteter gr�nnsaker og b�r
861        AREALTILSKUDD POTETER
862        AREALTILSKUDD GR�NNSAKER OG B�R
863        Frukt og baer
864        Groennsaker
870        AREALTILSKUDD ANNET �KOLOGISK DREVET AREAL
871        AREALTILSKUDD INNMARKSBEITE
875        AREALTILSKUDD GR�NNGJ�DSLING
880        Innmarksbeite 1. år karens
881        Grovfôrareal unntatt innmark 1. år karens
882        Annet areal 1. år karens
/;

     SET KORNPTS(RARKPTS) Kornaktiviteter fra Produksjonstilleggsregister /
238        Rug og rughvete
239        Korn til krossing
240        Vaarhvete
241        Rug
242        Bygg
243        Havre
247        Hoesthvete
249        Rughvete
/;

     SET OljePTS(RARKPTS) Oljefr� og erter fra Produksjonstilleggsregister /
237        Oljevekster
236        Annet froe og erter og
245        Erter og boenner til konserves
/;

     SET KornOljePTS(RARKPTS) Korn oljefr� og erter fra Produksjonstilleggsregister /
         set.KornPTS
         set.OljePTS
/;

    SET PTSTDISG(*,RARKPTS) Koder for beregning av distriktstilskudd for frukt baer og veksthusgroennsaker  /
EplerMM.(1,2,3,5)
Moreller.4
Press.6
Baer.(11,12,13,14,16,21)
IndBaer.22
Tomat.31
Agurk.32
Salat.33
/;

    SET NoOfFarms(*,RARKPTS) Koder for beregning av antall bønder med melk og kjøtt  /
Milk.(120, 139, 140)
Meat.(119,121,130,132,133,134,135,136,137,138,142,144,145,146,147,148,149,154,155,156,157,158,159)
/;


SET PtMngd Varer fra produksjonstilleggsregister /
bygg_for_kg
bygg_sakorn_kg
bygg_saakorn_kg
bygg_mat_kg
erter_for_kg
erter_mat_kg
erter_saakorn_kg
havre_for_kg
havre_saakorn_kg
hvete_for_kg
hvete_mat_kg
hvete_saakorn_kg
oljefro_kg
oljefro_saakorn_kg
rug_for_kg
rug_mat_kg
rug_saakorn_kg
rughvete_for_kg
rughvete_saakorn_kg
bgg_saakorn_kg
erter_sakorn_kg
havre_sakorn_kg
hvete_sakorn_kg
oljefro_sakorn_kg
rug_sakorn_kg
rughvete_sakorn_kg
kumelk_liter
geitemelk_liter
and_kg
geit_kg
gris_kg
gaas_kg
hane_kg
hest_foll_kg
hons_kg
kalkun_kg
kalv_kg
kje_kg
ku_kg
kvige_kg
kylling_kg
lam_kg
lam_villsau_kg
okse_kg
purke_kg
raane_kg
sau_kg
ungokse_kastrat_kg
ull_kg
ungku_kg
ungsau_kg
vaer_kg
egg_kg
/;
alias(PtPtMngd,PtMngd);

SET PtMngdHve(PtMngd) Hvetevarer fra produksjonstilleggsregister /
      hvete_for_kg
      hvete_mat_kg
      hvete_saakorn_kg
      hvete_sakorn_kg
/;
alias(PtPtMngdHve,PtMngdHve);

SET PtMngdByg(PtMngd) Byggvarer fra produksjonstilleggsregister /
      bygg_for_kg
      bygg_sakorn_kg
      bygg_mat_kg
      bygg_saakorn_kg
/;
alias(PtPtMngdByg,PtMngdByg);


SET PtMngdHav(PtMngd) Havrevarer fra produksjonstilleggsregister /
      havre_for_kg
      havre_sakorn_kg
      havre_saakorn_kg
/;
alias(PtPtMngdHav,PtMngdHav);


SET PtMngdRug(PtMngd) Rugvarer fra produksjonstilleggsregister /
      rug_for_kg
      rug_mat_kg
      rug_saakorn_kg
/;
alias(PtPtMngdRug,PtMngdRug);

SET PtMngdAkr(PtMngd) Akrnvarer fra produksjonstilleggsregister /
      rughvete_sakorn_kg
      rughvete_for_kg
/;
alias(PtPtMngdAkr,PtMngdAkr);

SET PtMngdRap(PtMngd) Rapsvarer fra produksjonstilleggsregister /
      oljefro_kg
      oljefro_saakorn_kg
/;
alias(PtPtMngdRap,PtMngdRap);

SET PtMngdErt(PtMngd) Ertevarer fra produksjonstilleggsregister /
      erter_for_kg
      erter_saakorn_kg
      erter_sakorn_kg
/;
alias(PtPtMngdErt,PtMngdErt);

SET PtMngdKorn(PtMngd) Kornvarer fra produksjonstilleggsregister /
   set.PtMngdHve
   set.PtMngdByg
   set.PtMngdHav
   set.PtMngdRug
   set.PtMngdAkr
/;
SET PtMngdOlje(PtMngd) Oljevarer fra produksjonstilleggsregister /
   set.PtMngdRap
   set.PtMngdErt
/;
SET PtMngdKornOlje(PtMngd) Korn og oljevarer fra produksjonstilleggsregister /
   set.PtMngdKorn
   set.PtMngdOlje
/;

*
*** Definer koder i Totalkalkylen (=Economic accounts of agriculture)
*
     SET KODETOT Koder i Totalkalkylen /
0100   'Hvete. Salg, matkornkvalitet  '
0101   'Hvete. Salg, fôrkornkvalitet  '
0102   'Hvete. Salg, såkornkvalitet  '
0103   'Hvete. Hjemmeforbruk,matkorn  '
0104   'Hvete. Salg og hjemmeforbruk  '
0105   'Rug. Salg, matkornkvalitet  '
0106   'Rug og rughvete fôrkorn.Salg  '
0107   'Rug og rughvete såkorn. Salg  '
0108   'Rug. Hjemmeforbruk, matkorn  '
0109   'Rug/rughvete. Salg/hjemmefb.  '
010A   'Bygg. Salg, matkornkvalitet  '
010B   'Bygg. Salg, fôrkornkvalitet  '
010Z   'Bygg. Salg  '
010V   'Bygg. Salg, såkornkvalitet  '
010W   'Bygg. Hjemmeforbruk, matkorn  '
010E   'Bygg. Salg og hjemmeforbruk  '
010F   'Havre. Salg, matkornkvalitet  '
010G   'Havre. Salg, fôrkornkvalitet  '
0110   'Havre. Salg  '
010X   'Havre. Salg, såkornkvalitet  '
010Y   'Havre. Hjemmeforbr.,matkorn  '
010J   'Havre. Salg og hjemmeforbruk  '
0118   'Erter til modning. Salg  '
0119   'Erter til modning. Såvare  '
011A   'Sum erter til modning  '
010K   'Sum korn (u/korreksj./tilsk)  '
010L   'Korreksjon for vann/kvalitet  '
010M   'Oljefrø og åkerbønner  '
010N   'Sum korn, oljefrø (u/tilsk.)  '
010P   'Korntrygd  '
010Q   'Særtillegg. Bygg  '
010R   'Kontantstøtte  '
010S   'Tillegg for løslevering  '
010T   'Geogr.prod.tillegg for korn  '
0113   'Lokale tillegg  '
010U   'Korn, erter og oljefrø  '
9900   'Korn, erter og oljefrø  '
0200   'Salg. Matpoteter  '
0201   'Salg. Matpoteter i spesialpk  '
0202   'Sum salg av matpoteter  '
0203   'Salg. Poteter til potetmel  '
0204   'Salg. Poteter til sprit  '
0205   'Salg. Poteter til mos/flakes  '
0206   'Salg. Poteter til pommes fr.  '
0207   'Salg. Poteter til chips  '
0208   'Salg. Vakuump. pot. mm.  '
0209   'Sum poteter til mos/chips mv  '
020A   'Salg. Poteter til eksport  '
020B   'Hjemmeforbruk. Matpoteter  '
020K   'Salg settepoteter  '
020C   'Salg. Reguleringspoteter  '
020D   'Sum poteter (uten tilskudd)  '
020E   'Potettrygd  '
020F   'Tilsk.statskontr.settepot.  '
020G   'Kontantstøtte  '
020H   'Frakttilskudd. Fôrpoteter  '
020I   'Distr.tilsk. for Nord-Norge  '
020J   'Poteter  '
0400   'Blomkål  '
0401   'Sommerkål  '
0402   'Vinterkål  '
0403   'Sum hodekål  '
0404   'Gulrot  '
0405   'Purre  '
0406   'Løk  '
0407   'Salatagurk (slangeagurk)  '
0408   'Tomater  '
0409   'Sum hovedkulturene.Grønnsak.  '
040A   'Rosenkål  '
040B   'Kinakål  '
040C   'Rødkål, brokkoli, mv.  '
042A   'Rødkål  '
042B   'Brokkoli  '
042C   'Annen kål 1  '
042D   'Annen kål 2  '
042E   'Bønner  '
042F   'Hageerter  '
042G   'Knollselleri  '
042H   'Stilkselleri  '
042I   'Selleri  '
042J   'Agurker, friland  '
042K   'Rødbeter  '
042L   'Rabarbra  '
042M   'Persillerot  '
042N   'Reddiker  '
042P   'Kruspersille  '
042Q   'Kålrot til mat  '
040Q   'Sum andre grønns.(u/salat)  '
040R   'Salatvekster  '
040S   'Salat veksthus  '
040T   'Issalat/Isbergsalat  '
0427   'Annen salat friland  '
0428   'Andre veksthusgrønnsaker  '
0424   'Urter i veksthus  '
040U   'Kjøkkenhager/uspes.vekster  '
040V   'Sum andre grønnsaker, m.v.  '
040W   'Sum grønnsaker  '
0423   'Epler  '
0410   'Pærer  '
0411   'Plommer  '
0412   'Kirsebær og moreller  '
0413   'Surkirsebær  '
0414   'Søtkirsebær (moreller)  '
0415   'Sum frukt  '
0416   'Jordbær  '
0417   'Bringebær  '
0418   'Solbær  '
0419   'Stikkelsbær  '
041A   'Rips  '
0425   'Andre bær  '
0426   'Bær i veksthus  '
041B   'Sum hagebær  '
041C   'Snittblomster/-grønt u.glass  '
0420   'Snittblomster  '
041D   'Blomstrende potteplanter  '
041E   'Dekorasjonsplanter  '
041F   'Snittblomster på friland  '
041G   'Utplantingsplanter  '
041H   'Sum blomster, store gartneri  '
041I   'Blomsterprod. i små gartneri  '
041J   'Sum blomster i gartnerier  '
041K   'Planteskoler  '
041L   'Blomster 1959-1972  '
041M   'Sum blomster  '
041N   'Kontantstøtte  '
041P   'Prod.tillegg,agurk og tomat  '
041Q   'Frakttilskudd, tomater  '
041R   'Distriktstilskudd på frukt  '
041S   'Emballasjetilskudd  '
0421   'Distr./kval.tilsk. fr/bær/gr  '
0429   'Tillegg i jordbruksoppgjør  '
041X   'Hagebruksprodukter  '
050U   'Høy. Innenlandsk salg  '
050V   'Halm. Innenl.salg til fôr  '
050W   'Halm. Innenl.salg forøvrig  '
050X   'Sum Halm. Innenlandsk salg  '
050Y   'Grasmel og fôrpellets. Salg  '
050Z   'Rundballer. Salg  '
0510   'Sum innenl. salg av stråfôr  '
0511   'Høy. Eksport  '
0512   'Halm. Eksport  '
0513   'Sum eksport av stråfôr  '
0514   'Stråfôr  '
050R   'Engfrø  '
050S   'Rotvekst- og grønnsaksfrø  '
050T   'Sum andre frø til modning  '
0516   'Lagerendringer, fôrmidler  '
0515   'Sum andre planteprodukter  '
9901   'Sum andre pl.prod unnt. korn  '
0000   'Sum planteprodukter  '
061L   'Kumelk. Meierileveranse  '
061M   'Kumelk. Direktesalg  '
061N   'Kumelk. Hjemmeforbr.helmelk  '
061P   'Kumelk. Salg, gårdssmør  '
061Q   'Kumelk. Hj.forbr.gårdssmør  '
0629   'Kumelk. Lokal foredling  '
061R   'Sum kumelk  '
061S   'Geitmelk. Meierileveranse  '
061T   'Geitmelk. Annet salg  '
061U   'Geitmelk. Hjemmeforbruk  '
061V   'Sum geitmelk  '
0628   'Produsenttjeneste, meierifin  '
0627   'Grunntilskudd melk  '
061X   'Sum ku/geitmelk m. gr.tilsk.  '
061Y   'Driftstilskudd  '
061Z   'Kvantumsavgrenset tilskudd  '
0620   'Distriktstilskudd  '
0621   'Frakttilskudd  '
0622   'Distriktsmeieritillegg  '
0623   'Oppkjøpsordning melkekvoter  '
0625   'Salg av melkekvoter  '
0624   'Ku- og geitmelk  '
9907   'Ku- og geitmelk  '
0700   'Storfe. Registrert salg  '
0701   'Storfe. Direkte salg  '
0702   'Storfe. Hjemmefb./returslakt  '
0703   'Sum storfe  '
0704   'Kalv. Registrert salg  '
0705   'Kalv. Direkte salg  '
0706   'Kalv. Hjemmefb./returslakt  '
0707   'Sum kalv  '
0708   'Sau/lam. Registrert salg  '
0709   'Sau/lam. Hj.fbr./r.s./d.salg  '
070A   'Sum sau/lam  '
070B   'Geit/kje. Registrert salg  '
070C   'Geit/kje. Hj.fb./returslakt  '
070D   'Sum geit/kje  '
070E   'Hest. Registrert salg  '
070F   'Hest. Hjemmefb./returslakt  '
070G   'Sum hest  '
070H   'Sum kjøtt (u/gris,fjørfe,tam  '
070I   'Gris. Registrert salg  '
070J   'Gris. Direkte salg  '
070K   'Gris. Hjemmefb./returslakt  '
071T   'Gris. Reg.salg u. hode/labb  '
071U   'Gris. Hj.fbr./r.s. u. h./l.  '
070L   'Sum gris  '
070M   'Sum kjøtt (u/fjørfe,tamrein)  '
070N   'Hønseslakt. Registrert salg.  '
070P   'Hønseslakt. Hjemmeforbruk  '
070Q   'Sum hønseslakt.  '
070R   'Kyllingslakt. Registr. salg.  '
070S   'Kyllingslakt. Hjemmeforbruk  '
070T   'Sum kyllingslakt.  '
070U   'Broilerslakt. Salg  '
070V   'Kylling (fra 1982). Salg  '
070W   'Sum høns,kylling,broilersl.  '
070X   'Gjess.  '
070Y   'Ender.  '
070Z   'Kalkuner. Salg  '
0710   'Fjør og dun  '
071F   'Struts  '
0711   'Sum annet fjørfe  '
0712   'Sum fjørfeslakt  '
0713   'Grunntilskudd kjøtt  '
0714   'Sum kjøtt inkl. grunntilsk.  '
0715   'Tilskuddsordn.for saueholdet  '
071G   'Internoverføring sauehold  '
071H   'Distriktstilskudd kjøtt  '
071I   'Ekstra distr.tils.Nord-Norge  '
071V   'Kvalitetstilskudd storfe  '
071X   'Tilskudd lam- og kjeslakt  '
071J   'Kvantumsavgrenset tilsk. sau  '
071K   'Premiert kalveslakting  '
071L   'Kastreringstilskudd  '
071M   'Tilskudd frifôring av sau  '
071N   'Tilsk. førtidsslakt. purker  '
071P   'Avviklingstilskudd svinehold  '
071Q   'Kontraktsf. mellomkalvprod.  '
071A   'Førtidslakt kalv og storfe  '
071R   'Ekstraslakting storfe/gris  '
071W   'Kompensas. red. sl.vekt gris  '
071Z   'Utkjøpsordning avlsgris  '
071Y   'Diverse utbetalinger  '
071S   'Sum tilskudd  '
071E   'Kjøtt og fjørfeslakt  '
9903   'Kjøtt og fjørfeslakt  '
0800   'Egg. Registrert salg.  '
0801   'Egg. Direkte salg.  '
0802   'Egg. Sum salg  '
0803   'Egg. Hjemmeforbruk, mat  '
0804   'Egg. Salg og hjemmeforbruk  '
0809   'Distriktstilskudd. Egg  '
0805   'Kontrakttillegg på egg  '
080A   'Kompensasjon øvrige tap  '
0807   'Komp. redusert verpeperiode  '
0808   'Egg  '
0900   'Ull  '
1100   'Innenlandsk salg. Hester  '
1101   'Eksport. Hester  '
1105   'Eksport. Andre dyr  '
110F   'Eksport. Embryo storfe  '
1106   'Sum eksport. Husdyr  '
110A   'Import. Andre dyr  '
110D   'Import. Embryo storfe  '
110E   'Import. Embryo småfe  '
110R   'Import. Embryo gris  '
110B   'Sum import. Husdyr  '
110G   'Kaninkjøtt  '
110H   'Kaninskinn  '
110I   'Sum kaniner  '
110P   'Oppdrettshjort  '
110Q   'Sum hjort  '
110J   'Honning  '
110K   'Salg til Honningcentralen  '
110L   'Honning.  Direkte salg  '
110M   'Katastrofetrygd for bier  '
110N   'Sum birøkt  '
110C   'Andre husdyrproduksjoner  '
9904   'Sum andre husdyrprodukter  '
0001   'Sum husdyrprodukter  '
0002   'Sum plante- og husdyrprod.  '
1209   'Kjøring v/invest. driftsbygn  '
120A   'Kjøring v/invest. grøfter  '
120B   'Kjøring v/invest. nydyrking  '
120C   'Sum kjøreinnt. v/investering  '
120D   'Kjøring i skogen  '
120E   'Kjøring på bierverv m.v.  '
120F   'Inntekter på kvarterhester  '
120G   'Innt. hester i full pensjon  '
120H   'Kjøreinntekter m.v.  '
1309   'Invest.arb. driftsbygninger  '
130A   'Invest.arb. grøfter  '
130B   'Invest.arb. nydyrking  '
130C   'Arbeidsinnt. v/investeringer  '
0003   'Sum andre inntekter  '
1405   'Hester  '
1406   'Storfe under 1 år  '
1407   'Okser over 1 år  '
1408   'Kviger  '
1409   'Kyr  '
140A   'Sum storfe  '
140B   'Sauer  '
140C   'Geiter  '
140D   'Slaktesvin  '
140E   'Avlssvin over 6 mnd.  '
140F   'Sum svin  '
140G   'Høner  '
140S   'Kyllinger  '
140H   'Ender, kalkuner og gjess  '
140I   'Struts  '
140J   'Sum fjørfe  '
140Q   'Kaniner  '
140R   'Endringer i buskapsverdi  '
1510   'Inntekt Jordleie  '
1520   'Inntekt Kvoteleie  '
1500   'Medlemsbonus  '
0004   'Sum lagerendr. buskap/ fôrm.  '
1601   'Ervervelse av tilleggsareal  '
1602   'Bygging av siloer  '
1603   'Press-saft anlegg  '
1604   'Låvetørkeanlegg  '
1605   'Planering av dyrket jord  '
1606   'Plant.i eldre frukttrefelt  '
1607   'Senkings- og lukkingsarb.mv  '
1608   'Vanningsanlegg  '
1609   'Bygging av driftsbygninger  '
160A   'BU-invest. tradisj. jordbruk  '
160B   'BU-invest. Drenering  '
160C   'Særlige utbyggingstiltak  '
160D   'Særlig vanskeligstilte bruk  '
160E   'Beredskapslager av drivstoff  '
160F   'Tekniske miljøinvest.  '
160G   'Tilsk. energiøkonom. tiltak  '
1639   'Tilskudd SMIL-ordning  '
160H   'Tilsk. til sær. kult.l.tilt.  '
160I   'Utvikl.prog. for geiteholdet  '
160J   'Organisert beitebruk  '
160K   'Beiteskade, gås  '
160L   'Setersatsing  '
160M   'Opphørte ordninger  '
160N   'Rentestøtte  '
1633   'Tilskudd til verdensarven  '
1634   'Morsa/Vestre Vannsjø  '
1635   'Utvalgte kulturlandskap  '
160P   'Sum utbet. Landbr.utb.fond  '
160Q   'Utbet. Katastrofef. pl.prod.  '
160R   'Utb.fra tiltaksf. små-/fj.fe  '
160S   'Utbet.Feriefondet for jordbr  '
160T   'Sum fondsutbetalinger  '
160U   'Grassilotrygd  '
160V   'Prisnedskr.stråfôr,N-Norge  '
160W   'Skadebot ved nedslakting  '
160X   'Frakttilskudd på høy  '
160Y   'Frakttilsk. Finnmark,kviger  '
160Z   'Frakttilskudd på stråfôr  '
1610   'Arealtilsk.pot/gr.s,N-Norge  '
1611   'Prod.till.dyrk.fôr i fjellet  '
1612   'Prod.tillegg, planteprod.  '
1613   'Areal- og k.landsk.till.korn  '
1614   'Produksjonstillegg, grovfôr  '
1615   'Areal- og k.l.sk.till. g.fôr  '
1616   'Areal- og kult.l.till. g.sek  '
1617   'Areal kult.landsk.tillegg  '
1618   'Andre arealbas. tilsk.ordn.  '
1619   'Produksjonstillegg husdyr  '
161A   'Årsverkstillegg, husdyr  '
161B   'Driftstilskudd i melkeprod.  '
161C   'Driftstilskudd  '
161D   'Tilskudd til økolog. jordb.  '
1632   'Beitetilskudd  '
161E   'Regionale miljøprogram  '
161F   'Ufordelt beløp  '
1636   'Tilsk. miljøv. spr. h.d.gjd.  '
161G   'Sum dir. tilsk. (underpost)  '
161H   'Fjøskontrollag  '
161I   'Sikring av frøavlen  '
161J   'Fremme av norsk engfrøavl  '
161K   'Utnytting av fjellbeitene  '
161L   'Tap av sau på beite  '
161M   'Regnskapslag  '
161N   'Tilskudd til veksthus  '
161P   'Inseminering m.v.  '
161Q   'Gras og frø i fjellbygdene  '
161R   'Luting av halm  '
161S   'Konservering av halm  '
161T   'Tilsk. til særl. miljøtilt.  '
161U   'Tilsk. til økologisk jordbr.  '
161V   'Tilsk. til energiøk. tiltak  '
161W   'Sum utviklingstiltak  '
161X   'Utbet.avløserordn.i jordbr.  '
161Y   'Adm.tilsk. avl.lag/l.vikar  '
161Z   'Refusj. utgifter under sykd.  '
1620   'Sjukelønnsordning  '
1637   'Landbruksvikar avløserlag  '
1621   'Kommunale vikarordninger  '
1622   'Medlemsavgift, folketrygden  '
1623   'Samdrifter  '
1624   'Tidligpensjonsordning  '
1625   'Sum velferdsordninger  '
1626   'Uford. bev.red. pristilsk.  '
1627   'Uspesifiserte utbetalinger  '
1628   'Sum utbet. jordbruksavt.  '
1629   'Utbet.Rasj.fondet for jordbr  '
162A   'Tilsk.felles potetkokeanl.  '
162B   '2/3 rentefritak bureis.lån  '
162C   'Uthus på nye bruk  '
162D   'Fulldyrking  '
162E   'Overflatedyrking  '
162F   'Opparb. tidlig. dyrk. jord  '
162G   'Grøfting av dyrket jord  '
162H   'Istandsetting av dyrket jord  '
162I   'Nedskr.mek.kostn.myrjordbruk  '
162J   'Innkj.av maskiner,brattl.br.  '
162K   'Felles setre  '
162L   'Bygging av jordbr.veier  '
162M   'Vedlikehold av jordbr.veier  '
162N   'Jordbruks/reindr.vei,Karasj.  '
162P   'Utflyttingstilskudd  '
162Q   'Maskinstasjoner  '
162R   'Landbr.b,33 %,stønadadslån  '
162S   'Bureisingslag  '
162T   'Gjødseloppsamling  '
162U   'Tilskudd til leplanting  '
162V   'Sum inv.tilsk. u. LUF  '
162W   'Erst. tilt. pl./dyresykdom  '
162X   'Driftsplanlag m.v.  '
162Y   'Tilsk. avløs. rep./HV-øvelse  '
162Z   'Erstatn. rovdyrsk. på husdyr  '
1638   'Tilskudd til erstatning m.m.  '
1630   'Sum andre ordninger  '
1631   'Sum direkte tilskudd  '
0005   'Sum inntekter inkl. tilsk.  '
1700   'Kalksalpeter m. B og Co  '
173C   'Kalsiumnitrat  '
173D   'Kalsiumnitrat m. B  '
1701   'Kalkammonsalpeter. 20,5% N  '
1702   'Kalkammonsalpeter. 26-28% N  '
1703   'Kalkkvelstoff - trollmel  '
1704   'Urea  '
172F   'Hydro Svovelpluss  '
172L   'Kalsiumnitrat med Mg og S  '
1705   'Ammoniumkalsiumsalpeter  '
1706   'Ammoniumnitrat m.m.  '
173E   'Ammoniumnitrat  '
173F   'Ammoniumnitrat m. S  '
173G   'Ammoniumsulfatnitrat  '
173H   'Annen N-gjødsel  '
1707   'Sum nitrogen-gjødsel  '
1708   'Enkelsuper. Lysaker  '
1709   'Enkelsuper. Norko  '
170A   'Enkelsuper. Svensk. 9%  '
172J   'Superfosfat P8  '
170B   'Enkelsuper. Svensk. 11%  '
170C   'Kraftsuper.13%  '
170D   'Dobbel superfosfat  '
170E   'Thomasfosfat  '
170F   'Råfosfat  '
1736   'OPTI P-20/Trippelsuperfosat  '
170G   'Sum fosforgjødsel, ugranul.  '
170H   'Granuleringstil. Fosforgj.  '
170I   'Sum fosforgjødsel  '
170J   'Kalisuperfosfat PK 6-8  '
170K   'Kalisuperfosfat PK 6-13  '
170L   'Kalisuperfosfat PK 5-15  '
172M   'Kalisuper PK 5-17  '
170M   'Kalisuperfosfat PK 4,5-17,6  '
170N   'Kalisuperfosfat PK 5-9  '
170P   'Kalisuperfosfat PK 7,5-20,0  '
170Q   'Kalisuperfosfat PK 11,0-14,5  '
170R   'Kalisuperfosfat PK 7-23  '
170S   'Kalisuperfosfat PK 6-21  '
1724   'Kalisuperfosfat PK 7-21  '
170T   'Kalisuperfosfat PK 5-16  '
170U   'Kalisuperfosfat PK 8-15  '
170V   'Kalisuperfosfat PK 7-13  '
1725   'Kalisuperfosfat PK 11-21  '
1728   'Kalisuperfosfat PK 7-18/9-16  '
170W   'Kaliumsulfat  '
170X   'Kaliumgjødsel 33%  '
170Y   'Kaliumgjødsel 41%  '
170Z   'Kaliumklorid  '
1710   'Kaliumsulfat m. Mg  '
172V   'K-gjødsel div.  '
1711   'Kaliumsulfatsuper PK 5-14  '
1755   'PK-gjødsel  '
1712   'Sum PK-gjødsel og kaliumgj.  '
173R   'NP 12-23  '
173S   'NP-gjødsel  '
173I   'Sum NP-gjødsel  '
173T   'NK-gjødsel 22-11  '
173U   'NK 19-16 / NK 20-10  '
173V   'Nitrogen-kalium-gjødsel 23-8  '
173W   'NK-gjødsel 22-12  '
173J   'Sum NK-gjødsel  '
173X   'Fullgjødsel A 12,5-5,5  '
173Y   'NPK-gjødsel 16-3-18  '
173Z   'Fullgjødsel B 11,5-5,0  '
1740   'NPK-gjødsel 21-6-6  '
1741   'Fullgjødsel C 14,5-6,5  '
1742   'Fullgjødsel A 14-6-16  '
1743   'NPK-gjødsel 18-2-10  '
1744   'Fullgjødsel B 13-6-16  '
1745   'NPK-gjødsel 11-5-17/11-5-18  '
1746   'NPK-gjødsel 12-4-18  '
1747   'Fullgjødsel C 16-7-12  '
1748   'NPK-gjødsel 17-5-13  '
1749   'NPK-gjødsel 21-3-10  '
174A   'Fullgjødsel D 20-5-9  '
174B   'NPK-gjødsel 21-4-10  '
174C   'NPK-gjødsel 22-2-12  '
174D   'Fullgjødsel F 16-3-15  '
174E   'NPK-gjødsel 22-3-10  '
174F   'NPK-gjødsel 19-4-12  '
174G   'Fullgjødsel 15-4-12  '
174H   'NPK-gjødsel 18-3-15  '
174I   'NPK-gjødsel 27-3-5  '
174J   'Fullgjødsel 19-5-9  '
174K   'NPK-gjødsel 20-4-11  '
174L   'Fullgjødsel 16-5-12  '
174M   'NPK-gjødsel 21-3-8  '
174N   'NPK-gjødsel 8-5-19  '
174P   'Fullgjødsel 11-5-18  '
174Q   'NPK-gjødsel 24-4-6  '
174R   'NPK-gjødsel 25-3-6  '
174S   'Fullgjødsel 20-3-6  '
174T   'Fullgjødsel 6-7-21  '
174U   'Fullgjødsel 25-2-6  '
174V   'Fullgjødsel 6-5-20  '
174W   'NPK-gjødsel 8-6-15  '
174X   'Mekanisk blandet handelsgjø.  '
174Z   'NPK-gjødsel N <9,5 %  '
1750   'NPK-gjødsel N 9,5 %-14,5 %  '
1751   'NPK-gjødsel N 14,5 %-19,5 %  '
1752   'NPK-gjødsel N 19,5 %-24,5 %  '
1753   'NPK-gjødsel N >24,5 %  '
174Y   'Sum NPK-gjødsel  '
173K   'Emballasje  '
1756   'Gjødsel grøntar./villahager  '
173Q   'Diverse handelsgjødsel  '
173L   'Sum diverse handelsgjødsel  '
173N   'Hamstring 2007/08  '
173P   'Negativ hamstring 2009/10  '
1757   'Annen gjødsel  '
171Q   'Sum handelsgjødsel  '
171R   'Magnesiumsulfat  10,6% Mg  '
171S   'Kiseritt  17% Mg  '
171T   'Boraks  16% B  '
171U   'Koppersulfat  25% Cu  '
171V   'Mangansulfat  32% Mn  '
171W   'Natriummolybdat  '
171X   'Frit mikronæringsblanding  '
171Y   'LOG Mikroblanding, vannløsel  '
172Q   'Mikronæringsstoff  '
1754   'Sekundær- og mikronæringsst.  '
172X   'Gjødsel til veksthus  '
171Z   'Sum mikronæringsstoff m.v.  '
1720   'Kalk  '
1721   'Sum hand.gj./kalk (u/tilsk.)  '
1722   'Handelsgj.tilsk. mindre bruk  '
172A   'Bulkrabatt/storsekkrabatt  '
172K   'Andre rabatter  '
1723   'Handelsgjødsel og kalk  '
9905   'Handelsgjødsel og kalk  '
1859   'Kli/gris mv. av imp. matkorn  '
185A   'Mais  '
185B   'Durra, korn og mel  '
185C   'Grøpp/fôrmel. Hvete,rug imp.  '
185D   'Grøpp/fôrmel. Bygg, imp.  '
185E   'Grøpp/fôrmel. Havre,imp.  '
185F   'Melasse  '
185G   'Potetpulver, importert  '
185H   'Annet karbohydratkraftfôr  '
185I   'Sum imp. karbohydratkraftfôr  '
185J   'Kli/gris mv av norsk matkorn  '
185K   'Grøpp/fôrmel.Hvete,rug,norsk  '
185L   'Grøpp/fôrmel.Bygg,     norsk  '
185M   'Grøpp/fôrmel.Havre,    norsk  '
188E   'Korreksjon kraftfôr pelsdyr  '
185N   'Sum norskprod. karbohydratkr  '
185P   'Sum karbohydratkraftfôr  '
185Q   'Kokoskakemel/ekspeller, imp.  '
185R   'Jordnøttekspeller, importert  '
185S   'Linkakemel, importert  '
185T   'Bomullsfrøekspeller, imp.  '
185U   'Soyamel, importert  '
185V   'Rapsmel/skrå, importert  '
185W   'Rapsfrø/oljefrø, importert  '
185X   'Solsikkekakemel/eksp., imp.  '
185Y   'Guarmel, importert  '
185Z   'Hvetekimmel, importert  '
1860   'Fiskemel, importert  '
1862   'Kokoskakemel/eksp.,norskprod  '
1861   'Sum imp. proteinkraftfôr  '
1863   'Jordnøtteksp.,norskprodusert  '
1864   'Linkakemel/frø, norskprod.  '
1865   'Soyamel, norskprodusert  '
1866   'Hvetekimmel, norskprodusert  '
1867   'Sum norskprod. proteinkr.fôr  '
1868   'Oljefrø (raps og rybs),norsk  '
1869   'Sildemel  '
186A   'Fiskemel, norsk  '
186B   'Blodmel  '
186C   'Kjøttbeinmel  '
186D   'Annet proteinkraftfôr  '
186E   'Sum norsk proteinkraftfôr  '
186F   'Sum proteinkraftfôr  '
186G   'Sum karbohydr./proteinkraft.  '
186H   'Kufôr A 12,5 %  '
186I   'Kupellets A 10 %  '
186J   'Kufôr A 15 %  '
187X   'Drøvtyggerfôr <100 AAT  '
187Y   'Drøvtyggerfôr 100-120 AAT  '
187Z   'Drøvtyggerfôr >120 AAT  '
186K   'Elite overgangsfôr  '
186L   'Kufôr C 32 %  '
186M   'Melkefôr, sau/geit  '
186N   'Andre blandinger storfe  '
186P   'Drøvtyggergrøpp  '
186Q   'Mineralkraftfôr, dr.t.  '
186R   'Kalvefôr  '
186S   'Sau- og ungfefôr  '
186T   'Mineralkraftfôr, sau  '
186U   'Andre blandinger sau/geit  '
186V   'Proteinkonsentrat ku  '
1884   'Drøvtyggerfôr  '
1885   'Økologisk drøvtyggerfôr  '
186W   'Sum kraftfôr til drøvtyggere  '
186X   'Svinefôr 1  '
186Y   'Svinefôr 2  '
186Z   'Svinefôr 3  '
1880   'Svinefôr  '
1870   'Diefôr purke  '
1871   'Purkefôr  '
1872   'Smågrisfôr  '
1873   'Apetittfôr svin  '
1874   'Karbohydratgrøpp, svin  '
1875   'Proteinkonsentrat, svin  '
1876   'Andre blandinger svin  '
1886   'Svinefôr  '
1887   'Økologisk svinefôr  '
1877   'Sum kraftfôr til svin  '
1878   'Hønefôr 1  '
1879   'Oppalsfôr  '
187A   'Burhønefôr  '
1881   'Verpefôr  '
187B   'Verpefôr  '
187C   'Rugefôr  '
187D   'Kalsiumrikt rugefôr  '
187E   'Kyllingfôr  '
187F   'Unghønefôr  '
187G   'Oppalsfôr, høns  '
187H   'Kalkunfôr  '
187I   'Broilerfôr  '
187J   'Proteinkonsentrat, fjørfe  '
187K   'Andre blandinger fjørfe  '
1888   'Fjørfefôr u. koksidiostatika  '
1889   'Fjørfefôr m. koksidiostatika  '
188A   'Økologisk fjørfefôr  '
187L   'Sum kraftfôr til fjørfe  '
187M   'Hestepellets (hestefôr)  '
187P   'Fôrklistret hvete  '
188B   'Hel/knust havre  '
188C   'Økologisk hestefôr  '
188D   'Kaninfôr  '
187Q   'Karbohydratgrøpp med vit.  '
187R   'Fiskemel  '
187S   'Andre fôrblandinger  '
187T   'Sum kraftfôr, andre husdyr  '
187U   'Sum kraftfôrbland. ukorr.  '
187V   'Grøpp av salgskorn  '
187W   'Sum innkjøpt kraftfôr ukorr.  '
1853   'Tillegg for ferdigbl. varer  '
1854   'Antibiotika  '
1855   'Bulk og kvantumsrabatt  '
1856   'Leiemalt i blandinger  '
183J   'Sum innkjøpt kraftfôr korr.  '
183K   'Kraftfôrrabatt  '
183L   'Kraftfôrrab.,ekstratildeling  '
183M   'Bulkrabatt  '
1882   'Rabatter og bonus  '
1883   'Småsekketillegg  '
183N   'Innkjøpt kraftfôr  '
1904   'Mineralnæring  '
1905   'Tran og vitaminer  '
1906   'Tilskuddsfôr  '
1907   'Høy, importert  '
190U   'Halm, importert  '
1908   'Grasmel  '
1909   'Reguleringspoteter  '
190A   'Forkalk  '
190B   'Skjellsand  '
190C   'Melkeerstatninger  '
190D   'Tangmel  '
190E   'Forgjær  '
190F   'Herdet fôrfett  '
190G   'Salt  '
190H   'Annet mineralfôr  '
190I   'Hvalkjøtt  '
190N   'Organisk våtfôr  '
190P   'Skummet melk  '
190Q   'Myse  '
190R   'Skummet tørrmelk  '
190W   'Sukker/biefôr  '
190S   'Annet innkjøpt fôr  '
9906   'Sum innkjøpt fôr  '
200P   'Innkjøpt såkorn. Hvete  '
200Q   'Innkjøpt såkorn. Rug  '
200R   'Innkjøpt såkorn. Bygg  '
200S   'Innkj. såkorn. Havre/bl.korn  '
200T   'Innkjøpt såkorn. Rughvete  '
200U   'Sum innkjøpt såkorn  '
200V   'Oljefrø til modning  '
2027   'Erter  '
201Z   'Importert engfrø. Timotei  '
2020   'Importert engfrø. Kløver  '
2021   'Imp. engfrø. Hundegras m.v.  '
2022   'Importert engfrø. Grønnfôr  '
2023   'Sum importert engfrø  '
2024   'Norskprod. engfrø.Omsetn.av.  '
2025   'Norskprodusert engfrø  '
2028   'Engfrø  '
2026   'Sum engfrø  '
201R   'Imp. frø. Fôrnepe/kålrot  '
201S   'Imp. frø. Fôrbete  '
201T   'Imp. frø. Andre rotv.  '
201U   'Sum importert rotvekstfrø  '
201V   'Importert grønnsakfrø  '
201W   'Oms.av. rot- og gr.saksfrø  '
201X   'Norskprod. rotv- og gr.frø  '
201Y   'Sum rotvekst- og grønnsakfrø  '
201Q   'Annet frø,imp. (prydplanter)  '
201L   'Kjøp settepoteter  '
201M   'Blomsterløk m.v.  '
201N   'Planteartikler  '
201P   'Sum planter  '
201H   'Sum såfrø/planter (u.tilsk)  '
201I   'Statstilskudd  '
201J   'Såfrø og planter  '
210W   'Fyringsolje. Veksthus  '
2118   'Bioenergi i veksthus  '
2117   'Gass i veksthus  '
210X   'Fyringsolje. Korntørker  '
210Y   'Bensin  '
210Z   'Refundert bensinavgift  '
2110   'Investeringsavgift. Bensin  '
2111   'Refundert inv.avg. Bensin  '
2112   'Diesel (brenselolje)  '
2113   'Smøremidler (olje,fett m.v.)  '
2114   'Petroleum til lys  '
211B   'Bioenergi i jordbruk  '
211C   'Gass til jordbruk  '
2115   'Elektrisk lys og kraft  '
2119   'Elektrisitet, jordbruk  '
211A   'Elektrisitet, veksthus  '
2116   'Sum energi og smøremidler  '
2200   'Kostn. v/leiemaling av korn  '
2201   'Rensing av såkorn  '
2202   'Rensing av engfrø  '
2246   'Ensileringsmidler  '
2203   'Ensileringsmid. Reymersholm  '
2204   'Ensileringsmid. Maursyre  '
2205   'Ensileringsmid. Kofasalt  '
2206   'Ensileringsmid. Casco  '
2207   'Ensileringsmid. A.I.V.-syre  '
2208   'Ensileringsmiddel. Foraform  '
2243   'GrasAAT  '
2209   'Halmbeh.middel. Natronlut  '
220A   'Halmbeh.middel.Kaustisk soda  '
220B   'Halmbeh.middel. Ammoniakk  '
220C   'Plantevernmidler  '
220D   'Hesjetråd  '
220E   'Investeringsavgift.Hesjetråd  '
220F   'Sum hesjetråd  '
220G   'Selvbindergarn  '
220H   'Inv.avgift. Selvbindergarn  '
220I   'Sum selvbindergarn  '
220J   'Frakt. Korn og oljefrø  '
220K   'Frakt. Handelsgjødsel  '
220L   'Frakt. Poteter  '
224G   'Frakt. Matpoteter  '
220M   'Frakt. Halm og annet stråfôr  '
220N   'Frakt. Grønnsaker  '
220P   'Frakt. Bær  '
220Q   'Frakt. Blomster  '
220R   'Frakt. Frukt  '
220S   'Sum frakt. Hagebruksprod.  '
220T   'Fiberduk  '
220U   'Investeringsavg. Fiberduk  '
220V   'Fiberduk inkl. inv.avgift  '
220W   'Plastfolie  '
220X   'Investeringsavg. Plastfolie  '
220Y   'Plast i jordbruket  '
220Z   'Inv.avgift plast i jordbr.  '
223Z   'Plastfolie i hagebruket  '
2241   'Inv.avg. plastf. i hagebr.  '
2240   'Plastfolie i jordbruket  '
2242   'Inv.avg. plastf. i jordbr.  '
2210   'Plastfolie inkl. inv.avgift  '
2211   'Sortering. Poteter  '
2212   'Emballasje. Korn  '
2213   'Emballasje. Poteter  '
2214   'Embal.Gr.s./bær.Bølgepapp  '
2215   'Embal.Gr.s./bær.Trekasser  '
2216   'Embal.Gr.s./bær.Papirsekker  '
2217   'Embal.Gr.s./bær.Bomullsekker  '
2218   'Embal.Gr.s./bær.Plastp./sek.  '
2219   'Embal.Gr.s./bær.Pl.korg. o.l  '
221A   'Emballasje. Eksp. polystyren  '
224J   'Sortering. Grønnsaker  '
2248   'Embal./sortering. Grønnsaker  '
221B   'Embal.Gr.s./bær.Annen embal.  '
221D   'Emballasje. Frukt  '
221E   'Emb. Frukt. Eksp.polystyren  '
2249   'Emballasje. Frukt og bær  '
221F   'Emballasje. Blomster  '
224A   'Emballasje. Blomster  '
221G   'Sum emballasje. Hagebrukspr.  '
221H   'Torv- og plastpotter  '
221I   'Dyrkingstorv  '
221J   'Bark-kompost  '
221K   'Steinullmatter (vekstmedium  '
221L   'Sinders, kull og koks  '
224K   'Avrenspotet  '
221P   'Sum andre kostn. v/pl.prod.  '
221Q   'Veterinær  '
221R   'Medisin til dyr  '
221S   'Inv.avgift. Veterinærmedisin  '
221U   'Veterinær og medisin til dyr  '
221V   'Kunstig inseminasjon. Storfe  '
221W   'Kunstig inseminasjon. Svin  '
221X   'Husdyrforsikring  '
224C   'Husdyrforsikring. Premie  '
224D   'Husdyrforsikring. Erstatning  '
221Y   'Frakt. Kraftfôr  '
224L   'Frakt. Grovfôr  '
221Z   'Frakt. Melk  '
2220   'Frakt. Kjøtt  '
2222   'Hesteskoing  '
2223   'Hestesko m.v.  '
2224   'Investeringsavg. Hestesko  '
2225   'Hestesko m.v. inkl. inv.avg.  '
2226   'Sum hesteskoing/hestesko mv  '
2227   'Silvatt og filter  '
2245   'Adm.geb. kjøp melkekvote  '
224I   'Destruksjon av høns  '
2229   'Sum a. kostn. v/husdyrprod.  '
222I   'Skadefors. maskiner netto  '
224B   'Skadefors. mask. m.v. brutto  '
222J   'Erstatninger på maskiner  '
222K   'Sum netto skadefors. maskin.  '
222L   'Eiendomsskatt  '
222P   'Frakt. Sinders, kull og koks  '
222Q   'Frakt. Fyringsolje  '
222R   'Frakt. Ensileringsmidler  '
222S   'Frakt. Natronlut/kaust. soda  '
222T   'Frakt. Såvarer  '
222U   'Frakt. Høy  '
222V   'Sum diverse frakter  '
2247   'Kontormaskiner  '
222X   'Teletjenester  '
222Y   'Porto  '
222Z   'Sum telefon og porto  '
223C   'Yrkesskadeforsikring  '
223D   'Personskadeavgift til staten  '
224H   'Årsavgift  '
2230   'Produsenttjenesten  '
2231   'Gårdsregnskap, registrert  '
2232   'Gårdsregnskap, ikke-reg.  '
2233   'Sum gårdsregnskap  '
2234   'Skadeforsikring på bygninger  '
224E   'Bygningsforsikr. Premie  '
224F   'Bygningsforsikr. Erstatning  '
223I   'Premie friv. sjuk.l.ordn.  '
223J   'Utb.trygd friv. sjuk.l.ordn.  '
224M   'Korreksj. kostn. pelsdyrhold  '
224N   'Ekstrakostn. koronapandemi  '
224P   'Leie av arbeid  '
224O   'Jordleie  '
224Q   'Kvoteleie  '
2236   'Sum diverse andre kostnader  '
2237   'Sum ekskl.posten forskjellig  '
2238   'Forskjellig  '
2239   'Invest.avgift. Forskjellig  '
223A   'Forskjellig inkl. inv.avgift  '
223V   'Utgifter til sjuk.lønn.ordn.  '
223X   'Medlemsavgift folketrygden  '
2244   'Adm.tilskudd til avløserlag  '
223Y   'Sum sosiale ordninger  '
223B   'Andre kostnader  '
2306   'Vedlikehold. Bygninger  '
2307   'Vedlikehold. Mask. og redsk.  '
2308   'Vedlikehold. Biler  '
2309   'Sum vedlikehold  '
0006   'Sum ikke-varige prod.midler  '
240K   'Leasing, kapitalslitdel  '
240L   'Leasing, rentedel  '
240M   'Leasing, effekt finansiering  '
240J   'Sum leasing av maskiner  '
2519   'Kapitalslit. Ma./t.u. dr.b.  '
251H   'Fast teknisk inventar  '
251I   'Bygningsinventar  '
251A   'Kapitalslit. Driftsbygninger  '
251F   'Kapitalslit. Sum driftsb.  '
251B   'Kapitalslit. Maskiner/redsk.  '
251C   'Kapitalslit. Biler  '
251D   'Kapitalslit. Grøfter  '
251E   'Kapitalslit. Hydrotekn. anl.  '
251G   'Kapitalslit. Delsum  '
2518   'Kapitalslit  '
000N   'Sum kapitalkostnader  '
0007   'Sum kostnader  '
260T   'Pantelån. Statsbanker  '
260U   'Pantelån. Kredittforeninger  '
260V   'Pantelån. Offentlige fonds  '
260W   'Pantelån. Forsikringsselsk.  '
260X   'Pantelån.Investeringslån LUF  '
260Y   'Pantelån.Off.banker/fond,mv.  '
260Z   'Pantelån.Andre bank/priv.lån  '
2610   'Veksellån og vekselobligasj.  '
2611   'Kassakred. m.v. Rentebærende  '
2612   'Kassakred. m.v. Ikke renteb.  '
2613   'Rentekostn. på lånt kapital  '
2614   'Nedbetalingslån statsbanker  '
2615   'Nedbetalingslån sparebanker  '
2616   'Nedbetalingslån forr.banker  '
2617   'Nedb.lån kr.for. og fin.sel.  '
2618   'Nedbetalingslån fors.selsk.  '
2619   'Nedb.lån andr. lång. t. 1996  '
261A   'Nedb.lån andr. lång. f. 1997  '
261B   'Sum nedbetalingslån  '
261C   'Kreditter sparebanker  '
261D   'Kreditter forr.banker  '
261E   'Kreditter andre långivere  '
261F   'Sum kreditter  '
261G   'Sum rentebærende utlån  '
261H   'Investeringslån LUF  '
261M   'Korreksjon bortleide bruk  '
261L   'Korreksjon gjeld og renter  '
261I   'Rentekostnader lånt kapital  '
261J   'Effekt av finansiering  '
261K   'Realrente lånt kapital  '
282P   'Rentekostn. på egen kapital  '
0008   'Sum inntekter (ekskl. korn)  '
0009   'Jordbrukets nettoprodukt  '
000A   'Vederlag, arbeid og kapital  '
000P   'Ved.lag, arb./kap. per årsv.  '
000B   'Vederlag, arbeid og egenkap.  '
000Q   'V.lag, arb./eg.kap.per årsv.  '
000C   'Beregnet total arb.inntekt  '
310B   'Mask. og tekn. utst. dr.byg.  '
310O   'Fast teknisk inventar  '
310P   'Bygningsinventar  '
310C   'Driftsbygninger  '
310N   'Sum driftsbygninger  '
310D   'Maskiner og redskaper  '
310E   'Biler  '
310F   'Grøfter  '
310G   'Hydrotekniske anlegg  '
310H   'Sum avskrivb. bruttoinvest.  '
310I   'Fulldyrking u. grøftekostn.  '
310J   'Overfl.dyrk. u. grøftekostn.  '
310K   'Senkingsarbeider  '
310L   'Planering  '
310M   'Sum br.invest.uavskr.jordkap  '
310A   'Sum bruttoinvesteringer  '
3200   'Bygninger (vedlikehold)  '
3201   'Imp.og norskprod.mask./redsk  '
3202   'Vanningsanlegg  '
3203   'Reg.utstyr,maskiner/redskap.  '
3204   'Brukte maskiner/redskaper  '
3205   'Vedlikehold,maskiner/redsk.  '
3206   'Sum inv.avg.,maskiner/redsk.  '
3207   'Investeringsavgift, biler  '
3208   'Investeringsavgift, grøfter  '
3209   'Sum inv.avg.,  kapitalvarer  '
3300   'Bygninger  '
3301   'Maskiner og redskaper  '
3302   'Biler  '
3303   'Grøfter  '
3305   'Hydrotekniske anlegg  '
3304   'Sum gjenanskaffelsesverdi  '
340I   'Teknisk inst. bygninger  '
340L   'Fast teknisk inventar  '
340M   'Bygningsinventar  '
340J   'Driftsbygninger  '
340K   'Sum driftsbygninger  '
3401   'Maskiner og redskaper  '
3402   'Biler  '
3403   'Grøfter  '
340B   'Hydrotekniske anlegg  '
3404   'Sum avskrivbare bruttoinv.  '
3405   'Fulldyrking  '
3406   'Overflatedyrking  '
3407   'Senkingsarbeider  '
3408   'Planering  '
3409   'Sum br.inv.i uavskr.jordkap.  '
340C   'Inv.prisind. Bygninger  '
340D   'Inv.prisind. Maskiner/redsk.  '
340E   'Inv.prisind. Biler  '
340F   'Inv.prisind. Grøfter  '
340G   'Inv.prisind. Hydrotekn. anl.  '
340H   'Sum inv.prisindeks  '
340A   'Sum bruttoinvesteringer  '
3500   'Gjenansk. verdi bygninger  '
3501   'Gjenansk. verdi mask./redsk.  '
3502   'Gjenansk. verdi biler  '
3503   'Gjenansk. verdi grøfter  '
3505   'Gjenansk. verdi hydrot. anl.  '
3504   'Sum gjenanskaffelsesverdi  '
3600   'Teknisk inst. bygninger  '
360H   'Bygningsinventar  '
360G   'Fast teknisk inventar  '
3601   'Driftsbygninger  '
3602   'Sum driftsbygninger  '
3603   'Maskiner og redskaper  '
3604   'Biler  '
3605   'Grøfter  '
3606   'Hydrotekniske anlegg  '
3607   'Sum avskrivbar kapital  '
3608   'Jord  '
3609   'Tillegg leiejord  '
360A   'Husdyr  '
360B   'Varer i arbeid  '
360C   'Sum ikke-avskrivbar kapital  '
360D   'Sum kapital  '
360E   'Lånt kapital  '
360F   'Egenkapital  '
370E   'Teknisk inst. bygninger  '
370H   'Fast teknisk inventar  '
370I   'Bygningsinventar  '
370F   'Driftsbygninger  '
370G   'Sum driftsbygninger  '
3701   'Maskiner og redskaper  '
3702   'Biler  '
3703   'Grøfter  '
3704   'Hydrotekniske anlegg  '
3705   'Sum avskrivbar kapital  '
3706   'Jord  '
3707   'Tillegg leiejord  '
3708   'Husdyr  '
3709   'Varer i arbeid  '
370A   'Sum ikke-avskrivbar kapital  '
370B   'Sum kapital  '
370C   'Lånt kapital  '
370D   'Egenkapital  '
3800   'Melkepris referansebruk  '
3900   'Statens fagtj. for landbr.  '
3901   'Landbruksetatene  '
390P   'Jordbrukset. i fylk. og kom.  '
390Q   'Videregå. oppl. i jordbr. mm  '
3902   'NLH  '
3903   'NILF  '
390R   'Landbruksteknisk institutt  '
3904   'NLVF  '
390S   'Annen utred. og utv.virks.  '
3905   'Fylkesvet./distr.vet.  '
3906   'Statens vet. lab.senter  '
3907   'Veterinære laboratorier  '
3908   'Veterinærutdanning  '
3909   'Statens vet. fors.g. småfe  '
390A   'Tilsk. til inv.tilt. jordbr.  '
390B   'Jordskifte  '
390C   'NIJOS  '
390D   'Andre ressurstiltak  '
390E   'Statens plantevern  '
390F   'Statens forskn.stasj. landb.  '
390G   'Tiltaksf. småfe og fjørfe  '
390Z   'Tilskudd norsk engfrøavl  '
390H   'Avsetningstiltak  '
390I   'Tilsk. til reguleringsanlegg  '
390J   'Tilsk. til forsøksr./forskn.  '
391E   'Dist.tilsk. potet Nord-Norge  '
390K   'Tilsk. til norsk ull  '
3915   'Tilsk. til økologisk landbr.  '
3916   'Sort.- og lageranl. potet  '
390L   'Frakttilskudd kjøtt og flesk  '
3917   'Frakttilskudd for frukt  '
3918   'Grunntilskudd epler og pærer  '
390M   'Frakttilskudd kalk  '
3913   'Korr. for vann og kvalitet  '
3914   'Korntrygd  '
390T   'Pristilskudd på norsk korn  '
390U   'Avg. fôr fra utenf. jordbr.  '
390V   'Justerte fôrkostnader  '
390W   'Avg. kunstgj. og plantev.m.  '
391F   'Høns-/kyllingsl. reg. salg  '
3919   'Sum poteter fratr. hj.forbr.  '
390X   'Kvalitetstilskudd på egg  '
391A   'Distr./kval.t. fr./bær/gr.s.  '
391B   'Prod./salgsfr. tilt. fr./bær  '
390Y   'Rentestøtte  '
391C   'Tilskudd til fruktlager  '
391D   'Grunntilskudd på poteter  '
3910   'Kvalitetstillegg poteter  '
391G   'Tørrstofftillegg poteter  '
391I   'Frakttilskudd på poteter  '
3911   'Grunntilskudd på melk  '
3912   'Grunntilskudd på slakt  '
391H   'Forbrukersubsidier på melk  '
391J   'Sum budsjettstøtte  '
4000   'Avling just. for vann. Hvete  '
4001   'Avling just. for vann. Rug  '
4002   'Avling just. for vann. Bygg  '
4003   'Avling just. for vann. Havre  '
4004   'Avling just.for vann.Bl.korn  '
4005   'Avling just. for vann. Korn  '
4006   'Ffe-avling (20% vann). Hvete  '
4007   'Ffe-avling (20% vann). Rug  '
4008   'Ffe-avling (20% vann). Bygg  '
4009   'Ffe-avling (20% vann). Havre  '
400A   'Ffe-avling (20%vann).Bl.korn  '
400B   'Ffe-avling (20% vann). Korn  '
400C   'Sum salg. Hvete  '
400D   'Sum salg. Rug  '
400E   'Sum salg. Bygg  '
400F   'Sum salg. Havre og blandkorn  '
400G   'Sum salg. Korn  '
400H   'Såkornbehov. Hvete  '
400I   'Såkornbehov. Rug  '
400J   'Såkornbehov. Bygg  '
400K   'Såkornbehov. Havre  '
400L   'Såkornbehov. Blandkorn  '
400M   'Såkornbehov. Sum  '
400N   'Såkorn, hj.forbruk. Hvete  '
400P   'Såkorn, hj.forbruk. Rug  '
400Q   'Såkorn, hj.forbruk. Bygg  '
400R   'Såkorn, hj.forbruk. Havre  '
400S   'Såkorn, hj.forbruk. Bl.korn  '
400T   'Såkorn, hj.forbruk. Sum  '
400U   'Leiemalt korn. Hvete  '
400V   'Leiemalt korn. Rug  '
400W   'Leiemalt korn. Bygg  '
400X   'Leiemalt korn. Havre  '
400Y   'Leiemalt korn. Sum  '
400Z   'Helt korn til fôr. Hvete  '
4010   'Helt korn til fôr. Rug  '
4011   'Helt korn til fôr. Bygg  '
4012   'Helt korn til fôr. Havre/blk  '
4013   'Helt korn til fôr. Sum  '
4014   'Sum korn til fôr. Hvete  '
4015   'Sum korn til fôr. Rug  '
4016   'Sum korn til fôr. Bygg  '
4017   'Sum korn til fôr. Havre/bl.k  '
4018   'Sum korn til fôr. Totalt  '
4019   'Korn til fôr,kal.år. Hvete  '
401A   'Korn til fôr,kal.år. Rug  '
401B   'Korn til fôr,kal.år. Bygg  '
401C   'Korn til fôr,kal.år. Havre/b  '
401D   'Korn til fôr,kal.år. Sum  '
401E   'Balanse. Hvete  '
401F   'Balanse (svinn mv.). Rug  '
401G   'Balanse (svinn mv.). Bygg  '
401H   'Balanse (svinn mv.). Havre/b  '
401I   'Balanse (svinn mv.). Sum  '
4100   'Hvete. Salg, matkornkvalitet  '
4101   'Hvete. Salg, fôrkornkvalitet  '
4102   'Hvete. Salg, såkornkvalitet  '
4103   'Hvete. Hjemmeforbruk,matkorn  '
4104   'Hvete. Salg og hjemmeforbruk  '
4105   'Rug. Salg, matkornkvalitet  '
4106   'Rug. Salg, fôrkornkvalitet  '
4107   'Rug. Salg, såkornkvalitet  '
4108   'Rug. Hjemmeforbruk, matkorn  '
4109   'Rug. Salg og hjemmeforbruk  '
410A   'Bygg. Salg, matkornkvalitet  '
410B   'Bygg. Salg, fôrkornkvalitet  '
410C   'Bygg. Salg  '
410D   'Bygg. Salg, såkornkvalitet  '
410E   'Bygg. Hjemmeforbruk, matkorn  '
410F   'Bygg. Salg og hjemmeforbruk  '
410G   'Havre. Salg, matkornkvalitet  '
410H   'Havre. Salg, fôrkornkvalitet  '
410I   'Havre. Salg  '
410J   'Havre. Salg, såkornkvalitet  '
410K   'Havre. Hjemmeforbr.,matkorn  '
410L   'Havre. Salg og hjemmeforbruk  '
410M   'Sum korn (u/korreksj./tilsk)  '
410N   'Korreksjon for vann/kvalitet  '
410P   'Oljefrø  '
410Q   'Sum korn, oljefrø (u/tilsk.)  '
410R   'Korntrygd  '
410S   'Særtillegg. Bygg  '
410T   'Kontantstøtte  '
410U   'Tillegg for løslevering  '
410V   'Geogr.prod.tillegg for korn  '
410W   'Korn, erter og oljefrø  '
4500   'Traktorer, import  '
4501   'Traktorer, bestand per 31.12  '
4502   'Skurtreskere, import  '
4503   'Skurtreskere, bst. per 31.12  '
4900   'Inntektsverdi før skatt  '
5800   'Timeverk i jordbruket  '
5801   'Årsverk i jordbruket  '
5900   'Hvete (St. Kornf.)  '
5901   'Rug (St. Kornf.)  '
5902   'Bygg (St. Kornf.)  '
5903   'Havre/bl.korn (St. Kornf.)  '
5904   'Oljevekster (St. Kornf.)  '
5905   'Poteter (Spesial/Hoveid)  '
6000   'Hvete  '
6001   'Rug  '
6002   'Bygg  '
6003   'Havre  '
6004   'Blandkorn og erter  '
6005   'Sum korn  '
6006   'Oljevekster til modning  '
6007   'Sum korn,erter og oljevekst.  '
6008   'Potet  '
6009   'Rotvekster, fôrnepe/ kålrot  '
600A   'Rotvekster, fôrbete  '
600B   'Rotvekster  '
600C   'Sum rotvekster  '
600D   'Grønnfôr/silo, fôrmargkål  '
600E   'Grønnfôr/silo,1-årig raigras  '
600F   'Grønnfôr/silo, kornvekster  '
600G   'Grønnfôr/silo, oljevekster  '
600H   'Sum grønnfôr/silovekster  '
600I   'Brakk  '
600J   'Blindpost  '
600K   'Kulturbeite fulldyrket jord  '
600L   'Kulturbeite natureng m.v.  '
600M   'Sum kulturbeite  '
600N   'Eng til slått. Fulldyrket jo  '
600P   'Eng til slått. Natureng m.v.  '
600Q   'Eng til slått. 1. Slått. Høy  '
600R   'Eng til slått. Ettersl. Høy  '
600S   'Eng til slått. 1.Slått. Silo  '
600T   'Eng til slått. Ettersl. Silo  '
600U   '1. Slått. Oppfôra ferskt  '
600V   'Etterslått. Oppfôra ferskt  '
600W   'Eng til frø  '
600X   'Blindpost  '
600Y   'Håbeite etter eng til slått  '
600Z   'Kulturbeite  '
6010   'Herav fulldyrk. jord i drift  '
6011   'Sum jordbruksvekstene  '
6100   'Blomkål  '
6101   'Sommer-og høsthvitkål  '
6102   'Vinterhvitkål  '
6103   'Sum hvitkål  '
6104   'Gulrot  '
6105   'Purre  '
6106   'Matløk  '
6107   'Salatagurk under glass  '
6108   'Tomater under glass  '
6109   'Rosenkål  '
610A   'Kinakål  '
610B   'Annen kål 1  '
610C   'Annen kål 2  '
610D   'Rødkål, broccoli mv  '
610E   'Bønner  '
610F   'Hageerter  '
610G   'Stilkselleri  '
610H   'Knollselleri  '
610I   'Selleri  '
610J   'Agurk. Friland  '
610K   'Rødbeter  '
610L   'Tomater. Friland  '
610M   'Rabarbra  '
610N   'Persillerot  '
610P   'Kålrot til mat  '
610Q   'Salat. Friland  '
610R   'Salat under glass/plast  '
610S   'Issalat, friland  '
610T   'Issalat u. glass/plast  '
610U   'Sum grønnsaker  '
610V   'Andre uspesifis. grønnsaker  '
610W   'Kjøkkenhager  '
610X   'Kjøkkenh. og uspes. grø.sak.  '
610Y   'Sopp. Kultivert  '
610Z   'Sopp. Fra skog og mark  '
6110   'Sum grønnsaker og sopp  '
6209   'Epler  '
6203   'Pærer  '
6204   'Plommer  '
6205   'Moreller og kirsebær  '
6206   'Surkirsebær  '
6207   'Søtkirsebær(moreller)  '
6208   'Sum frukt  '
6300   'Jordbær  '
6301   'Bringebær  '
6302   'Solbær  '
6303   'Stikkelsbær  '
6304   'Rips  '
6305   'Skogsbær  '
6306   'Sum bær (hage og skogsbær)  '
6400   'Poteter. Villahager  '
6401   'Grønnsaker. Villahager  '
6402   'Frukt. Villahager  '
6403   'Bær. Villahager  '
6404   'Sum. Villahager  '
6600   'Hester  '
6601   'Kalver under 1 mnd  '
6602   'Oksekalver under 1 år  '
6603   'Kvigekalver under 1 år  '
6604   'Sum storfe under 1 år  '
6605   'Okser over 1 år  '
6606   'Kviger  '
6607   'Kyr  '
6608   'Sum storfe  '
6609   'Sauer under 1 år (lam)  '
660A   'Sauer over 1 år (vinterfôra)  '
660B   'Sum sau  '
660C   'Geiter under 1 år  '
660D   'Geiter over 1 år  '
660E   'Sum geiter  '
660F   'Gris. Slaktegris  '
660G   'Ungpurker > 3mnd, uparret  '
660H   'Gris. Avlsgris over 6/3 mnd.  '
660I   'Sum gris  '
660J   'Kyllinger  '
660K   'Høner  '
660L   'Sum høner  '
660Q   'Sum husdyrbestand  '
6700   'Sauer under 1 år (lam)  '
6701   'Sauer over 1 år (vinterfôra)  '
6702   'Sum sau  '
000D   'Konsumprisindeksen  '
000J   'Prisindeks jord/veg. mod.br.  '
000E   'Tømmerpris i modellbruk  '
7000   'Kli/gris mv. av imp. matkorn  '
7001   'Mais  '
7002   'Durra, korn og mel  '
7003   'Grøpp/fôrmel. Hvete,rug imp.  '
7004   'Grøpp/fôrmel. Bygg, imp.  '
7005   'Grøpp/fôrmel. Havre,imp.  '
7006   'Melasse  '
7007   'Potetpulver, importert  '
7008   'Annet karbohydratkraftfôr  '
7009   'Sum imp. karbohydratkraftfôr  '
700A   'Kli/gris mv av norsk matkorn  '
700B   'Grøpp/fôrmel.Hvete,rug,norsk  '
700C   'Grøpp/fôrmel.Bygg,     norsk  '
700D   'Grøpp/fôrmel.Havre,    norsk  '
700E   'Sum norskprod. karbohydratkr  '
700F   'Sum karbohydratkraftfôr  '
700G   'Kokoskakemel/ekspeller, imp.  '
700H   'Jordnøttekspeller, importert  '
700I   'Linkakemel, importert  '
700J   'Bomullsfrøekspeller, imp.  '
700K   'Soyamel, importert  '
700L   'Rapsmel/skrå, importert  '
700M   'Rapsfrø/oljefrø, importert  '
700N   'Solsikkekakemel/eksp., imp.  '
700P   'Guarmel, importert  '
700Q   'Sum importert oljemel  '
700R   'Hvetekimmel, importert  '
700S   'Fiskemel, importert  '
700T   'Sum imp. proteinkraftfôr  '
700U   'Kokoskakemel/eksp.,norskprod  '
700V   'Jordnøtteksp.,norskprodusert  '
700W   'Linkakemel/frø, norskprod.  '
700X   'Soyamel, norskprodusert  '
700Y   'Sum norskprod. oljemel  '
700Z   'Hvetekimmel, norskprodusert  '
7010   'Sum norskprod. proteinkr.fôr  '
7011   'Oljefrø (raps og rybs),norsk  '
7012   'Sildemel  '
7013   'Fiskemel, norsk  '
7014   'Blodmel  '
7015   'Kjøttbeinmel  '
7016   'Annet proteinkraftfôr  '
7017   'Sum norsk proteinkraftfôr  '
7018   'Sum proteinkraftfôr  '
7019   'Sum karbohydr./proteinkr.fôr  '
701A   'Tillegg for ferdigbl. varer  '
701B   'Antibiotika  '
701C   'Bulk og kvantumsrabatt  '
701D   'Sum karbohydr./proteinkr.fôr  '
701E   'Kraftfôrrabatt  '
701F   'Kraftfôrrab.,ekstratildeling  '
701G   'Innkjøpt kraftfôr  '
7100   'Skummet melk  '
7101   'Myse  '
7102   'Skummet tørrmelk  '
7103   'Innkj. melkeprod. til fôr  '
7200   'Mineralnæring  '
7201   'Tran og vitaminer  '
7202   'Høy, importert  '
7203   'Grasmel  '
7204   'Reguleringspoteter  '
7205   'Forkalk  '
7206   'Skjellsand  '
7207   'Melkeerstatninger  '
7208   'Tangmel  '
7209   'Forgjær  '
720A   'Herdet fôrfett  '
720B   'Salt  '
720C   'Annet mineralfôr  '
720D   'Hvalkjøtt  '
720E   'Slakteriavfall  '
720F   'Fisk og fiskeavfall  '
720G   'Blod  '
720H   'Fett  '
720I   'Annet innkjøpt fôr  '
7300   'Brakk  '
7301   'Brakk  '
7302   'Grønnsaker  '
7303   'Sum bærareal  '
7304   'Sum areal  '
7305   'Antall slakt sau, lam, geit  '
7306   'Sum antall dyr slakt  '
7307   'Korn til fôr  '
7308   'Oljevekster til fôr  '
7309   'Sum fôrtilgang  '
730A   'Antall kalver  '
730B   'Antall kviger  '
730C   'Antall kyr  '
730D   'Antall voksne storfe  '
730E   'Antall melkeku > 2 år  '
730F   'Antall andre kuer > 2 år  '
730G   'Antall purker (desember)  '
730H   'Antall griser  '
730I   'Antall verpehøns  '
730J   'Sum søyer/søyelam (desember)  '
730K   'Sum geiter og killinger  '
730L   'Antall hester  '
730M   'Sum antall levende dyr  '
730N   'Kvigeslakt  '
730P   'Kuslakt  '
730Q   'Slakt, voksne storfe  '
730R   'Sum sau og geit  '
730S   'Myse til fôr  '
730T   'Rugeegg  '
730U   'Sum antall slakt  '
730V   'Prod.verd. storfe og kalv  '
730W   'Prod.verd. sau og geit  '
730X   'Sum produksjonsverdi  '
730Y   'Sum energiposter  '
730Z   'Uvarige driftsmidler  '
7310   'Sum budsjettstøtte  '
7311   'Sum jordleie  '
7312   'Sum leid arbeid  '
7313   'Bruttoprodukt  '
7314   'Vederlag arbeid, kap., kapsl  '
7315   'Sum andre elementer  '
7316   'Arbeidsforbruk i AWU  '
7317   'Sum arbeidsforbruk i AWU  '
7318   'Spedkalv  '
7319   'Kalver 4-8 uker  '
731A   'Kalver for slakt  '
731B   'Unge okser  '
731C   'Griser  '
731D   'Smågriser  '
731E   'Sau > 12 mndr  '
731J   'Lam 2-12 mndr  '
731K   'Kyllinger  '
731F   'Sum livdyr  '
731G   'Engrospris på fôrhvete  '
731H   'Sum fôrråstoffer  '
731I   'Sum SPEL-poster  '
800S   'Hvete  '
800T   'Rug/rughvete  '
800U   'Bygg  '
800V   'Havre  '
800W   'Erter og belgv. til modning  '
800Z   'Oljefrø  '
800X   'Sum korn, erter og oljefrø  '
800K   'Poteter  '
800L   'Rotvekster  '
800M   'Grønnfôr  '
800Y   'Andre grovfôrvekster  '
800N   'Andre vekster og brakk  '
800P   'Åker i alt  '
800Q   'Eng fulld. jord. Slått+beite  '
800E   'Fulldyrk. jord i drift i alt  '
800R   'Overfl.d. jord. Slått+beite  '
800I   'Sum jordbruksareal i drift  '
8100   'Hvete  '
8101   'Rug/rughvete  '
8102   'Bygg  '
8103   'Havre  '
8104   'Erter  '
8105   'Sum korn og erter  '
8106   'Oljefrø  '
8107   'Poteter  '
8108   'Rotvekster  '
8109   'Grønnfôr  '
810A   'Andre grovfôrvekster  '
810B   'Andre åker- og hagevekster  '
810C   'Sum åker og hage  '
810D   'Eng, slått  '
810E   'Eng, beite  '
810F   'Sum eng  '
810G   'Halm  '
810H   'Sum åker og eng  '
810I   'Utmarks- og fjellbeite  '
810J   'Sum avling  '
8200   'Hvete  '
8201   'Rug/rughvete  '
8202   'Bygg  '
8203   'Havre  '
8204   'Erter  '
8205   'Sum korn og erter  '
8206   'Oljefrø  '
8207   'Poteter  '
8208   'Rotvekster  '
8209   'Grønnfôr  '
820A   'Andre grovfôrvekster  '
820B   'Andre åker- og hagevekster  '
820C   'Sum åker og hage  '
820D   'Eng, slått  '
820E   'Eng, beite  '
820F   'Sum eng  '
820G   'Halm  '
820H   'Sum åker og eng  '
820I   'Utmarks- og fjellbeite  '
820J   'Sum avling  '
8300   'Hvete  '
8301   'Rug/rughvete  '
8302   'Bygg  '
8303   'Havre  '
8304   'Erter  '
8305   'Sum korn og erter  '
8306   'Oljefrø  '
8307   'Poteter  '
8308   'Rotvekster  '
8309   'Grønnfôr  '
830A   'Andre grovfôrvekster  '
830B   'Andre åker- og hagevekster  '
830C   'Sum åker og hage  '
830D   'Eng, slått  '
830E   'Eng, beite  '
830F   'Sum eng  '
830G   'Halm  '
830H   'Sum åker og eng  '
830I   'Utmarks- og fjellbeite  '
830J   'Sum avling  '
8400   'Hvete  '
8401   'Rug/rughvete  '
8402   'Bygg  '
8403   'Havre  '
8404   'Erter  '
8405   'Sum korn og erter  '
8406   'Oljefrø  '
8407   'Poteter  '
8408   'Rotvekster  '
8409   'Grønnfôr  '
840A   'Andre grovfôrvekster  '
840B   'Andre åker- og hagevekster  '
840C   'Sum åker og hage  '
840D   'Eng, slått  '
840E   'Eng, beite  '
840F   'Sum eng  '
840G   'Halm  '
840H   'Sum åker og eng  '
840I   'Utmarks- og fjellbeite  '
840J   'Sum avling  '
8500   'Hvete  '
8501   'Rug/rughvete  '
8502   'Bygg  '
8503   'Havre  '
8504   'Erter  '
8505   'Sum korn og erter  '
8506   'Oljefrø  '
8507   'Poteter  '
8508   'Rotvekster  '
8509   'Grønnfôr  '
850A   'Andre grovfôrvekster  '
850B   'Andre åker- og hagevekster  '
850C   'Sum åker og hage  '
850D   'Eng, slått  '
850E   'Eng, beite  '
850F   'Sum eng  '
850G   'Halm  '
850H   'Sum åker og eng  '
850I   'Utmarks- og fjellbeite  '
850J   'Sum avling  '
8600   'Hvete  '
8601   'Rug/rughvete  '
8602   'Bygg  '
8603   'Havre  '
8604   'Erter  '
8605   'Sum korn og erter  '
8606   'Oljefrø  '
8607   'Poteter  '
8608   'Rotvekster  '
8609   'Grønnfôr  '
860A   'Andre grovfôrvekster  '
860B   'Andre åker- og hagevekster  '
860C   'Sum åker og hage  '
860D   'Eng, slått  '
860E   'Eng, beite  '
860F   'Sum eng  '
860G   'Halm  '
860H   'Sum åker og eng  '
860I   'Utmarks- og fjellbeite  '
860J   'Sum avling  '
8700   'Hvete  '
8701   'Rug/rughvete  '
8702   'Bygg  '
8703   'Havre  '
8704   'Erter  '
8705   'Sum korn og erter  '
8706   'Oljefrø  '
8707   'Poteter  '
8708   'Rotvekster  '
8709   'Grønnfôr  '
870A   'Andre grovfôrvekster  '
870B   'Andre åker- og hagevekster  '
870C   'Sum åker og hage  '
870D   'Eng, slått  '
870E   'Eng, beite  '
870F   'Sum eng  '
870G   'Halm  '
870H   'Sum åker og eng  '
870I   'Utmarks- og fjellbeite  '
870J   'Sum avling  '
8800   'Hester  '
8801   'Kalver < 1 år  '
8802   'Okser > 1 år  '
8803   'Kviger  '
8804   'Melkekyr  '
8805   'Ammekyr  '
8806   'Sum storfe  '
8807   'Sauer  '
8808   'Geiter  '
8809   'Slaktesvin  '
880A   'Avlssvin over 6 mnd.  '
880B   'Sum svin  '
880C   'Høner  '
880D   'Kyllinger  '
880E   'Ender, kalkuner, gjess  '
880F   'Kaniner  '
880J   'Sum husdyr  '
880N   'Sum husdyrstatus  '
8900   'Kumelk  '
8901   'Geitmelk  '
8902   'Sum melk  '
8903   'Storfe  '
8904   'Kalv  '
8905   'Sau/lam  '
8906   'Geit/kje  '
8907   'Hest  '
8908   'Fjørfeslakt  '
8909   'Tamrein  '
890A   'Kaniner  '
890B   'Gris  '
890C   'Sum kjøtt  '
890D   'Egg  '
890E   'Sum husdyrproduksjon  '
9000   'Kli/gris no. matk. hvete/rug  '
9001   'Kli/gris no. matk. bygg  '
9002   'Kli/gris no. matk. havre  '
9003   'Sum leiemalt korn og helkorn  '
9004   'Poteter  '
9005   'Rotvekster  '
9006   'Grønnfôr  '
9007   'Andre grovfôrvekster  '
9008   'Silo og rundballer  '
9009   'Gras  '
900A   'Sum saftig fôr  '
900B   'Eng beregnet som høy  '
900C   'Herav silo, rundbal. og gras  '
900D   'Halm  '
900E   'Sum tørt stråfôr  '
900F   'Beite på innmark  '
900G   'Utmark og fjellbeite  '
900H   'Fôr fra frukt- og grønnsakp.  '
900I   'Sum hjemmeprod. planteprod.  '
900J   'Hjelpefôr og kjøkkenavfall  '
900K   'Melk og myse  '
900L   'Sum hjemmeprodusert fôr  '
900M   'Importert høy  '
900N   'Innkjøpt kraftfôr  '
900P   'Sum fôrtilgang  '
913P   'Imp. kbh.kr.f+kli imp. matk.  '
913Q   'Rent norskprod. kbh.kr.fôr  '
910F   'Sum karbohydratkraftfôr  '
913R   'Imp. p.kr.f. og av imp. rås.  '
913S   'Rent norskprd. proteinkr.fôr  '
9117   'Sum proteinkraftfôr  '
9118   'Sum innkjøpt kraftfôr  '
9119   'Norskavlet korn til fôr  '
911A   'Kli av matkorn til hj.forbr.  '
911B   'Sum kraftfôrforbruk 1959-84  '
913C   'Fôrblandinger drøvtyggere  '
913D   'Fôrblandinger svin  '
913E   'Fôrblandinger fjørfe  '
913F   'Fôrblandinger andre husdyr  '
913H   'Sum fôrbland. inkl. leiemalt  '
913G   'Leiemalt i blandinger  '
913L   'Sum innkj. kraftf. i bland.  '
913I   'Grøpp av salgskorn  '
913J   'Sum innkjøpt kraftfôr  '
913K   'Leiemalt korn og helkorn  '
913M   'Sum kr.f.forbr. f.o.m. 1985  '
913N   'Totalt kraftfôrforbruk  '
9200   'Melkekyr  '
9201   'Ammekyr  '
9202   'Kviger  '
9203   'Okser > 1 år  '
9204   'Kalver < 1 år  '
9205   'Sum storfe  '
9206   'Hester  '
9207   'Sauer > 1 år  '
9208   'Sauer < 1 år  '
9209   'Sum sauer  '
920A   'Geiter > 1 år  '
920B   'Geiter < 1 år  '
920C   'Sum geiter  '
920D   'Svin  '
920E   'Høns. Voksne  '
920F   'Høns. Livkyllinger  '
920G   'Sum høns  '
920H   'Ender, gjess og kylling, mv.  '
920I   'Pelsdyr (fôr i fôrtilg.)  '
920J   'Sum fôrbehov  '
000F   'Storfe markedsbalanse  '
000G   'Sau markedsbalanse  '
000H   'Gris markedsbalanse  '
000I   'Fjørfekjøtt markedsbalanse  '
000K   'Kumelk med grunntilskudd  '
000L   'Storfeslakt med grunntilsk.  '
000M   'Leasing av maskiner  '
*
* Koder som ikke er del av Totalkalkylen med foeres i andredata.gms pga nettoprinsipp i totalkalkylen
112308900000000000      '   Frakttilskudd egg               '
211422010230000000      '   Frakt. Egg                      '

* Inntektsverdi av jordbruksfradrag
999999999999999999      '   Inntektsv. av jordbruksfradag   '
*
* Dummy for andre tilskudd fra PSE
888888888888888888      '   Andre tilskudd fra PSE          '
/;
*
*
*** Definer regnark i Totalkalkylen
*
     SET RARKTOT Regnark i Totalkalkylen /
       MNGD     'Mengde'
       PRIS     'Pris'
       VERD     'Verdi'
/;
*
*** Aktiviteter
*
     SET TK Definisjoner for resultatmaal og totalkalkylen /
       OMFG   Omfang av produksjonen
       PRIS   Produsentpris
       MNGD   Salgsmengde
       VERD   Produksjonsverdi
       TINN   Sum inntekter for produksjoner
       TKST   Sum kostnader for produksjoner
       TTIL   Sum tilskudd for produksjoner
       TDIF   Differane mellom inntekter, kostnader og tilskudd
       TOTV   Totalkalkyeverdi
       TOTM   Totalkalkylemengde
       TOTP   Totalkalkylepris
/;
*
     SET PRDK Produksjoner i primaerjordbruket og naeringsmiddelindustrien /
*
*     ***   Planteproduksjon
*
       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
*
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
       POTE   Poteter
*
       GRNV   Groennsaker i veksthus
       GRNF   Groennsaker paa friland
       EPLE   Frukt paa traer
       AFRU   Annen frukt
       BLOM   Blomster
*
       GFFS   Grovfor paa fulldyrket jord til slatt
       GFFB   Grovfor paa fulldyrket jord til beite
       GFOS   Grovfor paa overflatedyrket jord til slatt
       GFOB   Grovfor paa overflatedyrket jord til beite
       GFIB   Grovfor paa innmarksbeite
       GFUB   Grovfor paa utmark
*
       GFFP   Grasprotein paa fulldyrket jord

*       FLOW   Flower strips
       
       BRAK   Brakklagt areal
*
*     *** Husdyrproduksjon
*
       MKYR   Melkekyr
       AKYR   Ammekyr
       OKSS   Okser til slakt
       KVGS   Kviger til slakt
       KVGO   Kviger til oppdrett
       OKKS   Oksekalver til slakt
       KVKS   Kvigekalver til slakt
       OKKO   Oksekalver til oppdrett
       KVKO   Kvigekalver til oppdrett
*
       GRIS   Slaktegriser
       PURK   Avlspurker
*
       SOEY   Soeye
       LAMS   Lam
       GEIT   Melkegeit
       KJES   Killing
*
       HOEN   Verpehoener
       KYLS   Slaktekyllinger
*
*     *** Produksjoner i meierier
*
       MLKD   Konsummelk dagligvare
       MLKI   Konsummelk industri
       MLKS   Sjokomelk
       YOGH   Yoghurt
       OSTD   Hvitost daglivare
       OSTI   Hvitost industri
       OSTK   Kremost
       OSTM   Mysost
       OSTG   Geitost
       OSTE   Jarlsberg til eksport
       OSTX   Divere oster til eksport
       SKMP   Melkepulver
*
*     *** Produksjoner i slakterier
*
       SLST   Slakting og skjaering av storfe
       SLSA   Slakting og skjaering av saulam
       SLSV   Slakting og skjaering av gris
*
       KDEI   Foredling av kjoettdeig
       KPOL   Foredling av poelser
       KPAL   Foredling av paalegg
       KSPP   Foredling av spekepoelser
       KSPV   Foredling av spekevarer
       KDIV   Foredling av diverse kjoettvarer
*
       KHEL   Hel kylling
       KFIL   Kyllingfilet
       KANT   Annen kylling
*
*     *** Produksjoner i moeller
*
       FDRM   Droevtyggerfor melk
       FDRA   Droevtyggerfor annet
       FSVN   Svinefor
       FKYL   Kyllingfor
       FEGG   Hoenefor
/;
ALIAS(PRDKPRDK,PRDK);
*
*      Alle planteproduksjoner
*
SET PLANTE(PRDK)  /
       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
*
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
       POTE   Poteter
*
       GRNV   Groennsaker i veksthus
       GRNF   Groennsaker paa friland
       EPLE   Frukt paa traer
       AFRU   Annen frukt
       BLOM   Blomster
*
       GFFS   Grovfor paa fulldyrket jord til slatt
       GFFB   Grovfor paa fulldyrket jord til beite
       GFOS   Grovfor paa overflatedyrket jord til slatt
       GFOB   Grovfor paa overflatedyrket jord til beite
       GFIB   Grovfor paa innmarksbeite
       GFUB   Grovfor paa utmark
*
       GFFP   Grasprotein paa fulldyrket jord
*
       BRAK   Brakklagt areal
/;
*
ALIAS(PLANTEPLANTE,PLANTE);
*
*      All tilskuddsberettiget grovforareal
*
SET GROV(PRDK) /
       GFFS   Grovfor paa fulldyrket jord til slatt
       GFFB   Grovfor paa fulldyrket jord til beite
       GFOS   Grovfor paa overflatedyrket jord til slatt
       GFOB   Grovfor paa overflatedyrket jord til beite
       GFIB   Grovfor paa innmarksbeite
       GFFP   Grasprotein paa fulldyrket jord
/;
ALIAS(GROVGROV,GROV);
*
SET GAKF(PRDK) Grovforaktiviteter med full AK-tilskudd /
       GFFS   Grovfor paa fulldyrket jord til slatt
       GFFB   Grovfor paa fulldyrket jord til beite
       GFOS   Grovfor paa overflatedyrket jord til slatt
       GFOB   Grovfor paa overflatedyrket jord til beite
       GFFP   Grasprotein paa fulldyrket jord
/;

SET GAKR(PRDK) Grovforaktiviteter med redusert AK-tilskudd /
       GFIB   Grovfor paa innmarksbeite
/;
*
SET GFSS(PRDK) /
       GFFS   Grovfor paa fulldyrket jord til slatt
       GFOS   Grovfor paa overflatedyrket jord til slatt
       GFFP   Grasprotein paa fulldyrket jord
/;

SET GFBB(PRDK) /
       GFFB   Grovfor paa fulldyrket jord til beite
       GFOB   Grovfor paa overflatedyrket jord til beite
       GFIB   Grovfor paa innmarksbeite
/;
* Grovforaktiviteter paa fulldyrket jord
SET GFFJ(PRDK) /
       GFFS   Grovfor paa fulldyrket jord til slatt
       GFFB   Grovfor paa fulldyrket jord til beite
       GFFP   Grasprotein paa fulldyrket jord
/;
*
* Overflatedyrket jord
*
SET OFLJ(PRDK) /
       GFOS   Grovfor paa overflatedyrket jord til slatt
       GFOB   Grovfor paa overflatedyrket jord til beite
/;
ALIAS(OFLJOFLJ,OFLJ);

SET OVERDYRK(PRDK) /
       GFOS   Grovfor paa overflatedyrket jord til slatt
       GFOB   Grovfor paa overflatedyrket jord til beite
       GFIB   Grovfor paa innmarksbeite
/;
SET BEIT(PRDK) /
       GFFB   Grovfor paa fulldyrket jord til beite
       GFOB   Grovfor paa overflatedyrket jord til beite
       GFIB   Grovfor paa innmarksbeite
/;
*
*      All tilskuddsberettiget frukt og baerareal
*
SET FRBA(PRDK) /
       EPLE   Frukt paa traer
       AFRU   Annen frukt
/;
ALIAS(FRBAFRBA,FRBA);
*
*      All groennsaksareal
*
SET GRNS(PRDK) /
       GRNV   Groennsaker paa veksthus
       GRNF   Groennsaker paa friland
       BLOM   Blomster i veksthus
/;
ALIAS(GRNSGRNS,GRNS);
*
*
*      All tilskuddsberettiget kornareal
*
SET KORN(PRDK) /
       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
/;
ALIAS(KORNKORN,KORN);


SET KornPrdk(PRDK) /
       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
/;
SET OljePrdk(PRDK) /
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
/;

SET KornOljePrdk(PRDK) /
     set.kornPrdk
     set.oljePrdk
/;

SET OmfgRugAkr(PRDK) Omfang rug og annet korn /
       RUGM   Rug til mat
       RUGF   Rug til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
/;

SET OmfgHavRapErt(PRDK) Omfang havre raps og erter /
       HAVM   Havre til mat
       HAVF   Havre til for
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
/;

SET APLN(PRDK) Andre planteproduksjoner enn korn og grovfor unntatt utmarksbeite /

       POTE   Poteter
*
       GRNV   Groennsaker i veksthus
       GRNF   Groennsaker paa friland
       EPLE   Frukt paa traer
       AFRU   Annen frukt
       BLOM   Blomster
*
/;

SET MATKN(PRDK) Matkorn /
       HVEM   Hvete til mat
       RUGM   Rug til mat
       BYGM   Bygg til mat
       HAVM   Havre til mat
       AKRM   Rughvete til mat
       RAPM   Oljefroe til mat
       ERTM   Belgfrukter til mat
/;

SET FULLJ(PRDK) Fulldyrket areal  /
       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
*
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
       POTE   Poteter
*
       GRNV   Groennsaker i veksthus
       GRNF   Groennsaker paa friland
       EPLE   Frukt paa traer
       AFRU   Annen frukt
       BLOM   Blomster
*
       GFFS   Grovfor paa fulldyrket jord til slatt
/;
*
SET PKGA(PRDK) Korn grovfor og andre plantevekster;
PKGA(KORN) = YES;
PKGA(GROV) = YES;
PKGA(APLN) = YES;

     SET KLPRDK(PRDK) Produksjoner med potensiell klimaeffekt /
       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
*
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
*
       POTE   Poteter
*
       GRNV   Groennsaker i veksthus
       GRNF   Groennsaker paa friland
       EPLE   Frukt paa traer
       AFRU   Annen frukt
       BLOM   Blomster
*
       GFFS   Grovfor paa fulldyrket jord til slatt
       GFFB   Grovfor paa fulldyrket jord til beite
       GFOS   Grovfor paa overflatedyrket jord til slatt
       GFOB   Grovfor paa overflatedyrket jord til beite
       GFIB   Grovfor paa innmarksbeite
       GFUB   Grovfor paa utmark
       GFFP   Grasprotein paa fulldyrket jord
*
       MKYR   Melkekyr
       AKYR   Ammekyr
       OKSS   Okser til slakt
       KVGS   Kviger til slakt
       KVGO   Kviger til oppdrett
       OKKS   Oksekalver til slakt
       KVKS   Kvigekalver til slakt
       OKKO   Oksekalver til oppdrett
       KVKO   Kvigekalver til oppdrett
*
       GRIS   Slaktegriser
       PURK   Avlspurker
*
       SOEY   Soeye
       LAMS   Lam
       GEIT   Melkegeit
       KJES   Killing
*
       HOEN   Verpehoener
       KYLS   Slaktekyllinger
/;

SET RARKPTS_TIL_PRDK(RARKPTS,PRDK) /
119.(OKKS,KVGS,KVGO,KVKS,OKKO,KVKO)
120.MKYR
121.AKYR
134.SOEY
140.GEIT
155.PURK
157.GRIS
160.HOEN
161.HOEN
186.KYLS
238.(RUGM,RUGF)
240.(HVEM,HVEF)
242.(BYGM,BYGF)
243.(HAVM,HAVF)
*ARKN???
237.(RAPM,RAPF)
245.(ERTM,ERTF)
210.GFFS
211.GFFB
212.GFOS
213.(GFOB,GFIB)
230.POTE
250.GRNV
264.GRNF
272.EPLE
280.AFRU
285.BLOM
/;

*
* Planteproduksjoner paa fulldyrket jord
*
SET FULLDYRK(PLANTE)  /

       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
*
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
       POTE   Poteter
*
       GRNF   Groennsaker paa friland
       AFRU   Annen frukt
       GFFS   Grovfor paa fulldyrket jord til slatt
       GFFB   Grovfor paa fulldyrket jord til beite
       GFFP   Grasprotein paa fulldyrket jord
       BRAK   Brakklagt areal
/;
*
ALIAS(FULLFULLDYRK,FULLDYRK);
*
*
*
SET FULLDYRKMAT(PLANTE)  /

       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
/;
*
SET SPRED(PRDK)  Produksjoner som mottar husdyrgjoedsel /

       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
*
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
       POTE   Poteter
/;
ALIAS(SPREDSPRED,SPRED)
;
*

Set CropType /
      UAAR
      AGRI
      FODD
      CROP
      GRAS
      OTHER
/;

alias (CropTypeType,CropType)


Set CropTypeObj(CropType) /
      CROP
      GRAS
/;


Set UAAR(PRDK)   /
HVEM
HVEF
RUGM
RUGF
BYGF
HAVF
AKRF
RAPF
ERTF
POTE
GRNV
GRNF
EPLE
AFRU
BLOM
GFFS
GFFB
GFOS
GFOB
GFIB
GFUB
/;

Set FODD(PRDK) /
GFFS
GFFB
GFOS
GFOB
GFIB
GFUB
/
;


Set CROP(PRDK) /
HVEM
HVEF
RUGM
RUGF
BYGF
HAVF
AKRF
RAPF
ERTF
POTE
GRNF
EPLE
AFRU
GFFS
GFFB
/
;

Set GRAS(PRDK) /
GFOS
GFOB
GFIB
/
;


Set CropTypeObj_to_PRDK(CropTypeObj,PRDK) /
      CROP.(set.CROP)
      GRAS.(set.GRAS)
/;

*
*      Alle husdyrproduksjoner
*
SET HUSDYR(PRDK) /
       MKYR   Melkekyr
       AKYR   Ammekyr
       OKSS   Okser til slakt
       KVGS   Kviger til slakt
       KVGO   Kviger til oppdrett
       OKKS   Oksekalver til slakt
       KVKS   Kvigekalver til slakt
       OKKO   Oksekalver til oppdrett
       KVKO   Kvigekalver til oppdrett
       GRIS   Slaktegriser
       PURK   Avlspurker
       SOEY   Soeye
       LAMS   Lam
       GEIT   Melkegeit
       KJES   Killing
       HOEN   Verpehoener
       KYLS   Slaktekyllinger
/;
ALIAS(HUSDYRDYR,HUSDYR);

SET MHUSDYR(PRDK) Droevtygger med melk /
       MKYR   Melkekyr
/;

SET AHUSDYR(PRDK) Droevtygger uten melk /
       AKYR   Ammekyr
       OKSS   Okser til slakt
       KVGS   Kviger til slakt
       KVGO   Kviger til oppdrett
       OKKS   Oksekalver til slakt
       KVKS   Kvigekalver til slakt
       OKKO   Oksekalver til oppdrett
       KVKO   Kvigekalver til oppdrett
       SOEY   Soeye
       LAMS   Lam
       GEIT   Melkegeit
       KJES   Kje
/;
SET STORFE(PRDK) /
       MKYR   Melkekyr
       AKYR   Ammekyr
       OKSS   Okser til slakt
       KVGS   Kviger til slakt
       KVGO   Kviger til oppdrett
       OKKS   Oksekalver til slakt
       KVKS   Kvigekalver til slakt
       OKKO   Oksekalver til oppdrett
       KVKO   Kvigekalver til oppdrett
/;
*
*      Husdyrproduksjoner med land - ruminants
*
SET DYRMLAND(PRDK) /
       MKYR   Melkekyr
       AKYR   Ammekyr
       OKSS   Okser til slakt
       KVGS   Kviger til slakt
       KVGO   Kviger til oppdrett
       OKKS   Oksekalver til slakt
       KVKS   Kvigekalver til slakt
       OKKO   Oksekalver til oppdrett
       KVKO   Kvigekalver til oppdrett
       SOEY   Soeye
       LAMS   Lam
       GEIT   Melkegeit
       KJES   Killing
/;
*
*
*      Husdyrproduksjoner uten land
*
SET DYRULAND(PRDK) /
       GRIS   Slaktegriser
       PURK   Avlspurker
       HOEN   Verpehoener
       KYLS   Slaktekyllinger
/;
*
*      Alle kalveproduksjoner
*
     SET KALV(PRDK) /
       OKKS   Oksekalver til slakt
       KVKS   Kvigekalver til slakt
       OKKO   Oksekalver til oppdrett
       KVKO   Kvigekalver til oppdrett
/;
ALIAS(KALVKALV,KALV);
*
*      Alle ungdyr storfe
*
     SET UNGD(PRDK) /
       OKSS   Okser til slakt
       KVGS   Kviger til slakt
       KVGO   Kviger til oppdrett
       OKKS   Oksekalver til slakt
       KVKS   Kvigekalver til slakt
       OKKO   Oksekalver til oppdrett
       KVKO   Kvigekalver til oppdrett
/;

ALIAS(UNGDUNGD,UNGD);

     SET HPRDK(PRDK) Produksjoner i primaerjordbruket og naeringsmiddelindustrien /
*
*     ***   Planteproduksjon
*

       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for
*
       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
       POTE   Poteter
*
       GRNV   Groennsaker i veksthus
       GRNF   Groennsaker paa friland
       EPLE   Frukt paa traer
       AFRU   Annen frukt
*
       MKYR   Melkekyr
       AKYR   Ammekyr
*
       PURK   Avlspurker
*
       SOEY   Soeye
       GEIT   Melkegeit
*
       HOEN   Verpehoener
       KYLS   Slaktekyllinger
*
*
/;

*
* Alle foredlingsprosesser
*
      SET FP(PRDK) Foredlingsprosseser i meieri slakteri og moeller /
       MLKD   Konsummelk dagligvare
       MLKI   Konsummelk industri
       MLKS   Sjokomelk
       YOGH   Yoghurt
       OSTD   Hvitost daglivare
       OSTI   Hvitost industri
       OSTK   Kremost
       OSTM   Mysost
       OSTG   Geitost
       OSTE   Jarlsberg til eksport
       OSTX   Divere oster til eksport
       SKMP   Melkepulver
*
       SLST   Slakting og skjaering av storfe
       SLSA   Slakting og skjaering av saulam
       SLSV   Slakting og skjaering av gris
       KDEI   Foredling av kjoettdeig
       KPOL   Foredling av poelser
       KPAL   Foredling av paalegg
       KSPP   Foredling av spekepoelser
       KSPV   Foredling av spekevarer
       KDIV   Foredling av diverse kjoettvarer
*
       KHEL   Hel kylling
       KFIL   Kyllingfilet
       KANT   Annen kylling
*
       HVEM   Hvete til mat
       RUGM   Rug til mat
       BYGM   Bygg til mat
       HAVM   Havre til mat
       AKRM   Rughvete til mat
*
       RAPM   Oljefroe til mat
       ERTM   Belgfrukter til mat
       FDRM   Droevtyggerfor melk
       FDRA   Droevtyggerfor annet
       FSVN   Svinefor
       FKYL   Kyllingfor
       FEGG   Hoenefor
/;
*
*     *** Prosesser i meierier
*
      SET MEIR(FP) /
       MLKD   Konsummelk dagligvare
       MLKI   Konsummelk industri
       MLKS   Sjokomelk
       YOGH   Yoghurt
       OSTD   Hvitost daglivare
       OSTI   Hvitost industri
       OSTK   Kremost
       OSTM   Mysost
       OSTG   Geitost
       OSTE   Jarlsberg til eksport
       OSTX   Divere oster til eksport
       SKMP   Melkepulver
/;
ALIAS(MEIR,MEIRMEIR);
*
*     *** Alle prosesser for kjoett
*
      SET SLK(FP) /
       SLST   Slakting og skjaering av storfe
       SLSA   Slakting og skjaering av saulam
       SLSV   Slakting og skjaering av gris
*
       KDEI   Foredling av kjoettdeig
       KPOL   Foredling av poelser
       KPAL   Foredling av paalegg
       KSPP   Foredling av spekepoelser
       KSPV   Foredling av spekevarer
       KDIV   Foredling av diverse kjoettvarer
/;
*
*     *** Prosesser for slakting og skjaering
*
      SET SSLK(SLK) /
       SLST   Slakting og skjaering av storfe
       SLSA   Slakting og skjaering av saulam
       SLSV   Slakting og skjaering av gris
/;
ALIAS(SSLK,SSLKSSLK);
*
*     *** Prosesser i foredling av kjoett
*
      SET FSLK(SLK) /
       KDEI   Foredling av kjoettdeig
       KPOL   Foredling av poelser
       KPAL   Foredling av paalegg
       KSPP   Foredling av spekepoelser
       KSPV   Foredling av spekevarer
       KDIV   Foredling av diverse kjoettvarer
/;
ALIAS(FSLK,FSLKFSLK);
*
      SET ZFSLK(FSLK) Aktiviteter paa foredlingsanlegg /
       KDEI   Foredling av kjoettdeig
       KPOL   Foredling av poelser
       KPAL   Foredling av paalegg
       KSPP   Foredling av spekepoelser
       KSPV   Foredling av spekevarer
       KDIV   Foredling av diverse kjoettvarer
/;
*
      SET KSLK(FP) Aktiviteter for slakteanlegg kylling /
       KHEL   Hel kylling
       KFIL   Kyllingfilet
       KANT   Annen kylling
/;
*
      SET MOEL(FP) Aktiviteter i moeller/
       HVEM   Hvete til mat
       RUGM   Rug til mat
       BYGM   Bygg til mat
       HAVM   Havre til mat
       AKRM   Rughvete til mat
       RAPM   Oljefroe til mat
       ERTM   Belgfrukter til mat
*
       FDRM   Droevtyggerfor melk
       FDRA   Droevtyggerfor annet
       FSVN   Svinefor
       FKYL   Kyllingfor
       FEGG   Hoenefor
/;
*
      SET MMOEL(FP) Matmelaktiviteter i moeller/
       HVEM   Hvete til mat
       RUGM   Rug til mat
       BYGM   Bygg til mat
       HAVM   Havre til mat
       AKRM   Rughvete til mat
       RAPM   Oljefroe til mat
       ERTM   Belgfrukter til mat
/;

      SET KMOEL(FP) Kraftforaktiviteter i moeller/
       FDRM   Droevtyggerfor melk
       FDRA   Droevtyggerfor annet
       FSVN   Svinefor
       FKYL   Kyllingfor
       FEGG   Hoenefor
/;
*
      SET BTUTDYR Dyr paa beite og paa utmarksbeite /
       BTKU   Kyr paa beite
       BTST   Ungdyr storfe paa beite
       BTGT   Geit og kje paa beite
       BTSA   Sau paa beite
       BTLA   Lam paa beite

       UTKU   Kyr paa utmarksbeite
       UTST   Ungdyr storfe paa utmarksbeite
       UTGT   Geit og kje paa utmarksbeite
       UTSA   Sau paa utmarksbeite
       UTLA   Lam paa utmarksbeite
/;
*
     SET C   Levels in the food chain /
      PRIM  Primary industry
      FIND  Food processing industry
      WHLS  Wholesale
      RETL  Retail
      CONS  Consumer 
      CNLS  Consumer loss
      CNLW  Consumer waste
/;
ALIAS (CC,C);

      SET CProc(C) Levels of food chain that processes food /
      FIND  Food processing industry
      WHLS  Wholesale
      RETL  Retail
/;
*
     SET CCons(C)   Levels in the food chain at household level/
      CNLS  Consumer loss
      CNLW  Consumer waste
/;
     SET B   Type enkeltbruk i primaerjordbruket /
*
*     ***   Planteproduksjon
      BKRN  Bruk med korn oljefroe og belgfrukter
      BPTE  Bruk med potet
      BFRK  Bruk med frukt og baer
      BHGE  Bruk med groennsaker og blomster
*
*     ***   Husdyrproduksjon
      BKMK  Bruk med melkekyr og salg av kalver
      BGMK  Bruk med geiter
      BAKY  Bruk med ammekyr
      BSAU  Bruk med sauer
      BGRI  Bruk med griser
      BHOE  Bruk med hoener
      BKYL  Bruk med kyllinger
/;
ALIAS (BB,B);
*
     SET BBIO(B)   Type enkeltbruk med klimatiltak for biogass /
*
      BKMK  Bruk med melkekyr og salg av kalver
*      BGMK  Bruk med geiter
      BAKY  Bruk med ammekyr
      BSAU  Bruk med sauer
*      BGRI  Bruk med griser
*      BHOE  Bruk med hoener
*      BKYL  Bruk med kyllinger
/;

     SET BAKT(B)   Aktive enkeltbruk i primaerjordbruket /
*
*     ***   Planteproduksjon
      BKRN  Bruk med korn oljefroe og belgfrukter
      BPTE  Bruk med potet
      BFRK  Bruk med frukt og baer
      BHGE  Bruk med groennsaker og blomster
*
*     ***   Husdyrproduksjon
      BKMK  Bruk med melkekyr og salg av kalver
      BGMK  Bruk med geiter
      BAKY  Bruk med ammekyr
      BSAU  Bruk med sauer
      BGRI  Bruk med griser
      BHOE  Bruk med hoener
      BKYL  Bruk med kyllinger
/;
     SET BHUSDJG(B)   Enkeltbruk som produserer husdyrgjoedsel /
      BKMK  Bruk med melkekyr og salg av kalver
      BGMK  Bruk med geiter
      BAKY  Bruk med ammekyr
      BSAU  Bruk med sauer
      BGRI  Bruk med griser
      BHOE  Bruk med hoener
      BKYL  Bruk med kyllinger
/;
*
     SET BSTFK(B)   Enkeltbruk som produserer storfekj�tt /
      BKMK  Bruk med melkekyr og salg av kalver
      BAKY  Bruk med ammekyr
/;
*
     SET BUTHDG(B)   Enkeltbruk som leverer husdyrgjoedsel /
      BGRI  Bruk med griser
      BHOE  Bruk med hoener
      BKYL  Bruk med kyllinger
/;
*
     SET BINHDG(B)   Enkeltbruk som mottar husdyrgjoedsel /
      BKRN  Bruk med korn oljefroe og belgfrukter
      BPTE  Bruk med potet
/;
     SET BGROV(B)   Enkeltbruk med grovfor /
*
      BKMK  Bruk med melkekyr og salg av kalver
      BGMK  Bruk med geiter
      BAKY  Bruk med ammekyr
      BSAU  Bruk med sauer
/;
*
     SET BSLK(B) Bruk som leverer til slakterier /
      BKMK  Bruk med melkekyr og salg av kalver
      BGMK  Bruk med geiter
      BAKY  Bruk med ammekyr
      BSAU  Bruk med sauer
      BGRI  Bruk med griser
/;
*
     SET BMEI(B) Bruk som leverer til meierier /
      BKMK  Bruk med melkekyr og salg av kalver
      BGMK  Bruk med geiter
/;
     SET BHAG(B) Bruk innen hagebruk /
      BFRK  Bruk med frukt og baer
      BHGE  Bruk med groennsaker og blomster
/;
*
*   Definisjon av lovlige aktiviteter paa enkeltbrukene
* Definition of valid activities PRDK for the specific farms B
    TABLE B_TIL_PRDK(PRDK,B)
      BKRN BPTE BFRK BHGE BKMK BGMK BAKY BSAU BGRI BHOE BKYL
HVEM  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
HVEF  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
RUGM  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
RUGF  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
BYGM  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
BYGF  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
HAVM  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
HAVF  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
AKRM  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
AKRF  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
RAPM  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
RAPF  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
ERTM  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
ERTF  YES  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
POTE  NO   YES  NO   NO   NO   NO   NO   NO   NO   NO   NO
GRNV  NO   NO   NO   YES  NO   NO   NO   NO   NO   NO   NO
GRNF  NO   NO   NO   YES  NO   NO   NO   NO   NO   NO   NO
EPLE  NO   NO   YES  NO   NO   NO   NO   NO   NO   NO   NO
AFRU  NO   NO   YES  NO   NO   NO   NO   NO   NO   NO   NO
BLOM  NO   NO   NO   YES  NO   NO   NO   NO   NO   NO   NO
GFFS  NO   NO   NO   NO   YES  YES  YES  YES  NO   NO   NO
GFFB  NO   NO   NO   NO   YES  YES  YES  YES  NO   NO   NO
GFOS  NO   NO   NO   NO   YES  YES  YES  YES  NO   NO   NO
GFOB  NO   NO   NO   NO   YES  YES  YES  YES  NO   NO   NO
GFIB  NO   NO   NO   NO   YES  YES  YES  YES  NO   NO   NO
GFFP  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
GFUB  NO   NO   NO   NO   NO   NO   NO   YES  NO   NO   NO
BRAK  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO   NO
MKYR  NO   NO   NO   NO   YES  NO   NO   NO   NO   NO   NO
AKYR  NO   NO   NO   NO   NO   NO   YES  NO   NO   NO   NO
OKSS  NO   NO   NO   NO   YES  NO   YES  NO   NO   NO   NO
KVGS  NO   NO   NO   NO   YES  NO   YES  NO   NO   NO   NO
KVGO  NO   NO   NO   NO   YES  NO   YES  NO   NO   NO   NO
OKKS  NO   NO   NO   NO   YES  NO   YES  NO   NO   NO   NO
KVKS  NO   NO   NO   NO   YES  NO   YES  NO   NO   NO   NO
OKKO  NO   NO   NO   NO   YES  NO   YES  NO   NO   NO   NO
KVKO  NO   NO   NO   NO   YES  NO   YES  NO   NO   NO   NO
GRIS  NO   NO   NO   NO   NO   NO   NO   NO   YES  NO   NO
PURK  NO   NO   NO   NO   NO   NO   NO   NO   YES  NO   NO
SOEY  NO   NO   NO   NO   NO   NO   NO   YES  NO   NO   NO
LAMS  NO   NO   NO   NO   NO   NO   NO   YES  NO   NO   NO
GEIT  NO   NO   NO   NO   NO   YES  NO   NO   NO   NO   NO
KJES  NO   NO   NO   NO   NO   YES  NO   NO   NO   NO   NO
HOEN  NO   NO   NO   NO   NO   NO   NO   NO   NO   YES  NO
KYLS  NO   NO   NO   NO   NO   NO   NO   NO   NO   NO   YES
;
*
*
*** Produkter tilskudd og innsatsfaktorer
*
     SET VARE Varer /
*
*** Produkter
*
*   Planteprodukter
*
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
*
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
      POTE   Poteter
*
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
*
      GFFS   Grovfor paa fulldyrket jord til slatt
      GFFB   Grovfor paa fulldyrket jord til beite
      GFOS   Grovfor paa overflatedyrket jord til slatt
      GFOB   Grovfor paa overflatedyrket jord til beite
      GFIB   Grovfor paa innmarksbeite
      GFUB   Grovfor paa utmark
*
*   Biprodukter planteproduksjon
*
      SPRE   Spredeareal
*
*   Husdyrprodukter
*
      KMLK   Kumelk
      GMLK   Geitmelk
*
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      FJRK   Fjoerfekjoett
*
      EGGS   Egg
*
*   Meierier
*
      MLKD   Konsummelk dagligvare
      MLKI   Konsummelk industri
      MLKS   Sjokomelk
      YOGH   Yoghurt
      OSTD   Hvitost daglivare
      OSTI   Hvitost industri
      OSTK   Kremost
      OSTM   Mysost
      OSTG   Geitost
      OSTE   Jarlsberg til eksport
      OSTX   Divere oster til eksport
      SKMP   Melkepulver
      FLOT   Floete
      SMOR   Smoer
*
*   Slakterier
*
      STKK   Storfe- og kalvekjoett
      SAGK   Saue- lam- geit- og kjekjoett
*     SVNK   Svinekjoett
*
      PRIN   Produksjonskoett og innmat
*
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KBSV   Foredlet biff og filet  gris
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KSSV   Foredlet saltet roekt og marinert kjoett gris
*
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
*
      KHEL   Hel kylling
      KFIL   Kyllingfilet
      KANT   Annet kylling
*
*   Moeller
*
      FMKN   Matkorn hvete rug akrn til for
      FFKN   Forkorn bygg havre til for
      FBLG   Belgvekster raps erter til for
*
*   Biprodukter husdyrproduksjon
*
      OKYR   Ung ku
      OKVG   Ung kvige
      OOKS   Ung okse
      OKVK   Ung kvigekalv
      OOKK   Ung oksekalv
*
      NITH   Nitrogen fra husdyr
      FOSH   Fosfor fra husdyr
      KALH   Kalium fra husdyr
*
      ULLS   Ull fra sau
*
*** Innsatsfaktorer
*
*   Spesifikk for planteproduksjon
*
      SAAK   Saakorn og saafroe
      PLVR   Plantevernmidler
*
      NITG   Nitrogen fra handelsgjoedsel
      FOSG   Fosfor fra handelsgjoedsel
      KALG   Kali fra handelsgjoedsel
*
      NITR   Nitrogengjoedsel
      FOSF   Fosforgjoedsl
      KALI   Kaliumgjoedsel
      KALK   Kalk
*
*   Spesifikk for husdyrproduksjon
*
*     Ungdyr
*
      IKYR   Ung ku
      IKVG   Ung kvige
      IOKS   Ung okse
      IKVK   Ung kvigekalv
      IOKK   Ung oksekalv
*
      IPRK   Antall slaktegriser pr purke
      ISAU   Antall lam pr soeye
      IGET   Antall kje pr geit
*
      VETM   Dyrelege og medisin
      INSM   Inseminering
*
*     Kraftforraavarer
*
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
      FGRV   Grovfor

      FFEM   Forenheter droevtygger
      FFEG   Forenheter svin
      FFEF   Forenheter fjoerfe

*      FMKN   Matkorn til for
*      FFKN   Forkorn til for
      FSOY   Soya til for
*      FBLG   Raps og erter til for
      FANT   Annet til for
      
      FGRP   Gras protein paste
      FGRJ   Gras protein residue juice
*
*   Generelle innsatsfaktorer
*
      VEDB   Vedlikehold bygninger
      VEDM   Vedlikehold maskiner
      AVSB   Avskrivninger bygninger
      AVSM   Avskrivninger maskiner
      EKRF   Kraft
      EBRN   Brensel diesel og bensin
      EFOL   Fyringsolje
      ESMR   Smoeremidler
      KAPB   Kapital bygninger
      KAPM   Kapital maskiner
      KAPD   Kapital dyr
      KAPJ   Kapital jord
      KAPK   Kapital kvoter
      ARBF   Eget arbeid
      ARBL   Leid arbeid
      AKST   Andre kostnader
*
*   Tilskudd
*
      TGRUN  Grunntilskudd
      TDISM  Distriktstilskudd for melk
      TDISK  Distriktstilskudd for kjoett
      TDISE  Distriktstilskudd for egg og fjoerfe
      TDISG  Distriktstilskudd for groent og potet
      TDMLK  Driftstilskudd melk
      TPROD  Produksjonstillegg husdyr
      TAKTL  Areal og kulturlandskapstillegg
      TSKAT  Fradrag for jordbruksinntekt
      TFRKT  Frakttilskudd
      TKORN  Prisnedskriving norsk korn og matkorntilskudd
      TBEIT  Beitetilskudd
      TUTMK  Tilskudd til utmark
      TVELF  Velferdsordninger
      TATIL  Andre tilskudd
      THIST  Tilskudd basert paa historiske rettigheter
      TPIPE  Pipetilskudd
      TARBF  Tilskudd basert p� arbeidsinnsats
      TKLIA  Tilskudd for � kompensere klimatiltak i jordbruket per aktivitet
      TKLIV  Tilskudd for � kompensere klimatiltak i jordbruket per vare
      TKFOR       Frakttilskudd for
      TENDO  Modellgenererte endogene tilskudd
*
*   Innsatsfaktorer i naeringsmiddelindustrien
*
      INNT   Inntransport
      AVAR   Andre innsatsvarer
      LONN   Loenn- og personalkostnader
      ANNT   Andre kostnader
*
*   Klimagass og miljoeindikatorer
*
      GE        Brutto energiinntak i MJ pr dyr pr dag
      YM        Andel av GE som omdannes til metan
      VSDM      Volatile solids i torrstoff
      NITHX     Produksjon av N

      CH4       Metan
      N2O       Lystgass
      CO2       Kulldioksid
      NH3       Ammoniak
      N         Nitrogen

      CH4E      Direkte utslipp av enterisk metan fra fordoyelsesprosessen
      CH4M      Direkte utslipp av metan fra gjodselhandtering
      CH4B      Direkte utslipp av metan fra brenning av restavling

      N2OMM     Direkte utslipp av lystgass fra gjodselhandetering
      N2OM      Direkte utslipp av lystgass fra gjodsling med husdyrgjodsel
      N2OB      Direkte utslipp av lystgass fra beiting
      N2OS      Direkte utslipp av lystgass fra gjodsling med kunstgjodsel
      N2ONH3MMNED  Indirekte utslipp av lystgass fra gjodselhandtering gjennom nedfall
      N2ONH3MMAVR  Indirekte utslipp av lystgass fra gjodselhandtering gjennom avrenning
      N2ONH3NED Indirekte utslipp av lystgass fra gj�dsel gjennom nedfall
      N2ONH3AVR Indirekte utslipp av lystgass fra gj�dsel gjennom avrenning
      N2OAVL    Utslipp av lystgass fra restavlinger
      N2OBRN    Utslipp av lystgass fra brenning av restavlinger
      N2OMYR    Utslipp av lystgass fra myr

      NH3MMNED  Ammoniak fra gjodselhandtering gjennom nedfall
      NH3MMAVR  Ammoniak fra gjodselhandtering gjennom avrenning
      NH3NED    Ammoniak fra gj�dsling gjennom nedfall
      NH3AVR    Ammoniak fra gj�dsling gjennom avrenning

      NAVL      Nitrogen i restavling
      NTAP      Residualt nitrogentap

      CO2SINK   Binding av karbondioksid
      CO2SOUR   Utslipp av karbondioksid
      CO2KALK   Utslipp av kalk
      
      EMIS_N    Utslipp av nitrogen
/;
*
ALIAS(VAREVARE,VARE);
ALIAS(VAREVAREVARE,VARE);

*
     SET KLVARE(VARE) Varer med potensiell klimaeffekt /
*
*** Produkter
*
*   Planteprodukter
*
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
*
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
*
      POTE   Poteter
*
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
*
      GFFS   Grovfor paa fulldyrket jord til slatt
      GFFB   Grovfor paa fulldyrket jord til beite
      GFOS   Grovfor paa overflatedyrket jord til slatt
      GFOB   Grovfor paa overflatedyrket jord til beite
      GFIB   Grovfor paa innmarksbeite
      GFUB   Grovfor paa utmark
*
*   Husdyrprodukter
*
      KMLK   Kumelk
      GMLK   Geitmelk
*
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      FJRK   Fjoerfekjoett
*
      EGGS   Egg
*
*   Biprodukter husdyrproduksjon
*
      NITH   Nitrogen fra husdyr
      FOSH   Fosfor fra husdyr
      KALH   Kalium fra husdyr
*
*** Innsatsfaktorer
*
*   Spesifikk for planteproduksjon
*
      SAAK   Saakorn og saafroe
      PLVR   Plantevernmidler
*
      NITG   Nitrogen fra handelsgjoedsel
      FOSG   Fosfor fra handelsgjoedsel
      KALG   Kali fra handelsgjoedsel
*
      NITR   Nitrogengjoedsel
      FOSF   Fosforgjoedsl
      KALI   Kaliumgjoedsel
      KALK   Kalk
*
*   Spesifikk for husdyrproduksjon
      VETM   Dyrelege og medisin
      INSM   Inseminering
*
*     Kraftforraavarer
*
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
      FGRV   Grovfor

      FFEM   Forenheter droevtygger
      FFEG   Forenheter svin
      FFEF   Forenheter fjoerfe

      FMKN   Matkorn til for
      FFKN   Forkorn til for
      FSOY   Soya til for
      FBLG   Raps og erter til for
      FANT   Annet til for
*
*   Generelle innsatsfaktorer
*
      VEDB   Vedlikehold bygninger
      VEDM   Vedlikehold maskiner
      AVSB   Avskrivninger bygninger
      AVSM   Avskrivninger maskiner
      EKRF   Kraft
      EBRN   Brensel diesel og bensin
      EFOL   Fyringsolje
      ESMR   Smoeremidler
      KAPB   Kapital bygninger
      KAPM   Kapital maskiner
      KAPD   Kapital dyr
      KAPJ   Kapital jord
      KAPK   Kapital kvoter
      ARBF   Eget arbeid
      ARBL   Leid arbeid
      AKST   Andre kostnader
*
*   Klimagass og miljoeindikatorer
*
      GE        Brutto energiinntak i MJ pr dyr pr dag
      YM        Andel av GE som omdannes til metan
      VSDM      Volatile solids i torrstoff
      NITHX     Produksjon av N

      CH4       Metan
      N2O       Lystgass
      CO2       Karbonioksid
      NH3       Ammoniak
      N         Nitrogen

      CH4E      Direkte utslipp av enterisk metan fra fordoyelsesprosessen
      CH4M      Direkte utslipp av metan fra gjodselhandtering
      CH4B      Direkte utslipp av metan fra brenning av restavling

      N2OMM     Direkte utslipp av lystgass fra gjodselhandetering
      N2OM      Direkte utslipp av lystgass fra gjodsling med husdyrgjodsel
      N2OB      Direkte utslipp av lystgass fra beiting
      N2OS      Direkte utslipp av lystgass fra gjodsling med kunstgjodsel
      N2ONH3MMNED  Indirekte utslipp av lystgass fra gjodselhandtering via nedfall av ammoniak
      N2ONH3MMAVR  Indirekte utslipp av lystgass fra gjodselhandtering via avrenning
      N2ONH3NED Indirekte utslipp av lystgass fra gj�dsel gjennom nedfall
      N2ONH3AVR Indirekte utslipp av lystgass fra gj�dseel gjennom avrenning
      N2OAVL    Utslipp av lystgass fra restavlinger
      N2OBRN    Utslipp av lystgass fra brenning av restavlinger
      N2OMYR    Utslipp av lystgass fra myr

      NH3MMNED     Ammoniak fra gjodselhandtering gjennom nedfall
      NH3MMAVR     Ammoniak fra gjodselhandtering gjennom avrenning
      NH3NED    Ammoniak fra gj�dsel gjennom nedfall
      NH3AVR    Ammoniak fra gj�dsel gjennom avrenning

      NAVL      Nitrogen i restavling
      NTAP      Residualt nitrogentap

      CO2SINK   Binding av karbondioksid
      CO2SOUR   Utslipp av karbondioksid
      CO2KALK   Utslipp av kalking
/;

      SET METAN(VARE) /
      CH4E
      CH4M
      CH4B
/;
*
      SET UTSLIPP(VARE) Alle utslippsvarer /
      CH4E
      CH4M
      CH4B
      N2OMM
      N2OM
      N2OB
      N2OS
      NH3MMNED
      N2ONH3MMNED
      NH3MMAVR
      N2ONH3MMAVR
      NH3NED
      N2ONH3NED
      NH3AVR
      N2ONH3AVR
      NAVL
      N2OAVL
      N2OBRN
      N2OMYR
      CO2
      CO2SINK
      CO2SOUR
      CO2KALK
/;
      SET UTSLIPPRSK(VARE) Utslipp til klimagassregnskap /
      CH4E
      CH4M
      CH4B
      N2OMM
      N2OM
      N2OB
      N2OS
*      NH3MMNED
*      NH3MMAVR
      N2ONH3MMNED
      N2ONH3MMAVR
*      NH3NED
      N2ONH3NED
*      NH3AVR
      N2ONH3AVR
*      NAVL
      N2OAVL
      N2OBRN
      N2OMYR
*      CO2
      CO2SINK
      CO2SOUR
      CO2KALK
/;
      SET UTSLIPPAVG(VARE)  Utslipp med miljoavgift /
      CH4  Metan
      N2O  Lystgass
      CO2  Karbondioksid
/;
      SET UTSLIPPGHG(VARE)  Utslipp med GHG /
      CH4  Metan
      N2O  Lystgass
      CO2  Karbondioksid
/;
*
      SET UTSLIPPAVG_TIL_UTSLIPPGHG(UTSLIPPGHG,UTSLIPPAVG) Utslipp GHG med miljoavgift/
      CH4.CH4
      N2O.N2O
      CO2.CO2
/;
      SET UTSLIPPAVG_TIL_UTSLIPP(VARE,VARE) Utslipp med miljoavgift/
      CH4.(CH4E, CH4M, CH4B)
      N2O.(N2OMM, N2OM, N2OB, N2OS, N2ONH3MMNED, N2ONH3MMAVR, N2ONH3NED, N2ONH3AVR, N2OAVL, N2OBRN, N2OMYR)
      CO2.(CO2SINK, CO2SOUR, CO2KALK)
*      NH3.(NH3MMNED, NH3MMAVR, NH3NED, NH3AVR)
*      N.  (NAVL)
/;
*
      SET UTSLIPPGHG_TIL_UTSLIPP(VARE,VARE) Aggregering av utslipp fra klimaregnskap /
      CH4.(CH4E, CH4M, CH4B)
      N2O.(N2OMM, N2OM, N2OB, N2OS, N2ONH3MMNED, N2ONH3MMAVR, N2ONH3NED, N2ONH3AVR, N2OAVL, N2OBRN, N2OMYR)
      CO2.(CO2SINK, CO2SOUR, CO2KALK)

/;
*
      SET Emis Emission gases and nutrients /
      NTAP  Avrenning av nitrogen beregnet som tap
      N2O   Lystgass
      NH3   Ammoniakk
/;
*
     SET RENTKJOETT(VARE) Rene kj�ttvarer også til beregning av helseeffekt /
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBSV   Foredlet biff og filet  gris
      KSSV   Foredlet saltet roekt og marinert kjoett gris
/;
*
     SET BEARBKJOETT(VARE) Bearbeidede kjoettvarer også til beregning av helseeffekt /
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
      KANT   Annet kylling
/;
*
     SET RKJOETT(VARE) R�dt kj�tt i handelspolitikk /
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      STKK   Storfe- og kalvekjoett
      SAGK   Saue- lam- geit- og kjekjoett
      PRIN   Produksjonskoett og innmat
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KBSV   Foredlet biff og filet  gris
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KSSV   Foredlet saltet roekt og marinert kjoett gris
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
/;
     SET UTSLIPPVARE(VARE) Varer med eksplisitt miljoeavgift /
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
*      KDEI   Kjoettdeig
*      KPOL   Poelser
*      KPAL   Paalegg
*      KSPP   Spekepoelser
      KSPV   Spekevarer
*      KDIV   Diverse kjoettvarer
/;



     SET NONUTSLIPPVARE(VARE) Kjoettvarer uten miljoeavgift /
      KYSV   Foredlet stykket kjoett gris
      KBSV   Foredlet biff og filet  gris
      KSSV   Foredlet saltet roekt og marinert kjoett gris
*
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KDIV   Diverse kjoettvarer
/;

*
*
     SET LDYR(VARE) Levende dyr /
      OKYR   Ung ku
      OKVG   Ung kvige
      OOKS   Ung okse
      OKVK   Ung kvigekalv
      OOKK   Ung oksekalv
      IKYR   Ung ku
      IKVG   Ung kvige
      IOKS   Ung okse
      IKVK   Ung kvigekalv
      IOKK   Ung oksekalv
/;
*
     SET FLYT(VARE) Flytende vare /
      KMLK   Kumelk
      GMLK   Geitmelk
      MLKD   Konsummelk dagligvare
      MLKI   Konsummelk industri
      MLKS   Sjokomelk
/;
*
     SET BULK(VARE) Bulkvare /
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
      POTE   Poteter
      FMKN   Matkorn hvete rug akrn til for
      FFKN   Forkorn bygg havre til for
      FBLG   Belgvekster raps erter til for
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
      FFEM   Forenheter droevtygger
      FFEG   Forenheter svin
      FFEF   Forenheter fjoerfe
/;
*
     SET TERM(VARE) Termoprodukter /
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      STKK   Storfe- og kalvekjoett
      SVNK   Svinejkoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      SAGK   Saue- lam- geit- og kjekjoett
      FJRK   Fjoerfekjoett
      EGGS   Egg
      YOGH   Yoghurt
      OSTD   Hvitost daglivare
      OSTI   Hvitost industri
      OSTK   Kremost
      OSTM   Mysost
      OSTG   Geitost
      OSTE   Jarlsberg til eksport
      OSTX   Divere oster til eksport
      SKMP   Melkepulver
      FLOT   Floete
      SMOR   Smoer
      PRIN   Produksjonskoett og innmat
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KBSV   Foredlet biff og filet  gris
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KSSV   Foredlet saltet roekt og marinert kjoett gris
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
      KHEL   Hel kylling
      KFIL   Kyllingfilet
      KANT   Annet kylling
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
/;
*
     SET PRODUKT(VARE) Produkter fra gaardsbruk /
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      GFFS   Grovfor paa fulldyrket jord til slatt
      GFFB   Grovfor paa fulldyrket jord til beite
      GFOS   Grovfor paa overflatedyrket jord til slatt
      GFOB   Grovfor paa overflatedyrket jord til beite
      GFIB   Grovfor paa innmarksbeite
      GFUB   Grovfor paa utmark
      KMLK   Kumelk
      GMLK   Geitmelk
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinejkoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      FJRK   Fjoerfekjoett
      EGGS   Egg
      OKYR   Ung ku
      OKVG   Ung kvige
      OOKS   Ung okse
      OKVK   Ung kvigekalv
      OOKK   Ung oksekalv
      NITH   Nitrogen fra husdyr
      FOSH   Fosfor fra husdyr
      KALH   Kalium fra husdyr
      ULLS   Ull fra sau

      FGRP   Gras protein paste
      FGRJ   Gras protein residue juice
*      GE
*      YM
*      VSDM

*      CH4E
*      CH4M
*      CH4B
*      NITHX
*      N2OMM
*      N2OM
*      N2OS
*      NH3MMNED
*      NH3MMAVR
*      N2ONH3MM
*      NH3NED
*      N2ONH3NED
*      NH3AVR
*      N2ONH3AVR
*      NAVL
*      N2OAVL
*      N2OBRN
*      N2OMYR
*      CO2
*      CO2SINK
*      CO2SOUR
*      CO2KALK
/;
ALIAS(PRODUKTPRODUKT,PRODUKT);
*
     SET HDYRPROD(PRODUKT) Produkter i husdyrproduksjonen  /
      KMLK   Kumelk
      GMLK   Geitmelk
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinejkoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      FJRK   Fjoerfekjoett
      EGGS   Egg
      OKYR   Ung ku
      OKVG   Ung kvige
      OOKS   Ung okse
      OKVK   Ung kvigekalv
      OOKK   Ung oksekalv
      NITH   Nitrogen fra husdyr
      FOSH   Fosfor fra husdyr
      KALH   Kalium fra husdyr
      ULLS   Ull fra sau
/;
*
     SET PLPROD(PRODUKT) Produkter i planteproduksjonen /
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      GFFS   Grovfor paa fulldyrket jord til slatt
      GFFB   Grovfor paa fulldyrket jord til beite
      GFOS   Grovfor paa overflatedyrket jord til slatt
      GFOB   Grovfor paa overflatedyrket jord til beite
      GFIB   Grovfor paa innmarksbeite
      GFUB   Grovfor paa utmark
/;
*
     SET FFEMPROD(VARE) Varer til beregning av markedsbalanse for /
      HVEF   Hvete til for
      RUGF   Rug til for
      BYGF   Bygg til for
      HAVF   Havre til for
      AKRF   Rughvete til for
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
      POTE   Poteter
      GFFS   Grovfor paa fulldyrket jord til slatt
      GFFB   Grovfor paa fulldyrket jord til beite
      GFOS   Grovfor paa overflatedyrket jord til slatt
      GFOB   Grovfor paa overflatedyrket jord til beite
      GFIB   Grovfor paa innmarksbeite
      GFUB   Grovfor paa utmark
/;

     SET FFEMKORN(VARE) Varer til beregning av markedsbalanse for /
      HVEF   Hvete til for
      RUGF   Rug til for
      BYGF   Bygg til for
      HAVF   Havre til for
      AKRF   Rughvete til for
/;
*
     SET FFEMAPLN(VARE) Varer til beregning av markedsbalanse for /
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
      POTE   Poteter
/;

     SET FFEMGRAS(VARE) Varer til beregning av markedsbalanse for /
      GFFS   Grovfor paa fulldyrket jord til slatt
      GFFB   Grovfor paa fulldyrket jord til beite
      GFOS   Grovfor paa overflatedyrket jord til slatt
      GFOB   Grovfor paa overflatedyrket jord til beite
      GFIB   Grovfor paa innmarksbeite
      GFUB   Grovfor paa utmark
/;

     SET STOKVARE(VARE) Varer med stokastisk avling /
      GFFS   Grovfor paa fulldyrket jord til slatt
      GFFB   Grovfor paa fulldyrket jord til beite
      GFOS   Grovfor paa overflatedyrket jord til slatt
      GFOB   Grovfor paa overflatedyrket jord til beite
      GFIB   Grovfor paa innmarksbeite
/;

     SET REGKORNVARE(VARE) Kornvarer med regionale mengder fra PT /
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
/;
     SET REGOLJEVARE(VARE) Oljevarer med regionale mengder fra PT /
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
/;
     SET REGKornOljeVARE(VARE) Korn og oljevarer med regionale mengder fra PT /
      set.regkornvare
      set.regoljevare
/;
alias(regregkornoljevare,regkornoljevare);

     SET REGAVLVARE(VARE) Produkter med regionalt avlingsnivaa /
      POTE
      GFFS
      GFFB
      GFOS
      GFOB
      GFIB
      GFUB
 /;
*
     SET REGPRODVARE(VARE) Produkter med regional produksjon   /
      EPLE
      AFRU
      GRNF
      GRNV
/;
*
     SET KFBH(VARE) Produkter i kraftforbasert husdyrproduksjon  /
      SVNK   Svinejkoett
      FJRK   Fjoerfekjoett
      EGGS   Egg
/;
*

     SET SLTVARE(VARE) Sluttprodukter til konsum /
      HVEM   Hvete til mat
      RUGM   Rug til mat
      BYGM   Bygg til mat
      HAVM   Havre til mat
      AKRM   Rughvete til mat
      RAPM   Oljefroe til mat
      ERTM   Belgfrukter til mat
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      MLKD   Konsummelk dagligvare
      MLKI   Konsummelk industri
      MLKS   Sjokomelk
      YOGH   Yoghurt
      OSTD   Hvitost daglivare
      OSTI   Hvitost industri
      OSTK   Kremost
      OSTM   Mysost
      OSTG   Geitost
      OSTE   Jarlsberg til eksport
      OSTX   Divere oster til eksport
      SKMP   Melkepulver
      FLOT   Floete
      SMOR   Smoer
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KBSV   Foredlet biff og filet  gris
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KSSV   Foredlet saltet roekt og marinert kjoett gris
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
      KHEL   Hel kylling
      KFIL   Kyllingfilet
      KANT   Annen kylling
      EGGS   Egg
/;
ALIAS(SLTVARE,SLTSLTVARE);
ALIAS(SLTVARE,SLT1VARE);
ALIAS(SLTVARE,SLT2VARE);
*
     SET SVARE(VARE) Sluttprodukter til innenlandsk konsum /
      HVEM   Hvete til mat
      RUGM   Rug til mat
      BYGM   Bygg til mat
      HAVM   Havre til mat
      AKRM   Rughvete til mat
      RAPM   Oljefroe til mat
      ERTM   Belgfrukter til mat
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      MLKD   Konsummelk dagligvare
      MLKI   Konsummelk industri
      MLKS   Sjokomelk
      YOGH   Yoghurt
      OSTD   Hvitost daglivare
      OSTI   Hvitost industri
      OSTK   Kremost
      OSTM   Mysost
      OSTG   Geitost
*      OSTE   Jarlsberg til eksport
*      OSTX   Divere oster til eksport
      SKMP   Melkepulver
      FLOT   Floete
      SMOR   Smoer
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KBSV   Foredlet biff og filet  gris
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KSSV   Foredlet saltet roekt og marinert kjoett gris
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
      KHEL   Hel kylling
      KFIL   Kyllingfilet
      KANT   Annen kylling
      EGGS   Egg
/;

ALIAS(SVARE,SSVARE);
ALIAS(SVARE,SSSVARE);

     SET FJRKMKVARE(VARE) Sluttprodukter fjoerfe med krysspriseffekt /
      KHEL   Hel kylling
      KFIL   Kyllingfilet
      KANT   Annen kylling
/;
*
     SET PLANSLTVARE(VARE) Sluttprodukter planteprodukter til konsum /
      HVEM   Hvete til mat
      RUGM   Rug til mat
      BYGM   Bygg til mat
      HAVM   Havre til mat
      AKRM   Rughvete til mat
*
      RAPM   Oljefroe til mat
      ERTM   Belgfrukter til mat
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
/;
*
     SET HvetVare(Vare) Hvete /
      HVEM   Hvete til mat
      HVEF   Hvete til for
/;

     SET ByggVare(Vare) Bygg /
      BYGM   Bygg til mat
      BYGF   Bygg til for
/;

     SET RugAkrVare(Vare) Rug og annet korn /
      RUGM   Rug til mat
      RUGF   Rugh til for
      AKRM   Annet korn til mat
      AKRF   Annet korn til for
/;

     SET HavRapErtVare(Vare) Havre raps og erter /
      HAVM   Havre til mat
      HAVF   Havre til for
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
/;


     SET KornVare(Vare) Sluttprodukter korn til konsum /
      HVEM   Hvete til mat
      RUGM   Rug til mat
      BYGM   Bygg til mat
      HAVM   Havre til mat
      AKRM   Rughvete til mat
*
      RAPM   Oljefroe til mat
      ERTM   Belgfrukter til mat
/;


     SET DemKorn(VARE) Final demand products in demand group cereals  /
      HVEM   
      BYGM   
      HAVM   
      ERTM   
      RUGM   
      AKRM   
      RAPM
      /;
*
     SET DemHage(VARE) Final demand products in demand group non-cereal crop products /
      EPLE   
      AFRU   
      GRNF   
      GRNV   
      POTE   
      BLOM   
      /;
*
     SET DemMelk(VARE)  Final demand products in demand group dairy products /
      MLKD   
      YOGH   
      OSTD   
      SKMP   
      EGGS   
      SMOR   
      OSTI   
      OSTK   
      OSTM   
      OSTG   
      MLKI   
      MLKS   
      FLOT   
      /;
*
     SET DemKjot(VARE) Final demand products in demand group meat products /
      KDIV   
      KDEI   
      KPOL   
      KPAL   
      KSPP   
      KSPV   
      KHEL   
      KFIL   
      KANT   
      KYSA   
      KBSA   
      KSSA   
      KYSV   
      KBSV   
      KSSV   
      KYST   
      KBST   
      KSST   
      /;


     SET STFKVARE(VARE) Sluttprodukter storfe med krysspriseffekt /
      KYST   Foredlet stykket kjoett storfe
      KBST   Foredlet biff og filet  storfe
      KSST   Foredlet saltet roekt og marinert kjoett storfe
/;
*
**
     SET SVNKVARE(VARE) Sluttprodukter svin med krysspriseffekt /
      KYSV   Foredlet stykket kjoett gris
      KBSV   Foredlet biff og filet  gris
      KSSV   Foredlet saltet roekt og marinert kjoett gris
/;
*
     SET SAUKVARE(VARE) Sluttprodukter sau med krysspriseffekt /
      KYSA   Foredlet stykket kjoett saulam
      KBSA   Foredlet biff og filet  saulam
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
/;
*
     SET SLKINNVARE(VARE) Innsatsprodukter slakterier /
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
/;
*
     SET IUVARE(VARE) Varer slakterier med intern utjevning /
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      FJRK   Fj�rfekj�tt
/;
*
     SET SLKVARE(VARE) Slakterivarer /
      STKK   Storfe- og kalvekjoett
      SAGK   Saue- lam- geit- og kjekjoett
      SVNK   Svinekjoeet
*
      PRIN   Produksjonskoett og innmat
*
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KBSV   Foredlet biff og filet  gris
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KSSV   Foredlet saltet roekt og marinert kjoett gris
*
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
/;
ALIAS(SLKVARE,SLKSLKVARE);
*
     SET SSLK_SLKINN(PRDK,VARE) Varer i slakterier /
      SLST.(STFK,KLVK) Storfe og kalv
      SLSA.(SAUK,GETK) Sau og geit
      SLSV.SVNK        Gris
/;
     SET SSLKFLYT(VARE,VARE) Varestroem i slakterier /
*      STKK.(STFK,KLVK) Storfe og kalv
      STKK.(STFK) Storfe og kalv
      SAGK.(SAUK,GETK) Sau og geit
      SVNK.SVNK        Gris
/;
     SET SSLKVARE(VARE) Slakterivarer i slakting og skjaering /
      STKK   Storfe- og kalvekjoett
      SAGK   Saue- lam- geit- og kjekjoett
      SVNK   Svinekjoett
*
      PRIN   Produksjonskoett og innmat
*
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KBSV   Foredlet biff og filet  gris
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KSSV   Foredlet saltet roekt og marinert kjoett gris
/;
ALIAS(SSLKVARE,SSLKSSLKVARE);
*
     SET FSLKVARE(VARE) Slakterivarer i foredling /
      PRIN   Produksjonskoett og innmat
*
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
/;
ALIAS(FSLKVARE,FSLKFSLKVARE);
*

     SET SLTMKVARE(SLTVARE) Sluttprodukter med krysspriselastisitet /
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KBSV   Foredlet biff og filet  gris
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KSSV   Foredlet saltet roekt og marinert kjoett gris
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
      KHEL   Hel kylling
      KFIL   Kyllingfilet
      KANT   Annet kylling
* Produkter egentlig uten krysspriselastisitet
      HVEM   Hvete til mat
      RUGM   Rug til mat
      BYGM   Bygg til mat
      HAVM   Havre til mat
      AKRM   Rughvete til mat
      RAPM   Oljefroe til mat
      ERTM   Belgfrukter til mat
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      MLKD   Konsummelk dagligvare
      MLKI   Konsummelk industri
      MLKS   Sjokomelk
      YOGH   Yoghurt
      OSTD   Hvitost daglivare
      OSTI   Hvitost industri
      OSTK   Kremost
      OSTM   Mysost
      OSTG   Geitost
      OSTE   Jarlsberg til eksport
      OSTX   Divere oster til eksport
      SKMP   Melkepulver
      FLOT   Floete
      SMOR   Smoer
      EGGS   Egg
/;
*
ALIAS(SLTMKVARE,SLTMK1VARE);
*
     SET SLTUKVARE(SLTVARE) Sluttprodukter uten krysspriselastisitet /
      HVEM   Hvete til mat
      RUGM   Rug til mat
      BYGM   Bygg til mat
      HAVM   Havre til mat
      AKRM   Rughvete til mat
      RAPM   Oljefroe til mat
      ERTM   Belgfrukter til mat
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      MLKD   Konsummelk dagligvare
      MLKI   Konsummelk industri
      MLKS   Sjokomelk
      YOGH   Yoghurt
      OSTD   Hvitost daglivare
      OSTI   Hvitost industri
      OSTK   Kremost
      OSTM   Mysost
      OSTG   Geitost
      OSTE   Jarlsberg til eksport
      OSTX   Divere oster til eksport
      SKMP   Melkepulver
      FLOT   Floete
      SMOR   Smoer
      EGGS   Egg
/;
*
     SET EFKVARE(VARE) Produkter med eksogene foredlingskostnader /
*      RAPM   Oljefroe til mat
*      ERTM   Belgfrukter til mat
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      EGGS   Egg
/;
*
     SET AINDVARE(VARE) Sluttprodukter i annen industri /
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      EGGS   Egg
      KHEL   Hel kylling
      KFIL   Kyllingfilet
      KANT   Annet kylling
      FJRK   Fjørfekjøtt
/;
*

     SET MEIINNVARE(VARE) Innsatsprodukter i meierier  /
      KMLK   Kumelk
      GMLK   Geitmelk
/;
*
    SET MEIVARE(VARE) Meierivarer /
      MLKD   Konsummelk dagligvare
      MLKI   Konsummelk industri
      MLKS   Sjokomelk
      YOGH   Yoghurt
      OSTD   Hvitost daglivare
      OSTI   Hvitost industri
      OSTK   Kremost
      OSTM   Mysost
      OSTG   Geitost
      OSTE   Jarlsberg til eksport
      OSTX   Divere oster til eksport
      SKMP   Melkepulver
      FLOT   Floete
      SMOR   Smoer
/;
*
ALIAS(MEIVARE,MEIMEIVARE);
*
     SET MEIDVARE(VARE) Meierivarer til innenlands forbruk /
      MLKD   Konsummelk dagligvare
      MLKI   Konsummelk industri
      MLKS   Sjokomelk
      YOGH   Yoghurt
      OSTD   Hvitost daglivare
      OSTI   Hvitost industri
      OSTK   Kremost
      OSTM   Mysost
      OSTG   Geitost
      SKMP   Melkepulver
      FLOT   Floete
      SMOR   Smoer
/;
*
     SET MEIXVARE(VARE) Meierivarer til eksport /
      OSTE   Jarlsberg til eksport
      OSTX   Divere oster til eksport
/;

     SET MEIMVARE(VARE) Flytende melk til beregning av helseeffekt /
       MLKD   Konsummelk dagligvare
       MLKI   Konsummelk industri
       MLKS   Sjokomelk
       YOGH   Yoghurt
/;
*
    SET MEIPUBIVARE(VARE) Meierivarer i PU-ordningen som biprodukt /
      FLOT   Floete
      SMOR   Smoer
/;
*
*
     SET MOELVARE(VARE) Moellevarer /
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for

      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for

      FMKN   Matkorn hvete rug akrn til for
      FFKN   Forkorn bygg havre til for
      FBLG   Belgvekster raps erter til for
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
/;

     SET VARE_TIL_MOEL(VARE,MOEL) Moelleprosesser og moellevarer /
       HVEM.HVEM
       RUGM.RUGM
       BYGM.BYGM
       HAVM.HAVM
       AKRM.AKRM
       RAPM.RAPM
       ERTM.ERTM
       FDRM.FDRM
       FDRA.FDRA
       FSVN.FSVN
       FKYL.FKYL
       FEGG.FEGG
/;
*
      SET KALIBKFORVARE(VARE) Kraftforvarer til kalibrering av PMP/
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FGRV   Grovf�r
/;
*5
*
     SET MOELINNVARE(VARE) Varer fra gård til moeller /
       HVEM   Hvete til mat
       HVEF   Hvete til for
       RUGM   Rug til mat
       RUGF   Rug til for
       BYGM   Bygg til mat
       BYGF   Bygg til for
       HAVM   Havre til mat
       HAVF   Havre til for
       AKRM   Rughvete til mat
       AKRF   Rughvete til for

       RAPM   Oljefroe til mat
       RAPF   Oljefroe til for
       ERTM   Belgfrukter til mat
       ERTF   Belgfrukter til for
/;

     SET MOELUTVARE(VARE) Varer fra moeller til gård eller konsum /
       HVEM   Hvete til mat
       RUGM   Rug til mat
       BYGM   Bygg til mat
       HAVM   Havre til mat
       AKRM   Rughvete til mat
       RAPM   Oljefroe til mat
       ERTM   Belgfrukter til mat
       FDRM   Kraftfor droevtygger melk
       FDRA   Kraftfor droevtygger annet
       FSVN   Kraftfor svin
       FKYL   Kyllingfor
       FEGG   Hoenefor
/;
      SET MOELUTKVARE(VARE) Varer fra moeller til gård /
       FDRM   Kraftfor droevtygger melk
       FDRA   Kraftfor droevtygger annet
       FSVN   Kraftfor svin
       FKYL   Kyllingfor
       FEGG   Hoenefor
/;
*
*
     SET MOELFLYT(VARE,VARE) Varestroem i moeller /
       HVEM.HVEM
       RUGM.RUGM
       BYGM.BYGM
       HAVM.HAVM
       AKRM.AKRM
       RAPM.RAPM
       ERTM.ERTM      
       FMKN.(HVEF, RUGF, AKRF)
       FFKN.(BYGF, HAVF)
       FBLG.(RAPF, ERTF)
       FGRP.FGRP
/;
*
     SET MOEL_TIL_VARE(MOEL,VARE) Moelleaktiviteter til produkter /
      FDRM.(KMLK, GMLK, STFK, KLVK, SAUK)
      FDRA.(KMLK, GMLK, STFK, KLVK, SAUK)
      FSVN.SVNK
      FKYL.FJRK
      FEGG.EGGS
/;
*
     SET MLMVARE(VARE) Mellomprodukter fra gardsbruk til foredling /
      KMLK   Kumelk
      GMLK   Geitmelk
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
*
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      STKK   Storfe og kalvekjoett
      SAGK   Sau lam geit og kjekjoett
/;
*
     SET INNSATS(VARE) Alle innsatsfaktorer  /
      SAAK   Saakorn og saafroe
      PLVR   Plantevernmidler
      NITG   Nitrogen fra handelsgjoedsel
      FOSG   Fosfor fra handelsgjoedsel
      KALG   Kali fra handelsgjoedsel
      NITR   Nitrogengjoedsel
      FOSF   Fosforgjoedsl
      KALI   Kaliumgjoedsel
      KALK   Kalk
      IKYR   Ung ku
      IKVG   Ung kvige
      IOKS   Ung okse
      IKVK   Ung kvigekalv
      IOKK   Ung oksekalv
      VETM   Dyrelege og medisin
      INSM   Inseminering
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
      FGRV   Grovfor
      FFEM   Forenheter droevtygger
      FFEG   Forenheter svin
      FFEF   Forenheter fjoerfe

      FMKN   Matkorn til for
      FFKN   Forkorn til for
      FSOY   Soya til for
      FBLG   Belgvekster raps og erter til for
      FANT   Annet til for

      VEDB   Vedlikehold bygninger
      VEDM   Vedlikehold maskiner
      AVSB   Avskrivninger bygninger
      AVSM   Avskrivninger maskiner
      EKRF   Kraft
      EBRN   Brensel diesel og bensin
      EFOL   Fyringsolje
      ESMR   Smoeremidler
      KAPB   Kapital bygninger
      KAPM   Kapital maskiner
      KAPD   Kapital dyr
      KAPJ   Kapital jord
      KAPK   Kapital kvoter
      ARBF   Eget arbeid
      ARBL   Leid arbeid
      AKST   Andre kostnader
/;
*
     SET INNSATM(VARE) Innsatsfaktorer med pris ulik 1 /
      SAAK   Saakorn og saafroe
      NITR   Nitrogengjoedsel
      FOSF   Fosforgjoedsl
      KALI   Kaliumgjoedsel
      KALK   Kalk
      IKYR   Ung ku
      IKVG   Ung kvige
      IOKS   Ung okse
      IKVK   Ung kvigekalv
      IOKK   Ung oksekalv
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
      FGRV   Grovfor
      FFEM   Forenheter droevtygger
      FFEG   Forenheter svin
      FFEF   Forenheter fjoerfe
      EKRF   Kraft
      EBRN   Brensel diesel og bensin
      EFOL   Fyringsolje
      ESMR   Smoeremidler
      KAPB   Kapital bygninger
      KAPM   Kapital maskiner
      KAPD   Kapital dyr
      KAPJ   Kapital jord
      KAPK   Kapital kvoter
      ARBF   Eget arbeid
      ARBL   Leid arbeid
/;
*
     SET INNSATV(VARE) Innsatsfaktorer med pris lik 1 /
      PLVR   Plantevernmidler
      VETM   Dyrelege og medisin
      INSM   Inseminering
      VEDB   Vedlikehold bygninger
      VEDM   Vedlikehold maskiner
      AVSB   Avskrivninger bygninger
      AVSM   Avskrivninger maskiner
      AKST   Andre kostnader
/;
*
     SET INNSATSUKFOR(VARE) Alle innsatsfaktorer  uten kraftfôrvarer /
      SAAK   Saakorn og saafroe
      PLVR   Plantevernmidler
      NITG   Nitrogen fra handelsgjoedsel
      FOSG   Fosfor fra handelsgjoedsel
      KALG   Kali fra handelsgjoedsel
      NITR   Nitrogengjoedsel
      FOSF   Fosforgjoedsl
      KALI   Kaliumgjoedsel
      KALK   Kalk
      IKYR   Ung ku
      IKVG   Ung kvige
      IOKS   Ung okse
      IKVK   Ung kvigekalv
      IOKK   Ung oksekalv
      VETM   Dyrelege og medisin
      INSM   Inseminering

      VEDB   Vedlikehold bygninger
      VEDM   Vedlikehold maskiner
      AVSB   Avskrivninger bygninger
      AVSM   Avskrivninger maskiner
      EKRF   Kraft
      EBRN   Brensel diesel og bensin
      EFOL   Fyringsolje
      ESMR   Smoeremidler
      KAPB   Kapital bygninger
      KAPM   Kapital maskiner
      KAPD   Kapital dyr
      KAPJ   Kapital jord
      KAPK   Kapital kvoter
      ARBF   Eget arbeid
      ARBL   Leid arbeid
      AKST   Andre kostnader
/;
     SET INNSVL(VARE) Innsatsfaktorer til vederlag for arbeid kapital og jord /
      KAPB   Kapital bygninger
      KAPM   Kapital maskiner
      KAPD   Kapital dyr
      KAPJ   Kapital jord
      KAPK   Kapital kvoter
      ARBF   Eget arbeid
      ARBL   Leid arbeid
/;
*
     SET INNARB(VARE) Innsatsfaktorer arbeid  /
      ARBF   Eget arbeid
      ARBL   Leid arbeid
      LONN   Arbeid slakterier
/;
*
     SET INNKAP(VARE) Innsatsfaktorer kapital /
      KAPB   Kapital bygninger
      KAPM   Kapital maskiner
      KAPD   Kapital dyr
      KAPJ   Kapital jord
      KAPK   Kapital kvoter
/;
*
     SET GJOD(VARE) Gjoedsel /
      NITR   Nitrogengjoedsel
      FOSF   Fosforgjoedsl
      KALI   Kaliumgjoedsel
/;
     SET HGJOD(VARE) Handelsgjoedsel /
      NITG   Nitrogen fra handelsgjoedsel
      FOSG   Fosfor fra handelsgjoedsel
      KALG   Kali fra handelsgjoedsel
/;
*
    SET INNTDB(VARE) Inntekter til beregning av DB /
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
*
      RAPM   Oljefroe til mat
      RAPF   Oljefore til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
      POTE   Poteter
*
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      SPRE   Spredeareal
*
      KMLK   Kumelk
      GMLK   Geitmelk
*
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      FJRK   Fjoerfekjoett
*
      EGGS   Egg
/;
*
     SET INNSATDB(VARE) Innsatsfaktorer til beregning av DB /
      SAAK   Saakorn og saafroe
      PLVR   Plantevernmidler
      NITG   Nitrogen fra handelsgjoedsel
      FOSG   Fosfor fra handelsgjoedsel
      KALG   Kali fra handelsgjoedsel
      KALK   Kalk
      VETM   Dyrelege og medisin
      INSM   Inseminering
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
      FGRV   Grovfor
      VEDB   Vedlikehold bygninger
      VEDM   Vedlikehold maskiner
      EKRF   Kraft
      EBRN   Brensel diesel og bensin
      EFOL   Fyringsolje
      ESMR   Smoeremidler
      AKST   Andre kostnader
/;
*
    SET SIMVARE(VARE) Vare med endogene prisendringer mellom iterasjonene /
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
*
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
      POTE   Poteter
*
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      SPRE   Spredeareal
*
      KMLK   Kumelk
      GMLK   Geitmelk
*
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      FJRK   Fjoerfekjoett
*
      EGGS   Egg
*
      MLKD   Konsummelk dagligvare
      MLKI   Konsummelk industri
      MLKS   Sjokomelk
      YOGH   Yoghurt
      OSTD   Hvitost daglivare
      OSTI   Hvitost industri
      OSTK   Kremost
      OSTM   Mysost
      OSTG   Geitost
      OSTE   Jarlsberg til eksport
      OSTX   Divere oster til eksport
      SKMP   Melkepulver
      FLOT   Floete
      SMOR   Smoer
*
*   Slakterier
*
      STKK   Storfe- og kalvekjoett
      SAGK   Saue- lam- geit- og kjekjoett
*     SVNK   Svinekjoett
*
      PRIN   Produksjonskoett og innmat
*
      KYST   Foredlet stykket kjoett storfe
      KYSA   Foredlet stykket kjoett saulam
      KYSV   Foredlet stykket kjoett gris
      KBST   Foredlet biff og filet  storfe
      KBSA   Foredlet biff og filet  saulam
      KBSV   Foredlet biff og filet  gris
      KSST   Foredlet saltet roekt og marinert kjoett storfe
      KSSA   Foredlet saltet roekt og marinert kjoett saulam
      KSSV   Foredlet saltet roekt og marinert kjoett gris
*
      KDEI   Kjoettdeig
      KPOL   Poelser
      KPAL   Paalegg
      KSPP   Spekepoelser
      KSPV   Spekevarer
      KDIV   Diverse kjoettvarer
*
      KHEL   Hel kylling
      KFIL   Kyllingfilet
      KANT   Annen kylling
*
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
*
      FMKN   Matkorn til for
      FFKN   Forkorn til for
      FBLG   Belgvekster til for

      FGRP   Gras protein paste
      FGRJ   Gras protein residue juice
*
      KAPK   Kvoter i melk og geit
/;
*
    SET HAGE(VARE) Vare innen hagebruk /
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
/
;
    SET GRON(VARE) Grønnsaker til beregning av helseeffekt /
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
/
;
*
    SET FRKT(VARE) Frukt til beregning av helseeffekt /
      EPLE   Frukt paa traer
      AFRU   Annen frukt
/
;

     SET KostGrp Grupper av varer for beregning av helseeffekter av kosthold /
      GRON
      FRKT
      BEARBKJOETT
      RENTKJOETT
      MEIMVARE
/;
     

     SET KostVare(KostGrp,Vare) Kobling mellom kostgrupper og varer /
      GRON.(set.gron)
      FRKT.(set.frkt)
      BEARBKJOETT.(set.bearbkjoett)  
      RENTKJOETT.(set.rentkjoett)
      MEIMVARE.(set.meimvare)
/;
     
     SET FoodGrp Food groups with dietary recommendations /
      GREENS
      PRMEAT
      DAIRY
/;

     SET FoodVare(FoodGrp,Vare) Link between food groups and single food product /
      GREENS.(set.gron, set.frkt)
      PRMEAT.(set.bearbkjoett, set.rentkjoett)
      DAIRY.(set.meidvare)
/;

*
*
     SET PRJBVARE(VARE) Varer til utskrift til totalkalkyle primaerjordbruk/
*
*** Produkter
*
*   Planteprodukter
*
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
*
      RAPM   Oljefroe til mat
      RAPF   Oljefroe til for
      ERTM   Belgfrukter til mat
      ERTF   Belgfrukter til for
      POTE   Poteter
*
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
*
*   Husdyrprodukter
*
      KMLK   Kumelk
      GMLK   Geitmelk
*
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinekjoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      FJRK   Fjoerfekjoett
*
      EGGS   Egg
*
*   Biprodukter husdyrproduksjon
*
      ULLS   Ull fra sau
*
*** Innsatsfaktorer
*
*   Spesifikk for planteproduksjon
*
      SAAK   Saakorn og saafroe
      PLVR   Plantevernmidler
*
      NITG   Nitrogen fra handelsgjoedsel
      FOSG   Fosfor fra handelsgjoedsel
      KALG   Kali fra handelsgjoedsel
*
      NITR   Nitrogengjoedsel
      FOSF   Fosforgjoedsl
      KALI   Kaliumgjoedsel
      KALK   Kalk
*
*   Spesifikk for husdyrproduksjon
*
      VETM   Dyrelege og medisin
      INSM   Inseminering
*
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
*
*   Generelle innsatsfaktorer
*
      VEDB   Vedlikehold bygninger
      VEDM   Vedlikehold maskiner
      AVSB   Avskrivninger bygninger
      AVSM   Avskrivninger maskiner
      EKRF   Kraft
      EBRN   Brensel diesel og bensin
      EFOL   Fyringsolje
      ESMR   Smoeremidler
      KAPB   Kapital bygninger
      KAPM   Kapital maskiner
      KAPD   Kapital dyr
      KAPJ   Kapital jord
      KAPK   Kapital kvoter
      ARBF   Eget arbeid
      AKST   Andre kostnader
*
*   Tilskudd
*
      TGRUN  Grunntilskudd
      TDISM  Distriktstilskudd for melk
      TDISK  Distriktstilskudd for kjoett
      TDISE  Distriktstilskudd for egg og fjoerfe
      TDISG  Distriktstilskudd for groent og potet
      TDMLK  Driftstilskudd melk
      TPROD  Produksjonstillegg husdyr
      TAKTL  Areal og kulturlandskapstillegg
      TSKAT  Fradrag for jordbruksinntekt
      TFRKT  Frakttilskudd
      TKORN  Prisnedskriving norsk korn og matkorntilskudd
      TBEIT  Beitetilskudd
      TVELF  Velferdsordninger
      TATIL  Andre tilskudd
      THIST  Tilskudd basert paa historiske rettigheter
      TPIPE  Pipetilskudd
      TARBF  Tilskudd basert p� arbeidsinnsats
      TKLIA  Tilskudd for � kompensere klimatiltak i jordbruket per aktivitet
      TKLIV  Tilskudd for � kompensere klimatiltak i jordbruket per vare
      TKFOR       Frakttilskudd for
      TENDO  Modellgenererte endogene tilskudd
/;


SET DGVARE /ARBP, ARBT, KAPB, KAPM, VEDB, VEDM, PLVR, VETM, AKST/;
SET DGVAREEXP(VARE) /KAPB, KAPM/;
SET DGVARELIN(VARE) /VEDB, VEDM, PLVR, VETM, AKST/;
SET DGVAREVARE(VARE) /KAPB, KAPM, VEDB, VEDM, PLVR, VETM, AKST/;

* Definisjon av klimatiltak
SET KLTK Klimatiltak /
         GRKL       Bedre kvalitet p� grovf�r med lav kostnad
         GRKH       Bedre kvalitet p� grovf�r med h�y kostnad
         GJSL       Spredning av husdyrgj�dsel med lav kostnad
         GJSH       Spredning av husdyrgj�dsel med h�y kostnad
         BIGL       Biogassanlegg med lav kostnad
         BIGH       Biogassanlegg med h�y kostnad
         KRFL       Klimavennlig kraftfor med lav kostnad
         KRFH       Klimavennlig kraftfor med h�y kostnad
         LAGL       Laglighet med lav kostnad
         LAGH       Laglighet med h�y kostnad
         GRFL       Gr�fting med lav kostnad
         GRFH       Gr�fting med h�y kostnad
         VSFL       Vekstskifte korn med gras og oljevekster lav kostnad
         VSFH       Vekstskifte korn med gras og oljevekster h�y kostnad
/;

SET KLTKL(KLTK) Klimatiltak med lave kostnader /
         GRKL       Bedre kvalitet p� grovf�r med lav kostnad
         GJSL       Spredning av husdyrgj�dsel med lav kostnad
         BIGL       Biogassanlegg med lav kostnad
         KRFL       Klimavennlig kraftfor med lav kostnad
         LAGL       Laglighet med lav kostnad
         GRFL       Gr?fting med lav kostnad
         VSFL       Vekstskifte korn med gras og oljevekster lav kostnad
/;

SET KLTKH(KLTK) Klimatiltak med h?ye kostnader /
         GRKH       Bedre kvalitet p? grovf?r med h?y kostnad
         GJSH       Spredning av husdyrgj?dsel med h?y kostnad
         BIGH       Biogassanlegg med h?y kostnad
         KRFH       Klimavennlig kraftfor med h?y kostnad
         LAGH       Laglighet med h?y kostnad
         GRFH       Gr?fting med h?y kostnad
         VSFH       Vekstskifte korn med gras og oljevekster h?y kostnad
/;


*
*     Matvaredeklarasjon
*
     SET NSTOFF Naeringsstoffer i matvarer  /

      ENER  Energi
      PROT  Protein
      FETT  Fett
      FFEM  Forverdi FEM
/;
     SET B_PRDK_VARE(B,PRDK,VARE) Kombinasjon av B PRDK og VARE til fordeling av utslipp /

      BKRN.(HVEM,HVEF,RUGM,RUGF,BYGM,BYGF,HAVM,HAVF,AKRM,AKRF,RAPM,RAPF,ERTM,ERTF).(HVEM,HVEF,RUGM,RUGF,BYGM,BYGF,HAVM,HAVF,AKRM,AKRF,RAPM,RAPF,ERTM,ERTF)
      BPTE.POTE.POTE
      BHGE.(GRNV,GRNF,BLOM).(GRNV,GRNF,BLOM)
      BFRK.(EPLE,AFRU).(EPLE,AFRU)
      BKMK.(GFFS,GFFB,GFOS,GFOB,GFIB,MKYR,OKSS,KVGS,KVGO,OKKS,KVKS,OKKO,KVKO).(KMLK,STFK,KLVK)
      BGMK.(GFFS,GFFB,GFOS,GFOB,GFIB,GEIT,KJES).(GMLK,GETK)
      BAKY.(GFFS,GFFB,GFOS,GFOB,GFIB,AKYR,OKSS,KVGS,KVGO,OKKS,KVKS,OKKO,KVKO).(STFK,KLVK)
      BGRI.(GRIS,PURK).SVNK
      BSAU.(GFFS,GFFB,GFOS,GFOB,GFIB,SOEY,LAMS).SAUK
      BKYL.KYLS.FJRK
      BHOE.HOEN.EGGS
/;

     SET KLIM_VARE_TIL_PRDK(PRDK,VARE) Kombinasjon av PRDK og VARE til beregning av utslipp for planteprodukter /

      HVEM.HVEM
      HVEF.HVEF
      RUGM.RUGM
      RUGF.RUGF
      BYGM.BYGM
      BYGF.BYGF
      HAVM.HAVM
      HAVF.HAVF
      AKRM.AKRM
      AKRF.AKRF
      RAPM.RAPM
      RAPF.RAPF
      ERTM.ERTM
      ERTF.ERTF
      POTE.POTE
      GRNV.GRNV
      GRNF.GRNF
      EPLE.EPLE
      AFRU.AFRU
      BLOM.BLOM
      GFFS.GFFS
      GFFB.GFFB
      GFOS.GFOS
      GFOB.GFOS
      GFIB.GFIB
/;

     SET VARE_TIL_PRDK(PRDK,VARE) Kombinasjon av PRDK og VARE til fordeling av skjermingstoette /

      HVEM.HVEM
      HVEF.HVEF
      RUGM.RUGM
      RUGF.RUGF
      BYGM.BYGM
      BYGF.BYGF
      HAVM.HAVM
      HAVF.HAVF
      AKRM.AKRM
      AKRF.AKRF
      RAPM.RAPM
      RAPF.RAPF
      ERTM.ERTM
      ERTF.ERTF
      POTE.POTE
      GRNV.GRNV
      GRNF.GRNF
      EPLE.EPLE
      AFRU.AFRU
      BLOM.BLOM
     (GFFS,GFFB,GFOS,GFOB,GFIB,MKYR,AKYR,OKSS,KVGS,KVGO,OKKS,KVKS,OKKO,KVKO,GEIT,SOEY,LAMS,KJES).(KMLK,GMLK,STFK,KLVK,SAUK,GETK)
     (GRIS,PURK).SVNK
      KYLS.FJRK
      HOEN.EGGS
/;

SET PtMngd_til_VARE(VARE,PtMngd) Kobling mellom varer i Jordmod og varer fra produksjonstilleggsregister /
         BYGF.bygg_for_kg
         BYGF.bygg_sakorn_kg
         BYGM.bygg_mat_kg
         ERTF.erter_for_kg
         ERTM.erter_mat_kg
         ERTF.erter_saakorn_kg
         HAVF.havre_for_kg
         HAVF.havre_saakorn_kg
         HVEF.hvete_for_kg
         HVEM.hvete_mat_kg
         HVEF.hvete_saakorn_kg
         RAPF.oljefro_kg
         RAPF.oljefro_saakorn_kg
         RUGF.rug_for_kg
         RUGM.rug_mat_kg
         RUGF.rug_saakorn_kg
         AKRF.rughvete_for_kg
         AKRF.rughvete_saakorn_kg
         BYGF.bygg_saakorn_kg
         ERTF.erter_sakorn_kg
         HAVF.havre_sakorn_kg
         HVEF.hvete_sakorn_kg
         RAPM.oljefro_sakorn_kg
         RUGF.rug_sakorn_kg
         AKRF.rughvete_sakorn_kg
         KMLK.kumelk_liter
         GMLK.geitemelk_liter
         FJRK.and_kg
         GETK.geit_kg
         SVNK.gris_kg
         FJRK.gaas_kg
         FJRK.hane_kg
         FJRK.hons_kg
         FJRK.kalkun_kg
         STFK.kalv_kg
         GETK.kje_kg
         STFK.ku_kg
         STFK.kvige_kg
         FJRK.kylling_kg
         SAUK.lam_kg
         SAUK.lam_villsau_kg
         STFK.okse_kg
         SVNK.purke_kg
         SVNK.raane_kg
         SAUK.sau_kg
         STFK.ungokse_kastrat_kg
         ULLS.ull_kg
         STFK.ungku_kg
         SAUK.ungsau_kg
         SAUK.vaer_kg
         EGGS.egg_kg
/;
    SET AHUSDYR_TIL_VARE(PRDK,VARE) Produksjon av droevtygger uten melk /
       AKYR.STFK
       OKSS.STFK
       KVGS.STFK
       OKKS.KLVK
       KVKS.KLVK
       SOEY.SAUK
       LAMS.SAUK
       GEIT.GMLK
/;
*
    SET AHUSDYR_TIL_MOEL(PRDK,VARE) Varer til Pmp;
    
AHUSDYR_TIL_MOEL(AHUSDYR,'FFEM') = YES;
AHUSDYR_TIL_MOEL(AHUSDYR,'FGRV') = YES;
AHUSDYR_TIL_MOEL(AHUSDYR,'FDRM') = YES;
AHUSDYR_TIL_MOEL(AHUSDYR,'FDRA') = YES;

*     Intensitet
*
     SET EKSI(VARE,PRDK) Input-output-kombinasjoner;
* eksogen intensitet for alle I-O kombinasjoner
EKSI(VARE,PRDK) = YES;
* endogen intensitet for utvalgtge I-O kombinasjoner
* melkeytelse og foring
EKSI('KMLK','MKYR') = NO;
EKSI('FDRM','MKYR') = NO;
EKSI('FGRV','MKYR') = NO;

EKSI('NITH','MKYR') = NO;
EKSI('FOSH','MKYR') = NO;
EKSI('KALH','MKYR') = NO;

EKSI(VARE,PRDK) $ AHUSDYR_TIL_MOEL(PRDK,VARE) = NO;
EKSI(VARE,PRDK) $ AHUSDYR_TIL_VARE(PRDK,VARE) = NO;

* avlingsniva korn og gras med endogen nitrogengjoedsling
EKSI('HVEM','HVEM') = NO;
EKSI('HVEF','HVEF') = NO;
EKSI('RUGM','RUGM') = NO;
EKSI('RUGF','RUGF') = NO;
EKSI('BYGM','BYGM') = NO;
EKSI('BYGF','BYGF') = NO;
EKSI('HAVM','HAVM') = NO;
EKSI('HAVF','HAVF') = NO;
EKSI('AKRM','AKRM') = NO;
EKSI('AKRF','AKRF') = NO;
EKSI('GFFS','GFFS') = NO;
EKSI('GFFB','GFFB') = NO;
EKSI('GFOS','GFOS') = NO;
EKSI('GFOB','GFOB') = NO;
EKSI('GFIB','GFIB') = NO;
* nitrogenintensitet med endogen nitrogengjoedsling
EKSI('NITR','HVEM') = NO;
EKSI('NITR','HVEF') = NO;
EKSI('NITR','RUGM') = NO;
EKSI('NITR','RUGF') = NO;
EKSI('NITR','BYGM') = NO;
EKSI('NITR','BYGF') = NO;
EKSI('NITR','HAVM') = NO;
EKSI('NITR','HAVF') = NO;
EKSI('NITR','AKRM') = NO;
EKSI('NITR','AKRF') = NO;
EKSI('NITR','GFFS') = NO;
EKSI('NITR','GFFB') = NO;
EKSI('NITR','GFOS') = NO;
EKSI('NITR','GFOB') = NO;
EKSI('NITR','GFIB') = NO;
* nitrogen fra handelsgjoedsel eller husdyrgjoedsel
EKSI('NITG',PLANTE) = NO;
EKSI('NITH',PLANTE) = NO;
EKSI('NITH',HUSDYR) = NO;
* fosfor fra handelsgjoedsel eller husdyrgjoedsel
EKSI('FOSG',PLANTE) = NO;
EKSI('FOSH',PLANTE) = NO;
* kali fra handelsgjoedsel eller husdyrgjoedsel
EKSI('KALG',PLANTE) = NO;
EKSI('KALH',PLANTE) = NO;
* stordrift arbeid og kapital
EKSI('KAPB',PRDK)   = NO;
EKSI('AVSB',PRDK)   = NO;
EKSI('KAPM',PRDK)   = NO;
EKSI('AVSM',PRDK)   = NO;
EKSI('ARBF',PRDK)   = NO;
* DG coefficients
EKSI('PLVR',PRDK) = NO;
EKSI('VETM',PRDK) = NO;
EKSI('VEDB',PRDK) = NO;
EKSI('VEDM',PRDK) = NO;
EKSI('AKST',PRDK) = NO;
*
* miljoindikatorer og utslipp
EKSI('GE      ',PRDK) = NO;
EKSI('YM      ',PRDK) = NO;
EKSI('VSDM    ',PRDK) = NO;
EKSI('NITHX   ',PRDK) = NO;
EKSI('CH4     ',PRDK) = NO;
EKSI('N2O     ',PRDK) = NO;
EKSI('CO2     ',PRDK) = NO;
EKSI('NH3     ',PRDK) = NO;
EKSI('N       ',PRDK) = NO;
EKSI('CH4E    ',PRDK) = NO;
EKSI('CH4M    ',PRDK) = NO;
EKSI('CH4B    ',PRDK) = NO;
EKSI('N2OMM   ',PRDK) = NO;
EKSI('N2OM    ',PRDK) = NO;
EKSI('N2OB    ',PRDK) = NO;
EKSI('N2OS    ',PRDK) = NO;
EKSI('N2ONH3MMNED',PRDK) = NO;
EKSI('N2ONH3MMAVR',PRDK) = NO;
EKSI('N2ONH3NED',PRDK) = NO;
EKSI('N2ONH3AVR',PRDK) = NO;
EKSI('N2OAVL  ',PRDK) = NO;
EKSI('N2OBRN  ',PRDK) = NO;
EKSI('N2OMYR  ',PRDK) = NO;
EKSI('NH3MMNED',PRDK) = NO;
EKSI('NH3MMAVR',PRDK) = NO;
EKSI('NH3NED  ',PRDK) = NO;
EKSI('NH3AVR  ',PRDK) = NO;
EKSI('NAVL    ',PRDK) = NO;
EKSI('NTAP    ',PRDK) = NO;
EKSI('CO2SOUR ',PRDK) = NO;
EKSI('CO2SINK ',PRDK) = NO;
EKSI('CO2KALK ',PRDK) = NO;
*
     SET VARETOT Varer som er med i totalkalkylesammenheng/
      HVEM   Hvete til mat
      HVEF   Hvete til for
      RUGM   Rug til mat
      RUGF   Rug til for
      BYGM   Bygg til mat
      BYGF   Bygg til for
      HAVM   Havre til mat
      HAVF   Havre til for
      AKRM   Rughvete til mat
      AKRF   Rughvete til for
      RAPM
      RAPF
      ERTM
      ERTF
      POTE   Poteter
      GRNV   Groennsaker i veksthus
      GRNF   Groennsaker paa friland
      EPLE   Frukt paa traer
      AFRU   Annen frukt
      BLOM   Blomster
      GFFS   Grovfor paa fulldyrket jord til slatt
      GFFB   Grovfor paa fulldyrket jord til beite
      GFOS   Grovfor paa overflatedyrket jord til slatt
      GFOB   Grovfor paa overflatedyrket jord til beite
      GFIB   Grovfor paa innmarksbeite
      GFUB   Grovfor paa utmark
      KMLK   Kumelk
      GMLK   Geitmelk
      STFK   Storfekjoett
      KLVK   Kalvekjoett
      SVNK   Svinejkoett
      SAUK   Saue og lammejkoett
      GETK   Geite og kjejkoett
      FJRF   Fjoerfekjoett
      EGGS   Egg
      OKYR   Ung ku
      OKVG   Ung kvige
      OOKS   Ung okse
      OKVK   Ung kvigekalv
      OOKK   Ung oksekalv
      NITH   Nitrogen fra husdyr
      FOSH   Fosfor fra husdyr
      KALH   Kalium fra husdyr
      ULLS   Ull fra sau
      SAAK   Saakorn og saafroe
      PLVR   Plantevernmidler
      NITR   Nitrogengjoedsel
      FOSF   Fosforgjoedsl
      KALI   Kaliumgjoedsel
      KALK   Kalk
      IKYR   Ung ku
      IKVG   Ung kvige
      IOKS   Ung okse
      IKVK   Ung kvigekalv
      IOKK   Ung oksekalv
      VETM   Dyrelege og medisin
      INSM   Inseminering
      FDRM   Kraftfor droevtygger melk
      FDRA   Kraftfor droevtygger annet
      FSVN   Kraftfor svin
      FKYL   Kyllingfor
      FEGG   Hoenefor
      FGRV   Grovfor
      VEDB   Vedlikehold bygninger
      VEDM   Vedlikehold maskiner
      AVSB   Avskrivninger bygninger
      AVSM   Avskrivninger maskiner
      EKRF   Kraft
      EBRN   Brensel diesel og bensin
      EFOL   Fyringsolje
      ESMR   Smoeremidler
      KAPB   Kapital bygninger
      KAPM   Kapital maskiner
      KAPD   Kapital dyr
      KAPJ   Kapital jord
      KAPK   Kapital kvoter
      ARBF   Eget arbeid
      ARBL   Leid arbeid
      AKST   Andre kostnader
/;

     SET PRDK_TIL_VARE(PRDK,VARE) Hovedprodukter i produksjoner /
       (HVEM.HVEM)
       (HVEF.HVEF)
       (RUGM.RUGM)
       (RUGF.RUGF)
       (BYGM.BYGM)
       (BYGF.BYGF)
       (HAVM.HAVM)
       (HAVF.HAVF)
       (AKRM.AKRM)
       (AKRF.AKRF)
*
       (RAPM.RAPM)
       (RAPF.RAPF)
       (ERTM.ERTM)
       (ERTF.ERTF)
*
       (POTE.POTE)   Poteter
       (GRNV.GRNV)   Groennsaker i veksthus
       (GRNF.GRNF)   Groennsaker paa friland
       (EPLE.EPLE)   Frukt paa traer
       (AFRU.AFRU)   Annen frukt
       (BLOM.BLOM)   Blomster
*
       (GFFS.GFFS)   Grovfor paa fulldyrket jord til slatt
       (GFFB.GFFB)   Grovfor paa fulldyrket jord til beite
       (GFOS.GFOS)   Grovfor paa overflatedyrket jord til slatt
       (GFOB.GFOB)   Grovfor paa overflatedyrket jord til beite
       (GFIB.GFIB)   Grovfor paa innmarksbeite
       (GFUB.GFUB)   Grovfor paa utmark
*
       (MKYR.KMLK)   Melkekyr
       (AKYR.STFK)   Ammekyr
       (OKSS.STFK)   Okser til slakt
       (KVGS.STFK)   Kviger til slakt
*       (KVGO.)   Kviger til oppdrett
       (OKKS.KLVK)   Oksekalver til slakt
       (KVKS.KLVK)   Kvigekalver til slakt
*       (OKKO.)   Oksekalver til oppdrett
*       (KVKO.)   Kvigekalver til oppdrett
       (GRIS.SVNK)   Slaktegriser
*       (PURK.)   Avlspurker
*       (SOEY.   Soeye
       (LAMS.SAUK)   Lam
       (GEIT.GMLK)   Melkegeit
*       (KJES.)   Killing
       (HOEN.EGGS)   Verpehoener
       (KYLS.FJRK)   Slaktekyllinger
/;
     SET B_TIL_VARE(B,VARE) Hovedprodukter for enkeltbruk i primaerjordbruket /
*
*     ***   Planteproduksjon
      BKRN.(HVEM,HVEF,RUGM,RUGF,BYGM,BYGF,HAVM,HAVF,AKRM,AKRF,RAPM,RAPF,ERTM,ERTF)  Bruk med korn og oljefroe
      BPTE.POTE  Bruk med potet
      BFRK.(EPLE,AFRU)  Bruk med frukt og baer
      BHGE.(GRNV,GRNF,BLOM)  Bruk med groennsaker og blomster
*
*     ***   Husdyrproduksjon
      BKMK.KMLK  Bruk med melkekyr og salg av kalver
      BGMK.GMLK  Bruk med geiter
      BAKY.(STFK,KLVK)  Bruk med ammekyr
      BSAU.SAUK  Bruk med sauer
      BGRI.SVNK  Bruk med griser
      BHOE.EGGS  Bruk med hoener
      BKYL.FJRK  Bruk med kyllinger
/;
*
     SET B_TIL_HRDK(B,PRDK) Hovedproduksjon for enkeltbruk i primaerjordbruket /
*
*     ***   Planteproduksjon
      BKRN.(HVEM,HVEF,RUGM,RUGF,BYGM,BYGF,HAVM,HAVF,AKRM,AKRF,RAPM,RAPF,ERTM,ERTF)  Bruk med korn og oljefroe
      BPTE.POTE  Bruk med potet og belgfrukter
      BFRK.(EPLE,AFRU)  Bruk med frukt og baer
      BHGE.(GRNV,GRNF,BLOM)  Bruk med groennsaker og blomster
*
*     ***   Husdyrproduksjon
      BKMK.MKYR  Bruk med melkekyr og salg av kalver
      BGMK.GEIT  Bruk med geiter
      BAKY.AKYR  Bruk med ammekyr
      BSAU.SOEY  Bruk med sauer
      BGRI.PURK  Bruk med griser
      BHOE.HOEN  Bruk med hoener
      BKYL.KYLS  Bruk med kyllinger
/;
     SET VARE_TIL_B(B,VARE) Varer til bruk ved prisoppdatering /
*
*     ***   Planteproduksjon
      BKRN.(HVEM,HVEF,RUGM,RUGF,BYGM,BYGF,HAVM,HAVF,AKRM,AKRF,RAPM,RAPF,ERTM,ERTF)
      BPTE.POTE
      BFRK.(EPLE, AFRU)
      BHGE.(GRNV, GRNF, BLOM)
      BKMK.KMLK
      BGMK.GMLK
      BAKY.(STFK, KLVK)
      BSAU.SAUK
      BGRI.SVNK
      BHOE.EGGS
      BKYL.FJRK
/;
*
     SET VAREALLOK(B,VARE) Varer med arealallokering /
*
*     ***   Planteproduksjon
      BKRN.(HVEM,HVEF,RUGM,RUGF,BYGM,BYGF,HAVM,HAVF,AKRM,AKRF,RAPM,RAPF,ERTM,ERTF)  Bruk med korn og oljefroe
      BFRK.(EPLE, AFRU)                                Bruk med frukt og baer
      BHGE.(GRNV, GRNF, BLOM)                          Bruk med groennsaker og blomster
      BKMK.(GFFS, GFOS, GFFB, GFOB, GFIB)              Bruk med melkekyr og salg av kalver
      BGMK.(GFFS, GFOS, GFFB, GFOB, GFIB)              Bruk med geiter
      BAKY.(GFFS, GFOS, GFFB, GFOB, GFIB)              Bruk med ammekyr
      BSAU.(GFFS, GFOS, GFFB, GFOB, GFIB)              Bruk med sauer
/;
     SET PRDKALLOK(B,PRDK) Aktiviteter med arealallokering /
*
*     ***   Planteproduksjon
      BKRN.(HVEM,HVEF,RUGM,RUGF,BYGM,BYGF,HAVM,HAVF,AKRM,AKRF,RAPM,RAPF,ERTM,ERTF)  Bruk med korn og oljefroe
      BFRK.(EPLE, AFRU)                                Bruk med frukt og baer
      BHGE.(GRNV, GRNF, BLOM)                          Bruk med groennsaker og blomster
      BKMK.(GFFS, GFOS, GFFB, GFOB, GFIB,
            OKKS, KVKS, OKKO, KVKO)                    Bruk med melkekyr
      BGMK.(GFFS, GFOS, GFFB, GFOB, GFIB)              Bruk med geiter
      BAKY.(GFFS, GFOS, GFFB, GFOB, GFIB,
            OKKS, KVKS, OKKO, KVKO)                    Bruk med ammekyr
      BSAU.(GFFS, GFOS, GFFB, GFOB, GFIB)              Bruk med sauer
/;

     SET PRDKALLOKDYR(B,PRDK) Aktiviteter med allokering av dyr /
*
      BKMK.MKYR     Bruk med melkekyr
      BGMK.GEIT     Bruk med geiter
      BAKY.AKYR     Bruk med ammekyr
      BSAU.SOEY     Bruk med sauer
      BGRI.PURK     Bruk med sauer
      BHOE.HOEN     Bruk med sauer
      BKYL.KYLS     Bruk med sauer
/;

     SET FP_TIL_SLTVARE(VARE,FP) Hovedprodukt for foredlingsprosesser /
*
*     ***   Foredling kjoett
      (KDEI.KDEI)   Kjoettdeig
      (KPOL.KPOL)   Poelser
      (KPAL.KPAL)   Paalegg
      (KSPP.KSPP)   Spekepoelser
      (KSPV.KSPV)   Spekevarer
      (KDIV.KDIV)   Diverse kjoettvarer
/;
*
     SET VEKST(VARE,PRDK) Varer i produksjoner med eksogen vekstrate  /
       (RAPM.RAPM)   Oljefroe til mat
       (RAPF.RAPF)   Oljefroe til for
       (ERTM.ERTM)   Belgfrukter til mat
       (ERTF.ERTF)   Belgfrukter til for
       (POTE.POTE)   Poteter
       (GRNV.GRNV)   Groennsaker i veksthus
       (GRNF.GRNF)   Groennsaker paa friland
       (EPLE.EPLE)   Frukt paa traer
       (AFRU.AFRU)   Annen frukt
       (BLOM.BLOM)   Blomster
       (STFK.MKYR)   Melkekyr
       (STFK.AKYR)   Ammekyr
       (STFK.OKSS)   Okser til slakt
       (STFK.KVGS)   Kviger til slakt
       (STFK.KVGO)   Kviger til oppdrett
       (STFK.OKKS)   Oksekalver til slakt
       (STFK.KVKS)   Kvigekalver til slakt
       (STFK.OKKO)   Oksekalver til oppdrett
       (STFK.KVKO)   Kvigekalver til oppdrett
       (SVNK.GRIS)   Slaktegriser
       (SVNK.PURK)   Avlspurker
       (SAUK.SOEY)   Soeye
       (SAUK.LAMS)   Lam
       (GMLK.GEIT)   Melkegeit
       (GETK.GEIT)   Melkegeit
       (GETK.KJES)   Killing
       (EGGS.HOEN)   Verpehoener
       (FJRK.KYLS)   Slaktekyllinger
/;


     SET TILSKUDD(VARE) Direkte tilskudd over statsbudsjettet /
         TGRUN       Grunntilskudd
         TDISM       Distriktstilskudd for melk
         TDISK       Distriktstilskudd for kjoett
         TDISE       Distriktstilskudd for egg og fjoerfe
         TDISG       Distriktstilskudd for groent og potet
         TDMLK       Driftstilskudd melk
         TPROD       Produksjonstillegg husdyr
         TAKTL       Areal og kulturlandskapstillegg
         TSKAT       Fradrag for jordbruksinntekt
         TFRKT       Frakttilskudd
         TKORN       Prisnedskriving norsk korn og matkorntilskudd
         TBEIT       Tilskudd til beite
         TUTMK       Tilskudd til utmark
         TVELF       Velferdsordninger
         TATIL       Andre tilskudd
         THIST       Tilskudd basert paa historiske rettigheter
         TPIPE       Pipetilskudd
         TARBF       Tilskudd basert p� arbeidsinnsats
         TKLIA       Tilskudd for � kompensere klimatiltak i jordbruket per aktivitet
         TKLIV       Tilskudd for � kompensere klimatiltak i jordbruket per vare
         TKFOR       Frakttilskudd for
         TENDO       Modellgenererte endogene tilskudd
/;
*
     SET VARETIL(TILSKUDD) Direkte tilskudd pr produkt over statsbudsjettet   /
         TGRUN       Grunntilskudd
         TDISM       Distriktstilskudd for melk
         TDISK       Distriktstilskudd for kjoett
         TDISE       Distriktstilskudd for egg og fjoerfe
         TDISG       Distriktstilskudd for groent og potet
         TKORN       Prisnedskriving norsk korn og matkorntilskudd
         TKLIV       Tilskudd for � kompensere klimatiltak i jordbruket per vare
         TKFOR       Frakttilskudd for
         TENDO       Modellgenererte endogene tilskudd

/;
*
     SET PRDKTIL(TILSKUDD) Direkte tilskudd pr aktivitet over statsbudsjettet   /
         TGRUN       Grunntilskudd
         TDMLK       Driftstilskudd melk
         TPROD       Produksjonstillegg husdyr
         TAKTL       Areal og kulturlandskapstillegg
         TFRKT       Frakttilskudd
         TBEIT       Beitetilskudd
         TUTMK       Tilskudd til utmark
         TVELF       Velferdsordninger
         TATIL       Andre tilskudd
         TSKAT       Fradrag for jordbruksinntekt
         TARBF       Tilskudd basert p� arbeidsinnsats
         TKLIA       Tilskudd for � kompensere klimatiltak i jordbruket per aktivitet
         THIST       Tilskudd basert paa historiske rettigheter
         TPIPE       Pipetilskudd
         TENDO       Modellgenererte endogene tilskudd

/;
*
     SET TRINNTIL(TILSKUDD) Direkte tilskudd pr produkt med trappetrinn  /
         TDMLK       Driftstilskudd melk
         TPROD       Produksjonstillegg husdyr
         TAKTL       Areal og kulturlandskapstillegg
         TVELF       Velferdsordninger
         TSKAT       Fradrag for jordbruksinntekt
/;
*
     SET TILBLAA(TILSKUDD) Tilskudd i blaa boks /
         TDISM       Distriktstilskudd for melk
         TDISK       Distriktstilskudd for kjoett
         TDISE       Distriktstilskudd for egg og fjoerfe
         TDISG       Distriktstilskudd for groent og potet
         TDMLK       Driftstilskudd melk
         TPROD       Produksjonstillegg husdyr

/;
*
     SET TILSKUDB(VARE) Direkte tilskudd til beregning av dekningsbidrag /
         TGRUN       Grunntilskudd
         TDISM       Distriktstilskudd for melk
         TDISK       Distriktstilskudd for kjoett
         TDISE       Distriktstilskudd for egg og fjoerfe
         TDISG       Distriktstilskudd for groent og potet
         TDMLK       Driftstilskudd melk
         TPROD       Produksjonstillegg husdyr
         TAKTL       Areal og kulturlandskapstillegg
/;
*
     SET KLEF Effekt av klimatiltak /
         ABS        Absolutt endring
         REL        Relativ endring
/;
*
SET ARBKAP Resultatmaal arbeid og kapital enkeltbruk  /
         KAPT   Mengde KAPB og KAPM
         ARBT   Mengde ARBF og ARBL
         DBHP   DB pr hovedvare
         ARBK   Kostnader ARBF og ARBL
         ENHK   Enhetskostnader pr hovedvare
 /;
*
SET MBAL Posisjoner i markedsbalansen /
         PROD   Produksjon
         IMPO   Ordinaer import
         IMPQ   Kvoteimport MFN
         IMPA   Kvoteimport administrativt
         IMPB   Kvoteimport bilateralt
         IMPS   Kvoteimport sensitiv
         KNSM   Konsum
         EKSP   Eksport
/;

$ontext
SET SKJ(VARE) Varer for beregning av skjermingstoette?
/
         KMLK
         GMLK
         STKK
         SVNK
         SAGK
         FJRK
         BYGG
         HAVR
         HVET
         RUGH
         AKRN
         POTE
         EGGS
/;
$offtext
*
* Set for utslipp og miljoeindikatorer
*

SET SOROST(R)
/
    011101
    021101
    021103
    041101
    041203
    04125A
    051103
    05125A
    061101
    06125A
    071101
    081103
    081203
    08125A
    09225A
    10225A
    112102
    112203
    11215B
    11225B
/;
*
SET PA /KORNAREAL,ENGAREAL/;

*   Avrenningsomraader
SET P_TIL_PA(PA,PRDK)
/
KORNAREAL.(HVEM,HVEF,RUGM,RUGF,BYGM,BYGF,HAVM,HAVF,AKRM,AKRF,RAPM,RAPF,ERTM,ERTF,POTE)
ENGAREAL.(GFFS,GFFB,GFOS,GFOB,GFIB)
/;

SET BEITEDYR(PRDK)
/
       MKYR   Melkekyr
       AKYR   Ammekyr
       OKSS   Okser til slakt
       KVGS   Kviger til slakt
       KVGO   Kviger til oppdrett
       OKKS   Oksekalver til slakt
       KVKS   Kvigekalver til slakt
       OKKO   Oksekalver til oppdrett
       KVKO   Kvigekalver til oppdrett

       SOEY   Soeye
       LAMS   Lam
       GEIT   Melkegeit
       KJES   Killing
/;

SET BEITEBRUK(B)
/

      BKMK  Bruk med melkekyr og salg av kalver
      BGMK  Bruk med geiter
      BAKY  Bruk med ammekyr
      BSAU  Bruk med sauer
/;


SET SDDim4 /
FBLG
FFKN
FMKN
AFRU
AKRF
AKRM
AKST
AKYR
ANNT
ARBF
ARBL
AVAR
AVSB
AVSM
BLOM
BRAK
BYGF
BYGM
EBRN
EFOL
EGGS
EKRF
eller
EPLE
ERTF
ERTM
ESMR
FANT
FDRA
FDRM
FEGG
FFEF
FFEG
FFEM
FGRV
FJRK
FKYL
FLOT
FOSF
FOSG
FOSH
FSOY
FSVN
GE
GEIT
GETK
GFFB
GFFS
GFIB
GFOB
GFOS
GFUB
GMLK
GRIS
GRNF
GRNV
HAVF
HAVM
HOEN
HVEF
HVEM
IGET
IKVG
IKVK
IKYR
INNT
INSM
IOKK
IOKS
IPRK
ISAU
KALG
KALH
KALI
KALK
KANT
KAPB
KAPD
KAPJ
KAPK
KAPM
KBSA
KBST
KBSV
KDEI
KDIV
KFIL
KHEL
KJES
KLVK
KMLK
KPAL
KPOL
KSPP
KSPV
KSSA
KSST
KSSV
KVGO
KVGS
KVKO
KVKS
KYLS
KYSA
KYST
KYSV
LAMS
LONN
MKYR
MLKD
MLKI
MLKS
N
OKKO
OKKS
OKSS
OKVG
OKVK
OKYR
OOKK
OOKS
OSTD
OSTE
OSTG
OSTI
OSTK
OSTM
OSTX
PLVR
POTE
PRIN
PURK
RAPF
RAPM
RUGF
RUGM
SAGK
SAUK
SKMP
SLSA
SLST
SLSV
SMOR
SOEY
SPRE
STFK
STKK
SVNK
SAAK
TAKTL
TARBF
TATIL
TBEIT
TDISE
TDISG
TDISK
TDISM
TDMLK
TENDO
TFRKT
TGRUN
THIST
TKFOR
TKLIA
TKLIV
TKORN
TPIPE
TPROD
TSKAT
TUTMK
TVELF
ULLS
VEDB
VEDM
VETM
VSDM
YM
YOGH
omfg
     mngd
     verd
     enhk
     mdst
     prof
     min
     max
     ''

/;


SET SDDim5  /
FBLG
FFKN
FMKN
AFRU
AKRF
AKRM
AKST
AKYR
ANNT
ARBF
ARBL
AVAR
AVSB
AVSM
BLOM
BRAK
BYGF
BYGM
EBRN
EFOL
EGGS
EKRF
eller
EPLE
ERTF
ERTM
ESMR
FANT
FDRA
FDRM
FEGG
FFEF
FFEG
FFEM
FGRV
FJRK
FKYL
FLOT
FOSF
FOSG
FOSH
FSOY
FSVN
GE
GEIT
GETK
GFFB
GFFS
GFIB
GFOB
GFOS
GFUB
GMLK
GRIS
GRNF
GRNV
HAVF
HAVM
HOEN
HVEF
HVEM
IGET
IKVG
IKVK
IKYR
INNT
INSM
IOKK
IOKS
IPRK
ISAU
KALG
KALH
KALI
KALK
KANT
KAPB
KAPD
KAPJ
KAPK
KAPM
KBSA
KBST
KBSV
KDEI
KDIV
KFIL
KHEL
KJES
KLVK
KMLK
KPAL
KPOL
KSPP
KSPV
KSSA
KSST
KSSV
KVGO
KVGS
KVKO
KVKS
KYLS
KYSA
KYST
KYSV
LAMS
LONN
MKYR
MLKD
MLKI
MLKS
N
OKKO
OKKS
OKSS
OKVG
OKVK
OKYR
OOKK
OOKS
OSTD
OSTE
OSTG
OSTI
OSTK
OSTM
OSTX
PLVR
POTE
PRIN
PURK
RAPF
RAPM
RUGF
RUGM
SAGK
SAUK
SKMP
SLSA
SLST
SLSV
SMOR
SOEY
SPRE
STFK
STKK
SVNK
SAAK
TAKTL
TARBF
TATIL
TBEIT
TDISE
TDISG
TDISK
TDISM
TDMLK
TENDO
TFRKT
TGRUN
THIST
TKFOR
TKLIA
TKLIV
TKORN
TPIPE
TPROD
TSKAT
TUTMK
TVELF
ULLS
VEDB
VEDM
VETM
VSDM
YM
YOGH
     prof
     verd
     step
     ''

OMFG_LO 
OMFG_L  
OMFG_UP 

INTENS_LO 
INTENS_L  
INTENS_UP 

GROVAND_MIN
GROVAND_MAX

ARBEID_LO  
ARBEID_L   
ARBEID_UP  

BEITEAND_LO
BEITEAND_L 
BEITEAND_UP

PRIS_LO
PRIS_L 
PRIS_UP

OPPTAK_LO  
OPPTAK_L   
OPPTAK_UP  


/;
     