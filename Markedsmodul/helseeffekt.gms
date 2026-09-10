************************************************************************
*
*   Jordmod 
*
*   Ansvarlig: Klaus, Ruralis
*   Formaal: Parametre for beregning av helseeffekt av kosthold
*   Kommentarer: 
*   Status:
************************************************************************
* FØR
* Enhet: g per person og dag
*Parameter RefDiet(KostGrp) Diet in referance run /
*GRON        131.1905
*FRKT        178.6895
*BEARBKJOETT 58.14409838  
*RENTKJOETT  38.96979069
*MEIMVARE    283.9526
*/;
* NÅ
* Enhet: g per person og dag
* Source: Landwell, PH0ES0
Parameter RefDiet(KostGrp) Diet in referance run /
GRON        186.157            
FRKT         54.349              
BEARBKJOETT  40.986                    
RENTKJOETT   27.561                   
MEIMVARE    185.263            
/;
*
*
Parameter EatCorr(KostGrp) Correction for prepared and eaten food ;
EatCorr('GRON       ') =  1 ;
EatCorr('FRKT       ') =  1 ;
EatCorr('BEARBKJOETT') =  1 ;
EatCorr('RENTKJOETT ') =  1 ;
EatCorr('MEIMVARE   ') =  1 ;

*
* Enhet: g per person og dag
Parameter GBDDiet(KostGrp);
GBDDiet(KostGrp) = RefDiet(KostGrp);
*
*
* Minste resikonivå
PARAMETER TMREL(KostGrp) teoretisk inntak med minste risiko /
GRON            306
FRKT            340
BEARBKJOETT     0
RENTKJOETT      0
MEIMVARE        390
/;

$onText
Source:
Global Burden of Disease Study 2021 (GBD 2024) Dietary Risk Exposure Estimates 1990-2021, Table 1, Annex 1, p. 170
https://www.thelancet.com/journals/lancet/article/PIIS0140-6736(24)00933-4/fulltext#supplementaryMaterial

TMREL   g/day   
val lower   upper
RentKjoett  0   0   200
BearbKjoett 0   0   0
MEIMVARE    390 390 476
FRKT        340 340 350
GRON        306 306 372
$offtext

* mill kr
* https://www.helsedirektoratet.no/veiledere/virkninger-pa-helse-og-livskvalitet-i-utredninger-og-samfunnsokonomiske-analyser/helse-og-livskvalitetseffekter-i-samfunnsokonomiske-analyser#verdien-pa-et-statistisk-levear-vsly-anbefales-anvendt-som-okonomisk-verdi-i-nytte-kostnadsanalyser-i-de-tilfeller-der-helseenhetene-qaly-eller-daly-er-relevant-a-bruke-som-indikator-pa-endring-i-total-livskvalitet
* 1.68 mill 2023-kr
* 1.68 / 1.556 * 1.345 mill kr 2021-kr 
* 0.5% vekst i BNP 2021-2035
* KPI i tillegg

SCALAR VSL Verdien av et statistisk liv (mill kr); 
VSL = 1.68 / 1.556 * 1.345 * (1 + KPI + 0.005) ** (Y - %BAS%);
*
$if %SCEN%==SensVSL VSL = 1.68 / 1.556 * 1.345 * (1 + KPI) ** (Y - %BAS%);
*
*FØR
** Source: GBD2024.xlsx
*Parameter DALYPerG(KostGrp) Change in DALY per g per day change in diet group /
*RENTKJOETT  257.683
*BEARBKJOETT 268.569
*MEIMVARE    9.011
*FRKT        39.971
*GRON        56.438
*/;
* Source: GBD2024.xlsx
Set DALYDistr /act, val, upp, low /;
Parameter DALYPerG(KostGrp,DALYDistr) Change in DALY per g per day change in diet group /
*value  
RENTKJOETT.val  257.68
BEARBKJOETT.val 268.57
MEIMVARE.val     24.14
FRKT.val         44.28
GRON.val         42.36
*upper  
RENTKJOETT.upp  367.33
BEARBKJOETT.upp 347.63
MEIMVARE.upp     73.54
FRKT.upp         94.71
GRON.upp         75.02
*lower  
RENTKJOETT.low  -0.15
BEARBKJOETT.low 70.28
MEIMVARE.low     4.57
FRKT.low        15.79
GRON.low        18.80
/;
*
DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
*
$if %SCEN%==PHuppESupp    DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'upp');
$if %SCEN%==PHuppESval    DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'upp');
$if %SCEN%==PHuppESlow    DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'upp');
$if %SCEN%==PHuppES0      DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'upp');
$if %SCEN%==PHvalESupp    DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PHvalESval    DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PHvalESvalFix DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PHvalESlow    DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PHvalES0      DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PHlowESupp    DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'low');
$if %SCEN%==PHlowESval    DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'low');
$if %SCEN%==PHlowESlow    DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'low');
$if %SCEN%==PHlowES0      DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'low');
$if %SCEN%==PH0ESupp      DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PH0ESval      DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PH0ESlow      DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PH0ES0        DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PH0ES0H       DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==PH0ES0L       DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
*
$if %SCEN%==SensESS       DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==SensVSL       DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==SensDUp       DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==SensDLo       DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==SensLUC       DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==SensCPUp      DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
$if %SCEN%==SensCPLo      DALYPerG(KostGrp,'act') = DALYPerG(KostGrp,'val');
*
