************************************************************************
*
*   Jordmod version 2026
*
*   Ansvarlig: Klaus, Ruralis
*   Formaal: Main model file
*   Kommentarer:
*   Enheter: Priser i kr / kg, dyr, daa etc
*            Mengder i 1000 kg
*            Verdier i 1000 kr
*            Omfang i  dyr eller daa
*   Status:
*
************************************************************************
*  slaa av listing fil
*$OFFLISTING
*
*  slaa av utskrift av sets parametre osv
$OFFSYMXREF OFFSYMLIST
option limrow = 0;
option limcol = 0;
*
*********************
*** Innlesing av sets
*********************
$include sets.gms
*
***************************
*** Definisjon av scenarier
***************************
* Definere basisaar og simuleringsaar
$setglobal BAS 24
$setglobal SIM 50
*
* Test economies of scale
$setglobal SIZE NO
*
***************************
* Calibration runs
**************************
* Step 1: Calibration of farm profits

* Make sure to set $setglobal SIMYEAR NO

* YES: Precalibration for farm profits
* NO: Ordinary calibration run
$setglobal PreCalibration NO

* Step 2: Calibration of PMP-terms
* YES: Calibration mode, NO: Simulation mode
$setglobal PMP NO

***************************
* Simulation runs
**************************
* Make sure to set $setglobal PMP NO
*
* Velg emission factor GWP100 eller GWPStar
$setglobal GWP GWP100
*
* Choose available scenarios
*$setglobal SCEN BAS
$setglobal SCEN REF     
*$setglobal SCEN Scen1
*$setglobal SCEN Scen2

* Choose year
* YES = Simulationyear, NO = Baseyear
$setglobal SIMYEAR YES
*
*
* Introduce scenario name
SET SCENNAVN Scenarionavn /%SCEN%/ ;
*
* Velge aar for hvert scenario
SCALAR Y Simuleringsaar;
$if %SCEN%==BAS       Y = %BAS%;
$if %SCEN%==REF       Y = %SIM%;
$if %SCEN%==Scen1     Y = %SIM%;
$if %SCEN%==Scen2     Y = %SIM%;
*
* Number of iterations in calibration mode
$ifThenI.pmp %PMP%==YES
* Antall iterasjoner mellom modulene
SET STEP /I1/;
ALIAS(STEPSTEP,STEP);
* Velg hvilke iterasjoner som skal danne likevektsloesningen
SET STEPRES(STEP) /I1/;
$endif.pmp

* Number of iterations in simulation mode
$ifThenI.pmp %PMP%==NO
* Antall iterasjoner mellom modulene
SET STEP /I1*I3/ ;
ALIAS(STEPSTEP,STEP);
* Choose which iterations are reported as equilibrium solution
SET STEPRES(STEP) /I2*I3/;
$endif.pmp
*
SET RBUT(R,B) Regionale enkeltbruk i primaerjordbruket som ikke er med i tilbudsmodulen;
RBUT(R,B) = NO;

*
* Velg aktive klimatiltak per scenario
SET KLTKA(KLTK) ;
$if %SCEN%==BAS       KLTKA(KLTK)  = NO;
$if %SCEN%==REF       KLTKA(KLTK)  = NO;
$if %SCEN%==Scen1     KLTKA(KLTK)  = NO;
$if %SCEN%==Scen2     KLTKA(KLTK)  = NO;
*
*
*********************
*** Innlesing av data
*********************
*
PARAMETER DATA(*,*,*,*)    Parameter for data
          ENHDATA(*,*,*,*) Parameter for data i tilbudsmodellen
          ENDOKOEFF(R,*,*) Parameter for endogen intensitet i tilbudsmodellen
          KLIMADATA(*,*,*,*) Parameter for klimadata i simulasjon
          SIMDATA(*,*,*,*) Parameter for data i simulasjon
          KONVERGESIMDATA(*,*,*,*,*) Parameter for data per simulasjon
          POL(*,*,*)       Politikk
          CalibLevl(R,B,PRDK) Activity level in calibration run
          SIMDATACHECK(*,*,*,*)
          SIZEDATA(*,B,*,*,*)
          PROFITTSTATUS(*,*)
          CHECK(*,*)
          KONVERGENS(*,*,*,*) Sjekk konvergens mellom modulene
          KonvergensTest(*,*,*,*,*) Sjekk konvergens mellom modulene
          TEST(*,*,*,*)
          NYTEST(*,*,*,*)
          MELKTEST(*,*,*,*,*,*)
          TESTNORGE(B,R)
          SIMPROF(R,B)
          UTSLIPPTEST(*,*,*,*)
          KLIMATIL(*,*,*)
          KLIMDATA(R,B,*,*,KLEF)
          KLIMATEST(*,*,*,*,*,*,*)
          INTENSM(R,B,VARE,PRDK)
          PmpFeedQuad(R,B,VARE,PRDK)
          PmpFeedCnst(R,B,VARE,PRDK)
          PmpProdQuad(R,B)
          PmpProdCnst(R,B)
          PmpFeedTest(*,*,*,*,*)
          PmpTest(*,*,*,*,*)
          Verdikjede(*,*,*,*,*)
          Demand(*,*,*,*)
          OBJTEST(*,*)
          MarkedsBalanse(*,*,*,*,*)
          SimulationData(*,STEP,R,*,SDDim4,SDDim5)
          pmpKForTest(*,*,*,*,*,*)  
          StartVerdierMarket(*,*,*,*)
          StartProducerPrice(R,VARE)
          UngdyrTest(*,*,*,*)
          FkTest(*,*,*,*,*)
          KylTest(*,*,*,*,*)
          RESNORGETest(*,*,*,*)
          AreaChange(*,*,*,STEP)
          Assum(*,*,*,*)  Scenario assumptions
          CSWVARE(STEP) Check negative consumer surplus
          CalibTestdata(*,*,*,*,*) Test calibration values
          MarketBalance(*,*,*,*,*) Test market balance
          CalibARBP(R,B)  Calibration of opportunity costs of labour based on calibrated profit
;

SET       SimDataDev(STEP,R,*,SDDim4,SDDim5)
          KalvSet(R)
          CSWSET(VARE)
          FarmsWithPmp(B,R)
;


SET MODSTATUS(R,B,STEP) Status for modellen;
MODSTATUS(R,B,STEP) = NO;
SET TESTBRUK(R,B,INNSATS);

Set PmpProfit(R,B) Check of profit per farm for calibrating PMP-terms

*** Lese inn aktivitetsspesifikke data
TABLE IOBAS(*,*,*)
$include raadata\io%BAS%.gms
;

* Delete KAPD (animal capital) and KAPJ (land) as those have no alternative opportunity outside the sector
IOBAS('KAPD',PRDK,R) = 0;
IOBAS('KAPJ',PRDK,R) = 0;
*
* Copy data because of missing chicken activity in the base year
IOBAS(VARE,'KYLS','195207') = IOBAS(VARE,'KYLS','195206');
*
* Copy data because of small region
IOBAS(VARE,PRDK,'11215B') $ (NOT IOBAS(VARE,PRDK,'11215B')) = IOBAS(VARE,PRDK,'112102');
IOBAS(VARE,PRDK,'11225B') $ (NOT IOBAS(VARE,PRDK,'11225B')) = IOBAS(VARE,PRDK,'112102');
*
* Scale intensity based on RefBruk
IOBAS('EKRF',KORN,R) = IOBAS('EKRF',KORN,R) * 0.7579;
IOBAS('EKRF','POTE',R) = IOBAS('EKRF','POTE',R) * 2.4861;
IOBAS('EKRF',GRNS,R) = IOBAS('EKRF',GRNS,R) * 0.6;
IOBAS('EKRF','GEIT',R) = IOBAS('EKRF','GEIT',R) * 1.3268;
IOBAS('EKRF','MKYR',R) = IOBAS('EKRF','MKYR',R) * 1.2306;
IOBAS('EKRF','AKYR',R) = IOBAS('EKRF','AKYR',R) * 0.6649;
IOBAS('EKRF','SOEY',R) = IOBAS('EKRF','SOEY',R) * 1.2467;
IOBAS('EKRF','PURK',R) = IOBAS('EKRF','PURK',R) * 1.1784;
IOBAS('EKRF','GRIS',R) = IOBAS('EKRF','GRIS',R) * 1.1784;
IOBAS('EKRF','HOEN',R) = IOBAS('EKRF','HOEN',R) * 5.5797;
IOBAS('EKRF','KYLS',R) = IOBAS('EKRF','KYLS',R) * 0.7876;
*
IOBAS('EBRN',KORN,R)   = IOBAS('EBRN',KORN,R) * 0.7906;
IOBAS('EBRN','POTE',R) = IOBAS('EBRN','POTE',R) * 1.2120;
IOBAS('EBRN',GRNS,R)   = IOBAS('EBRN',GRNS,R) * 0.211;
IOBAS('EBRN',FRBA,R)   = IOBAS('EBRN',FRBA,R) * 0.9912;
IOBAS('EBRN','GEIT',R) = IOBAS('EBRN','GEIT',R) * 1.1415;
IOBAS('EBRN','MKYR',R) = IOBAS('EBRN','MKYR',R) * 0.6800;
IOBAS('EBRN','AKYR',R) = IOBAS('EBRN','AKYR',R) * 1.3071;
IOBAS('EBRN','SOEY',R) = IOBAS('EBRN','SOEY',R) * 0.4769;
IOBAS('EBRN','PURK',R) = IOBAS('EBRN','PURK',R) * 0.1917;
IOBAS('EBRN','GRIS',R) = IOBAS('EBRN','GRIS',R) * 0.1917;
IOBAS('EBRN','HOEN',R) = IOBAS('EBRN','HOEN',R) * 1.0722;
IOBAS('EBRN','KYLS',R) = IOBAS('EBRN','KYLS',R) * 0.1162;
*
* Change feed products for poultry
IOBAS('FEGG','HOEN',R) = IOBAS('FFEF','HOEN',R);
IOBAS('FKYL','KYLS',R) = IOBAS('FFEF','KYLS',R);
IOBAS('FFJR',VARE,R) = 0;
*
* Sjekke �penbare feil
IOBAS('VEDB','KYLS',R) = IOBAS('VEDB','KYLS',R) * .33;
IOBAS('VEDB',GRNS,R) = IOBAS('VEDB',GRNS,R) * .33;
IOBAS('VEDM',GRNS,R) = IOBAS('VEDM',GRNS,R) * .33;
*
* Øke fôrbehov geit fra Håndboka 2020/2021
IOBAS('FGRV','GEIT',R) = IOBAS('FGRV','GEIT',R) + 250;
IOBAS('FFEM','GEIT',R) = IOBAS('FFEM','GEIT',R) + 250;
*
IOBAS(GROV,GROV,R) = IOBAS(GROV,GROV,R) * .925;
*
* Calibrate slaughter weights for sheep and cattle
IOBAS('SAUK','SOEY',R) = IOBAS('SAUK','SOEY',R) * 1.04 * 1.02 * 0.98;
IOBAS('SAUK','LAMS',R) = IOBAS('SAUK','LAMS',R) * 1.04 * 1.02 * 0.98;
IOBAS('STFK',Storfe,R) = IOBAS('STFK',Storfe,R) * 0.98;
IOBAS('KLVK',Storfe,R) = IOBAS('KLVK',Storfe,R) * 0.98;
*
* Sikre at GFIB får koeffisienter for DG-varer
IOBAS(DGVARE,'GFIB',R) $ (NOT IOBAS(DGVARE,'GFIB',R)) = IOBAS(DGVARE,'GFOB',R) * .8;
*
* Calibrate feeding for ruminants other than dairy cows
IOBAS('FDRA',AHUSDYR,R) = IOBAS('FDRA',AHUSDYR,R) * 1.35 ;
IOBAS('FGRV',AHUSDYR,R) = IOBAS('FGRV',AHUSDYR,R) * .8 ;
*
* Scale nutrients from animals
IOBAS('FOSH',HUSDYR,R) = IOBAS('FOSH',HUSDYR,R) * 1.24 ;
IOBAS('KALH',HUSDYR,R) = IOBAS('KALH',HUSDYR,R) * 0.79 ;
IOBAS('NITR',PLANTE,R) = IOBAS('NITR',PLANTE,R) * 1.07 * 1.07;
IOBAS('FOSF',PLANTE,R) = IOBAS('FOSF',PLANTE,R) * 0.94 * 1.00 *  0.98;
IOBAS('KALI',PLANTE,R) = IOBAS('KALI',PLANTE,R) * 1.1  * 1.03 *  0.99;
*
* Kalibrere husdyrkapital
IOBAS('KAPD',HUSDYR,R) = IOBAS('KAPD',HUSDYR,R) * 1000;
*
* Introduce land opportunity costs
IOBAS('KAPJ',PRDK,R) = 0;
IOBAS('KAPJ',PLANTE,R) $ (NOT SAMEAS('GFUB',PLANTE)) = 0;

* Introduce milk quota capital
IOBAS('KAPK','MKYR',R) = IOBAS('KMLK','MKYR',R);
IOBAS('KAPK','GEIT',R) = IOBAS('GMLK','GEIT',R);
*
* Reberegne forbehovet
IOBAS('FFem',HUSDYR,R) = IOBAS('FGRV',HUSDYR,R) + IOBAS('FDRA',HUSDYR,R) + IOBAS('FDRM',HUSDYR,R);
*
ENHDATA(R,VARE,PRDK,'BAS') $ (NOT (SAMEAS('FFEM',VARE) OR SAMEAS('FFEG',VARE) OR SAMEAS('FFEF',VARE))) = IOBAS(VARE,PRDK,R);
*
* Innføre og initiatlisere gras protein
ENHDATA(R,INNSATS,'GFFP','BAS') = ENHDATA(R,INNSATS,'GFFS','BAS') * 1;
ENHDATA(R,INNSATV,'GFFP','BAS') = ENHDATA(R,INNSATV,'GFFS','BAS') * 1;
*                              
ENHDATA(R,'FGRP','GFFP','BAS') = .45 * ENHDATA(R,'GFFS','GFFS','BAS');
ENHDATA(R,'FGRJ','GFFP','BAS') = .55 * ENHDATA(R,'GFFS','GFFS','BAS');
*
* Initialisere endogen arbeid og kapital
ENHDATA(R,'KAPB',PRDK,'BAS') = 1;
ENHDATA(R,'KAPM',PRDK,'BAS') = 1;
ENHDATA(R,'ARBF',PRDK,'BAS') = 1;
ENHDATA(R,'ARBL',PRDK,'BAS') = 1;
*
* Initialisere husdyrgjoedsel paa bruk uten husdyr
ENHDATA(R,'NITH',PLANTE,'BAS') = 1;
ENHDATA(R,'FOSH',PLANTE,'BAS') = 1;
ENHDATA(R,'KALH',PLANTE,'BAS') = 1;
*
* Initialisere miljovarer
ENHDATA(R,'CH4      ',HUSDYR,'BAS') = 1;
ENHDATA(R,'CH4E     ',HUSDYR,'BAS') = 1;
ENHDATA(R,'CH4M     ',HUSDYR,'BAS') = 1;
ENHDATA(R,'CH4E     ',HUSDYR,'BAS') = 1;
ENHDATA(R,'CH4B     ',KORN,'BAS') = 1;
ENHDATA(R,'N2OMM    ',HUSDYR,'BAS') = 1;
ENHDATA(R,'N2OB     ',HUSDYR,'BAS') = 1;
ENHDATA(R,'N2OM     ',HUSDYR,'BAS') = 1;
ENHDATA(R,'N2OS     ',PLANTE,'BAS')  $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'NH3MMNED ',HUSDYR,'BAS') = 1;
ENHDATA(R,'NH3MMAVR ',HUSDYR,'BAS') = 1;
ENHDATA(R,'N2ONH3MMNED',HUSDYR,'BAS') = 1;
ENHDATA(R,'N2ONH3MMAVR',HUSDYR,'BAS') = 1;
ENHDATA(R,'NH3NED   ',PRDK,'BAS') $ (NOT SAMEAS('GFUB',PRDK)) = 1;
ENHDATA(R,'N2ONH3NED',PRDK,'BAS') $ (NOT SAMEAS('GFUB',PRDK)) = 1;
ENHDATA(R,'NH3AVR   ',PRDK,'BAS') $ (NOT SAMEAS('GFUB',PRDK)) = 1;
ENHDATA(R,'N2ONH3AVR',PRDK,'BAS') $ (NOT SAMEAS('GFUB',PRDK)) = 1;
ENHDATA(R,'NAVL     ',PLANTE,'BAS') $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'NTAP     ',PLANTE,'BAS') $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'N2OAVL   ',PLANTE,'BAS') $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'N2OMYR   ',PLANTE,'BAS') $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'N2OBRN   ',KORN,'BAS') = 1;
ENHDATA(R,'CO2      ',PLANTE,'BAS') $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'CO2SINK  ',PLANTE,'BAS') $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'CO2SOUR  ',PLANTE,'BAS') $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'CO2KALK  ',PLANTE,'BAS') $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'N2O      ',PRDK  ,'BAS') $ (NOT SAMEAS('GFUB',PRDK)) = 1;
ENHDATA(R,'NH3      ',PRDK  ,'BAS') $ (NOT SAMEAS('GFUB',PRDK)) = 1;
ENHDATA(R,'N        ',PLANTE,'BAS') $ (NOT SAMEAS('GFUB',PLANTE)) = 1;
ENHDATA(R,'GE       ','MKYR','BAS') = 301.422;
ENHDATA(R,'YM       ','MKYR','BAS') = 7.930;
ENHDATA(R,'VSDM     ','MKYR','BAS') = 1920;
*
*** Lese inn kommunevis omfang av aktiviteter angitt i daa og dyr
PARAMETER KOMFGBAS(*,*,*)
/
$include raadata\komfg%BAS%.gms
/
;
* Omregning til 1000 dyr og daa
DATA(K,PRDK,'OMFG','BAS') = KOMFGBAS(K,PRDK,'BAS')/1000;
DATA(K,BEITEDYR,'OMFG','BAS') = KOMFGBAS(K,BEITEDYR,'BAS')/1000;
*
*** Lese inn regionsvis omfang av aktiviteter
TABLE ROMFGBAS(*,*)
$include raadata\romfg%BAS%.gms
;

* Move activities with very low levels to regions with higher levels
ROMFGBAS('POTE','08125A') = ROMFGBAS('POTE','081203') + ROMFGBAS('POTE','08125A');
ROMFGBAS('POTE','081203') = 0;
ROMFGBAS('POTE','11225B') = ROMFGBAS('POTE','11225B') + ROMFGBAS('POTE','112203');
ROMFGBAS('POTE','112203') = 0;
ROMFGBAS('POTE','14325B') = ROMFGBAS('POTE','14325B') + ROMFGBAS('POTE','12325B');
ROMFGBAS('POTE','12325B') = 0;
ROMFGBAS('POTE','16425A') = ROMFGBAS('POTE','16425A') + ROMFGBAS('POTE','164204');
ROMFGBAS('POTE','164204') = 0;
ROMFGBAS('POTE','195206') = ROMFGBAS('POTE','195206') + ROMFGBAS('POTE','195207') + ROMFGBAS('POTE','205207');
ROMFGBAS('POTE','195207') = 0;
ROMFGBAS('POTE','205207') = 0;

ROMFGBAS('GEIT','021101') = ROMFGBAS('GEIT','021101') + ROMFGBAS('GEIT','011101') + ROMFGBAS('GEIT','021103');
ROMFGBAS('GEIT','011101') = 0;
ROMFGBAS('GEIT','021103') = 0;
ROMFGBAS('GEIT','041203') = ROMFGBAS('GEIT','041203') + ROMFGBAS('GEIT','041101');
ROMFGBAS('GEIT','041101') = 0;
ROMFGBAS('GEIT','06125A') = ROMFGBAS('GEIT','06125A') + ROMFGBAS('GEIT','061101') + ROMFGBAS('GEIT','071101');
ROMFGBAS('GEIT','061101') = 0;
ROMFGBAS('GEIT','071101') = 0;
ROMFGBAS('GEIT','08125A') = ROMFGBAS('GEIT','08125A') + ROMFGBAS('GEIT','081103') + ROMFGBAS('GEIT','081203');
ROMFGBAS('GEIT','081103') = 0;
ROMFGBAS('GEIT','081203') = 0;
ROMFGBAS('GEIT','10225A') = ROMFGBAS('GEIT','10225A') + ROMFGBAS('GEIT','09225A');
ROMFGBAS('GEIT','09225A') = 0;
ROMFGBAS('GEIT','16425A') = ROMFGBAS('GEIT','16425A') + ROMFGBAS('GEIT','164204');
ROMFGBAS('GEIT','164204') = 0;
ROMFGBAS('GEIT','195207') = ROMFGBAS('GEIT','195207') + ROMFGBAS('GEIT','205207');
ROMFGBAS('GEIT','205207') = 0;

ROMFGBAS(FRBA,'041101') = ROMFGBAS(FRBA,'041101') + ROMFGBAS(FRBA,'041203') + ROMFGBAS(FRBA,'04125A');
ROMFGBAS(FRBA,'041203') = 0;
ROMFGBAS(FRBA,'04125A') = 0;
ROMFGBAS(FRBA,'051103') = ROMFGBAS(FRBA,'051103') + ROMFGBAS(FRBA,'05125A');
ROMFGBAS(FRBA,'05125A') = 0;
ROMFGBAS(FRBA,'112102') = ROMFGBAS(FRBA,'112102') + ROMFGBAS(FRBA,'112203');
ROMFGBAS(FRBA,'112203') = 0;
ROMFGBAS(FRBA,'17425A') = ROMFGBAS(FRBA,'17425A') + ROMFGBAS(FRBA,'185206');
ROMFGBAS(FRBA,'185206') = 0;

DATA(R,PRDK,'OMFG','BAS') = ROMFGBAS(PRDK,R);
DATA('NORGE',PRDK,'OMFG','BAS') = SUM(R, DATA(R,PRDK,'OMFG','BAS'));
DATA(R,BTUTDYR,'OMFG','BAS') = ROMFGBAS(BTUTDYR,R);
DATA('NORGE',BTUTDYR,'OMFG','BAS') = SUM(R, DATA(R,BTUTDYR,'OMFG','BAS'));

*
* Sikre avlinger ved aktivitet
ENHDATA(R,VARE,PRDK,'BAS') $ (PRDK_TIL_VARE(PRDK,VARE) AND DATA(R,PRDK,'OMFG','BAS')) =  MAX[1, ENHDATA(R,VARE,PRDK,'BAS')];
*
* Ensure feed coefficients for ruminants other than dairy cows in all regions
ENHDATA(R,'FDRA',AHUSDYR,'BAS') $ (NOT ENHDATA(R,'FDRA',AHUSDYR,'BAS')) =
    SUM(RR, ENHDATA(R,'FDRA',AHUSDYR,'BAS') * DATA(RR,AHUSDYR,'OMFG','BAS'))
 /  SUM(RR,                                   DATA(RR,AHUSDYR,'OMFG','BAS'));
*
ENHDATA(R,'FGRV',AHUSDYR,'BAS') $ (NOT ENHDATA(R,'FGRV',AHUSDYR,'BAS')) =
    SUM(RR, ENHDATA(R,'FGRV',AHUSDYR,'BAS') * DATA(RR,AHUSDYR,'OMFG','BAS'))
 /  SUM(RR,                                   DATA(RR,AHUSDYR,'OMFG','BAS'));
*
*Parameter enhdatatest(R,VARE,AHUSDYR);
*enhdatatest(R,VARE,AHUSDYR) = enhdata(R,VARE,AHUSDYR,'BAS');
*Set enhdatatestset(R,AHUSDYR);
*enhdatatestset(R,AHUSDYR) $ ((ENHDATA(R,'FGRV',AHUSDYR,'BAS')+ENHDATA(R,'FDRM',AHUSDYR,'BAS')+ENHDATA(R,'FDRA',AHUSDYR,'BAS')) = 0) = YES;
*execute_unload 'enhdatatest.gdx', enhdatatest enhdatatestset, enhdata, data;
*abort '';

*
*** Lese inn mengder i basisaaret
TABLE TOTMNGDBAS(*,*)
$include raadata\totmngd%BAS%.gms
;
*
* Move quantities accordingly
TOTMNGDBAS('POTE','08125A') = TOTMNGDBAS('POTE','081203') + TOTMNGDBAS('POTE','08125A');
TOTMNGDBAS('POTE','081203') = 0;
TOTMNGDBAS('POTE','11225B') = TOTMNGDBAS('POTE','11225B') + TOTMNGDBAS('POTE','112203');
TOTMNGDBAS('POTE','112203') = 0;
TOTMNGDBAS('POTE','14325B') = TOTMNGDBAS('POTE','14325B') + TOTMNGDBAS('POTE','12325B');
TOTMNGDBAS('POTE','12325B') = 0;
TOTMNGDBAS('POTE','16425A') = TOTMNGDBAS('POTE','16425A') + TOTMNGDBAS('POTE','164204');
TOTMNGDBAS('POTE','164204') = 0;
TOTMNGDBAS('POTE','195206') = TOTMNGDBAS('POTE','195206') + TOTMNGDBAS('POTE','195207') + TOTMNGDBAS('POTE','205207');
TOTMNGDBAS('POTE','195207') = 0;
TOTMNGDBAS('POTE','205207') = 0;

TOTMNGDBAS('GMLK','021101') = TOTMNGDBAS('GMLK','021101') + TOTMNGDBAS('GMLK','011101') + TOTMNGDBAS('GMLK','021103');
TOTMNGDBAS('GMLK','011101') = 0;
TOTMNGDBAS('GMLK','021103') = 0;
TOTMNGDBAS('GMLK','041203') = TOTMNGDBAS('GMLK','041203') + TOTMNGDBAS('GMLK','041101');
TOTMNGDBAS('GMLK','041101') = 0;
TOTMNGDBAS('GMLK','06125A') = TOTMNGDBAS('GMLK','06125A') + TOTMNGDBAS('GMLK','061101') + TOTMNGDBAS('GMLK','071101');
TOTMNGDBAS('GMLK','061101') = 0;
TOTMNGDBAS('GMLK','071101') = 0;
TOTMNGDBAS('GMLK','08125A') = TOTMNGDBAS('GMLK','08125A') + TOTMNGDBAS('GMLK','081103') + TOTMNGDBAS('GMLK','081203');
TOTMNGDBAS('GMLK','081103') = 0;
TOTMNGDBAS('GMLK','081203') = 0;
TOTMNGDBAS('GMLK','10225A') = TOTMNGDBAS('GMLK','10225A') + TOTMNGDBAS('GMLK','09225A');
TOTMNGDBAS('GMLK','09225A') = 0;
TOTMNGDBAS('GMLK','16425A') = TOTMNGDBAS('GMLK','16425A') + TOTMNGDBAS('GMLK','164204');
TOTMNGDBAS('GMLK','164204') = 0;
TOTMNGDBAS('GMLK','195207') = TOTMNGDBAS('GMLK','195207') + TOTMNGDBAS('GMLK','205207');
TOTMNGDBAS('GMLK','205207') = 0;

TOTMNGDBAS(FRKT,'041101') = TOTMNGDBAS(FRKT,'041101') + TOTMNGDBAS(FRKT,'041203') + TOTMNGDBAS(FRKT,'04125A');
TOTMNGDBAS(FRKT,'041203') = 0;
TOTMNGDBAS(FRKT,'04125A') = 0;
TOTMNGDBAS(FRKT,'051103') = TOTMNGDBAS(FRKT,'051103') + TOTMNGDBAS(FRKT,'05125A');
TOTMNGDBAS(FRKT,'05125A') = 0;
TOTMNGDBAS(FRKT,'112102') = TOTMNGDBAS(FRKT,'112102') + TOTMNGDBAS(FRKT,'112203');
TOTMNGDBAS(FRKT,'112203') = 0;
TOTMNGDBAS(FRKT,'17425A') = TOTMNGDBAS(FRKT,'17425A') + TOTMNGDBAS(FRKT,'185206');
TOTMNGDBAS(FRKT,'185206') = 0;

* Re-calculate yields 
IOBAS('GMLK','GEIT',R) $ ROMFGBAS('GEIT',R) = TOTMNGDBAS('GMLK',R) / ROMFGBAS('GEIT',R);
IOBAS('GMLK','GEIT',R) $ (NOT ROMFGBAS('GEIT',R)) = 0;
IOBAS('KAPK','GEIT',R)         = IOBAS('GMLK','GEIT',R);
ENHDATA(R,'KAPK','GEIT','BAS') = IOBAS('GMLK','GEIT',R) ;
ENHDATA(R,'GMLK','GEIT','BAS') = IOBAS('GMLK','GEIT',R) ;
*
IOBAS('POTE','POTE',R) $ ROMFGBAS('POTE',R) = TOTMNGDBAS('POTE',R) / ROMFGBAS('POTE',R);
IOBAS('POTE','POTE',R) $ (NOT ROMFGBAS('POTE',R)) = 0;
ENHDATA(R,'POTE','POTE','BAS') = IOBAS('POTE','POTE',R) ;
*
IOBAS(FRKT,FRBA,R) $ (ROMFGBAS(FRBA,R) $ PRDK_TIL_VARE(FRBA,FRKT)) = TOTMNGDBAS(FRKT,R) / ROMFGBAS(FRBA,R);
IOBAS(FRKT,FRBA,R) $ ((NOT ROMFGBAS(FRBA,R)) $ PRDK_TIL_VARE(FRBA,FRKT))= 0;
ENHDATA(R,FRKT,FRBA,'BAS') $ PRDK_TIL_VARE(FRBA,FRKT) = IOBAS(FRKT,FRBA,R) ;


* omregner alle mengder til mill. kg
DATA(R,VARE,'MNGD','BAS') = TOTMNGDBAS(VARE,R) / 1000;
*kapital er allerede angitt i mill kr
DATA(R,INNKAP,'MNGD','BAS') = TOTMNGDBAS(INNKAP,R) ;

DATA(M,VARE,'MNGD','BAS') = SUM(R$R_TIL_M(M,R), DATA(R,VARE,'MNGD','BAS'));
DATA('NORGE',VARE,'MNGD','BAS') = SUM(M, DATA(M,VARE,'MNGD','BAS'));
SIMDATA(M,VARE,'MNGD','BAS') = DATA(M,VARE,'MNGD','BAS');
*
* Overfoere mengder fra BAS til Y
SIMDATA(M,VARE,'MNGD','Y') = SIMDATA(M,VARE,'MNGD','BAS');
SIMDATA(R,VARE,'MNGD','Y') = DATA(R,VARE,'MNGD','BAS');
*
*
*** Lese inn verdier i basisaaret
TABLE TOTVERDBAS(*,*)
$include raadata\totverd%BAS%.gms
;
* omregner alle verdier til mill. kr
DATA(R,VARE,'VERD','BAS') = TOTVERDBAS(VARE,R) / 1000;
DATA('NORGE',VARE,'VERD','BAS') = (SUM(R, TOTVERDBAS(VARE,R)) + TOTVERDBAS(VARE,'NORGE')) / 1000;
*
*kapital er allerede angitt i mill kr
DATA(R,INNKAP,'VERD','BAS') = TOTVERDBAS(INNKAP,R) ;
DATA('NORGE',INNKAP,'VERD','BAS') = SUM(R, TOTVERDBAS(INNKAP,R)) ;
*
*
*** Lese inn priser i basisaaret
TABLE TOTPRISBAS(*,*)
$include raadata\totpris%BAS%.gms
;
* Correct missing prices in region 195207
TOTPRISBAS(VARE,'195207') $ (NOT TOTPRISBAS(VARE,'195207')) = TOTPRISBAS(VARE,'195206');
*
* Include missing prices for oilseeds and legumes 
TOTPRISBAS('RAPM',R) = 5.6729;
TOTPRISBAS('ERTM',R) = 4.2299;
*
* Redo calculations for value
DATA(R,'RAPM','VERD','BAS') = TOTPRISBAS('RAPM',R) * DATA(R,'RAPM','MNGD','BAS') ;
DATA(R,'ERTM','VERD','BAS') = TOTPRISBAS('ERTM',R) * DATA(R,'ERTM','MNGD','BAS') ;
*
DATA('NORGE','RAPM','VERD','BAS') = SUM(R, DATA(R,'RAPM','VERD','BAS')) ;
DATA('NORGE','ERTM','VERD','BAS') = SUM(R, DATA(R,'ERTM','VERD','BAS')) ;
*
* Calibrate prices for fertilizer
TOTPRISBAS('NITG',R) = TOTPRISBAS('NITG',R) * 1;
TOTPRISBAS('NITR',R) = TOTPRISBAS('NITG',R) * 0;
*
TOTPRISBAS('FOSG',R) = TOTPRISBAS('FOSG',R) * 1;
TOTPRISBAS('FOSF',R) = TOTPRISBAS('FOSG',R) * 0;
*
TOTPRISBAS('KALG',R) = TOTPRISBAS('KALG',R) * 1;
TOTPRISBAS('KALI',R) = TOTPRISBAS('KALG',R) * 0;
*
* Assume 50 per cent of land rent as opportunity cost
TOTPRISBAS('KAPJ',R) = TOTPRISBAS('KAPJ',R) * 0;
*
* Assume 50 per cent of interest rate on milk price as opportunity cost of quota
TOTPRISBAS('KAPK',R) = TOTPRISBAS('KMLK',R) * TOTPRISBAS('KAPK',R) * 0;
*
******************************************************
* Overfoere ENHDATA fra BAS til Y
ENHDATA(R,VARE,PRDK,'Y') = ENHDATA(R,VARE,PRDK,'BAS');
*
* Sette priser
DATA(R,VARE,'TOTP','BAS') $ (NOT SAMEAS('FFEM',VARE)) = TOTPRISBAS(VARE,R);
DATA(M,VARE,'TOTP','BAS') $ ((NOT SAMEAS('FFEM',VARE)) AND SUM(R$R_TIL_M(M,R), DATA(R,VARE,'MNGD','BAS'))) = SUM(R$R_TIL_M(M,R), DATA(R,VARE,'VERD','BAS')) / SUM(R$R_TIL_M(M,R), DATA(R,VARE,'MNGD','BAS')) ;

DATA('NORGE',VARE,'TOTP','BAS') $ ((NOT SAMEAS('FFEM',VARE)) AND DATA('NORGE',VARE,'MNGD','BAS')) = DATA('NORGE',VARE,'VERD','BAS') / DATA('NORGE',VARE,'MNGD','BAS');
* Sette priser for kornprodukter uten mengde
DATA('NORGE','HAVM','TOTP','BAS') = DATA('NORGE','HAVF','TOTP','BAS') * DATA('NORGE','HVEM','TOTP','BAS') / DATA('NORGE','HVEF','TOTP','BAS');
DATA('NORGE','AKRM','TOTP','BAS') = DATA('NORGE','AKRF','TOTP','BAS') * DATA('NORGE','HVEM','TOTP','BAS') / DATA('NORGE','HVEF','TOTP','BAS');
*
* Sett pris paa husdyrgjoedsel lik null
DATA(R,'NITH','TOTP','BAS') = 0;
DATA(R,'FOSH','TOTP','BAS') = 0;
DATA(R,'KALH','TOTP','BAS') = 0;
*
* Sett pris paa grovfor til null
DATA(R,'GFFS','TOTP','BAS') = 0;
DATA(R,'GFFB','TOTP','BAS') = 0;
DATA(R,'GFOS','TOTP','BAS') = 0;
DATA(R,'GFOB','TOTP','BAS') = 0;
DATA(R,'GFIB','TOTP','BAS') = 0;
DATA(R,'GFUB','TOTP','BAS') = 0;
DATA(R,'FGRV','TOTP','BAS') = 0;
*
* Sett pris paa ungdyr til null
DATA(R,'IKYR','TOTP','BAS') = 0;
DATA(R,'IKVG','TOTP','BAS') = 0;
DATA(R,'IOKS','TOTP','BAS') = 0;
DATA(R,'IKVK','TOTP','BAS') = 0;
DATA(R,'IOKK','TOTP','BAS') = 0;
DATA(R,'OKYR','TOTP','BAS') = 0;
DATA(R,'OKVG','TOTP','BAS') = 0;
DATA(R,'OOKS','TOTP','BAS') = 0;
DATA(R,'OKVK','TOTP','BAS') = 0;
DATA(R,'OOKK','TOTP','BAS') = 0;
*
* Sett pris paa ull til null
* Regnes som tilskudd
DATA(R,'ULLS','TOTP','BAS') = 0;
*
* Overfoer kraftforpriser
DATA(R,'FSVN','TOTP','BAS') = DATA(R,'FFEG','TOTP','BAS');
DATA(R,'FKYL','TOTP','BAS') = DATA(R,'FFEF','TOTP','BAS');
DATA(R,'FEGG','TOTP','BAS') = DATA(R,'FFEF','TOTP','BAS');
*
* Initialisere pris for grasprotein 
DATA(R,'FGRP','TOTP','BAS') = 50;
*
* Pris for leid arbeid angitt i kr/time
* Pris for leid arbeid i hagebruk satt i 2/3 i tilbudsmodellen
* Minstelønn for fast ansatt med 4 år erfaring
* Source: Håndbok for driftsplanlegging
$include tilbudsmodul\arbeidsgiveravgift.gms
* angitt i kr per time
DATA(R,'ARBL','TOTP','BAS') = 190.90 * (1 + ARBAVGIFT(R)) * 1.15 ;
*
* Initialisere pris for spredareal i kr pr daa
DATA(R,'SPRE','TOTP','BAS') = 1;
*
*
* Overfoere TOTP fra BAS til Y
DATA(R,VARE,'TOTP','Y') = DATA(R,VARE,'TOTP','BAS');

SIMDATA(R,VARE,'TOTP','Y') = DATA(R,VARE,'TOTP','Y');
SIMDATA(M,SLKINNVARE,'TOTP','Y') = DATA(M,SLKINNVARE,'TOTP','Y');
*
* Read in pmp terms in simulation mode
$iftheni.Pmp %Pmp%==NO
$gdxin pmp.gdx
$load PmpProdQuad
$load PmpProdCnst

* Manipulate pmp-terms after calibration
* 1: 116
*PmpProdQuad(R,'BAKY') = PmpProdQuad(R,'BAKY') * 1.15;
$endif.Pmp
*
* Initialize pmp terms in calibration mode
$iftheni.Pmp %Pmp%==YES
PmpProdQuad(R,B) = 0;
PmpProdCnst(R,B) = 0;
$endif.Pmp

* Initialisering av klimatiltak
PARAMETER KLEFFEKT(*,*,*,*) Effekt av klimatiltak;
*
* Forberedelse for tilbudsmodellen
* RRBB inneholder elementer i (R,B) som optimeres
* RRR  inneholder den aktuelle regionen som optimeres
* BBB inneholder det aktuelle bruket som optimeres
* PRDKOPT inneholder tillatte PRDK
* PRDKNOPT inneholder ikke tillatte PRDK
* VAREOPT inneholder tillatte VARE
* VARENOPT inneholder ikke tillatte VARE
* TILOPT inneholder tillatte TILSKUDD
SET RRBB(RR,BB);
SET RRR(RR);
SET BBB(BB);
SET PRDKOPT(PRDK);
SET VAREOPT(VARE);
SET VAREVAREOPT(VARE);
SET PRDKNOPT(PRDK);
SET VARENOPT(VARE);
SET TILOPT(TILSKUDD);
*
PRDKOPT(PRDK) = YES;
VAREOPT(VARE) = YES;
VAREVAREOPT(VARE) = YES;
TILOPT(TILSKUDD) = YES;
*
SET RB(R,B) Regionale enkeltbruk i primaerjordbruket;
*
* Definer regionalt brukt dersom minst en av brukenes aktivitet finnes i basisaaret
RB(R,B)$SUM(PRDK, B_TIL_PRDK(PRDK,B)*DATA(R,PRDK,'OMFG','BAS')) = YES;
*
* Nedre grense for regional areal og dyrehold
RBUT(R,'BKRN') $ (SUM(PRDK $ B_TIL_PRDK(PRDK,'BKRN'), DATA(R,PRDK,'OMFG','BAS')) < .5) = YES;
RBUT(R,'BPTE') $ (SUM(PRDK $ B_TIL_PRDK(PRDK,'BPTE'), DATA(R,PRDK,'OMFG','BAS')) < .2) = YES;
RBUT(R,'BFRK') $ (SUM(PRDK $ B_TIL_PRDK(PRDK,'BFRK'), DATA(R,PRDK,'OMFG','BAS')) < .1) = YES;
RBUT(R,'BHGE') $ (SUM(PRDK $ B_TIL_PRDK(PRDK,'BHGE'), DATA(R,PRDK,'OMFG','BAS')) < .1) = YES;
RBUT(R,'BGMK') $ (DATA(R,'GEIT','OMFG','BAS') < .25) = YES;

SET RBActive(R,B) Active farms;
RBActive(R,B) $ (RB(R,B) $ (NOT RBUT(R,B))) = YES;

* Re-Calibrate milk yield for goats
IOBAS('GMLK','GEIT',R) $ SUM(RR $ (NOT RBUT(RR,'BGMK')), DATA(RR,'GEIT','OMFG','BAS')) = SUM(RR $ (NOT RBUT(RR,'BGMK')), DATA(RR,'GMLK','MNGD','BAS')) * 1000 / SUM(RR $ (NOT RBUT(RR,'BGMK')), DATA(RR,'GEIT','OMFG','BAS'));
*
PARAMETER OMSET(VARE) Omsetningsavgift;
PARAMETER FKOSTSSLK(M) ;
PARAMETER FKOSTFSLK(M) ;
PARAMETER ProdIntens(R,AHUSDYR,VARE) Produksjonsintensitet fôr til kjøtt;
*
* Vekstrater
* Lese inn scenariouavhengige vekstrater
$include vekstrater.gms
*
* Lese inn utslippskoeffisienter
$include tilbudsmodul\klimagasser.gms
*
* Lese inn dyrkingsklasser
$include markedsmodul\dyrkingsklasser.gms
*
* Innlesing av klimaeffekter
$include tilbudsmodul\klimatiltak.gms
*
* Lese inn koeffisienter for ecosystemservices
$include markedsmodul\ecosystemservices.gms
*
**************************************
* Definere satser for tilskudd
* og handelspolitiske rammebetingelser
**************************************
* Load payments and payment criteria for the base year
$include tilbudsmodul\tilskudd.gms
*
* Specificy changes in payments compared to base year run
$if exist scenarier\tilskudd%SCEN%.gms  $include scenarier\tilskudd%SCEN%.gms
*
*** Load trade policy for the base year
$include markedsmodul\handel%BAS%.gms
*
* Specificy changes in trade policy compared to base year run
$if exist scenarier\handel%SCEN%.gms  $include scenarier\handel%SCEN%.gms
*
* Load framework condition (prices, available area etc.)
$include markedsmodul\politikk%BAS%.gms
*
* Specificy changes in other framework conditions (prices, available area etc.) compared to base year run
$if exist scenarier\politikk%SCEN%.gms $include scenarier\politikk%SCEN%.gms
*
* Lese inn markedsdata
$include markedsmodul\markedsdata%BAS%.gms
*
* Lese inn koeffisienter for naeringsstoffer i matvarer
$include markedsmodul\naeringsinnhold.gms
*
* Lese inn koeffisienter for helseeffekter av kostholdsvarer
$include markedsmodul\helseeffekt.gms
*
* Save scenario assumptions
Assum('DALYPerG',KostGrp,'act','') = DALYPerG(KostGrp,'act');
Assum('VSL','','','') = VSL;
Assum('WTPLandest',r,'','') = WTPLandest(r);
Assum('WTPBiodiv',r,'','') = WTPBiodiv(r);
Assum('WTPCulther',r,'','') = WTPCulther(r);
Assum('WTPRecreat',r,'','') = WTPRecreat(r);
Assum('EmisCost',r,'NTAP','') = EmisCost('NTAP',r);
Assum('EmisCost',r,'N2O','') = EmisCost('N2O',r);
Assum('EmisCost',r,'NH3','') = EmisCost('NH3',r);
Assum('LUCCoeff',r,cropType,cropTypeType) = LUCCoeff(r,cropType,cropTypeType);
Assum('LUCAvg','','','') = LUCAvg;
Assum('CO2AvgXp','',Utslippavg,'') = CO2AVGXP(UTSLIPPAVG) ;

*******************************************************
$iftheni.pmp %PMP%==NO
execute_unload 'resultater\%SCEN%_pol.gdx', pol;
execute_unload 'resultater\%SCEN%_Assum.gdx', Assum;
$endif.pmp

$iftheni.pmp %PMP%==YES
execute_unload 'resultater\Calib_pol.gdx', pol;
execute_unload 'resultater\Calib_Assum.gdx', Assum;
$endif.pmp
*
*******************************************************
* Oppdatere priser pa kraftforravarer
DATA(R,MOELUTVARE,'TOTP','Y') = PI(MOELUTVARE)+TOLL(MOELUTVARE);

execute_unload 'klimaeffekt.gdx', kleffekt, klimaeffekt, kltka, klimdata;
*execute_unload 'tskat.gdx', satser, margskatt, trinn;
*
* Allow export price for brown cheese to be identical to domestic price due to market calibration purposes
PE(VARE) $ (SAMEAS('OSTM',VARE) OR SAMEAS('OSTG',VARE)) = P0(VARE) * .75;
*
* Updata pmp terms in simulation mode
$iftheni.Pmp %Pmp%==NO
PmpProdQuad(R,B) = PmpProdQuad(R,B) * (1 + KPI) ** (Y - %BAS%) ;
PmpProdCnst(R,B) = PmpProdCnst(R,B) * (1 + KPI) ** (Y - %BAS%) ;
$endif.Pmp
*
* Updata margins in simulation mode
$iftheni.Pmp %Pmp%==NO
MARGIN(VARE,M,'RETL') = MARGIN(VARE,M,'RETL') * (1 + KPI) ** (Y - %BAS%) ;
$endif.Pmp
*
******************************************
* Initialisering slakteri og meierimodulen
******************************************
PARAMETER INNFRAKTTIL(R,VARE);

SIMDATA(M,SLKINNVARE,'TOTP','Y') = SUM(R$R_TIL_M(M,R), TOTVERDBAS(SLKINNVARE,R) / 1000) / SIMDATA(M,SLKINNVARE,'MNGD','Y');
SIMDATA(M,MEIINNVARE,'TOTP','Y') = SUM(R$R_TIL_M(M,R), TOTVERDBAS(MEIINNVARE,R) / 1000) / SIMDATA(M,MEIINNVARE,'MNGD','Y');
*
* Ta med tollkvote import
SIMDATA('OEST',SLKINNVARE,'MNGD','Y') = SIMDATA('OEST',SLKINNVARE,'MNGD','Y') + POL('NORGE',SLKINNVARE,'BILIMPT')
                                                                              + POL('NORGE',SLKINNVARE,'SENIMPT') + POL('NORGE',SLKINNVARE,'MFNIMPT');
*
SIMDATA('NORGE',SLKINNVARE,'MNGD','Y') = SUM(M, SIMDATA(M,SLKINNVARE,'MNGD','Y'));
SIMDATA('NORGE',SLKINNVARE,'TOTP','Y') = SUM(M, SIMDATA(M,SLKINNVARE,'MNGD','Y') * SIMDATA(M,SLKINNVARE,'TOTP','Y'))
                                       / SUM(M, SIMDATA(M,SLKINNVARE,'MNGD','Y'));
SIMDATA('NORGE','STKK','TOTP','Y') = SUM(VARE$SSLKFLYT('STKK',VARE), SIMDATA('NORGE',VARE,'MNGD','Y') * SIMDATA('NORGE',VARE,'TOTP','Y')) /
SUM(VARE$SSLKFLYT('STKK',VARE), SIMDATA('NORGE',VARE,'MNGD','Y'));
SIMDATA('NORGE','SAGK','TOTP','Y') = SUM(VARE$SSLKFLYT('SAGK',VARE), SIMDATA('NORGE',VARE,'MNGD','Y') * SIMDATA('NORGE',VARE,'TOTP','Y')) /
SUM(VARE$SSLKFLYT('SAGK',VARE), SIMDATA('NORGE',VARE,'MNGD','Y'));
*
* Supplerer manglende mengder med data fra markedsdata.gms
SIMDATA(M,VARE,'MNGD','Y')$((NOT SIMDATA(M,VARE,'MNGD','Y')) AND X0(VARE,M)) = X0(VARE,M);
*
* Innfoer fleksibilitet i slakteri og meierimodulen
*SIMDATA(M,VARE,'MNGD','Y')$(SLTVARE(VARE) AND SLKVARE(VARE)) = SIMDATA(M,VARE,'MNGD','Y') * .99;
*SIMDATA(M,VARE,'MNGD','Y')$MEIVARE(VARE)                     = SIMDATA(M,VARE,'MNGD','Y') * .99;
SIMDATA(M,MEIVARE,'TOTP','Y') = DATA(M,MEIVARE,'TOTP','BAS');
SIMDATA(M,SLKVARE,'TOTP','Y') = DATA(M,SLKVARE,'TOTP','BAS');
SIMDATA('NORGE',SLKVARE,'TOTP','Y') $ SUM(M, SIMDATA(M,SLKVARE,'MNGD','Y')) =
SUM(M, SIMDATA(M,SLKVARE,'TOTP','Y') * SIMDATA(M,SLKVARE,'MNGD','Y')) / SUM(M, SIMDATA(M,SLKVARE,'MNGD','Y'));

SIMDATA(M,VARE,'TOTP','Y') $ ((NOT SIMDATA(M,VARE,'TOTP','Y')) AND P0(VARE)) = P0(VARE);
SIMDATA('NORGE',VARE,'TOTP','Y') $ ((NOT SIMDATA('NORGE',VARE,'TOTP','Y')) AND P0(VARE)) = P0(VARE);
*
* Initialisere antall anlegg i foredlingsindustrien
SIMDATA(M,'SSLK','OMFG','Y') = POL(M,'SSLK','gs_MIN');
SIMDATA(M,'MEIR','OMFG','Y') = POL(M,'MEIR','MIN');
*
* Load producer prices from calibration
$iftheni.Pmp %Pmp%==NO
$gdxin pmp.gdx
$load StartProducerPrice
$endif.Pmp

*
PARAMETER KJRAAVARE(M) Samlet kjoettraavare i markedsregion;
KJRAAVARE(M) =  SUM(SLKINNVARE, SIMDATA(M,SLKINNVARE,'MNGD','BAS'));
*
*
*** Lese inn filer for enkeltbruk meierier slakterier markedsforhold og klimagasser
$include markedsmodul\kalibslakteri%BAS%.gms
$include markedsmodul\kalibmeieri%BAS%.gms
$include tilbudsmodul\kalibbruk%BAS%.gms
*
*** Lese inn modeller
$include tilbudsmodul\tilbudsmodell.gms
$include markedsmodul\slakterimodell.gms
$include markedsmodul\meierimodell.gms
$include markedsmodul\markedsmodell.gms
*
* Initialisere variable i nevner i ligninger i markedsmodellen
x.l(VARE,'PRIM','NORGE') = 1;
x.l(VARE,'CONS','NORGE') = 1;
xe.l(VARE,'NORGE') = 1;
xi.l(VARE,'NORGE') = 1;
xq.l(VARE,'NORGE') = 1;
xqa.l(VARE,'NORGE') = 1;
xqb.l(VARE,'NORGE') = 1;
xqs.l(VARE,'NORGE') = 1;
g.l(B,R) = 1;
h.l(FP,M) = 1;
p.l(VARE,'CONS',M) = P0(VARE);
*
* Ulike parameter til resultater
PARAMETER RESNORGE(*,*,*,*);
PARAMETER RESULTAT1(*,*,*);
PARAMETER RESULTAT2(*,*,*);
PARAMETER ITEST(*,*,*,*,*,*);

****************************
*** Optimering av enkeltbruk
****************************
* Sette grenser for tilskudd
bidrag.lo(R,B,TILSKUDD) = 0;
bidrag.up(R,B,TILSKUDD) = 1000;
bidrag.up(R,B,TILSKUDD) = MAKSSATS(TILSKUDD);
*
* Sette startverdier og grenser for omfang
omfang.l(R,B,PRDK) = 10;
omfang.l(R,'BKMK',GROV) = 10 * BRUKSTOR(R,'BKMK','MAKS','Y') * (GROVAND(R,GROV,'MIN') + GROVAND(R,GROV,'MAX'))/2;
omfang.l(R,'BAKY',GROV) = 10 * BRUKSTOR(R,'BAKY','MAKS','Y') * (GROVAND(R,GROV,'MIN') + GROVAND(R,GROV,'MAX'))/2;
omfang.l(R,'BGMK',GROV) = 6  * BRUKSTOR(R,'BGMK','MAKS','Y') * (GROVAND(R,GROV,'MIN') + GROVAND(R,GROV,'MAX'))/2;
omfang.l(R,'BSAU',GROV) = 8  * BRUKSTOR(R,'BSAU','MAKS','Y') * (GROVAND(R,GROV,'MIN') + GROVAND(R,GROV,'MAX'))/2;
omfang.lo(R,B,GROV) = 0;
*
omfang.up(R,B,'BLOM') = + INF;
*
* Initialisere endogene pristilskudd
RESNORGE('MARG',VARE,'VERD',STEP) = 0;
*
*
* Grenser for beiteandel
beiteand.fx(R,B) = 0;
beiteand.lo(R,BEITEBRUK) = 0;
beiteand.l(R,BEITEBRUK) = (DATA(R,'GFFB','OMFG','BAS')+DATA(R,'GFIB','OMFG','BAS')+DATA(R,'GFUB','OMFG','BAS'))/
(DATA(R,'GFFS','OMFG','BAS')+DATA(R,'GFFB','OMFG','BAS')+DATA(R,'GFOS','OMFG','BAS')
 + DATA(R,'GFOB','OMFG','BAS')+DATA(R,'GFIB','OMFG','BAS')+DATA(R,'GFUB','OMFG','BAS'));
beiteand.up(R,BEITEBRUK) = 1;
*
* Startverdier
intens.lo(R,VARE,PRDK) = 0;
intens.l(R,VARE,PRDK)  = ENHDATA(R,VARE,PRDK,'BAS');
*intens.up(R,VARE,PRDK) = ENHDATA(R,VARE,PRDK,'BAS') * 999;
*
* Kutte ut intensitetskombinasjoner som ikke er definert
intens.fx(R,VARE,PRDK) $ (NOT ENHDATA(R,VARE,PRDK,'BAS')) = 0;
*
* Sette grenseverdier for endogen faktorintensitet
intens.lo(R,'FGRV','MKYR') = 100;
intens.l(R,'FGRV','MKYR') = 3500;
intens.up(R,'FGRV','MKYR') = 9999;
intens.lo(R,'FDRM','MKYR') = 1;
intens.l(R,'FDRM','MKYR') = 2500;
intens.up(R,'FDRM','MKYR') = 9999 ;
* from supply model
intens.lo(R,'FGRV','MKYR') = mFGRV + 1;
intens.lo(R,'FDRM','MKYR') = mF - mFGRV;
*
*
ENHDATA(R,'FFEM',AHUSDYR,'BAS') = ENHDATA(R,'FDRM',AHUSDYR,'BAS') + ENHDATA(R,'FDRA',AHUSDYR,'BAS') + ENHDATA(R,'FGRV',AHUSDYR,'BAS') ;
intens.lo(R,'FFEM',AHUSDYR) = ENHDATA(R,'FFEM',AHUSDYR,'BAS') * 0;
intens.l(R,'FFEM',AHUSDYR)  = ENHDATA(R,'FFEM',AHUSDYR,'BAS') ;
intens.up(R,'FFEM',AHUSDYR) = ENHDATA(R,'FFEM',AHUSDYR,'BAS') * 1.5;
intens.lo(R,'FDRM',AHUSDYR) = ENHDATA(R,'FDRM',AHUSDYR,'BAS') * 0;
intens.up(R,'FDRM',AHUSDYR) = ENHDATA(R,'FDRM',AHUSDYR,'BAS') * 10;
intens.lo(R,'FDRA',AHUSDYR) = ENHDATA(R,'FDRA',AHUSDYR,'BAS') * 0;
intens.up(R,'FDRA',AHUSDYR) = ENHDATA(R,'FDRA',AHUSDYR,'BAS') * .99;
intens.lo(R,'FGRV',AHUSDYR) = ENHDATA(R,'FGRV',AHUSDYR,'BAS') * 1;
intens.up(R,'FGRV',AHUSDYR) = ENHDATA(R,'FGRV',AHUSDYR,'BAS') * 2;
intens.up(R,'STFK',AHUSDYR) = ENHDATA(R,'STFK',AHUSDYR,'BAS') ;
intens.up(R,'KLVK',AHUSDYR) = ENHDATA(R,'KLVK',AHUSDYR,'BAS') ;
*
* Økt slaktevekt utover basisl?sningen ikke tillatt
intens.up(R,VARE,AHUSDYR) $ SUM(PRDK, AHUSDYR_TIL_VARE(PRDK,VARE)) = ENHDATA(R,VARE,AHUSDYR,'BAS');
intens.fx(R,'GMLK','GEIT') = ENHDATA(R,'GMLK','GEIT','BAS');
intens.up(R,'GETK','GEIT') = ENHDATA(R,'GETK','GEIT','BAS');
*
* Calculate meat to feed ratio
ProdIntens(R,AHUSDYR,VARE) $ AHUSDYR_TIL_VARE(AHUSDYR,VARE) =
ENHDATA(R,VARE,AHUSDYR,'BAS') / (ENHDATA(R,'FGRV',AHUSDYR,'BAS') + ENHDATA(R,'FDRA',AHUSDYR,'BAS') + ENHDATA(R,'FDRM',AHUSDYR,'BAS'));
*
intens.lo(R,'NITR',PLANTE) $ (NOT EKSI('NITR',PLANTE)) = ENHDATA(R,'NITR',PLANTE,'BAS') * .5;
intens.up(R,'NITR',PLANTE) $ (NOT EKSI('NITR',PLANTE)) = ENHDATA(R,'NITR',PLANTE,'BAS') * 2;
*
* Nitratdirektiv og Nordsj?avtalen
intens.up(R,'NITR',PLANTE)  $ (NOT EKSI('NITR',PLANTE)) = intens.up(R,'NITR',PLANTE) * (1-NITRAVRENN(R));
intens.l(R,'NITR',PLANTE)   $ (NOT EKSI('NITR',PLANTE)) = MIN(intens.l(R,'NITR',PLANTE),intens.up(R,'NITR',PLANTE));
intens.lo(R,'NITR',PLANTE)   $ (NOT EKSI('NITR',PLANTE)) = MIN(intens.lo(R,'NITR',PLANTE),intens.up(R,'NITR',PLANTE));
*
intens.up(R,'NITG',PLANTE) = 100;
intens.up(R,'FOSG',PLANTE) = 100;
intens.up(R,'KALG',PLANTE) = 100;
*
* Initialisering av husdyrgjoedsel paa alle bruk
intens.up(R,'NITH',PLANTE) = 50;
intens.up(R,'FOSH',PLANTE) = 50;
intens.up(R,'KALH',PLANTE) = 50;
intens.fx(R,'NITH',HUSDYR)  $ ((NOT SAMEAS('MKYR',HUSDYR)) AND BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = BRUTTODYRGJOEDSEL(HUSDYR,'NITH');
* Calibration
intens.fx(R,'NITH',HUSDYR) = intens.l(R,'NITH',HUSDYR) * 0.86 * 0.84 * 0.69;
*
intens.up(R,'NITH','MKYR') = 200;
intens.fx(R,'N2OMM',HUSDYR)     $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'N2OB',HUSDYR)     $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'N2OM',HUSDYR)      $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'N2ONH3MMNED',HUSDYR)  $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'N2ONH3MMAVR',HUSDYR)  $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'N2ONH3NED',HUSDYR)   $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'N2ONH3AVR',HUSDYR)   $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'NH3MMNED',HUSDYR)     $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'NH3MMAVR',HUSDYR)     $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'NH3NED',HUSDYR)      $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
intens.fx(R,'NH3AVR',HUSDYR)      $ (NOT BRUTTODYRGJOEDSEL(HUSDYR,'NITH')) = 0;
*
* Initialisering av husdyrgjoedsel paa bruk uten husdyr med verdier fra basisloesningen
intens.up(R,'NITH',SPRED) = SUM((RR,PRDK,BUTHDG)$B_TIL_PRDK(PRDK,BUTHDG), ENHDATA(RR,'NITH',PRDK,'BAS') * DATA(RR,PRDK,'OMFG','BAS'))
                          / SUM((RR,PRDK,BINHDG)$B_TIL_PRDK(PRDK,BINHDG), ENHDATA(RR,'NITH',PRDK,'BAS') * DATA(RR,PRDK,'OMFG','BAS'));
intens.up(R,'FOSH',SPRED) = SUM((RR,PRDK,BUTHDG)$B_TIL_PRDK(PRDK,BUTHDG), ENHDATA(RR,'FOSH',PRDK,'BAS') * DATA(RR,PRDK,'OMFG','BAS'))
                          / SUM((RR,PRDK,BINHDG)$B_TIL_PRDK(PRDK,BINHDG), ENHDATA(RR,'FOSH',PRDK,'BAS') * DATA(RR,PRDK,'OMFG','BAS'));
intens.up(R,'KALH',SPRED) = SUM((RR,PRDK,BUTHDG)$B_TIL_PRDK(PRDK,BUTHDG), ENHDATA(RR,'KALH',PRDK,'BAS') * DATA(RR,PRDK,'OMFG','BAS'))
                          / SUM((RR,PRDK,BINHDG)$B_TIL_PRDK(PRDK,BINHDG), ENHDATA(RR,'KALH',PRDK,'BAS') * DATA(RR,PRDK,'OMFG','BAS'));
*
* Initialisering av spredareal
intens.fx(R,'SPRE',PRDK)   = 1;
*
* Initiatliserting av kvotekapital
intens.fx(R,'KAPK','MKYR') = ENHDATA(R,'KMLK','MKYR','BAS');
intens.fx(R,'KAPK','GEIT') = ENHDATA(R,'GMLK','GEIT','BAS');


*
* Initialisering av opptak av klimatiltak
opptak.lo(R,B,KLTKA) = 0;
opptak.l(R,B,KLTKA) = 0;
opptak.up(R,B,KLTKA) = 1;
*
* Ekskludere umulige klimatiltak
opptak.fx(R,'BHOE','GRKL') = 0;
opptak.fx(R,'BHOE','KRFL') = 0;
opptak.fx(R,'BHOE','LAGL') = 0;
opptak.fx(R,'BHOE','GRFL') = 0;
opptak.fx(R,'BHOE','VSFL') = 0;
opptak.fx(R,'BHOE','GJSL') = 0;
opptak.fx(R,'BHOE','BIGL') = 0;
opptak.fx(R,'BHOE','GRKH') = 0;
opptak.fx(R,'BHOE','KRFH') = 0;
opptak.fx(R,'BHOE','LAGH') = 0;
opptak.fx(R,'BHOE','GRFH') = 0;
opptak.fx(R,'BHOE','VSFH') = 0;
opptak.fx(R,'BHOE','GJSH') = 0;
opptak.fx(R,'BHOE','BIGH') = 0;
*
opptak.fx(R,'BKYL','GRKL') = 0;
opptak.fx(R,'BKYL','KRFL') = 0;
opptak.fx(R,'BKYL','LAGL') = 0;
opptak.fx(R,'BKYL','GRFL') = 0;
opptak.fx(R,'BKYL','VSFL') = 0;
opptak.fx(R,'BKYL','GJSL') = 0;
opptak.fx(R,'BKYL','GRKH') = 0;
opptak.fx(R,'BKYL','KRFH') = 0;
opptak.fx(R,'BKYL','LAGH') = 0;
opptak.fx(R,'BKYL','GRFH') = 0;
opptak.fx(R,'BKYL','VSFH') = 0;
opptak.fx(R,'BKYL','GJSH') = 0;
*
opptak.fx(R,'BGRI','GRKL') = 0;
opptak.fx(R,'BGRI','KRFL') = 0;
opptak.fx(R,'BGRI','LAGL') = 0;
opptak.fx(R,'BGRI','GRFL') = 0;
opptak.fx(R,'BGRI','VSFL') = 0;
opptak.fx(R,'BGRI','GJSL') = 0;
opptak.fx(R,'BGRI','GRKH') = 0;
opptak.fx(R,'BGRI','KRFH') = 0;
opptak.fx(R,'BGRI','LAGH') = 0;
opptak.fx(R,'BGRI','GRFH') = 0;
opptak.fx(R,'BGRI','VSFH') = 0;
opptak.fx(R,'BGRI','GJSH') = 0;
*
opptak.fx(R,'BPTE','BIGL') = 0;
opptak.fx(R,'BPTE','GRKL') = 0;
opptak.fx(R,'BPTE','KRFL') = 0;
opptak.fx(R,'BPTE','LAGL') = 0;
opptak.fx(R,'BPTE','GRFL') = 0;
opptak.fx(R,'BPTE','VSFL') = 0;
opptak.fx(R,'BPTE','BIGL') = 0;
opptak.fx(R,'BPTE','GJSL') = 0;
opptak.fx(R,'BPTE','GRKH') = 0;
opptak.fx(R,'BPTE','KRFH') = 0;
opptak.fx(R,'BPTE','LAGH') = 0;
opptak.fx(R,'BPTE','GRFH') = 0;
opptak.fx(R,'BPTE','VSFH') = 0;
opptak.fx(R,'BPTE','GJSH') = 0;
*
opptak.fx(R,'BFRK','BIGL') = 0;
opptak.fx(R,'BFRK','GRKL') = 0;
opptak.fx(R,'BFRK','KRFL') = 0;
opptak.fx(R,'BFRK','LAGL') = 0;
opptak.fx(R,'BFRK','GRFL') = 0;
opptak.fx(R,'BFRK','VSFL') = 0;
opptak.fx(R,'BFRK','GJSL') = 0;
opptak.fx(R,'BFRK','BIGH') = 0;
opptak.fx(R,'BFRK','GRKH') = 0;
opptak.fx(R,'BFRK','KRFH') = 0;
opptak.fx(R,'BFRK','LAGH') = 0;
opptak.fx(R,'BFRK','GRFH') = 0;
opptak.fx(R,'BFRK','VSFH') = 0;
opptak.fx(R,'BFRK','GJSH') = 0;
*
opptak.fx(R,'BHGE','BIGL') = 0;
opptak.fx(R,'BHGE','GRKL') = 0;
opptak.fx(R,'BHGE','KRFL') = 0;
opptak.fx(R,'BHGE','LAGL') = 0;
opptak.fx(R,'BHGE','GRFL') = 0;
opptak.fx(R,'BHGE','VSFL') = 0;
opptak.fx(R,'BHGE','GJSL') = 0;
opptak.fx(R,'BHGE','BIGH') = 0;
opptak.fx(R,'BHGE','GRKH') = 0;
opptak.fx(R,'BHGE','KRFH') = 0;
opptak.fx(R,'BHGE','LAGH') = 0;
opptak.fx(R,'BHGE','GRFH') = 0;
opptak.fx(R,'BHGE','VSFH') = 0;
opptak.fx(R,'BHGE','GJSH') = 0;
*
intens.lo(R,'ARBF',PRDK) $ ENHDATA(R,'ARBF',PRDK,'BAS') = 1E-05;
*
* Maksimal timer familiearbeid til familiearbeidspris
arbeid.up(R,B,'ARBF') = TimerPerAarsverk * 1.5;
*arbeid.up(R,'BKRN','ARBF') = TimerPerAarsverk;
*arbeid.up(R,'BAKY','ARBF') = TimerPerAarsverk;
*arbeid.up(R,'BSAU','ARBF') = TimerPerAarsverk;
*
arbeid.lo(R,B,'ARBF') = TimerPerAarsverk * 0.25;
arbeid.lo(R,'BKMK','ARBF') = TimerPerAarsverk * 1;
arbeid.lo(R,'BKRN','ARBF') = TimerPerAarsverk * .1;
arbeid.lo('09225A','BKRN','ARBF') = TimerPerAarsverk * .05;
arbeid.lo('10225A','BKRN','ARBF') = TimerPerAarsverk * .05;
arbeid.lo('112102','BKRN','ARBF') = TimerPerAarsverk * .05;
arbeid.lo('112203','BKRN','ARBF') = TimerPerAarsverk * .05;
arbeid.lo('185206','BKRN','ARBF') = TimerPerAarsverk * .05;
arbeid.lo(R,'BAKY','ARBF') = TimerPerAarsverk * .1;
arbeid.lo(R,'BSAU','ARBF') = TimerPerAarsverk * .001;
arbeid.lo(R,'BAKY','ARBF') = TimerPerAarsverk * .1;
arbeid.lo(R,'BHGE','ARBF') = TimerPerAarsverk * .1;
arbeid.lo(R,'BGMK','ARBF') = TimerPerAarsverk * .1;
arbeid.lo(R,'BHOE','ARBF') = TimerPerAarsverk * .1;
arbeid.lo('195206','BGMK','ARBF') = TimerPerAarsverk * .01;
*
* Laveste pris for eget arbeid
pris.lo(R,B,'ARBF')   = 100 ;
pris.l(R,B,'ARBF')    = 150 ;
* Hoyeste pris for eget arbeid
pris.up(R,B,'ARBF')   = 750 ;

* Test
pris.up(R,B,'ARBF')   = 3000 ;



* Lower price for some farms
pris.lo(R,'BKMK','ARBF') = 50 ;
pris.lo(R,'BKRN','ARBF') = 50 ;
pris.lo(R,'BAKY','ARBF') = 25 ;
pris.lo(R,'BSAU','ARBF') = 1 ;
pris.lo(R,'BHGE','ARBF') = 25 ;
pris.lo(R,'BFRK','ARBF') = 75 ;
pris.lo(R,'BHOE','ARBF') = 200 ;
pris.lo(R,'BKYL','ARBF') = 250 ;
pris.lo(R,'BGRI','ARBF') = 250 ;

pris.lo(R,B,'ARBF') = pris.lo(R,B,'ARBF') * (1 + KPI + LOENN) ** (Y - %BAS%);
pris.up(R,B,'ARBF') = pris.up(R,B,'ARBF') * (1 + KPI + LOENN) ** (Y - %BAS%);

*
* Sette pris lik alternativ verdi (jf. alternativverdier kapital og arbeid.xlsx)
Parameter PrisArbeidFylke(F) /
010000        373.668  
020300        409.539  
040000        375.457  
050000        375.457  
060000        376.952  
070000        381.500  
080000        385.985  
090000        393.982  
100000        393.982  
110000        395.393  
120000        391.913  
140000        391.913  
150000        372.309  
160000        388.451  
170000        388.451  
180000        380.007  
190000        387.071  
200000        377.972
/;



* Nullstille pris
SIZEDATA(R,B,VARE,'PRIS',SIZE) = 0;
SIZEDATA('NORGE',B,VARE,'PRIS',SIZE) = 0;
*
PARAMETER LAGRESTARTVERDIER(*,*,*,*);
LAGRESTARTVERDIER(R,B,PRDK,'OMFG_LO') = omfang.lo(R,B,PRDK);
LAGRESTARTVERDIER(R,B,PRDK,'OMFG_L')  = omfang.l(R,B,PRDK);
LAGRESTARTVERDIER(R,B,PRDK,'OMFG_UP') = omfang.up(R,B,PRDK);

LAGRESTARTVERDIER(R,VARE,PRDK,'INTENS_LO') = intens.lo(R,VARE,PRDK);
LAGRESTARTVERDIER(R,VARE,PRDK,'INTENS_L')  = intens.l(R,VARE,PRDK);
LAGRESTARTVERDIER(R,VARE,PRDK,'INTENS_UP') = intens.up(R,VARE,PRDK);

LAGRESTARTVERDIER(R,GROV,'MIN','GROVAND_MIN') = GROVAND(R,GROV,'MIN');
LAGRESTARTVERDIER(R,GROV,'MAX','GROVAND_MAX') = GROVAND(R,GROV,'MAX');

LAGRESTARTVERDIER(R,B,VARE,'ARBEID_LO')  = arbeid.lo(R,B,VARE);
LAGRESTARTVERDIER(R,B,VARE,'ARBEID_L')   = arbeid.l(R,B,VARE);
LAGRESTARTVERDIER(R,B,VARE,'ARBEID_UP')  = arbeid.up(R,B,VARE);

LAGRESTARTVERDIER(R,B,'','BEITEAND_LO')  = beiteand.lo(R,B);
LAGRESTARTVERDIER(R,B,'','BEITEAND_L')   = beiteand.l(R,B);
LAGRESTARTVERDIER(R,B,'','BEITEAND_UP')  = beiteand.up(R,B);

LAGRESTARTVERDIER(R,B,VARE,'PRIS_LO')  = pris.lo(R,B,VARE);
LAGRESTARTVERDIER(R,B,VARE,'PRIS_L')   = pris.l(R,B,VARE);
LAGRESTARTVERDIER(R,B,VARE,'PRIS_UP')  = pris.up(R,B,VARE);
*
LAGRESTARTVERDIER(R,B,KLTK,'OPPTAK_LO')  = opptak.lo(R,B,KLTK);
LAGRESTARTVERDIER(R,B,KLTK,'OPPTAK_L')   = opptak.l(R,B,KLTK);
LAGRESTARTVERDIER(R,B,KLTK,'OPPTAK_UP')  = opptak.up(R,B,KLTK);

execute_unload 'lagrestartverdier.gdx', lagrestartverdier;
execute_unload 'simdata.gdx', simdata;
execute_unload 'iobas.gdx', iobas, enhdata;

SET MODSIZE(R,B,STEP,SIZE) Status for modellen;
MODSIZE(R,B,STEP,SIZE) = NO;

* Her starter loop mellom tilbudsmodell og markedsmodell
LOOP(STEP,

* Her starter loop for beregning av enhetskostnader
$ifTheni.size %SIZE%==YES
LOOP(SIZE,
$endIf.size
*

* Her starter loop som beregner optimal driftsplan for hvert gaardsbruk
LOOP((RR,BB) $ ((NOT RBUT(RR,BB))
* AND (SAMEAS('BKMK',BB) OR SAMEAS('BSAU',BB) OR SAMEAS('BGMK',BB))
*AND (SAMEAS('BKMK',BB) OR SAMEAS('BAKY',BB) OR SAMEAS('BSAU',BB) OR SAMEAS('BFRK',BB)) AND SAMEAS('123205',RR)
*AND (SAMEAS('BKMK',BB) OR SAMEAS('BAKY',BB))
*AND SAMEAS('BGMK',BB)
*AND (SAMEAS('BKMK',BB) OR SAMEAS('BGMK',BB) OR SAMEAS('BAKY',BB) OR SAMEAS('BSAU',BB))
*SIZE /XXS,XS,S,M,L,XL,XXL,XXXL/;
*AND (SAMEAS('xxs',SIZE) or SAMEAS('xs',SIZE) or SAMEAS('s',SIZE) or SAMEAS('m',SIZE))
*AND (SAMEAS('l',SIZE) or SAMEAS('xl',SIZE) or SAMEAS('xxl',SIZE) or SAMEAS('xxxl',SIZE))
*AND (SAMEAS('m',SIZE) or SAMEAS('xxl',SIZE))
*AND SAMEAS('xxxl',SIZE)
*AND SAMEAS('BKMK',BB) AND SAMEAS('011101',RR)
*AND SAMEAS('011101',RR) 
*AND (SAMEAS('011101',RR) OR SAMEAS('04125A',RR))

*AND SAMEAS('M',SIZE)
),

         RB(R,B) = SAMEAS(RR,R) AND SAMEAS(BB,B);
         RRR(R)  = SAMEAS(RR,R);
         BBB(B)  = SAMEAS(BB,B);

         PRDKOPT(PRDK)$ (NOT SUM(BBB, B_TIL_PRDK(PRDK,BBB))) = NO;
         VAREOPT(VARE)$(NOT SUM(PRDKOPT, B_TIL_PRDK(PRDKOPT,BB) * ENHDATA(RR,VARE,PRDKOPT,'BAS'))) = NO;
         VAREVAREOPT(VARE)$(NOT SUM(PRDKOPT, B_TIL_PRDK(PRDKOPT,BB) * ENHDATA(RR,VARE,PRDKOPT,'BAS'))) = NO;
         
         VAREOPT('SPRE')   = YES;
         VAREOPT('EMIS_N') = YES;
         
         TILOPT(TILSKUDD) = NO;
         TILOPT(TILSKUDD)$ (SUM((PRDKOPT,TTIL), B_TIL_PRDK(PRDKOPT,BB) * (SATSER(TILSKUDD,PRDKOPT,TTIL,RR) + SATSER(TILSKUDD,PRDKOPT,TTIL,'0')))
                         OR SUM((UNGD,TTIL), B_TIL_PRDK(UNGD,BB) * (SATSER(TILSKUDD,'UNGD',TTIL,RR) + SATSER(TILSKUDD,'UNGD',TTIL,'0')))
                         OR SUM((KORN,TTIL), B_TIL_PRDK(KORN,BB) * (SATSER(TILSKUDD,'KORN',TTIL,RR) + SATSER(TILSKUDD,'KORN',TTIL,'0')))
                         OR SUM((GAKF,TTIL), B_TIL_PRDK(GAKF,BB) * (SATSER(TILSKUDD,'GAKF',TTIL,RR) + SATSER(TILSKUDD,'GAKF',TTIL,'0')))
                         OR SUM((GAKR,TTIL), B_TIL_PRDK(GAKR,BB) * (SATSER(TILSKUDD,'GAKR',TTIL,RR) + SATSER(TILSKUDD,'GAKR',TTIL,'0')))
                         OR SUM((FRBA,TTIL), B_TIL_PRDK(FRBA,BB) * (SATSER(TILSKUDD,'FRBA',TTIL,RR) + SATSER(TILSKUDD,'FRBA',TTIL,'0')))
                         OR SUM((KLTKA,TTIL), (SATSER(TILSKUDD,KLTKA,'0',RR) + SATSER(TILSKUDD,KLTKA,'0','0')))
                         OR SUM((PRDKOPT,VAREOPT,TTIL), B_TIL_PRDK(PRDKOPT,BB) * ENHDATA(RR,VAREOPT,PRDKOPT,'BAS') * (SATSER(TILSKUDD,VAREOPT,TTIL,RR) + SATSER(TILSKUDD,VAREOPT,TTIL,'0'))))
                  = YES;
         TILOPT('TSKAT') $ SATSER('TSKAT','ARBF','0','0') = YES;
         TILOPT('TARBF') $ SUM(R, SATSER('TARBF','ARBF','0',R)) = YES;

         PRDKNOPT(PRDK) $ (NOT PRDKOPT(PRDK)) = YES;
         VARENOPT(VARE) $ (NOT VAREOPT(VARE)) = YES;

*
* Sette grenser for omfang
VAREKVOT(RR,'KMLK')  $ SAMEAS('BKMK',BB) = ENHDATA(RR,'KMLK','MKYR','BAS') * BRUKSTOR(RR,'BKMK','MAKS','Y') ;
*
omfang.lo(RR,BB,PRDKOPT) = EPS;
omfang.fx(RR,BB,PRDKNOPT) = .0;
*
omfang.up(RR,BB,'MKYR') $ SAMEAS('BKMK',BB) = BRUKSTOR(RR,'BKMK','MAKS','Y');
omfang.up(RR,BB,'MKYR') $ SAMEAS('BKMK',BB) = 999;
omfang.up(RR,BB,'GEIT') $ SAMEAS('BGMK',BB) = BRUKSTOR(RR,'BGMK','MAKS','Y');
omfang.up(RR,BB,'AKYR') $ SAMEAS('BAKY',BB) = BRUKSTOR(RR,'BAKY','MAKS','Y');
omfang.up(RR,BB,'SOEY') $ SAMEAS('BSAU',BB) = BRUKSTOR(RR,'BSAU','MAKS','Y');
omfang.up(RR,BB,'PURK') $ SAMEAS('BGRI',BB) = BRUKSTOR(RR,'BGRI','MAKS','Y');
omfang.up(RR,BB,'HOEN') $ SAMEAS('BHOE',BB) = BRUKSTOR(RR,'BHOE','MAKS','Y');
omfang.up(RR,BB,'KYLS') $ SAMEAS('BKYL',BB) = BRUKSTOR(RR,'BKYL','MAKS','Y');
omfang.up(RR,BB,'POTE') $ SAMEAS('BPTE',BB) = BRUKSTOR(RR,'BPTE','MAKS','Y');
*
omfang.lo(RR,BB,'MKYR') $ SAMEAS('BKMK',BB) = BRUKSTOR(RR,'BKMK','MIN','Y') * .25;
omfang.lo(RR,BB,'GEIT') $ SAMEAS('BGMK',BB) = BRUKSTOR(RR,'BGMK','MIN','Y');
omfang.lo(RR,BB,'AKYR') $ SAMEAS('BAKY',BB) = BRUKSTOR(RR,'BAKY','MIN','Y');
omfang.lo(RR,BB,'SOEY') $ SAMEAS('BSAU',BB) = BRUKSTOR(RR,'BSAU','MIN','Y');
omfang.lo(RR,BB,'PURK') $ SAMEAS('BGRI',BB) = BRUKSTOR(RR,'BGRI','MIN','Y');
omfang.lo(RR,BB,'HOEN') $ SAMEAS('BHOE',BB) = BRUKSTOR(RR,'BHOE','MIN','Y');
omfang.lo(RR,BB,'KYLS') $ SAMEAS('BKYL',BB) = BRUKSTOR(RR,'BKYL','MIN','Y');
omfang.lo(RR,BB,'POTE') $ SAMEAS('BPTE',BB) = BRUKSTOR(RR,'BPTE','MIN','Y');
*
omfang.up(RR,BB,'GFUB') $ (SAMEAS('BSAU',BB) AND DATA(RR,'GFUB','OMFG','BAS'))
  = BRUKSTOR(RR,'BSAU','MAKS','Y') * DATA(RR,'GFUB','OMFG','BAS') / DATA(RR,'SOEY','OMFG','BAS');
*
KORNOMFANGMAX  = BRUKSTOR(RR,'BKRN','MAKS','Y') $ SUM(BBB, SAMEAS('BKRN',BBB));
FRBAOMFANGMAX  = BRUKSTOR(RR,'BFRK','MAKS','Y') $ SUM(BBB, SAMEAS('BFRK',BBB));
GRNSOMFANGMAX  = BRUKSTOR(RR,'BHGE','MAKS','Y') $ SUM(BBB, SAMEAS('BHGE',BBB));
*
KORNOMFANGMIN  = BRUKSTOR(RR,'BKRN','MIN','Y') $ SUM(BBB, SAMEAS('BKRN',BBB));
FRBAOMFANGMIN  = BRUKSTOR(RR,'BFRK','MIN','Y') $ SUM(BBB, SAMEAS('BFRK',BBB));
GRNSOMFANGMIN  = BRUKSTOR(RR,'BHGE','MIN','Y') $ SUM(BBB, SAMEAS('BHGE',BBB));
*
omfang.l(RR,BB,KornOljePRDK) $ SAMEAS('BKRN',BB) = .5 * (KORNAND(RR,KornOljePRDK,'MIN') * KORNOMFANGMIN + KORNAND(RR,KornOljePRDK,'MAX') * KORNOMFANGMAX) ;
omfang.lo(RR,BB,KornOljePRDK) $ SAMEAS('BKRN',BB) = KORNAND(RR,KornOljePRDK,'MIN') * KORNOMFANGMIN ;
omfang.up(RR,BB,KornOljePRDK) $ SAMEAS('BKRN',BB) = KORNAND(RR,KornOljePRDK,'MAX') * KORNOMFANGMAX ;
omfang.l(RR,BB,KornOljePRDK) $ SAMEAS('BKRN',BB) = .5 * (omfang.lo(RR,BB,KornOljePRDK) + omfang.up(RR,BB,KornOljePRDK)) ;

omfang.l(RR,BB,GRNS) $ SAMEAS('BHGE',BB) = .5 * (GRNSAND(RR,GRNS,'MIN') * GRNSOMFANGMIN + GRNSAND(RR,GRNS,'MAX') * GRNSOMFANGMAX) ;
omfang.lo(RR,BB,GRNS) $ SAMEAS('BHGE',BB) = GRNSAND(RR,GRNS,'MIN') * GRNSOMFANGMIN ;
omfang.up(RR,BB,GRNS) $ SAMEAS('BHGE',BB) = GRNSAND(RR,GRNS,'MAX') * GRNSOMFANGMAX ;
omfang.l(RR,BB,GRNS) $ SAMEAS('BHGE',BB) = .5 * (omfang.lo(RR,BB,GRNS) + omfang.up(RR,BB,GRNS)) ;
*
omfang.l(RR,BB, FRBA) $ SAMEAS('BFRK',BB) = .5 * (FRBAAND(RR,FRBA,'MIN') * FRBAOMFANGMIN + FRBAAND(RR,FRBA,'MAX') * FRBAOMFANGMAX) ;
omfang.lo(RR,BB,FRBA) $ SAMEAS('BFRK',BB) =       FRBAAND(RR,FRBA,'MIN') * FRBAOMFANGMIN ;
omfang.up(RR,BB,FRBA) $ SAMEAS('BFRK',BB) =       FRBAAND(RR,FRBA,'MAX') * FRBAOMFANGMAX ;
omfang.l(RR,BB, FRBA) $ SAMEAS('BFRK',BB) = .5 * (omfang.lo(RR,BB,FRBA) + omfang.up(RR,BB,FRBA)) ;

omfang.lo(RR,BB,FRBA) = omfang.l(RR,BB,FRBA) * .001;
omfang.lo(RR,BB,GRNS) = omfang.l(RR,BB,GRNS) * .001;

omfang.lo(R,B,GROV) = 1E-3;
omfang.fx(R,B,'GFFP') = 0;

* Special rule for BAKY to avoid infeasibility
omfang.lo(RRR,BBB,UNGD) $ (SAMEAS('BAKY',BBB)) = 1E-3;

*
balans.up(R,B,'SPRE') $ SAMEAS('BKRN',B) = SUM(PRDK$B_TIL_PRDK(PRDK,B), SPREDKOEFF(PRDK) * KORNOMFANGMAX);
balans.up(R,B,'SPRE') $ SAMEAS('BPTE',B) = SUM(PRDK$B_TIL_PRDK(PRDK,B), SPREDKOEFF(PRDK) * omfang.up(RR,BB,'POTE'));
balans.up(R,B,'SPRE') $ SAMEAS('BFRK',B) = SUM(PRDK$B_TIL_PRDK(PRDK,B), SPREDKOEFF(PRDK) * FRBAOMFANGMAX);
balans.up(R,B,'SPRE') $ SAMEAS('BHGE',B) = SUM(PRDK$B_TIL_PRDK(PRDK,B), SPREDKOEFF(PRDK) * GRNSOMFANGMAX);
*
bidrag.lo(R,B,VARE) $ (NOT SAMEAS('SPRE',VARE)) = 0;
*
$ifTheni.size %SIZE%==YES
* Aktivere ved beregning for bruksst?rrelse
VAREKVOT(RRR,VARE) = +INF;
omfang.fx(RRR,'BKMK','MKYR') = STORRELSE(RRR,'BKMK',SIZE);
omfang.fx(RRR,'BGMK','GEIT') = STORRELSE(RRR,'BGMK',SIZE);
omfang.fx(RRR,'BAKY','AKYR') = STORRELSE(RRR,'BAKY',SIZE);
omfang.fx(RRR,'BSAU','SOEY') = STORRELSE(RRR,'BSAU',SIZE);
omfang.fx(RRR,'BGRI','PURK') = STORRELSE(RRR,'BGRI',SIZE);
omfang.fx(RRR,'BHOE','HOEN') = STORRELSE(RRR,'BHOE',SIZE);
omfang.fx(RRR,'BKYL','KYLS') = STORRELSE(RRR,'BKYL',SIZE);
omfang.fx(RRR,'BPTE','POTE') = STORRELSE(RRR,'BPTE',SIZE);

KORNOMFANGMIN  = (STORRELSE(RR,'BKRN',SIZE) * .75) $ SUM(B, SAMEAS('BKRN',B))  ;
FRBAOMFANGMIN  = (STORRELSE(RR,'BFRK',SIZE) * .75) $ SUM(B, SAMEAS('BFRK',B))  ;
GRNSOMFANGMIN  = (STORRELSE(RR,'BHGE',SIZE) * .75) $ SUM(B, SAMEAS('BHGE',B))  ;

KORNOMFANGMAX  = STORRELSE(RR,'BKRN',SIZE) $ SUM(B, SAMEAS('BKRN',B));
FRBAOMFANGMAX  = STORRELSE(RR,'BFRK',SIZE) $ SUM(B, SAMEAS('BFRK',B));
GRNSOMFANGMAX  = STORRELSE(RR,'BHGE',SIZE) $ SUM(B, SAMEAS('BHGE',B));

omfang.lo(RR,BB,KornOljePRDK) $ SAMEAS('BKRN',BB) = KORNAND(RR,KornOljePRDK,'MIN') * KORNOMFANGMIN ;
omfang.up(RR,BB,KornOljePRDK) $ SAMEAS('BKRN',BB) = KORNAND(RR,KornOljePRDK,'MAX') * KORNOMFANGMAX ;
omfang.lo(RR,BB,GRNS) $ SAMEAS('BHGE',BB) = GRNSAND(RR,GRNS,'MIN') * GRNSOMFANGMIN ;
omfang.up(RR,BB,GRNS) $ SAMEAS('BHGE',BB) = GRNSAND(RR,GRNS,'MAX') * GRNSOMFANGMAX ;
omfang.lo(RR,BB,FRBA) $ SAMEAS('BFRK',BB) =       FRBAAND(RR,FRBA,'MIN') * FRBAOMFANGMIN ;
omfang.up(RR,BB,FRBA) $ SAMEAS('BFRK',BB) =       FRBAAND(RR,FRBA,'MAX') * FRBAOMFANGMAX ;

omfang.up(RRR,BBB,'GFUB') $ (SAMEAS('BSAU',BBB) AND DATA(RRR,'GFUB','OMFG','BAS'))
  = STORRELSE(RRR,'BSAU',SIZE) * DATA(RRR,'GFUB','OMFG','BAS') / DATA(RRR,'SOEY','OMFG','BAS');

omfang.lo(RR,BB,FRBA)  $ SUM(B, SAMEAS('BFRK',B)) = EPS;
omfang.lo(RR,BB,GRNS)  $ SUM(B, SAMEAS('BHGE',B)) = EPS;
balans.up(R,B,'SPRE') = INF;
$endif.size
*

* Sikre ikke-negative utslipp for klimatiltak med relativ effekt
RELKLIMAEFFEKT(RRR,BBB,PRDK,VARE) = SUM(KLTKA, KLIMAEFFEKT(RRR,BBB,PRDK,VARE,'','REL',KLTKA));
KLIMAEFFEKT(RRR,BBB,PRDK,VARE,'','REL',KLTKA) $ (RELKLIMAEFFEKT(RRR,BBB,PRDK,VARE) > 1) = KLIMAEFFEKT(RRR,BBB,PRDK,VARE,'','REL',KLTKA) / RELKLIMAEFFEKT(RRR,BBB,PRDK,VARE);

*$ontext
ITEST(RRR,BBB,'OMFG_LO',PRDKOPT,'',STEP)  = omfang.lo(RRR,BBB,PRDKOPT);
ITEST(RRR,BBB,'OMFG_L',PRDKOPT,'',STEP)   = omfang.l(RRR,BBB,PRDKOPT);
ITEST(RRR,BBB,'OMFG_UP',PRDKOPT,'',STEP)  = omfang.up(RRR,BBB,PRDKOPT);
ITEST(RRR,BBB,'GROVAND_MIN',GROV,'',STEP) =  GROVAND(RRR,GROV,'MIN');
ITEST(RRR,BBB,'GROVAND_MAX',GROV,'',STEP) =  GROVAND(RRR,GROV,'MAX');
ITEST(RRR,BBB,'intens_lo',VARE,PRDK,STEP)     =  intens.lo(RRR,VARE,PRDK);
ITEST(RRR,BBB,'intens_l',VARE,PRDK,STEP)     =  intens.l(RRR,VARE,PRDK);
ITEST(RRR,BBB,'intens_up',VARE,PRDK,STEP)     =  intens.up(RRR,VARE,PRDK);

ITEST(RRR,BBB,'arbeid_lo',VARE,'',STEP)     =  arbeid.lo(RRR,BBB,VARE);
ITEST(RRR,BBB,'arbeid_l',VARE,'',STEP)     =  arbeid.l(RRR,BBB,VARE);
ITEST(RRR,BBB,'arbeid_up',VARE,'',STEP)     =  arbeid.up(RRR,BBB,VARE);

ITEST(RRR,BBB,'beiteand_lo','','',STEP)     =  beiteand.lo(RRR,BBB);
ITEST(RRR,BBB,'beiteand_l','','',STEP)     =  beiteand.l(RRR,BBB);
ITEST(RRR,BBB,'beiteand_up','','',STEP)     =  beiteand.up(RRR,BBB);

ITEST(RRR,BBB,'pris_lo',VARE,'',STEP)     =  pris.lo(RRR,BBB,VARE);
ITEST(RRR,BBB,'pris_l',VARE,'',STEP)     =  pris.l(RRR,BBB,VARE);
ITEST(RRR,BBB,'pris_up',VARE,'',STEP)     =  pris.up(RRR,BBB,VARE);

ITEST(RRR,BBB,'balans_lo',VARE,'',STEP)     =  balans.lo(RRR,BBB,VARE);
ITEST(RRR,BBB,'balans_l',VARE,'',STEP)     =  balans.l(RRR,BBB,VARE);
ITEST(RRR,BBB,'balans_up',VARE,'',STEP)     =  balans.up(RRR,BBB,VARE);

ITEST(RRR,BBB,'bidrag_lo',VARE,'',STEP)      =  bidrag.lo(RRR,BBB,VARE);
ITEST(RRR,BBB,'bidrag_l',VARE,'',STEP)       =  bidrag.l(RRR,BBB,VARE);
ITEST(RRR,BBB,'bidrag_up',VARE,'',STEP)      =  bidrag.up(RRR,BBB,VARE);

MELKTEST(RRR,BBB,'A','A','A','A') = (AMELK * (intens.l(RRR,'FGRV','MKYR')-MFGRV));
MELKTEST(RRR,'B','B','B','B','B') = (BMELK *  intens.l(RRR,'FDRM','MKYR') * (1+SUM((KLTKA,BBB), KLIMAEFFEKT(RRR,BBB,'FDRM','','MKYR','REL',KLTKA)*opptak.l(RRR,BBB,KLTKA))));
MELKTEST(RRR,'C','C','C','C','C') = (CMELK * (intens.l(RRR,'FGRV','MKYR')+intens.l(RRR,'FDRM','MKYR')*(1+SUM((KLTKA,BBB), KLIMAEFFEKT(RRR,BBB,'FDRM','','MKYR','REL',KLTKA)*opptak.l(RRR,BBB,KLTKA))))-MF);
MELKTEST(RRR,BBB,'D','D','D','D') =  FMELK;
MELKTEST(RRR,BBB,'FGRV','lo','','') =  intens.lo(RRR,'FGRV','MKYR');
MELKTEST(RRR,BBB,'FGRV','l','','') =   intens.l(RRR,'FGRV','MKYR');
MELKTEST(RRR,BBB,'FGRV','up','','') =  intens.up(RRR,'FGRV','MKYR');
MELKTEST(RRR,BBB,'FDRM','lo','','') =  intens.lo(RRR,'FDRM','MKYR');
MELKTEST(RRR,BBB,'FDRM','l','','') =   intens.l(RRR,'FDRM','MKYR');
MELKTEST(RRR,BBB,'FDRM','up','','') =  intens.up(RRR,'FDRM','MKYR');
MELKTEST(RRR,BBB,'KMLK','lo','','') =  intens.lo(RRR,'KMLK','MKYR');
MELKTEST(RRR,BBB,'KMLK','l','','') =   intens.l(RRR,'KMLK','MKYR');
MELKTEST(RRR,BBB,'KMLK','up','','') =  intens.up(RRR,'KMLK','MKYR');


option solprint = on;

*SIMDATACHECK(RRR,BBB,'omfang.lo',PRDKOPT) = omfang.lo(RRR,BBB,PRDKOPT);
*SIMDATACHECK(RRR,BBB,'kornand',PRDKOPT)   = kornand(RRR,PRDKOPT,'max');
*
*arbeid.lo(R,B,'ARBF') = 0;
*omfang.fx(R,B,'OKKS') = 0;
*omfang.fx(R,B,'KVKS') = 0;
*pris.lo('17425A','BAKY','ARBF') = 0;
**display simdatacheck;
*execute_unload 'JordmodTest.gdx';



         solve tilbudsmodell maximizing objbruk using NLP;
         

MODSTATUS(RRR,BBB,STEP) $ ((tilbudsmodell.numinfes > 0)   or (tilbudsmodell.modelstat eq 3)
                        or (tilbudsmodell.modelstat eq 4) or (tilbudsmodell.modelstat eq 5)) = YES;

$ifThenI.size %size%==YES
option solprint = on;

MODSTATUS(RRR,BBB,STEP) = NO;
MODSIZE(RRR,BBB,STEP,SIZE) $ ((tilbudsmodell.numinfes > 0)   or (tilbudsmodell.modelstat eq 3)
                          or (tilbudsmodell.modelstat eq 4) or (tilbudsmodell.modelstat eq 5)) = YES;
$endIf.size

*abort '';
*
* Snu fortegn til CO2SINK
intens.l(RRR,'CO2SINK',PRDKOPT) = -intens.l(RRR,'CO2SINK',PRDKOPT);

*
* Lagre koeffisienter for videre bruk i markedsmodellen
SIMDATA(RRR,BBB,'OMFG',PRDKOPT) $(NOT MODSTATUS(RRR,BBB,STEP)) = omfang.l(RRR,BBB,PRDKOPT) ;
SIMDATA(RRR,BBB,'OMFG','SPRE')  $(NOT MODSTATUS(RRR,BBB,STEP)) = balans.l(RRR,BBB,'SPRE')  ;
SIMDATA(RRR,BBB,'OMFG','BEIT')  $(NOT MODSTATUS(RRR,BBB,STEP)) = beiteand.l(RRR,BBB)  ;
*
* Fysiske produkter innsatsfaktorer og utslipp
SIMDATA(RRR,BBB,'MNGD',VAREOPT) $(NOT MODSTATUS(RRR,BBB,STEP)) = SUM(PRDKOPT, omfang.l(RRR,BBB,PRDKOPT) * intens.l(RRR,VAREOPT,PRDKOPT)) / 1000 ;
*
* All arbeid legges paa ARBF
SIMDATA(RRR,BBB,'MNGD','ARBF')  $(NOT MODSTATUS(RRR,BBB,STEP)) = arbeid.l(RRR,BBB,'ARBF') + arbeid.l(RRR,BBB,'ARBL') ;
SIMDATA(RRR,BBB,'MNGD','ARBL')  $(NOT MODSTATUS(RRR,BBB,STEP)) = 0                                               ;
SIMDATA(RRR,BBB,'PRIS','ARBF')  $(NOT MODSTATUS(RRR,BBB,STEP)) = pris.l(RRR,BBB,'ARBF');
*
*SIMDATA(RRR,BBB,'MARG','GFFP')  $(NOT MODSTATUS(RRR,BBB,STEP)) = (-EQMAKSGFFP.m(RRR,BBB));
*
* Monetaere verdier for varer innsatsfaktorer tilskudd og miljoavgifter
SIMDATA(RRR,BBB,'VERD',VAREOPT) $(NOT MODSTATUS(RRR,BBB,STEP)) = bidrag.l(RRR,BBB,VAREOPT)                                      ;
SIMDATA(RRR,BBB,'VERD','ARBF')  $(NOT MODSTATUS(RRR,BBB,STEP)) = SIMDATA(RRR,BBB,'VERD','ARBF') + SIMDATA(RRR,BBB,'VERD','ARBL')  ;
SIMDATA(RRR,BBB,'VERD','ARBL')                            = 0                                                              ;
SIMDATA(RRR,BBB,'VERD',TILOPT)  $(NOT MODSTATUS(RRR,BBB,STEP)) = bidrag.l(RRR,BBB,TILOPT)                                       ;
SIMDATA(RRR,BBB,'VERD','PROF')  $(NOT MODSTATUS(RRR,BBB,STEP)) = profitt.l(RRR,BBB)                                          ;
*
* Gjoedslingsintensitet i grovfor og plante
SIMDATA(RRR,BBB,GJOD,KORN) $ (SAMEAS('BKRN',BBB) AND omfang.l(RRR,BBB,KORN) AND (NOT MODSTATUS(RRR,BBB,STEP))) = intens.l(RRR,GJOD,KORN) ;
SIMDATA(RRR,BBB,GJOD,GROV) $ (SAMEAS('BKMK',BBB) AND omfang.l(RRR,BBB,GROV) AND (NOT MODSTATUS(RRR,BBB,STEP))) = intens.l(RRR,GJOD,GROV) ;
*
* Arbeid omregnes fra timer til aarsverk
SIMDATA(RRR,BBB,'MNGD','ARBF') $(NOT MODSTATUS(RRR,BBB,STEP)) = SIMDATA(RRR,BBB,'MNGD','ARBF') / TimerPerAarsverk;
*
* Intensitet
SIMDATA(RRR,BBB,VAREOPT,PRDKOPT) $((NOT MODSTATUS(RRR,BBB,STEP)) AND omfang.l(RRR,BBB,PRDKOPT)) = intens.l(RRR,VAREOPT,PRDKOPT) ;
*
* Opptak av klimatiltak
SIMDATA(RRR,BBB,'OPPTAK',KLTK) $(NOT MODSTATUS(RRR,BBB,STEP)) = opptak.l(RRR,BBB,KLTK);
SIMDATA(RRR,BBB,'OPPTVD',KLTK) $(NOT MODSTATUS(RRR,BBB,STEP)) = opptak.m(RRR,BBB,KLTK);
*
* Utslipp til GHG og miljoavgift
SIMDATA(RRR,BBB,'MNGD',UTSLIPPGHG)  $(NOT MODSTATUS(RRR,BBB,STEP)) = SUM(UTSLIPP$UTSLIPPGHG_TIL_UTSLIPP(UTSLIPPGHG,UTSLIPP), SIMDATA(RRR,BBB,'MNGD',UTSLIPP));
SIMDATA(RRR,BBB,'VERD',UTSLIPPAVG)  $(NOT MODSTATUS(RRR,BBB,STEP)) = bidrag.l(RRR,BBB,UTSLIPPAVG);
*
* Utslipp pr aktivitet i kg utslippvare pr dyr eller daa
SIMDATA(RRR,BBB,PRDKOPT,UTSLIPP) $(NOT MODSTATUS(RRR,BBB,STEP)) = omfang.l(RRR,BBB,PRDKOPT) * intens.l(RRR,UTSLIPP,PRDKOPT) / 1000;
* Save
KLIMADATA(RRR,BBB,PRDKOPT,UTSLIPP) $(NOT MODSTATUS(RRR,BBB,STEP)) = SIMDATA(RRR,BBB,PRDKOPT,UTSLIPP) ;
* Produkt i kg utslippvare pr kg produkt beregnes etter simulering for alle bruk
*
* Utslipp kraftforraavare
SIMDATA(RRR,BBB,UTSLIPPGHG,MOELUTKVARE) $(NOT MODSTATUS(RRR,BBB,STEP)) =
SUM(MOEL$VARE_TIL_MOEL(MOELUTKVARE,MOEL), SIMDATA(RRR,BBB,'MNGD',MOELUTKVARE) * (1-MOLDATA('FFKN',MOEL)) * GHGMOELUTVARE(UTSLIPPGHG)) ;
*
* Utslipp produksjon av kunstgjoedsel
SIMDATA(RRR,BBB,UTSLIPPGHG,HGJOD) $(NOT MODSTATUS(RRR,BBB,STEP)) =  SIMDATA(RRR,BBB,'MNGD',HGJOD) * GHGHGJOD(HGJOD,UTSLIPPGHG)  ;
*
* Enhetskostnader
SIMDATA(RRR,BBB,'ENHK','VERD') $ SUM(VARE$B_TIL_VARE(BBB,VARE), SIMDATA(RRR,BBB,'MNGD',VARE)) = SUM(INNSATS, bidrag.l(RRR,BBB,INNSATS))
 / SUM(VARE$B_TIL_VARE(BBB,VARE), SIMDATA(RRR,BBB,'MNGD',VARE));
*
* Lagre modelstatus
SIMDATA(RRR,BBB,'MDST',STEP)  = 1 $ MODSTATUS(RRR,BBB,STEP) ;
*
* Konvergensindikator primaerjordbruk
KONVERGENS(RRR,BBB,'PROF',STEP) = profitt.l(RRR,BBB);

* Lagre koeffisienter per simulering
KONVERGESIMDATA(STEP,RRR,VARE,'PRIS',VARE)        =  SIMDATA(RRR,VARE,'TOTP','Y')        ;
KONVERGESIMDATA(STEP,RRR,BBB,'OMFG',PRDKOPT)      =  SIMDATA(RRR,BBB,'OMFG',PRDKOPT)     ;
KONVERGESIMDATA(STEP,RRR,BBB,'OMFG','SPRE')       =  SIMDATA(RRR,BBB,'OMFG','SPRE')      ;
KONVERGESIMDATA(STEP,RRR,BBB,'MNGD',VAREOPT)      =  SIMDATA(RRR,BBB,'MNGD',VAREOPT)     ;
KONVERGESIMDATA(STEP,RRR,BBB,'VERD',VAREOPT)      =  SIMDATA(RRR,BBB,'VERD',VAREOPT)     ;
KONVERGESIMDATA(STEP,RRR,BBB,'VERD',TILOPT)       =  SIMDATA(RRR,BBB,'VERD',TILOPT)      ;
KONVERGESIMDATA(STEP,RRR,BBB,'VERD','PROF')       =  SIMDATA(RRR,BBB,'VERD','PROF')      ;
KONVERGESIMDATA(STEP,RRR,BBB,GJOD,KORN)           =  SIMDATA(RRR,BBB,GJOD,KORN)          ;
KONVERGESIMDATA(STEP,RRR,BBB,GJOD,GROV)           =  SIMDATA(RRR,BBB,GJOD,GROV)          ;
KONVERGESIMDATA(STEP,RRR,BBB,VAREOPT,PRDKOPT)     =  SIMDATA(RRR,BBB,VAREOPT,PRDKOPT)    ;
KONVERGESIMDATA(STEP,RRR,BBB,'MNGD',UTSLIPPGHG)   =  SIMDATA(RRR,BBB,'MNGD',UTSLIPPGHG)  ;
KONVERGESIMDATA(STEP,RRR,BBB,'MNGD',UTSLIPPAVG)   =  SIMDATA(RRR,BBB,'MNGD',UTSLIPPAVG)  ;
KONVERGESIMDATA(STEP,RRR,BBB,PRDKOPT,UTSLIPP)     =  SIMDATA(RRR,BBB,PRDKOPT,UTSLIPP)    ;
KONVERGESIMDATA(STEP,RRR,BBB,UTSLIPPGHG,MOELUTKVARE) =  SIMDATA(RRR,BBB,UTSLIPPGHG,MOELUTKVARE);
KONVERGESIMDATA(STEP,RRR,BBB,UTSLIPPGHG,HGJOD)    =  SIMDATA(RRR,BBB,UTSLIPPGHG,HGJOD)   ;
KONVERGESIMDATA(STEP,RRR,BBB,'ENHK','VERD')       =  SIMDATA(RRR,BBB,'ENHK','VERD')      ;
KONVERGESIMDATA(STEP,RRR,BBB,'MDST',STEP)         =  SIMDATA(RRR,BBB,'MDST',STEP)        ;
KONVERGESIMDATA(STEP,RRR,BBB,'OPPTAK.L',KLTK)     =  SIMDATA(RRR,BBB,'OPPTAK',KLTK)        ;
KONVERGESIMDATA(STEP,RRR,BBB,'OPPTAK.M',KLTK)     =  SIMDATA(RRR,BBB,'OPPTVD',KLTK)        ;
KONVERGESIMDATA(STEP,RRR,'TKLIA','',KLTK)         =  SATSER('TKLIA',KLTK,'0',RRR)        ;
KONVERGESIMDATA(STEP,RRR,BBB,'PROF','')           =  profitt.l(RRR,BBB)       ;
KONVERGESIMDATA(STEP,RRR,BBB,'OBJ','')            =  objbruk.l   ;
*KONVERGESIMDATA(STEP,RRR,BBB,'PMPFeed','')        =  Sum(PRDK, PmpFeed.l(RRR,BBB,PRDK))       ;
*


$ifThenI.size %SIZE%==YES
* Data for beregning av enkeltbruk
* Enhetskostnader
SIZEDATA(RRR,BBB,'ENHK','VERD',SIZE) $ (SUM(VARE$B_TIL_VARE(BBB,VARE), SIMDATA(RRR,BBB,'MNGD',VARE)) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE))) = SUM(INNSATS, bidrag.l(RRR,BBB,INNSATS))
 / SUM(VARE$B_TIL_VARE(BBB,VARE), SIMDATA(RRR,BBB,'MNGD',VARE)) ;
SIZEDATA(RRR,BBB,'ENHK',INNSATS,SIZE) $ (SUM(VARE$B_TIL_VARE(BBB,VARE), SIMDATA(RRR,BBB,'MNGD',VARE)) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE))) = bidrag.l(RRR,BBB,INNSATS)
 / SUM(VARE$B_TIL_VARE(BBB,VARE), SIMDATA(RRR,BBB,'MNGD',VARE)) ;
SIZEDATA('NORGE',BBB,'ENHK','VERD',SIZE) = SUM(RRR, SIZEDATA(RRR,BBB,'ENHK','VERD',SIZE)) / CARD(RRR);
*
* Intensitet melk
SIZEDATA(RRR,BBB,'FDRM','INTN',SIZE) $ (omfang.l(RRR,BBB,'MKYR') AND (NOT MODSIZE(RRR,BBB,STEP,SIZE))) = intens.l(RRR,'FDRM','MKYR');
SIZEDATA(RRR,BBB,'FGRV','INTN',SIZE) $ (omfang.l(RRR,BBB,'MKYR') AND (NOT MODSIZE(RRR,BBB,STEP,SIZE))) = intens.l(RRR,'FGRV','MKYR');
SIZEDATA(RRR,BBB,'KMLK','INTN',SIZE) $ (omfang.l(RRR,BBB,'MKYR') AND (NOT MODSIZE(RRR,BBB,STEP,SIZE))) = intens.l(RRR,'KMLK','MKYR');
*SIZEDATA(RRR,BBB,'KVOT','INTN',SIZE) = eqvarekvot.m(RRR,'KMLK');
SIZEDATA(RRR,BBB,'GROV','INTN',SIZE) $ SUM((PLANTE,INNSATS), omfang.l(RRR,BBB,PLANTE) * intens.l(RRR,INNSATS,PLANTE)) =
      SUM((PLANTE,INNSATS), omfang.l(RRR,BBB,PLANTE) * intens.l(RRR,INNSATS,PLANTE) * DATA(RRR,INNSATS,'TOTP','Y')) /
      SUM((PLANTE,INNSATS), omfang.l(RRR,BBB,PLANTE) * intens.l(RRR,INNSATS,PLANTE));
SIZEDATA(RRR,BBB,'FDRM','SOEY',SIZE) $ (omfang.l(RRR,BBB,'SOEY') AND (NOT MODSIZE(RRR,BBB,STEP,SIZE))) = intens.l(RRR,'FDRM','SOEY');
SIZEDATA(RRR,BBB,'SAUK','LAMS',SIZE) $ (omfang.l(RRR,BBB,'LAMS') AND (NOT MODSIZE(RRR,BBB,STEP,SIZE))) = intens.l(RRR,'SAUK','LAMS');
*
* Omfang
SIZEDATA(RRR,BBB,PRDKOPT,'OMFG',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'OMFG',PRDKOPT);
SIZEDATA(RRR,BBB,'KORN','OMFG',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SUM(KORN, SIMDATA(RRR,BBB,'OMFG',KORN));
SIZEDATA(RRR,BBB,'UNGD','OMFG',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SUM(UNGD, SIMDATA(RRR,BBB,'UNGD',UNGD));
SIZEDATA(RRR,BBB,'GROV','OMFG',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SUM(GROV, SIMDATA(RRR,BBB,'GROV',GROV));

SIZEDATA('NORGE',BBB,PRDKOPT,'OMFG',SIZE) = SUM(RRR, SIZEDATA(RRR,BBB,PRDKOPT,'OMFG',SIZE)) / CARD(RRR);
SIZEDATA('NORGE',BBB,'KORN','OMFG',SIZE) = SUM(RRR, SIZEDATA(RRR,BBB,'KORN','OMFG',SIZE)) / CARD(RRR);
SIZEDATA('NORGE',BBB,'UNGD','OMFG',SIZE) = SUM(RRR, SIZEDATA(RRR,BBB,'UNGD','OMFG',SIZE)) / CARD(RRR);
SIZEDATA('NORGE',BBB,'GROV','OMFG',SIZE) = SUM(RRR, SIZEDATA(RRR,BBB,'GROV','OMFG',SIZE)) / CARD(RRR);
* Mengder
SIZEDATA(RRR,BBB,VAREOPT,'MNGD',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'MNGD',VAREOPT) ;
SIZEDATA(RRR,BBB,'ARB_F','MNGD',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = arbeid.l(RRR,BBB,'ARBF');
SIZEDATA(RRR,BBB,'ARB_L','MNGD',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = arbeid.l(RRR,BBB,'ARBL');
*
SIZEDATA('NORGE',BBB,VAREOPT,'MNGD',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,VAREOPT,'MNGD',SIZE)) / CARD(RRR);
SIZEDATA('NORGE',BBB,'ARB_F','MNGD',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,'ARB_F','MNGD',SIZE)) / CARD(RRR);
SIZEDATA('NORGE',BBB,'ARB_L','MNGD',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,'ARB_L','MNGD',SIZE)) / CARD(RRR);
*
* Innsatsfaktorer
SIZEDATA(RRR,BBB,'KAPB','MNGD',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'MNGD','KAPB');
SIZEDATA('NORGE',BBB,'KAPB','MNGD',SIZE) = SUM(RRR, SIZEDATA(RRR,BBB,'KAPB','MNGD',SIZE)) / CARD(RRR);
SIZEDATA(RRR,BBB,'KAPM','MNGD',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'MNGD','KAPM');
SIZEDATA('NORGE',BBB,'KAPM','MNGD',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,'KAPM','MNGD',SIZE)) / CARD(RRR);
SIZEDATA(RRR,BBB,'ARBF','MNGD',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'MNGD','ARBF');
SIZEDATA('NORGE',BBB,'ARBF','MNGD',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,'ARBF','MNGD',SIZE)) / CARD(RRR);
* Tilskudd
SIZEDATA(RRR,BBB,'TIL','VERD',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SUM(TILOPT, SIMDATA(RRR,BBB,'VERD',TILOPT));
SIZEDATA('NORGE',BBB,'TIL','VERD',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,'TIL','VERD',SIZE)) / CARD(RRR);
* Bidrag
SIZEDATA(RRR,BBB,VAREOPT,'VERD',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'VERD',VAREOPT);
SIZEDATA(RRR,BBB,'ARBF','PRIS',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = pris.l(RRR,BBB,'ARBF');
SIZEDATA(RRR,BBB,'ARBL','PRIS',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = DATA(RRR,'ARBL','TOTP','Y');
*
SIZEDATA('NORGE',BBB,VAREOPT,'VERD',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,VAREOPT,'VERD',SIZE)) / CARD(RRR);
SIZEDATA('NORGE',BBB,VAREOPT,'PRIS',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,VAREOPT,'PRIS',SIZE)) / CARD(RRR);
*
* Profitt
SIZEDATA(RRR,BBB,'PROF','VERD',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'VERD','PROF');
SIZEDATA('NORGE',BBB,'PROF','VERD',SIZE) = SUM(RRR, SIZEDATA(RRR,BBB,'PROF','VERD',SIZE)) / CARD(RRR);
*
* Dekningsbidrag
SIZEDATA(RRR,BBB,'DB','VERD',SIZE) $ SUM(INNSATDB, SIMDATA(RRR,BBB,'VERD',INNSATDB)) =  SUM(SIMVARE, SIMDATA(RRR,BBB,'VERD',SIMVARE)) / SUM(INNSATDB, SIMDATA(RRR,BBB,'VERD',INNSATDB)) ;
*
* Enhetsinnsatsfaktorer
SIZEDATA(RRR,BBB,'KAPB','ENHM',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'MNGD','KAPB') / SUM(PRDKOPT $B_TIL_HRDK(BBB,PRDKOPT), SIMDATA(RRR,BBB,'OMFG',PRDKOPT));
SIZEDATA('NORGE',BBB,'KAPB','ENHM',SIZE) = SUM(RRR, SIZEDATA(RRR,BBB,'KAPB','ENHM',SIZE)) / CARD(RRR);
SIZEDATA(RRR,BBB,'KAPM','ENHM',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'MNGD','KAPM') / SUM(PRDKOPT $B_TIL_HRDK(BBB,PRDKOPT), SIMDATA(RRR,BBB,'OMFG',PRDKOPT));
SIZEDATA('NORGE',BBB,'KAPM','ENHM',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,'KAPM','ENHM',SIZE)) / CARD(RRR);
SIZEDATA(RRR,BBB,'ARBF','ENHM',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = (SIMDATA(RRR,BBB,'MNGD','ARBF') * TimerPerAarsverk) / SUM(PRDKOPT $B_TIL_HRDK(BBB,PRDKOPT), SIMDATA(RRR,BBB,'OMFG',PRDKOPT));
SIZEDATA('NORGE',BBB,'ARBF','ENHM',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,'ARBF','ENHM',SIZE)) / CARD(RRR);
SIZEDATA(RRR,BBB,'ARBF','ENHV',SIZE) $ (NOT MODSIZE(RRR,BBB,STEP,SIZE)) = SIMDATA(RRR,BBB,'VERD','ARBF') / (SIMDATA(RRR,BBB,'MNGD','ARBF') * TimerPerAarsverk);
SIZEDATA('NORGE',BBB,'ARBF','ENHV',SIZE)  = SUM(RRR, SIZEDATA(RRR,BBB,'ARBF','ENHV',SIZE)) / CARD(RRR);
*

INTENSM(RRR,BBB,MOELUTVARE,AHUSDYR) $ (SAMEAS('BKMK',BBB) OR SAMEAS('BGMK',BBB) OR SAMEAS('BAKY',BBB) OR SAMEAS('BSAU',BBB)) = intens.m(RRR,MOELUTVARE,AHUSDYR);
$endIf.size
*
* Tilbakestiller startverdier
PRDKOPT(PRDK) = YES;
PRDKNOPT(PRDK) = NO;
VAREOPT(VARE) = YES;
VARENOPT(VARE) = NO;
TILOPT(TILSKUDD) = YES;

omfang.lo(R,B,PRDK)    =  LAGRESTARTVERDIER(R,B,PRDK,'OMFG_LO')         ;
omfang.l(R,B,PRDK)     =  LAGRESTARTVERDIER(R,B,PRDK,'OMFG_L')          ;
omfang.up(R,B,PRDK)    =  LAGRESTARTVERDIER(R,B,PRDK,'OMFG_UP')         ;

intens.lo(R,VARE,PRDK) =  LAGRESTARTVERDIER(R,VARE,PRDK,'INTENS_LO')    ;
intens.l(R,VARE,PRDK)  =  LAGRESTARTVERDIER(R,VARE,PRDK,'INTENS_L')     ;
intens.up(R,VARE,PRDK) =  LAGRESTARTVERDIER(R,VARE,PRDK,'INTENS_UP')    ;

GROVAND(R,GROV,'MIN')  =  LAGRESTARTVERDIER(R,GROV,'MIN','GROVAND_MIN') ;
GROVAND(R,GROV,'MAX')  =  LAGRESTARTVERDIER(R,GROV,'MAX','GROVAND_MAX') ;

arbeid.lo(R,B,VARE)    =  LAGRESTARTVERDIER(R,B,VARE,'ARBEID_LO')       ;
arbeid.l(R,B,VARE)     =  LAGRESTARTVERDIER(R,B,VARE,'ARBEID_L')        ;
arbeid.up(R,B,VARE)    =  LAGRESTARTVERDIER(R,B,VARE,'ARBEID_UP')       ;

beiteand.lo(R,B)       =  LAGRESTARTVERDIER(R,B,'','BEITEAND_LO')       ;
beiteand.l(R,B)        =  LAGRESTARTVERDIER(R,B,'','BEITEAND_L')        ;
beiteand.up(R,B)       =  LAGRESTARTVERDIER(R,B,'','BEITEAND_UP')       ;

pris.lo(R,B,VARE)      =  LAGRESTARTVERDIER(R,B,VARE,'PRIS_LO')         ;
pris.l(R,B,VARE)       =  LAGRESTARTVERDIER(R,B,VARE,'PRIS_L')          ;
pris.up(R,B,VARE)      =  LAGRESTARTVERDIER(R,B,VARE,'PRIS_UP')         ;

opptak.lo(R,B,KLTK)    =  LAGRESTARTVERDIER(R,B,KLTK,'OPPTAK_LO')       ;
opptak.l(R,B,KLTK)     =  LAGRESTARTVERDIER(R,B,KLTK,'OPPTAK_L')        ;
opptak.up(R,B,KLTK)    =  LAGRESTARTVERDIER(R,B,KLTK,'OPPTAK_UP')       ;
*
* Her stopper loop som beregner optimal driftsplan for hvert gaardsbruk
);


$ifThenI.pmpFeed %PMP%==YES
execute_unload 'pmpFeed.gdx', PmpFeedCnst, PmpFeedQuad, PmpKForTest ;
$endif.pmpFeed


*
$ifThenI.size %SIZE%==YES
* Her stopper loop farmsize som beregner data for vurdering av enkeltbruk
);
execute_unload 'resultater\sizedata.gdx', sizedata, simdata, omfang, bidrag, intens, arbeid, modstatus, modsize;
abort '';
$endIf.size

* Her stopper loop for hele iterasjonen
*);

*$ontext
* Abort modellen ved infeasibilities for noen bruk
IF ((SUM((R,B)$MODSTATUS(R,B,STEP), 1) > 0),
   execute_unload '%SCEN%_infes_tilbud.gdx'
   abort "Infeasibilities i tilbudsmodellen", MODSTATUS ; );
*$offtext
*
* Fordele utslipp på VARE etter enkeltbruksberegninger
*$ontext
SIMDATA(R,B,UTSLIPP,VARE) $((NOT MODSTATUS(R,B,STEP)) AND SUM(PRDK$B_PRDK_VARE(B,PRDK,VARE), 1) AND
SUM(VAREVARE $ SUM(PRDK$B_PRDK_VARE(B,PRDK,VAREVARE), SIMDATA(R,B,'VERD',VAREVARE)), SIMDATA(R,B,'VERD',VAREVARE))) =
SUM(PRDK, KLIMADATA(R,B,PRDK,UTSLIPP)) * SIMDATA(R,B,'VERD',VARE) / SUM(VAREVARE $ SUM(PRDK$B_PRDK_VARE(B,PRDK,VAREVARE), SIMDATA(R,B,'VERD',VAREVARE)), SIMDATA(R,B,'VERD',VAREVARE));
*
* For plant production use same emissions for quantities as for activities
SIMDATA(R,B,UTSLIPP,VARE)$SUM(PRDK$(PLANTE(PRDK) $ KLIM_VARE_TIL_PRDK(PRDK,VARE)), 1) = SUM(PRDK$KLIM_VARE_TIL_PRDK(PRDK,VARE), KLIMADATA(R,B,PRDK,UTSLIPP));


*SIMDATACHECK(R,B,'VERDAndel',VARE) = SIMDATA(R,B,'VERD',VARE) / SUM(VAREVARE $ SUM(PRDK$B_PRDK_VARE(B,PRDK,VAREVARE), SIMDATA(R,B,'VERD',VAREVARE)), SIMDATA(R,B,'VERD',VAREVARE));

*
execute_unload 'simdatacheck.gdx', simdatacheck;
*
*abort '';

$ifThenI.PreCalib %PreCalibration%==YES
CalibARBP(R,B) = SIMDATA(R,B,'VERD','PROF');
execute_unload 'Tilbudsmodul\CalibARBP.gdx', CalibARBP;

CalibLevl(R,B,PRDK) = SIMDATA(R,B,'OMFG',PRDK);
execute_unload 'Tilbudsmodul\CalibLevl.gdx', CalibLevl;


SimdataCheck(R,B,'Cal','KAPT_Coeff')  = 97.095;
SimdataCheck(R,B,'Cal','KAPT_Exp')    = 0.0611;
SimdataCheck(R,B,'Cal','KAPT_Levl')   = 40.01;
SimdataCheck(R,B,'Cal','KAPT_PerDyr') = 121;
SimdataCheck(R,B,'Cal','KAPT_Tot')  = SimdataCheck(R,B,'Cal','KAPT_PerDyr') * SimdataCheck(R,B,'Cal','KAPT_Levl');
       
SimdataCheck(R,B,'Mod','KAPB_Coeff') = SUM(PRDK $ B_TIL_HRDK(B,PRDK), EndoCoeffA(R,B,PRDK,'KAPB')); 
SimdataCheck(R,B,'Mod','KAPB_Levl')  = SUM(PRDK $ B_TIL_PRDK(PRDK,B), ShareEndoIntens(R,B,PRDK,'KAPB') * Simdata(R,B,'OMFG',PRDK));
SimdataCheck(R,B,'Mod','KAPB_Omfg')  = SUM(PRDK $ B_TIL_HRDK(B,PRDK), Simdata(R,B,'OMFG',PRDK));
SimdataCheck(R,B,'Mod','KAPB_Exp')   = EndoCoeffE(B,'KAPB');
SimdataCheck(R,B,'Mod','KAPB_PerDyr') $ SUM(PRDK $ B_TIL_PRDK(PRDK,B), ShareEndoIntens(R,B,PRDK,'KAPB') * Simdata(R,B,'OMFG',PRDK)) =
       SUM(PRDK $ B_TIL_HRDK(B,PRDK), EndoCoeffA(R,B,PRDK,'KAPB')) * SUM(PRDK $ B_TIL_PRDK(PRDK,B), ShareEndoIntens(R,B,PRDK,'KAPB') * Simdata(R,B,'OMFG',PRDK))**EndoCoeffE(B,'KAPB');
SimdataCheck(R,B,'Mod','KAPB_Tot')  = SimdataCheck(R,B,'Mod','KAPB_PerDyr') * SimdataCheck(R,B,'Mod','KAPB_Omfg');

SimdataCheck(R,B,'Mod','KAPM_Coeff') = SUM(PRDK $ B_TIL_HRDK(B,PRDK), EndoCoeffA(R,B,PRDK,'KAPM')); 
SimdataCheck(R,B,'Mod','KAPM_Levl')  = SUM(PRDK $ B_TIL_PRDK(PRDK,B), ShareEndoIntens(R,B,PRDK,'KAPM') * Simdata(R,B,'OMFG',PRDK));
SimdataCheck(R,B,'Mod','KAPM_Omfg')  = SUM(PRDK $ B_TIL_HRDK(B,PRDK), Simdata(R,B,'OMFG',PRDK));
SimdataCheck(R,B,'Mod','KAPM_Exp')   = EndoCoeffE(B,'KAPM');
SimdataCheck(R,B,'Mod','KAPM_PerDyr') $ SUM(PRDK $ B_TIL_PRDK(PRDK,B), ShareEndoIntens(R,B,PRDK,'KAPM') * Simdata(R,B,'OMFG',PRDK)) =
       SUM(PRDK $ B_TIL_HRDK(B,PRDK), EndoCoeffA(R,B,PRDK,'KAPM')) * SUM(PRDK $ B_TIL_PRDK(PRDK,B), ShareEndoIntens(R,B,PRDK,'KAPM') * Simdata(R,B,'OMFG',PRDK))**EndoCoeffE(B,'KAPM');
SimdataCheck(R,B,'Mod','KAPM_Tot')  = SimdataCheck(R,B,'Mod','KAPM_PerDyr') * SimdataCheck(R,B,'Mod','KAPM_Omfg');

SimdataCheck(R,B,'Mod','KAPT_PerDyr') = SimdataCheck(R,B,'Mod','KAPB_PerDyr') + SimdataCheck(R,B,'Mod','KAPM_PerDyr');
SimdataCheck(R,B,'Mod','KAPT_Tot')    = SimdataCheck(R,B,'Mod','KAPB_Tot')    + SimdataCheck(R,B,'Mod','KAPM_Tot');

SimdataCheck(R,B,PRDK,'KAPB_PerDyr_Sim') = Simdata(R,B,'KAPB',PRDK);
SimdataCheck(R,B,PRDK,'KAPM_PerDyr_Sim') = Simdata(R,B,'KAPM',PRDK);

SimdataCheck(R,B,'Sup','KAPB_Tot') = Sum(PRDK, Simdata(R,B,'KAPB',PRDK) * Simdata(R,B,'OMFG',PRDK)) ;
SimdataCheck(R,B,'Sup','KAPM_Tot') = Sum(PRDK, Simdata(R,B,'KAPM',PRDK) * Simdata(R,B,'OMFG',PRDK)) ;
SimdataCheck(R,B,'Sup','KAPT_Tot') = SimdataCheck(R,B,'Sup','KAPB_Tot') + SimdataCheck(R,B,'Sup','KAPM_Tot');

SimdataCheck(R,B,'Sup','KAPB_Verd') = SimdataCheck(R,B,'Sup','KAPB_Tot') * SIMDATA(R,'KAPB','TOTP','Y') ;
SimdataCheck(R,B,'Sup','KAPM_Verd') = SimdataCheck(R,B,'Sup','KAPM_Tot') * SIMDATA(R,'KAPM','TOTP','Y') ;

SimdataCheck(R,B,PRDK,'KAPB_Share') $ SUM(PRDKPRDK,  ENDOKOEFF(R,PRDK,'KAPB') * Simdata(R,B,'OMFG',PRDKPRDK)) =
                    ENDOKOEFF(R,PRDK,'KAPB') * Simdata(R,B,'OMFG',PRDK)
  /  SUM(PRDKPRDK,  ENDOKOEFF(R,PRDKPRDK,'KAPB') * Simdata(R,B,'OMFG',PRDKPRDK));
*
SimdataCheck(R,B,PRDK,'KAPM_Share') $ SUM(PRDKPRDK,  ENDOKOEFF(R,PRDK,'KAPM') * Simdata(R,B,'OMFG',PRDKPRDK)) =
                    ENDOKOEFF(R,PRDK,'KAPM') * Simdata(R,B,'OMFG',PRDK)
  /  SUM(PRDKPRDK,  ENDOKOEFF(R,PRDKPRDK,'KAPM') * Simdata(R,B,'OMFG',PRDKPRDK));


execute_unload 'Tilbudsmodul\Simdata.gdx', Simdata SimdataCheck;
abort 'Precalibration run successfull. Run second step calibration run.';
$endIf.PreCalib

*$offtext
*

$ifThenI.pmp %PMP%==YES
* Test of PMP
PMPTest(R,B,'Profitt','','Mod_Bruk')  = SIMDATA(R,B,'VERD','PROF') ;

PMPTest(R,B,'ProfPerDaa','','Mod_Bruk')  $ SUM(PLANTE$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE)) = SIMDATA(R,B,'VERD','PROF') / SUM(PLANTE$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE));
PMPTest(R,B,'ProfPerTime','','Mod_Bruk') $ SIMDATA(R,B,'MNGD','ARBF')= SIMDATA(R,B,'VERD','PROF') / SIMDATA(R,B,'MNGD','ARBF');
   
PMPTest(R,B,VARE,'Bidrag','Mod_Bruk') = SIMDATA(R,B,'VERD',VARE);
   
PMPTest(R,B,'VederlagPerDaa','','Mod_Bruk') $ SUM(PLANTE$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE)) =
(SIMDATA(R,B,'VERD','PROF')+SIMDATA(R,B,'VERD','ARBF')+SIMDATA(R,B,'VERD','KAPB')+SIMDATA(R,B,'VERD','KAPM')+SIMDATA(R,B,'VERD','KAPJ')) / SUM(PLANTE$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE));
*  
PMPTest(R,B,'VederlagPerTime','','Mod_Bruk') $ SIMDATA(R,B,'MNGD','ARBF')=
(SIMDATA(R,B,'VERD','PROF')+SIMDATA(R,B,'VERD','ARBF')+SIMDATA(R,B,'VERD','KAPB')+SIMDATA(R,B,'VERD','KAPM')+SIMDATA(R,B,'VERD','KAPJ')) / SIMDATA(R,B,'MNGD','ARBF');

PMPTest(R,B,'ArbeidPerAktivitet','','Mod_Bruk') $ SUM(PRDK $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) =
SIMDATA(R,B,'MNGD','ARBF') /  SUM(PRDK $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) ;

PMPTest(R,'BKRN','','ANTL','Mod_Bruk') $ SUM(KornOljePrdk, SIMDATA(R,'BKRN','OMFG',KornOljePrdk)) = Sum(KornOljePrdk, DATA(R,KornOljePrdk,'OMFG','BAS')) / SUM(KornOljePrdk, SIMDATA(R,'BKRN','OMFG',KornOljePrdk)) ;
PMPTest(R,'BPTE','','ANTL','Mod_Bruk') $ SIMDATA(R,'BPTE','OMFG','POTE') = DATA(R,'POTE','OMFG','BAS') / SIMDATA(R,'BPTE','OMFG','POTE') ;
PMPTest(R,'BHGE','','ANTL','Mod_Bruk') $ SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS)) = Sum(GRNS, DATA(R,GRNS,'OMFG','BAS')) / SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS)) ;
PMPTest(R,'BFRK','','ANTL','Mod_Bruk') $ SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA)) = Sum(FRBA, DATA(R,FRBA,'OMFG','BAS')) / SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA)) ;
PMPTest(R,'BKMK','','ANTL','Mod_Bruk') $ SIMDATA(R,'BKMK','OMFG','MKYR') = DATA(R,'MKYR','OMFG','BAS') / SIMDATA(R,'BKMK','OMFG','MKYR') ;
PMPTest(R,'BAKY','','ANTL','Mod_Bruk') $ SIMDATA(R,'BAKY','OMFG','AKYR') = DATA(R,'AKYR','OMFG','BAS') / SIMDATA(R,'BAKY','OMFG','AKYR') ;
PMPTest(R,'BGMK','','ANTL','Mod_Bruk') $ SIMDATA(R,'BGMK','OMFG','GEIT') = DATA(R,'GEIT','OMFG','BAS') / SIMDATA(R,'BGMK','OMFG','GEIT') ;
PMPTest(R,'BSAU','','ANTL','Mod_Bruk') $ SIMDATA(R,'BSAU','OMFG','SOEY') = DATA(R,'SOEY','OMFG','BAS') / SIMDATA(R,'BSAU','OMFG','SOEY') ;
PMPTest(R,'BGRI','','ANTL','Mod_Bruk') $ SIMDATA(R,'BGRI','OMFG','PURK') = DATA(R,'PURK','OMFG','BAS') / SIMDATA(R,'BGRI','OMFG','PURK') ;
PMPTest(R,'BHOE','','ANTL','Mod_Bruk') $ SIMDATA(R,'BHOE','OMFG','HOEN') = DATA(R,'HOEN','OMFG','BAS') / SIMDATA(R,'BHOE','OMFG','HOEN') ;
PMPTest(R,'BKYL','','ANTL','Mod_Bruk') $ SIMDATA(R,'BKYL','OMFG','KYLS') = DATA(R,'KYLS','OMFG','BAS') / SIMDATA(R,'BKYL','OMFG','KYLS') ;
*
* Intensity
PmpTest('Norge',B,'',DGVARE,'Obs') = RefBrukKoeff(DGVARE,B);
PmpTest('Norge',B,'','EBRN','Obs') = RefBrukKoeff('EBRN',B);
PmpTest('Norge',B,'','EKRF','Obs') = RefBrukKoeff('EKRF',B);
*   
PmpTest('Norge',B,'',DGVARE,'Mod_Bruk') $ SUM((R,PRDK) $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) = 1000 * SUM(R, SIMDATA(R,B,'VERD',DGVARE)  ) / SUM((R,PRDK) $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));
PmpTest('Norge',B,'','EBRN','Mod_Bruk') $ SUM((R,PRDK) $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) = 1000 * SUM(R, SIMDATA(R,B,'VERD','EBRN')  ) / SUM((R,PRDK) $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));
PmpTest('Norge',B,'','EKRF','Mod_Bruk') $ SUM((R,PRDK) $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) = 1000 * SUM(R, SIMDATA(R,B,'VERD','EKRF')  ) / SUM((R,PRDK) $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));
PmpTest('Norge',B,'','ARBT','Mod_Bruk') $ SUM((R,PRDK) $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) = 1000 * SUM(R, SIMDATA(R,B,'MNGD','ARBF'))   / SUM((R,PRDK) $ B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));
PmpTest('Norge',B,'','ARBP','Mod_Bruk') $ SUM(R, SIMDATA(R,B,'MNGD','ARBF'))                           = SUM(R, SIMDATA(R,B,'VERD','ARBF'))   / SUM(R,                             SIMDATA(R,B,'MNGD','ARBF'));
*
PmpTest('Norge',B,'','KAPB','Mod_Bruk') = PmpTest('Norge',B,'','KAPB','Mod_Bruk') / RENTE ;
PmpTest('Norge',B,'','KAPM','Mod_Bruk') = PmpTest('Norge',B,'','KAPM','Mod_Bruk') / RENTE ;
               
PmpTest('Norge',B,'',DGVARE,'CorrFac') $ PmpTest('Norge',B,'',DGVARE,'Mod_Bruk') = PmpTest('Norge',B,'',DGVARE,'Obs') / PmpTest('Norge',B,'',DGVARE,'Mod_Bruk') ;
PmpTest('Norge',B,'','EBRN','CorrFac') $ PmpTest('Norge',B,'','EBRN','Mod_Bruk') = PmpTest('Norge',B,'','EBRN','Obs') / PmpTest('Norge',B,'','EBRN','Mod_Bruk') ;
PmpTest('Norge',B,'','EKRF','CorrFac') $ PmpTest('Norge',B,'','EKRF','Mod_Bruk') = PmpTest('Norge',B,'','EKRF','Obs') / PmpTest('Norge',B,'','EKRF','Mod_Bruk') ;
PmpTest('Norge',B,'','ARBT','CorrFac') $ PmpTest('Norge',B,'','ARBT','Mod_Bruk') = PmpTest('Norge',B,'','ARBT','Obs') / PmpTest('Norge',B,'','ARBT','Mod_Bruk') ;
PmpTest('Norge',B,'','ARBP','CorrFac') $ PmpTest('Norge',B,'','ARBP','Mod_Bruk') = PmpTest('Norge',B,'','ARBP','Obs') / PmpTest('Norge',B,'','ARBP','Mod_Bruk') ;
*
* Omfg
PmpTest(R,'',PRDK,'OMFG','Mod_Bruk') = SUM(B, SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PmpTest(R,'',PRDK,'OMFG','Obs')      = DATA(R,PRDK,'OMFG','BAS');
PmpTest(R,'','AREAL','OMFG','Mod_Bruk') = SUM(PLANTE$(NOT SAMEAS('GFUB',PLANTE)), PmpTest(R,'',PLANTE,'OMFG','Mod_Bruk'));
PmpTest(R,'','AREAL','OMFG','Obs')      = SUM(PLANTE$(NOT SAMEAS('GFUB',PLANTE)), PmpTest(R,'',PLANTE,'OMFG','Obs')     );
PmpTest(R,'','KORN','OMFG','Mod_Bruk') = SUM(KornOljePrdk, PmpTest(R,'',KornOljePrdk,'OMFG','Mod_Bruk'));
PmpTest(R,'','KORN','OMFG','Obs')      = SUM(KornOljePrdk, PmpTest(R,'',KornOljePrdk,'OMFG','Obs')     );
PmpTest(R,'','GROV','OMFG','Mod_Bruk') = SUM(Grov, PmpTest(R,'',Grov,'OMFG','Mod_Bruk'));
PmpTest(R,'','GROV','OMFG','Obs')      = SUM(Grov, PmpTest(R,'',Grov,'OMFG','Obs')     );
*
PmpTest('Norge','',PRDK,'OMFG','Mod_Bruk')    = Sum(R, PmpTest(R,'',PRDK,'OMFG','Mod_Bruk'));
PmpTest('Norge','',PRDK,'OMFG','Obs')         = Sum(R, PmpTest(R,'',PRDK,'OMFG','Obs'));
PmpTest('NORGE','','AREAL','OMFG','Mod_Bruk') = SUM(R, PmpTest(R,'','AREAL','OMFG','Mod_Bruk'));
PmpTest('NORGE','','AREAL','OMFG','Obs')      = SUM(R, PmpTest(R,'','AREAL','OMFG','Obs')     );
PmpTest('NORGE','','KORN','OMFG','Mod_Bruk')  = SUM(R, PmpTest(R,'','KORN','OMFG','Mod_Bruk') );
PmpTest('NORGE','','KORN','OMFG','Obs')       = SUM(R, PmpTest(R,'','KORN','OMFG','Obs')      );
PmpTest('NORGE','','GROV','OMFG','Mod_Bruk')  = SUM(R, PmpTest(R,'','GROV','OMFG','Mod_Bruk') );
PmpTest('NORGE','','GROV','OMFG','Obs')       = SUM(R, PmpTest(R,'','GROV','OMFG','Obs')      );
*
* Mngd
PmpTest(R,'',VARE,'MNGD','Mod_Bruk') = SUM(B, SIMDATA(R,B,'MNGD',VARE) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PmpTest(R,'',VARE,'MNGD','Obs')      = DATA(R,VARE,'MNGD','BAS');
PmpTest('Norge','',VARE,'MNGD','Mod_Bruk') = Sum(R, PmpTest(R,'',VARE,'MNGD','Mod_Bruk'));
PmpTest('Norge','',VARE,'MNGD','Obs')      = Sum(R, PmpTest(R,'',VARE,'MNGD','Obs'));
*
*Verd
PmpTest(R,'',VARE,'VERD','Mod_Bruk') = SUM(B, SIMDATA(R,B,'VERD',VARE) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PmpTest(R,'',VARE,'VERD','Obs')      = DATA(R,VARE,'VERD','BAS');
PmpTest('Norge','',VARE,'VERD','Mod_Bruk') = Sum(R, PmpTest(R,'',VARE,'VERD','Mod_Bruk'));
PmpTest('Norge','',VARE,'VERD','Obs')      = Sum(R, PmpTest(R,'',VARE,'VERD','Obs'));

PMPTest(R,B,'Bidrag',VARE,'Mod_Bruk') = SIMDATA(R,B,'VERD',VARE);

PMPTest(R,B,'BidragPerEnh',VARE,'Mod_Bruk') $ SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) =
SIMDATA(R,B,'VERD',VARE) / SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));

PMPTest(R,B,'BidragPerEnh',PRODUKT,'Mod_Bruk') $ (SUM(PRDK$PRDK_TIL_VARE(PRDK,PRODUKT), SIMDATA(R,B,'OMFG',PRDK)) GT .001) =
SIMDATA(R,B,'VERD',PRODUKT) / SUM(PRDK$PRDK_TIL_VARE(PRDK,PRODUKT), SIMDATA(R,B,'OMFG',PRDK));

PMPTest(R,B,'BidragPerEnh','ARBF','Mod_Bruk') $ SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) =
SIMDATA(R,B,'MNGD','ARBF') * TimerPerAarsverk / SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));
PMPTest(R,B,'BidragPerEnh','ARBP','Mod_Bruk') $ SIMDATA(R,B,'MNGD','ARBF') = SIMDATA(R,B,'VERD','ARBF') / SIMDATA(R,B,'MNGD','ARBF');
PMPTest(R,B,'BidragPerEnh','TIL','Mod_Bruk') $ SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) =
SUM(TILSKUDD, SIMDATA(R,B,'VERD',TILSKUDD)) / SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));
PMPTest(R,B,'BidragPerEnh','PROF','Mod_Bruk') $ SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) =
SIMDATA(R,B,'VERD','PROF') / SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));

PMPTest(R,B,'InntektPerEnh','','Mod_Bruk') $ SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) =
SUM(PRODUKT, SIMDATA(R,B,'VERD',PRODUKT)) / SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));

PMPTest(R,B,'KostnadPerEnh','','Mod_Bruk') $ SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) =
(SUM(INNSATS, SIMDATA(R,B,'VERD',INNSATS))-SUM(INNSVL, SIMDATA(R,B,'VERD',INNSVL))) / SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));

PMPTest(R,B,'TilskuddPerEnh','','Mod_Bruk') $ SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) =
SUM(TILSKUDD, SIMDATA(R,B,'VERD',TILSKUDD)) / SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));

*
** Fodder intake
PMPTest(R,B,'FGRV_Feed',PRDK,'Mod_Bruk')  = SIMDATA(R,B,'FGRV',PRDK) ;
PMPTest(R,B,'FDRM_Feed',PRDK,'Mod_Bruk')  = SIMDATA(R,B,'FDRM',PRDK) ;
PMPTest(R,B,'FDRA_Feed',PRDK,'Mod_Bruk')  = SIMDATA(R,B,'FDRA',PRDK) ;
PMPTest(R,B,'FSVN_Feed',PRDK,'Mod_Bruk')  = SIMDATA(R,B,'FSVN',PRDK) ;
PMPTest(R,B,'FKYL_Feed',PRDK,'Mod_Bruk')  = SIMDATA(R,B,'FKYL',PRDK) ;
PMPTest(R,B,'FEGG_Feed',PRDK,'Mod_Bruk')  = SIMDATA(R,B,'FEGG',PRDK) ;
*
PMPTest('Norge','','FGRV_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FGRV',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FDRM_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FDRM',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FDRA_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FDRA',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FSVN_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FSVN',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FKYL_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FKYL',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FEGG_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FEGG',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));

PMPTest(R,'BKMK','FDRM','KMLK','Mod_Bruk') $ SIMDATA(R,'BKMK','KMLK','MKYR') = SIMDATA(R,'BKMK','FDRM','MKYR') / SIMDATA(R,'BKMK','KMLK','MKYR');
PMPTest(R,'BKMK','FGRV','KMLK','Mod_Bruk') $ SIMDATA(R,'BKMK','KMLK','MKYR') = SIMDATA(R,'BKMK','FGRV','MKYR') / SIMDATA(R,'BKMK','KMLK','MKYR');
PMPTest(R,'BKMK','KMLK','KMLK','Mod_Bruk') = SIMDATA(R,'BKMK','KMLK','MKYR');
PMPTest(R,'BKMK','FDRM','MKYR','Mod_Bruk') = SIMDATA(R,'BKMK','FDRM','MKYR') ;
PMPTest(R,'BKMK','FGRV','MKYR','Mod_Bruk') = SIMDATA(R,'BKMK','FGRV','MKYR') ;
*
* Labour
PmpTest(R,B,'ARBP','PRIS','Mod_Bruk') $ SIMDATA(R,B,'MNGD','ARBF')= SIMDATA(R,B,'VERD','ARBF') / (SIMDATA(R,B,'MNGD','ARBF') * 1.845);
PmpTest(R,B,'ARBP','MNGD','Mod_Bruk') = (SIMDATA(R,B,'MNGD','ARBF') * 1.845);
PmpTest(R,B,'ARBP','VERD','Mod_Bruk') = SIMDATA(R,B,'VERD','ARBF');


execute_unload 'pmptest.gdx', pmptest, simdata

*abort '';

$endIf.pmp

$iftheni.calib %PMP%==NO
PMPTest(R,'BKRN','','ANTL','Mod_Bruk') $ SUM(KornOljePrdk, SIMDATA(R,'BKRN','OMFG',KornOljePrdk)) = Sum(KornOljePrdk, DATA(R,KornOljePrdk,'OMFG','BAS')) / SUM(KornOljePrdk, SIMDATA(R,'BKRN','OMFG',KornOljePrdk)) ;
PMPTest(R,'BPTE','','ANTL','Mod_Bruk') $ SIMDATA(R,'BPTE','OMFG','POTE') = DATA(R,'POTE','OMFG','BAS') / SIMDATA(R,'BPTE','OMFG','POTE') ;
PMPTest(R,'BHGE','','ANTL','Mod_Bruk') $ SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS)) = Sum(GRNS, DATA(R,GRNS,'OMFG','BAS')) / SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS)) ;
PMPTest(R,'BFRK','','ANTL','Mod_Bruk') $ SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA)) = Sum(FRBA, DATA(R,FRBA,'OMFG','BAS')) / SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA)) ;
PMPTest(R,'BKMK','','ANTL','Mod_Bruk') $ SIMDATA(R,'BKMK','OMFG','MKYR') = DATA(R,'MKYR','OMFG','BAS') / SIMDATA(R,'BKMK','OMFG','MKYR') ;
PMPTest(R,'BAKY','','ANTL','Mod_Bruk') $ SIMDATA(R,'BAKY','OMFG','AKYR') = DATA(R,'AKYR','OMFG','BAS') / SIMDATA(R,'BAKY','OMFG','AKYR') ;
PMPTest(R,'BGMK','','ANTL','Mod_Bruk') $ SIMDATA(R,'BGMK','OMFG','GEIT') = DATA(R,'GEIT','OMFG','BAS') / SIMDATA(R,'BGMK','OMFG','GEIT') ;
PMPTest(R,'BSAU','','ANTL','Mod_Bruk') $ SIMDATA(R,'BSAU','OMFG','SOEY') = DATA(R,'SOEY','OMFG','BAS') / SIMDATA(R,'BSAU','OMFG','SOEY') ;
PMPTest(R,'BGRI','','ANTL','Mod_Bruk') $ SIMDATA(R,'BGRI','OMFG','PURK') = DATA(R,'PURK','OMFG','BAS') / SIMDATA(R,'BGRI','OMFG','PURK') ;
PMPTest(R,'BHOE','','ANTL','Mod_Bruk') $ SIMDATA(R,'BHOE','OMFG','HOEN') = DATA(R,'HOEN','OMFG','BAS') / SIMDATA(R,'BHOE','OMFG','HOEN') ;
PMPTest(R,'BKYL','','ANTL','Mod_Bruk') $ SIMDATA(R,'BKYL','OMFG','KYLS') = DATA(R,'KYLS','OMFG','BAS') / SIMDATA(R,'BKYL','OMFG','KYLS') ;

PMPTest('Norge','','FGRV_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FGRV',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FDRM_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FDRM',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FDRA_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FDRA',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FSVN_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FSVN',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FKYL_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FKYL',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
PMPTest('Norge','','FEGG_Feed',PRDK,'Mod_Bruk') $ (SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) > 1) = SUM((R,B), SIMDATA(R,B,'FEGG',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk')) / SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * PMPTEST(R,B,'','ANTL','Mod_Bruk'));
$endif.calib

execute_unload 'itest.gdx', itest, KORNOMFANGMAX, FRBAOMFANGMAX, GRNSOMFANGMAX, KORNOMFANGMIN, FRBAOMFANGMIN, GRNSOMFANGMIN, GROVAND, KORNAND, GRNSAND, FRBAAND, KALVAND, simdata;


*abort '';

****************************
*** Optimering av slakterier
****************************
* Sette startverdier og grenser
gs.lo(M) = MAX[0.001, POL(M,'SSLK','gs_MIN')];
gs.up(M) = POL(M,'SSLK','gs_MAKS');
*
zs_.lo(M,SSLK) = MAX[0.001, POL(M,SSLK,'zs_MIN')];
*
zs.lo(M) = MAX[0.001, POL(M,'SSLK','zs_MIN')];
zs.up(M) = POL(M,'SSLK','zs_MIN') * 100;
*
zk_.lo(M,FSLKVARE) = MAX[0.001, POL(M,FSLKVARE,'zk_MIN')];
*
zk.lo(M) = MAX[0.001, SUM(FSLKVARE, SIMDATA(M,FSLKVARE,'MNGD','Y')) * 0.8];
zk.l(M)  =            SUM(FSLKVARE, SIMDATA(M,FSLKVARE,'MNGD','Y'));

turantall.l(M) = KJRAAVARE(M) * 1000000 / PROD_SLK(M) / BESOEK;
turantall.up(M) = turantall.l(M) * 1000;
*
* Kutte ut krav til foredlede varer fra slakteprossen SSLK som produseres  med faste koeffisienter
SIMDATA(M,VARE,'MNGD','Y')$(SLTVARE(VARE) AND SSLKVARE(VARE)) = 0;
*
* Sette tilgang på slakt
*
* Kreve slakttilgang minst like stor som slakteriminimum pluss sikkerhetsmargin
SIMDATA(M,'STFK','MNGD','Y') = MAX[SIMDATA(M,'STFK','MNGD','Y'), zs_.lo(M,'SLST') * gs.lo(M) * 1.1];
SIMDATA(M,'SAUK','MNGD','Y') = MAX[SIMDATA(M,'SAUK','MNGD','Y'), zs_.lo(M,'SLSA') * gs.lo(M) * 1.1];
SIMDATA(M,'SVNK','MNGD','Y') = MAX[SIMDATA(M,'SVNK','MNGD','Y'), zs_.lo(M,'SLSV') * gs.lo(M) * 1.1];

*
* Oppdatere effektiv landareal
AREAL(M) = AREALKNST(M) + AREALPROD(M) * PROD_SLK(M);
*

option solprint = on;

option limrow = 999;
option limcol = 999;

solve slakterimodell minimizing objslk using NLP;

SLKINFES(STEP) = slakterimodell.numinfes;
*$ontext
* Etterberegning av foredlingskostnader til bruk i markedsmodellen
* Angitt i kr pr kg pr prosess
* Slakting og skjaering anlegg
* Beregn ukorrigert landsgjennomsnitt
SIMDATA('NORGE',SSLK,'APRS','Y') =
(SUM(M, (CFAS + CFBS/zs.l(M)) * zs.l(M) * gs.l(M)) / SUM(M, zs.l(M) * gs.l(M)))
 *  (SLKDATA('LONN',SSLK) + SLKDATA('ANNT',SSLK)) / FKOSTSSLKBAS ;
* Beregn korrigeringsfaktor
FKOSTSSLK(M) =
(CFAS + CFBS/zs.l(M)) * zs.l(M) * gs.l(M) /
SUM(SSLK, SIMDATA('NORGE',SSLK,'APRS','Y') * zs_.l(M,SSLK) * gs.l(M));
* Beregn korrigert regionsspesifikk prosesskostnad
SIMDATA(M,SSLK,'APRS','Y') = SLKDATA('AVAR',SSLK) + SIMDATA('NORGE',SSLK,'APRS','Y') * FKOSTSSLK(M);
*
*
* Slakting og skjaering inntransport
SIMDATA(M,SSLK,'IPRS','Y') = ctslk.l(M) / (zs.l(M) * gs.l(M));
*
* Inntransport og anlegg
SIMDATA(M,SSLK,'PRIS','Y') = SIMDATA(M,SSLK,'APRS','Y') + SIMDATA(M,SSLK,'IPRS','Y');
SIMDATA('NORGE',SSLK,'PRIS','Y') = SUM(M, SIMDATA(M,SSLK,'PRIS','Y') * zs.l(M) * gs.l(M)) / SUM(M, zs.l(M) * gs.l(M));
*
* Foredling av PRIN
* Beregn ukorrigert landsgjennomsnitt
SIMDATA('NORGE',FSLK,'PRIS','Y') =
(SUM(M, (CFAK + CFBK/zk.l(M)) * zk.l(M) + transsslk.l(M)) / SUM(M, zk.l(M)))
 *  (SLKDATA('LONN',FSLK) + SLKDATA('ANNT',FSLK)) / FKOSTFSLKBAS ;
* Beregn korrigeringsfaktor
FKOSTFSLK(M) =
(CFAK + CFBK/zk.l(M)) * zk.l(M) /
SUM((FSLK,FSLKVARE)$FP_TIL_SLTVARE(FSLKVARE,FSLK), SIMDATA('NORGE',FSLK,'PRIS','Y') * zk_.l(M,FSLKVARE));
* Beregn korrigert regionsspesifikk prosesskostnad
SIMDATA(M,FSLK,'PRIS','Y') = SLKDATA('AVAR',FSLK) + SIMDATA('NORGE',FSLK,'PRIS','Y') * FKOSTFSLK(M);
*
* Ikke tillatt mer enn foredlingskostnad i referansebanen
SIMDATA('NORD','SLST','PRIS','Y') = MIN(SIMDATA('NORD','SLST','PRIS','Y'), 31.5691  );
SIMDATA('NORD','SLSA','PRIS','Y') = MIN(SIMDATA('NORD','SLSA','PRIS','Y'), 52.6687  );
SIMDATA('NORD','SLSV','PRIS','Y') = MIN(SIMDATA('NORD','SLSV','PRIS','Y'), 30.2524  );
SIMDATA('MIDT','SLST','PRIS','Y') = MIN(SIMDATA('MIDT','SLST','PRIS','Y'), 17.898   );
SIMDATA('MIDT','SLSA','PRIS','Y') = MIN(SIMDATA('MIDT','SLSA','PRIS','Y'), 21.13    );
SIMDATA('MIDT','SLSV','PRIS','Y') = MIN(SIMDATA('MIDT','SLSV','PRIS','Y'), 21.909   );
SIMDATA('VEST','SLST','PRIS','Y') = MIN(SIMDATA('VEST','SLST','PRIS','Y'), 23.6844  );
SIMDATA('VEST','SLSA','PRIS','Y') = MIN(SIMDATA('VEST','SLSA','PRIS','Y'), 33.294   );
SIMDATA('VEST','SLSV','PRIS','Y') = MIN(SIMDATA('VEST','SLSV','PRIS','Y'), 23.9614  );
SIMDATA('SOER','SLST','PRIS','Y') = MIN(SIMDATA('SOER','SLST','PRIS','Y'), 14.13    );
SIMDATA('SOER','SLSA','PRIS','Y') = MIN(SIMDATA('SOER','SLSA','PRIS','Y'), 16.574   );
SIMDATA('SOER','SLSV','PRIS','Y') = MIN(SIMDATA('SOER','SLSV','PRIS','Y'), 15.934   );
SIMDATA('OEST','SLST','PRIS','Y') = MIN(SIMDATA('OEST','SLST','PRIS','Y'), 17.781   );
SIMDATA('OEST','SLSA','PRIS','Y') = MIN(SIMDATA('OEST','SLSA','PRIS','Y'), 20.126   );
SIMDATA('OEST','SLSV','PRIS','Y') = MIN(SIMDATA('OEST','SLSV','PRIS','Y'), 18.897   );
*
* Gjenta beregningen for hele Norge
SIMDATA('NORGE',SSLK,'PRIS','Y') = SUM(M, SIMDATA(M,SSLK,'PRIS','Y') * zs.l(M) * gs.l(M)) / SUM(M, zs.l(M) * gs.l(M));
*
* Konvergensindikator slakterier
KONVERGENS(M,FSLK,'PRIS',STEP) = SIMDATA(M,FSLK,'PRIS','Y');
KONVERGENS(M,SSLK,'PRIS',STEP) = SIMDATA(M,SSLK,'PRIS','Y');
KONVERGENS(M,'gs','MNGD',STEP) = gs.l(M);
KONVERGENS(M,'zs_',SSLK,STEP) = zs_.l(M,SSLK);
KONVERGENS(M,'zs','MNGD',STEP) = zs.l(M);
KONVERGENS(M,'zk_',FSLKVARE,STEP) = zk_.l(M,FSLKVARE);
KONVERGENS(M,'zk','MNGD',STEP) = zk.l(M);
KONVERGENS(M,'turantall','MNGD',STEP) = turantall.l(M);
KONVERGENS(M,'turlengde','MNGD',STEP) = turlengde.l(M);
KONVERGENS(M,'stopp','MNGD',STEP) = stopp.l(M);
KONVERGENS(M,'produsent','SLK',STEP) = PROD_SLK(M);
KONVERGENS(M,SLKINNVARE,'MNGD',STEP) = SIMDATA(M,SLKINNVARE,'MNGD','Y');

*
* Foredlingskostnader kylling
SIMDATA(M,KSLK,'PRIS','Y') = KYLDATA('LONN',KSLK) + KYLDATA('ANNT',KSLK) + KYLDATA('AVAR',KSLK);
*
**************************
*** Optimering av meierier
**************************
* Lese inn data fra markedsmodulen fra forrige iterasjon
zpmei.up(M,MEIINNVARE) = MAX[1, SIMDATA(M,MEIINNVARE,'MNGD','Y')];
zpmei.lo(M,MEIINNVARE) = 1;
zpmei.l(M,MEIINNVARE)  = SIMDATA(M,MEIINNVARE,'MNGD','Y');
xmei.l(MEIDVARE,M) = SIMDATA(M,MEIDVARE,'MNGD','Y');
xpmei.l(MEIDVARE,M) = SIMDATA(M,MEIDVARE,'MNGD','Y');
xemei.l(MEIXVARE,M) = SIMDATA(M,MEIXVARE,'MNGD','Y');
pmei.l(MEIDVARE,M) = SIMDATA(M,MEIDVARE,'PRIS','Y');
*
* Restriksjoner transport
uttrmei.fx(VARE,M,M) = 0;
inntrmei.fx(VARE,M,M) = 0;
*
* Ingen innenlands konsum av eksportost
xmei.fx(MEIXVARE,M) = 0;
*
* Mengde subsidiert eksport
prodtotmei.up(MEIXVARE) = POL('NORGE',MEIXVARE,'KVTEXPT');
*
* Ingen konsum av raavare
xmei.up('KMLK',M) = 0;
xmei.up('GMLK',M) = 0;
pmei.up('KMLK',M) = 0;
pmei.up('GMLK',M) = 0;
*
*  Restriksjoner struktur og lokalisering
qmei.lo(M) = POL(M,'MEIR','MIN');
qmei.up(M) = qmei.lo(M) * 100;
*
option solprint = off;

SOLVE MEIERIMODELL USING NLP MAXIMIZING OBJMEI;

MEIINFES(STEP) = meierimodell.numinfes;
*$ontext
* Etterberegning av foredlingskostnader inkl offentlige avgifter til bruk i markedsmodellen
* Angitt i kr pr prosess
SIMDATA(M,MEIR,'PRIS','Y') =
* Foredlingskostnader
  + AFmei(MEIR) * SUM(VARE$(SAMEAS('KMLK',VARE) OR SAMEAS('GMLK',VARE)), MEIDATA(VARE,MEIR))
  + BFmei * qmei.l(M) * SUM(VARE$(SAMEAS('KMLK',VARE) OR SAMEAS('GMLK',VARE)), MEIDATA(VARE,MEIR))  / SUM(VARE, zpmei.l(M,VARE))
* Inntransportkostnader
  + ctmei.l(M) * SUM(VARE$(SAMEAS('KMLK',VARE) OR SAMEAS('GMLK',VARE)), MEIDATA(VARE,MEIR))  / SUM(VARE, zpmei.l(M,VARE)) ;
*
SIMDATA(M,MEIR,'IPRS','Y') = ctmei.l(M) * SUM(VARE$(SAMEAS('KMLK',VARE) OR SAMEAS('GMLK',VARE)), MEIDATA(VARE,MEIR))  / SUM(VARE, zpmei.l(M,VARE)) ;
SIMDATA(M,MEIR,'APRS','Y') = AFmei(MEIR) * SUM(VARE$(SAMEAS('KMLK',VARE) OR SAMEAS('GMLK',VARE)), MEIDATA(VARE,MEIR))
                           + BFmei * qmei.l(M) * SUM(VARE$(SAMEAS('KMLK',VARE) OR SAMEAS('GMLK',VARE)), MEIDATA(VARE,MEIR))  / SUM(VARE, zpmei.l(M,VARE)) ;
* Konvergensindikator meierier
KONVERGENS(M,MEIINNVARE,'MNGD',STEP) = zpmei.l(M,MEIINNVARE);
KONVERGENS(M,MEIDVARE,'KONS',STEP) = xmei.l(MEIDVARE,M);
KONVERGENS(M,MEIDVARE,'PROD',STEP) = xpmei.l(MEIDVARE,M);
KONVERGENS(M,MEIXVARE,'EXPT',STEP) = xemei.l(MEIXVARE,M);
KONVERGENS(M,MEIDVARE,'PRIS',STEP) = pmei.l(MEIDVARE,M);
KONVERGENS(M,'MEIR','ANTL',STEP) = qmei.l(M);
KONVERGENS(M,MEIR,'PRIS',STEP) = SIMDATA(M,MEIR,'PRIS','Y');
KONVERGENS(M,MEIR,'APRS',STEP) = SIMDATA(M,MEIR,'APRS','Y');
KONVERGENS(M,MEIR,'IPRS',STEP) = SIMDATA(M,MEIR,'IPRS','Y');
KONVERGENS(M,'produsent','MEI',STEP) = PROD_MEI(M);
*
************************************
*** Forberedelse for markedsmodellen
************************************
*
********************************
*** Optimering av markedsmodulen
********************************
* Startverdier fra tidligere iterasjoner
$ifThenI.pmp %PMP%==NO
x.l(VARE,C,M)      $  StartVerdierMarket('x',VARE,C,M)      =  StartVerdierMarket('x',VARE,C,M)  ;   
xi.l(VARE,M)       $  StartVerdierMarket('xi',VARE,'',M)    =  StartVerdierMarket('xi',VARE,'',M) ;  
xq.l(VARE,M)       $  StartVerdierMarket('xq',VARE,'',M)    =  StartVerdierMarket('xq',VARE,'',M) ;  
xqa.l(VARE,M)      $  StartVerdierMarket('xqa',VARE,'',M)   =  StartVerdierMarket('xqa',VARE,'',M) ; 
xqb.l(VARE,M)      $  StartVerdierMarket('xqb',VARE,'',M)   =  StartVerdierMarket('xqb',VARE,'',M) ; 
xqs.l(VARE,M)      $  StartVerdierMarket('xqs',VARE,'',M)   =  StartVerdierMarket('xqs',VARE,'',M) ; 
*xe.l(VARE,M)       $  StartVerdierMarket('xe',VARE,'',M)    =  StartVerdierMarket('xe',VARE,'',M) ;  
p.l(VARE,C,M)      $  StartVerdierMarket('p',VARE,C,M)      =  StartVerdierMarket('p',VARE,C,M)  ;   
g.l(B,R)           $  StartVerdierMarket('g',B,'',R)        =  StartVerdierMarket('g',B,'',R)    ;   
h.l(FP,M)          $  StartVerdierMarket('h',FP,'',M)       =  StartVerdierMarket('h',FP,'',M)   ;   
z.l(VARE,M)        $  StartVerdierMarket('z',VARE,'',M)     =  StartVerdierMarket('z',VARE,'',M) ;   
z.l(VARE,R)        $  StartVerdierMarket('z',VARE,'',R)     =  StartVerdierMarket('z',VARE,'',R) ;   
inntr.l(VARE,M,MM) $  StartVerdierMarket('inntr',VARE,M,MM) =  StartVerdierMarket('inntr',VARE,M,MM); 
uttr.l(VARE,M,MM)  $  StartVerdierMarket('uttr',VARE,M,MM)  =  StartVerdierMarket('uttr',VARE,M,MM) ;
$endif.pmp

* Konsum
* Code leaves market model infes (negative exponent)
x.lo(VARE,'CONS',M)$(SLTVARE(VARE) AND P0(VARE)) = X0(VARE,M) * .001;
x.up(VARE,'CONS',M)$(SLTVARE(VARE) AND P0(VARE)) = x.l(VARE,'CONS',M) * 100;
* Code leaves market model infes (negative exponent) x.up(VARE,'CONS',M)$(SLTVARE(VARE) AND P0(VARE)) = alfa(VARE,M) ;
x.fx(MEIXVARE,'CONS',M) = 0;
* Produksjon
x.up(VARE,'PRIM',M)$PRODUKT(VARE) = 1000;
x.up(TILSKUDD,'PRIM',M) = 10000;
x.up(INNSATS,'PRIM',M) = 10000;
x.lo(FFEMKORN,'PRIM',M) = EPS;
*
* Trade only to Oslo region
*
* Kutte ut eksport unntatt produkter fra gårdsbruk og sluttprodukter
xe.up(VARE,M) = 0;
xe.up(VARE,'OEST')$PRODUKT(VARE)  = POL('NORGE',VARE,'KVTEXPT');
xe.up(VARE,'OEST')$SLTVARE(VARE)  = POL('NORGE',VARE,'KVTEXPT');
xe.up(VARE,'OEST')$MOELVARE(VARE) = POL('NORGE',VARE,'KVTEXPT');
xe.up(VARE,'NORGE') = POL('NORGE',VARE,'KVTEXPT');
*
xi.up(VARE,M) = 0;
xi.up(VARE,'OEST') = +INF;
xi.up(VARE,'NORGE') = 10000;
xi.up(VARE,'NORGE') $ (NOT PI(VARE)) = 0;
*
xq.up(VARE,M) = 0;
xq.up(VARE,'OEST') = +INF;
xq.up(VARE,'NORGE') = 10000;
xq.up(VARE,'NORGE') $ (NOT PI(VARE)) = 0;
*
xqa.up(VARE,M) = 0;
xqa.up(VARE,'OEST') = +INF;
xqa.up(VARE,'NORGE') = 10000;
xqa.up(VARE,'NORGE') $ (NOT PI(VARE)) = 0;
*
xqb.up(VARE,M) = 0;
xqb.up(VARE,'OEST') = +INF;
xqb.up(VARE,'NORGE') = 10000;
xqb.up(VARE,'NORGE') $ (NOT PI(VARE)) = 0;
*
xqs.up(VARE,M) = 0;
xqs.up(VARE,'OEST') = +INF;
xqs.up(VARE,'NORGE') = 10000;
xqs.up(VARE,'NORGE') $ (NOT PI(VARE)) = 0;
*
* No imports of cheese with goat milk
xi.up('OSTM','NORGE') = 0;
xq.up('OSTM','NORGE') = 0;
xqa.up('OSTM','NORGE') = 0;
xqb.up('OSTM','NORGE') = 0;
xqs.up('OSTM','NORGE') = 0;
*
xi.up('OSTG','NORGE') = 0;
xq.up('OSTG','NORGE') = 0;
xqa.up('OSTG','NORGE') = 0;
xqb.up('OSTG','NORGE') = 0;
xqs.up('OSTG','NORGE') = 0;
*
* No trade with raw milk
xi.up(MEIINNVARE,'NORGE') = 0;
xq.up(MEIINNVARE,'NORGE') = 0;
xqa.up(MEIINNVARE,'NORGE') = 0;
xqb.up(MEIINNVARE,'NORGE') = 0;
xqs.up(MEIINNVARE,'NORGE') = 0;
xe.up(MEIINNVARE,'NORGE') = 0;
*
* No trade with roughage
xi.up(FFEMGRAS,'NORGE') = 0;
xq.up(FFEMGRAS,'NORGE') = 0;
xqa.up(FFEMGRAS,'NORGE') = 0;
xqb.up(FFEMGRAS,'NORGE') = 0;
xqs.up(FFEMGRAS,'NORGE') = 0;
xe.up(FFEMGRAS,'NORGE') = 0;
*
* Trade of feed only by administrative quotas
xi.up(MOELVARE,'NORGE') = 0;
xq.up(MOELVARE,'NORGE') = 0;
xqb.up(MOELVARE,'NORGE') = 0;
xqs.up(MOELVARE,'NORGE') = 0;
xe.up(MOELUTKVARE,'NORGE') = 0;
*
** Allow for calibration purposes
z.l(VARE,M) = 1;

*
* Enkeltbruk
g.up(B,R) = 1000;
*
* Priser
p.lo(VARE,'CONS',M)$SLTVARE(VARE) = PI(VARE);
* Special case of dietary recommendations
p.lo(VARE,'CONS',M)$(SLTVARE(VARE) $ (SUM(FoodGrp$FoodVARE(FoodGrp,VARE), POL('NORGE',FoodGrp,'MIN') > 0))) = 0;

p.up(VARE,'CONS',M)$( SLTVARE(VARE) AND BETA(VARE,VARE,M)) =
 ((ALFA(VARE,M) - SUM(VAREVARE$(NOT SAMEAS(VARE,VAREVARE)), P0(VAREVARE)*BETA(VARE,VAREVARE,M))) / BETA(VARE,VARE,M)) * 10;

* Ingen transport i egen region
inntr.up(VARE,M,MM) = 1000;
uttr.up(VARE,M,MM) = 1000;
uttr.fx(VARE,M,MM) $SAMEAS(M,MM) = 0;
inntr.fx(VARE,M,MM)$SAMEAS(M,MM) = 0;
*
*Ingen transport av grasprotein ut av region
inntr.up('FGRP',M,MM) = 0;
uttr.up('FGRP',M,MM) = 0;
xe.up('FGRP',M) = 0;
*
* Theoretical imports of gras proteins
xqs.up('FGRP','Norge') = 1000;
xqs.up('FGRP',M) = 1000;
POL('NORGE','FGRP','SENIMPT') = 1000;
*
* Sikre positive verdier i LOG10-funksjon
hnfikrnshr.lo(FULLDYRK) = 1E-5;
*
* Ecosystem services
landest.up(R) = 0;
biodiv.up(R) = 0;
culther.up(R) = 0;
recreat.up(R) = 0;
emis_n.l  = 1;

*
* Folkehelse
helse.l(KostGrp)  = (TMREL(KostGrp)                      * DALYPerG(KostGrp,'act') * VSL) $ (TMREL(KostGrp) > GBDDiet(KostGrp))
                  + ((RefDiet(KostGrp) - TMREL(KostGrp)) * DALYPerG(KostGrp,'act') * VSL) $ (TMREL(KostGrp) < GBDDiet(KostGrp));
helse.up(KostGrp) = (TMREL(KostGrp)                      * DALYPerG(KostGrp,'act') * VSL) $ (TMREL(KostGrp) > GBDDiet(KostGrp))
                  + ((RefDiet(KostGrp) - TMREL(KostGrp)) * DALYPerG(KostGrp,'act') * VSL) $ (TMREL(KostGrp) < GBDDiet(KostGrp));
*
* Reset land use change variables
LUCInn.l(R,CropTypeObj)  = 0;
LUCObs.l(R,CropTypeObj)  = 0;
LUCOut.l(R,CropTypeObj)  = 0;
*
LUCInn.up(R,CropTypeObj)  = 1E+5;
LUCObs.up(R,CropTypeObj)  = 1E+5;
LUCOut.up(R,CropTypeObj)  = 1E+5;
*

*abort xqa.l,xqa.up;

***********************************************************
* STEP 1: Calibrate pmp terms for farms in calibration mode including demand
***********************************************************
$ifThenI.pmp %pmp%==YES
option solprint = on;

*... fix consumer demand
x.fx(VARE,'CONS',M)$(SLTVARE(VARE) AND P0(VARE)) = X0(VARE,M);
x.lo(VARE,'CONS',M)$(SLTVARE(VARE) AND P0(VARE)) = X0(VARE,M) * .9;
x.up(VARE,'CONS',M)$(SLTVARE(VARE) AND P0(VARE)) = X0(VARE,M) * 1.1;
*
x.lo('OSTG','CONS',M) = X0('OSTG',M) * .5;
x.up('OSTG','CONS',M) = X0('OSTG',M) * 2;
*
* Fix number of farms
g.l('BKRN',R) $ SUM(KornOljePRDK, SIMDATA(R,'BKRN','OMFG',KornOljePRDK)) = SUM(KornOljePRDK, DATA(R,KornOljePRDK,'OMFG','BAS')) / SUM(KornOljePRDK, SIMDATA(R,'BKRN','OMFG',KornOljePRDK));
g.l('BPTE',R) $ SIMDATA(R,'BPTE','OMFG','POTE') = DATA(R,'POTE','OMFG','BAS') / SIMDATA(R,'BPTE','OMFG','POTE');
g.l('BHGE',R) $ SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS)) = SUM(GRNS, DATA(R,GRNS,'OMFG','BAS')) / SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS));
g.l('BFRK',R) $ SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA)) = SUM(FRBA, DATA(R,FRBA,'OMFG','BAS')) / SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA));
*
g.l('BKMK',R) $ SIMDATA(R,'BKMK','OMFG','MKYR') = DATA(R,'MKYR','OMFG','BAS') / SIMDATA(R,'BKMK','OMFG','MKYR');
g.l('BGMK',R) $ SIMDATA(R,'BGMK','OMFG','GEIT') = DATA(R,'GEIT','OMFG','BAS') / SIMDATA(R,'BGMK','OMFG','GEIT');
g.l('BAKY',R) $ SIMDATA(R,'BAKY','OMFG','AKYR') = DATA(R,'AKYR','OMFG','BAS') / SIMDATA(R,'BAKY','OMFG','AKYR');
g.l('BSAU',R) $ SIMDATA(R,'BSAU','OMFG','SOEY') = DATA(R,'SOEY','OMFG','BAS') / SIMDATA(R,'BSAU','OMFG','SOEY');
g.l('BGRI',R) $ SIMDATA(R,'BGRI','OMFG','PURK') = DATA(R,'PURK','OMFG','BAS') / SIMDATA(R,'BGRI','OMFG','PURK');
g.l('BHOE',R) $ SIMDATA(R,'BHOE','OMFG','HOEN') = DATA(R,'HOEN','OMFG','BAS') / SIMDATA(R,'BHOE','OMFG','HOEN');
g.l('BKYL',R) $ SIMDATA(R,'BKYL','OMFG','KYLS') = DATA(R,'KYLS','OMFG','BAS') / SIMDATA(R,'BKYL','OMFG','KYLS');
*
g.fx(B,R) = g.l(B,R) ;
*
*

CalibTestdata('0','g.l','',B,R) = g.l(B,R);
CalibTestdata('0','x.l',VARE,'PRIM','NORGE') = x.l(VARE,'PRIM','NORGE');
CalibTestdata('0','x.l',VARE,'PRIM',R) = x.l(VARE,'PRIM',R);

MarketBalance('0',Vare,M,'Inbal','LHS') = SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M)) + xi.l(VARE,M) + xq.l(VARE,M) + xqa.l(VARE,M) + xqb.l(VARE,M) + xqs.l(VARE,M) + SUM(MM, inntr.l(VARE,M,MM));
MarketBalance('0',Vare,M,'Inbal','RHS') = SUM(MOEL $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M)) + SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM(MM, uttr.l(VARE,M,MM));
MarketBalance('0',Vare,M,'Utbal','LHS') = SUM(MOEL$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M)) +  SUM(MOEL$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('0',Vare,M,'Utbal','RHS') = z.l(VARE,M) $ MOELUTKVARE(VARE) + x.l(VARE,'WHLS',M) $ SLTVARE(VARE) ;
MarketBalance('0',Vare,'Norge','Inbal','xDom') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M));
MarketBalance('0',Vare,'Norge','Inbal','xi') =   sum(M, xi.l(VARE,M));
MarketBalance('0',Vare,'Norge','Inbal','xi') =   sum(M, xq.l(VARE,M));
MarketBalance('0',Vare,'Norge','Inbal','xqa') =  sum(M, xqa.l(VARE,M));
MarketBalance('0',Vare,'Norge','Inbal','xqb') =  sum(M, xqb.l(VARE,M));
MarketBalance('0',Vare,'Norge','Inbal','xqs') =  sum(M, xqs.l(VARE,M));
MarketBalance('0',Vare,'Norge','Inbal','inntr') =  SUM((M,MM), inntr.l(VARE,M,MM));
MarketBalance('0',Vare,'Norge','Inbal','h') = SUM((M,MOEL) $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('0',Vare,'Norge','Inbal','uttr') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM((M,MM), uttr.l(VARE,M,MM));
MarketBalance('0',Vare,'Norge','Utbal','h_MoelUt') =   SUM((M,MOEL)$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('0',Vare,'Norge','Utbal','h_Slt')    =   SUM((M,MOEL)$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('0',Vare,'Norge','Utbal','z') =      sum(m, z.l(VARE,M) $ MOELUTKVARE(VARE)) ;
MarketBalance('0',Vare,'Norge','Utbal','x') =      sum(m, x.l(VARE,'WHLS',M) $ SLTVARE(VARE)) ;

display "Step1";
SOLVE MARKEDSMODELL USING NLP MAXIMIZING OBJ;

CalibTestdata('1','g.l','',B,R) = g.l(B,R);
CalibTestdata('1','x.l',VARE,'PRIM','NORGE') = x.l(VARE,'PRIM','NORGE');
CalibTestdata('1','x.l',VARE,'PRIM',R) = x.l(VARE,'PRIM',R);

MarketBalance('1',Vare,M,'Inbal','LHS') = SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M)) + xi.l(VARE,M) + xq.l(VARE,M) + xqa.l(VARE,M) + xqb.l(VARE,M) + xqs.l(VARE,M) + SUM(MM, inntr.l(VARE,M,MM));
MarketBalance('1',Vare,M,'Inbal','RHS') = SUM(MOEL $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M)) + SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM(MM, uttr.l(VARE,M,MM));
MarketBalance('1',Vare,M,'Utbal','LHS') = SUM(MOEL$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M)) +  SUM(MOEL$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('1',Vare,M,'Utbal','RHS') = z.l(VARE,M) $ MOELUTKVARE(VARE) + x.l(VARE,'WHLS',M) $ SLTVARE(VARE) ;
MarketBalance('1',Vare,'Norge','Inbal','xDom') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M));
MarketBalance('1',Vare,'Norge','Inbal','xi') =   sum(M, xi.l(VARE,M));
MarketBalance('1',Vare,'Norge','Inbal','xi') =   sum(M, xq.l(VARE,M));
MarketBalance('1',Vare,'Norge','Inbal','xqa') =  sum(M, xqa.l(VARE,M));
MarketBalance('1',Vare,'Norge','Inbal','xqb') =  sum(M, xqb.l(VARE,M));
MarketBalance('1',Vare,'Norge','Inbal','xqs') =  sum(M, xqs.l(VARE,M));
MarketBalance('1',Vare,'Norge','Inbal','inntr') =  SUM((M,MM), inntr.l(VARE,M,MM));
MarketBalance('1',Vare,'Norge','Inbal','h') = SUM((M,MOEL) $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('1',Vare,'Norge','Inbal','uttr') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM((M,MM), uttr.l(VARE,M,MM));
MarketBalance('1',Vare,'Norge','Utbal','h_MoelUt') =   SUM((M,MOEL)$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('1',Vare,'Norge','Utbal','h_Slt')    =   SUM((M,MOEL)$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('1',Vare,'Norge','Utbal','z') =      sum(m, z.l(VARE,M) $ MOELUTKVARE(VARE)) ;
MarketBalance('1',Vare,'Norge','Utbal','x') =      sum(m, x.l(VARE,'WHLS',M) $ SLTVARE(VARE)) ;

*
* Define PMP-parameters
PmpProdQuad(R,B) $ g.l(B,R) = g.m(B,R) / g.l(B,R);
PmpProdCnst(R,B) $ g.l(B,R) = 
                            0  $ (g.m(B,R) > 0)
            +  (2*(-g.m(B,R))) $ (g.m(B,R) < 0)
;


FarmsWithPmp(B,R) = No;
FarmsWithPmp(B,R) $ PmpProdQuad(R,B) = Yes;
FarmsWithPmp(B,R) $ PmpProdCnst(R,B) = Yes;

display '2', FarmsWithPmp;

MRKINFES(STEP) = markedsmodell.numinfes;
IF ((MRKINFES(STEP) > 0), abort "Infeasibilities i markedsmodellen"; );


***********************************************************
* STEP 2: Check calibration by removing bounds on farm numbers 
***********************************************************
*
*... remove bounds on number of farms
g.l('BKRN',R) $ SUM(KornOljePrdk, SIMDATA(R,'BKRN','OMFG',KornOljePrdk)) = Sum(KornOljePrdk, DATA(R,KornOljePrdk,'OMFG','BAS')) / SUM(KornOljePrdk, SIMDATA(R,'BKRN','OMFG',KornOljePrdk)) ;
g.l('BPTE',R) $ SIMDATA(R,'BPTE','OMFG','POTE') = DATA(R,'POTE','OMFG','BAS') / SIMDATA(R,'BPTE','OMFG','POTE') ;
g.l('BHGE',R) $ SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS)) = Sum(GRNS, DATA(R,GRNS,'OMFG','BAS')) / SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS)) ;
g.l('BFRK',R) $ SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA)) = Sum(FRBA, DATA(R,FRBA,'OMFG','BAS')) / SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA)) ;
g.l('BKMK',R) $ SIMDATA(R,'BKMK','OMFG','MKYR') = DATA(R,'MKYR','OMFG','BAS') / SIMDATA(R,'BKMK','OMFG','MKYR') ;
g.l('BAKY',R) $ SIMDATA(R,'BAKY','OMFG','AKYR') = DATA(R,'AKYR','OMFG','BAS') / SIMDATA(R,'BAKY','OMFG','AKYR') ;
g.l('BGMK',R) $ SIMDATA(R,'BGMK','OMFG','GEIT') = DATA(R,'GEIT','OMFG','BAS') / SIMDATA(R,'BGMK','OMFG','GEIT') ;
g.l('BSAU',R) $ SIMDATA(R,'BSAU','OMFG','SOEY') = DATA(R,'SOEY','OMFG','BAS') / SIMDATA(R,'BSAU','OMFG','SOEY') ;
g.l('BGRI',R) $ SIMDATA(R,'BGRI','OMFG','PURK') = DATA(R,'PURK','OMFG','BAS') / SIMDATA(R,'BGRI','OMFG','PURK') ;
g.l('BHOE',R) $ SIMDATA(R,'BHOE','OMFG','HOEN') = DATA(R,'HOEN','OMFG','BAS') / SIMDATA(R,'BHOE','OMFG','HOEN') ;
g.l('BKYL',R) $ SIMDATA(R,'BKYL','OMFG','KYLS') = DATA(R,'KYLS','OMFG','BAS') / SIMDATA(R,'BKYL','OMFG','KYLS') ;
g.lo(B,R) = 0;
g.up(B,R) = g.l(B,R) * 100;

*... check calibration with bounds on quota and area
display "Step2";
SOLVE MARKEDSMODELL USING NLP MAXIMIZING OBJ;

CalibTestdata('2','g.l','',B,R) = g.l(B,R);
CalibTestdata('2','x.l',VARE,'PRIM','NORGE') = x.l(VARE,'PRIM','NORGE');
CalibTestdata('2','x.l',VARE,'PRIM',R) = x.l(VARE,'PRIM',R);

MarketBalance('2',Vare,M,'Inbal','LHS') = SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M)) + xi.l(VARE,M) + xq.l(VARE,M) + xqa.l(VARE,M) + xqb.l(VARE,M) + xqs.l(VARE,M) + SUM(MM, inntr.l(VARE,M,MM));
MarketBalance('2',Vare,M,'Inbal','RHS') = SUM(MOEL $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M)) + SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM(MM, uttr.l(VARE,M,MM));
MarketBalance('2',Vare,M,'Utbal','LHS') = SUM(MOEL$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M)) +  SUM(MOEL$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('2',Vare,M,'Utbal','RHS') = z.l(VARE,M) $ MOELUTKVARE(VARE) + x.l(VARE,'WHLS',M) $ SLTVARE(VARE) ;
MarketBalance('2',Vare,'Norge','Inbal','xDom') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M));
MarketBalance('2',Vare,'Norge','Inbal','xi') =   sum(M, xi.l(VARE,M));
MarketBalance('2',Vare,'Norge','Inbal','xi') =   sum(M, xq.l(VARE,M));
MarketBalance('2',Vare,'Norge','Inbal','xqa') =  sum(M, xqa.l(VARE,M));
MarketBalance('2',Vare,'Norge','Inbal','xqb') =  sum(M, xqb.l(VARE,M));
MarketBalance('2',Vare,'Norge','Inbal','xqs') =  sum(M, xqs.l(VARE,M));
MarketBalance('2',Vare,'Norge','Inbal','inntr') =  SUM((M,MM), inntr.l(VARE,M,MM));
MarketBalance('2',Vare,'Norge','Inbal','h') = SUM((M,MOEL) $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('2',Vare,'Norge','Inbal','uttr') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM((M,MM), uttr.l(VARE,M,MM));
MarketBalance('2',Vare,'Norge','Utbal','h_MoelUt') =   SUM((M,MOEL)$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('2',Vare,'Norge','Utbal','h_Slt')    =   SUM((M,MOEL)$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('2',Vare,'Norge','Utbal','z') =      sum(m, z.l(VARE,M) $ MOELUTKVARE(VARE)) ;
MarketBalance('2',Vare,'Norge','Utbal','x') =      sum(m, x.l(VARE,'WHLS',M) $ SLTVARE(VARE)) ;

MRKINFES(STEP) = markedsmodell.numinfes;

IF ((MRKINFES(STEP) > 0), abort "Infeasibilities i markedsmodellen"; );
*$onText
***********************************************************
* STEP 3: Check calibration by removing bounds on quota and area
***********************************************************
*... check calibration with bounds on quota and area
* ... reintroduce bounds on available agricultural area
POL(R,'AREAL','TAK') = ArealTak(R,'AREAL');
POL(R,'FULLJ','TAK') = ArealTak(R,'FULLJ');
POL(R,'KORN','TAK')  = ArealTak(R,'KORN');
POL(R,'MATKN','TAK') = ArealTak(R,'MATKN') ;
POL(R,'GRAS','TAK') = ArealTak(R,'GRAS') ;
POL(R,'GFUB','TAK') = ArealTak(R,'GFUB') ;
**
** ... reintroduce quotas
POL(F,'KMLK','KVOTE') = KvoteTak(F,'KMLK');
POL(F,'GMLK','KVOTE') = KvoteTak(F,'GMLK');
*
display "Step3";
SOLVE MARKEDSMODELL USING NLP MAXIMIZING OBJ;

CalibTestdata('3','g.l','',B,R) = g.l(B,R);
CalibTestdata('3','x.l',VARE,'PRIM','NORGE') = x.l(VARE,'PRIM','NORGE');
CalibTestdata('3','x.l',VARE,'PRIM',R) = x.l(VARE,'PRIM',R);

MarketBalance('3',Vare,M,'Inbal','LHS') = SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M)) + xi.l(VARE,M) + xq.l(VARE,M) + xqa.l(VARE,M) + xqb.l(VARE,M) + xqs.l(VARE,M) + SUM(MM, inntr.l(VARE,M,MM));
MarketBalance('3',Vare,M,'Inbal','RHS') = SUM(MOEL $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M)) + SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM(MM, uttr.l(VARE,M,MM));
MarketBalance('3',Vare,M,'Utbal','LHS') = SUM(MOEL$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M)) +  SUM(MOEL$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('3',Vare,M,'Utbal','RHS') = z.l(VARE,M) $ MOELUTKVARE(VARE) + x.l(VARE,'WHLS',M) $ SLTVARE(VARE) ;
MarketBalance('3',Vare,'Norge','Inbal','xDom') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M));
MarketBalance('3',Vare,'Norge','Inbal','xi') =   sum(M, xi.l(VARE,M));
MarketBalance('3',Vare,'Norge','Inbal','xi') =   sum(M, xq.l(VARE,M));
MarketBalance('3',Vare,'Norge','Inbal','xqa') =  sum(M, xqa.l(VARE,M));
MarketBalance('3',Vare,'Norge','Inbal','xqb') =  sum(M, xqb.l(VARE,M));
MarketBalance('3',Vare,'Norge','Inbal','xqs') =  sum(M, xqs.l(VARE,M));
MarketBalance('3',Vare,'Norge','Inbal','inntr') =  SUM((M,MM), inntr.l(VARE,M,MM));
MarketBalance('3',Vare,'Norge','Inbal','h') = SUM((M,MOEL) $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('3',Vare,'Norge','Inbal','uttr') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM((M,MM), uttr.l(VARE,M,MM));
MarketBalance('3',Vare,'Norge','Utbal','h_MoelUt') =   SUM((M,MOEL)$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('3',Vare,'Norge','Utbal','h_Slt')    =   SUM((M,MOEL)$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('3',Vare,'Norge','Utbal','z') =      sum(m, z.l(VARE,M) $ MOELUTKVARE(VARE)) ;
MarketBalance('3',Vare,'Norge','Utbal','x') =      sum(m, x.l(VARE,'WHLS',M) $ SLTVARE(VARE)) ;

MRKINFES(STEP) = markedsmodell.numinfes;

IF ((MRKINFES(STEP) > 0), abort "Infeasibilities i markedsmodellen"; );

***********************************************************
* STEP 4: Calculate endogenous processing margins
***********************************************************
*
* Calculate margins from previous run
MARGIN(VARE,M,'RETL') $  x.l(VARE,'CONS',M) = MARGIN(VARE,M,'RETL') - (-x.m(VARE,'CONS',M) * x.l(VARE,'CONS',M)) / x.l(VARE,'CONS',M) ;
MarginL(VARE,M) $ x.l(VARE,'CONS',M) = MARGIN(VARE,M,'RETL');
MarginP(VARE,M) $ x.l(VARE,'CONS',M) = p.l(VARE,'CONS',M);

display "step4";
SOLVE MARKEDSMODELL USING NLP MAXIMIZING OBJ;

CalibTestdata('4','g.l','',B,R) = g.l(B,R);
CalibTestdata('4','x.l',VARE,'PRIM','NORGE') = x.l(VARE,'PRIM','NORGE');
CalibTestdata('4','x.l',VARE,'PRIM',R) = x.l(VARE,'PRIM',R);

MarketBalance('4',Vare,M,'Inbal','LHS') = SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M)) + xi.l(VARE,M) + xq.l(VARE,M) + xqa.l(VARE,M) + xqb.l(VARE,M) + xqs.l(VARE,M) + SUM(MM, inntr.l(VARE,M,MM));
MarketBalance('4',Vare,M,'Inbal','RHS') = SUM(MOEL $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M)) + SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM(MM, uttr.l(VARE,M,MM));
MarketBalance('4',Vare,M,'Utbal','LHS') = SUM(MOEL$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M)) +  SUM(MOEL$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('4',Vare,M,'Utbal','RHS') = z.l(VARE,M) $ MOELUTKVARE(VARE) + x.l(VARE,'WHLS',M) $ SLTVARE(VARE) ;
MarketBalance('4',Vare,'Norge','Inbal','xDom') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M));
MarketBalance('4',Vare,'Norge','Inbal','xi') =   sum(M, xi.l(VARE,M));
MarketBalance('4',Vare,'Norge','Inbal','xi') =   sum(M, xq.l(VARE,M));
MarketBalance('4',Vare,'Norge','Inbal','xqa') =  sum(M, xqa.l(VARE,M));
MarketBalance('4',Vare,'Norge','Inbal','xqb') =  sum(M, xqb.l(VARE,M));
MarketBalance('4',Vare,'Norge','Inbal','xqs') =  sum(M, xqs.l(VARE,M));
MarketBalance('4',Vare,'Norge','Inbal','inntr') =  SUM((M,MM), inntr.l(VARE,M,MM));
MarketBalance('4',Vare,'Norge','Inbal','h') = SUM((M,MOEL) $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('4',Vare,'Norge','Inbal','uttr') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM((M,MM), uttr.l(VARE,M,MM));
MarketBalance('4',Vare,'Norge','Utbal','h_MoelUt') =   SUM((M,MOEL)$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('4',Vare,'Norge','Utbal','h_Slt')    =   SUM((M,MOEL)$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('4',Vare,'Norge','Utbal','z') =      sum(m, z.l(VARE,M) $ MOELUTKVARE(VARE)) ;
MarketBalance('4',Vare,'Norge','Utbal','x') =      sum(m, x.l(VARE,'WHLS',M) $ SLTVARE(VARE)) ;

MRKINFES(STEP) = markedsmodell.numinfes;

IF ((MRKINFES(STEP) > 0), abort "Infeasibilities i markedsmodellen"; );

***********************************************************
* STEP 5: Final check with unbounded consumption
***********************************************************

* Remove bounds on consumption
x.lo(VARE,'CONS',M)$(SLTVARE(VARE) AND P0(VARE)) = X0(VARE,M) * .1;
x.l(VARE,'CONS',M)$(SLTVARE(VARE) AND P0(VARE)) = X0(VARE,M);
x.up(VARE,'CONS',M)$(SLTVARE(VARE) AND P0(VARE)) = x.l(VARE,'CONS',M) * 100;
* Code leaves market model infes (negative exponent)
x.fx(MEIXVARE,'CONS',M) = 0;

execute_unload 'Calibration.gdx';
*abort '';
display "step5";
SOLVE MARKEDSMODELL USING NLP MAXIMIZING OBJ;

CalibTestdata('5','g.l','',B,R) = g.l(B,R);
CalibTestdata('5','x.l',VARE,'PRIM','NORGE') = x.l(VARE,'PRIM','NORGE');
CalibTestdata('5','x.l',VARE,'PRIM',R) = x.l(VARE,'PRIM',R);

MarketBalance('5',Vare,M,'Inbal','LHS') = SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M)) + xi.l(VARE,M) + xq.l(VARE,M) + xqa.l(VARE,M) + xqb.l(VARE,M) + xqs.l(VARE,M) + SUM(MM, inntr.l(VARE,M,MM));
MarketBalance('5',Vare,M,'Inbal','RHS') = SUM(MOEL $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M)) + SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM(MM, uttr.l(VARE,M,MM));
MarketBalance('5',Vare,M,'Utbal','LHS') = SUM(MOEL$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M)) +  SUM(MOEL$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('5',Vare,M,'Utbal','RHS') = z.l(VARE,M) $ MOELUTKVARE(VARE) + x.l(VARE,'WHLS',M) $ SLTVARE(VARE) ;
MarketBalance('5',Vare,'Norge','Inbal','xDom') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',M));
MarketBalance('5',Vare,'Norge','Inbal','xi') =   sum(M, xi.l(VARE,M));
MarketBalance('5',Vare,'Norge','Inbal','xi') =   sum(M, xq.l(VARE,M));
MarketBalance('5',Vare,'Norge','Inbal','xqa') =  sum(M, xqa.l(VARE,M));
MarketBalance('5',Vare,'Norge','Inbal','xqb') =  sum(M, xqb.l(VARE,M));
MarketBalance('5',Vare,'Norge','Inbal','xqs') =  sum(M, xqs.l(VARE,M));
MarketBalance('5',Vare,'Norge','Inbal','inntr') =  SUM((M,MM), inntr.l(VARE,M,MM));
MarketBalance('5',Vare,'Norge','Inbal','h') = SUM((M,MOEL) $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('5',Vare,'Norge','Inbal','uttr') = SUM((M,VAREVARE)$MOELFLYT(VARE,VAREVARE), xe.l(VAREVARE,M)) + SUM((M,MM), uttr.l(VARE,M,MM));
MarketBalance('5',Vare,'Norge','Utbal','h_MoelUt') =   SUM((M,MOEL)$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('5',Vare,'Norge','Utbal','h_Slt')    =   SUM((M,MOEL)$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h.l(MOEL,M));
MarketBalance('5',Vare,'Norge','Utbal','z') =      sum(m, z.l(VARE,M) $ MOELUTKVARE(VARE)) ;
MarketBalance('5',Vare,'Norge','Utbal','x') =      sum(m, x.l(VARE,'WHLS',M) $ SLTVARE(VARE)) ;

MRKINFES(STEP) = markedsmodell.numinfes;

IF ((MRKINFES(STEP) > 0), abort "Infeasibilities i markedsmodellen"; );

*
StartVerdierMarket('x',VARE,C,M)      = x.l(VARE,C,M)      ;
StartVerdierMarket('xi',VARE,'',M)    = xi.l(VARE,M)       ;
StartVerdierMarket('xq',VARE,'',M)    = xq.l(VARE,M)       ;
StartVerdierMarket('xqa',VARE,'',M)   = xqa.l(VARE,M)      ;
StartVerdierMarket('xqb',VARE,'',M)   = xqb.l(VARE,M)      ;
StartVerdierMarket('xqs',VARE,'',M)   = xqs.l(VARE,M)      ;
StartVerdierMarket('xe',VARE,'',M)    = xe.l(VARE,M)       ;
StartVerdierMarket('p',VARE,C,M)      = p.l(VARE,C,M)      ;
StartVerdierMarket('g',B,'',R)        = g.l(B,R)           ;
StartVerdierMarket('h',FP,'',M)       = h.l(FP,M)          ;
StartVerdierMarket('z',VARE,'',M)     = z.l(VARE,M)        ;
StartVerdierMarket('z',VARE,'',R)     = z.l(VARE,R)        ;
StartVerdierMarket('inntr',VARE,M,MM) = inntr.l(VARE,M,MM) ;
StartVerdierMarket('uttr',VARE,M,MM)  = uttr.l(VARE,M,MM)  ;
StartVerdierMarket('Margin',VARE,M,'')  = Margin(VARE,M,'RETL')  ;
StartVerdierMarket('Margin/P',VARE,M,'')  = MarginL(VARE,M)  ;
StartVerdierMarket('P',VARE,M,'')    = MarginP(VARE,M)  ;
StartVerdierMarket('P0',VARE,'','')   = P0(VARE)  ;

* Store producerprices
StartProducerPrice(R,VARE) $ MOELINNVARE(VARE) = MaalPris(VARE);
StartProducerPrice(R,VARE) $ (MOELUTKVARE(VARE) $ SUM(M$R_TIL_M(M,R), -EQMOELUTBAL.m(VARE,M))) =  SUM(M$R_TIL_M(M,R), -EQMOELUTBAL.m(VARE,M));
StartProducerPrice(R,VARE) $ (SUM(M$R_TIL_M(M,R), EQMELKBAL.m(VARE,M)) AND SUM(M$R_TIL_M(M,R),x.l(VARE,'PRIM',M))) = SUM(M$R_TIL_M(M,R), EQMELKBAL.m(VARE,M));
StartProducerPrice(R,'STFK') $ SUM(M, EQSTKKBAL.m(M)) = SUM(M$R_TIL_M(M,R), EQSTKKBAL.m(M));
StartProducerPrice(R,'KLVK') $ SUM(M, EQSTKKBAL.m(M)) = SUM(M$R_TIL_M(M,R), EQSTKKBAL.m(M));
StartProducerPrice(R,'SAUK') $ SUM(M, EQSAGKBAL.m(M)) = SUM(M$R_TIL_M(M,R), EQSAGKBAL.m(M));
StartProducerPrice(R,'GETK') $ SUM(M, EQSAGKBAL.m(M)) = SUM(M$R_TIL_M(M,R), EQSAGKBAL.m(M));
StartProducerPrice(R,'SVNK') $ SUM(M, EQSVNKBAL.m(M)) = SUM(M$R_TIL_M(M,R), EQSVNKBAL.m(M));
StartProducerPrice(R,'FJRK') $ SUM(M, EQFJRKBAL.m(M)) = SUM(M$R_TIL_M(M,R), EQFJRKBAL.m(M));
StartProducerPrice(R,VARE) $ (SUM(M$R_TIL_M(M,R), FK(VARE,M)) > 0) = SUM(M$R_TIL_M(M,R), p.l(VARE,'CONS',M) - FK(VARE,M));
*
* Ensure non-negative producer prices (it happens that equilibrium prices become negative)
StartProducerPrice(R,VARE) = MAX(0, StartProducerPrice(R,VARE));
*
* Store PMP-values and start values
execute_unload 'pmp.gdx', PmpProdCnst, PmpProdQuad, Margin, StartVerdierMarket, StartProducerPrice, MarginL ;
execute_unload 'CalibTestdata.gdx', CalibTestdata, MarketBalance;
$endif.pmp

* Run market model in simulation mode
$ifThenI.pmp %pmp%==NO
g.l('BKRN',R) $ SUM(KornOljePrdk, SIMDATA(R,'BKRN','OMFG',KornOljePrdk)) = Sum(KornOljePrdk, DATA(R,KornOljePrdk,'OMFG','BAS')) / SUM(KornOljePrdk, SIMDATA(R,'BKRN','OMFG',KornOljePrdk)) ;
g.l('BPTE',R) $ SIMDATA(R,'BPTE','OMFG','POTE') = DATA(R,'POTE','OMFG','BAS') / SIMDATA(R,'BPTE','OMFG','POTE') ;
g.l('BHGE',R) $ SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS)) = Sum(GRNS, DATA(R,GRNS,'OMFG','BAS')) / SUM(GRNS, SIMDATA(R,'BHGE','OMFG',GRNS)) ;
g.l('BFRK',R) $ SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA)) = Sum(FRBA, DATA(R,FRBA,'OMFG','BAS')) / SUM(FRBA, SIMDATA(R,'BFRK','OMFG',FRBA)) ;
g.l('BKMK',R) $ SIMDATA(R,'BKMK','OMFG','MKYR') = DATA(R,'MKYR','OMFG','BAS') / SIMDATA(R,'BKMK','OMFG','MKYR') ;
g.l('BAKY',R) $ SIMDATA(R,'BAKY','OMFG','AKYR') = DATA(R,'AKYR','OMFG','BAS') / SIMDATA(R,'BAKY','OMFG','AKYR') ;
g.l('BGMK',R) $ SIMDATA(R,'BGMK','OMFG','GEIT') = DATA(R,'GEIT','OMFG','BAS') / SIMDATA(R,'BGMK','OMFG','GEIT') ;
g.l('BSAU',R) $ SIMDATA(R,'BSAU','OMFG','SOEY') = DATA(R,'SOEY','OMFG','BAS') / SIMDATA(R,'BSAU','OMFG','SOEY') ;
g.l('BGRI',R) $ SIMDATA(R,'BGRI','OMFG','PURK') = DATA(R,'PURK','OMFG','BAS') / SIMDATA(R,'BGRI','OMFG','PURK') ;
g.l('BHOE',R) $ SIMDATA(R,'BHOE','OMFG','HOEN') = DATA(R,'HOEN','OMFG','BAS') / SIMDATA(R,'BHOE','OMFG','HOEN') ;
g.l('BKYL',R) $ SIMDATA(R,'BKYL','OMFG','KYLS') = DATA(R,'KYLS','OMFG','BAS') / SIMDATA(R,'BKYL','OMFG','KYLS') ;
*
g.lo(B,R) = 0;
g.up(B,R) = g.l(B,R) * 100;

* Starting values from the market model
x.l(VARE,C,M)      = StartVerdierMarket('x',VARE,C,M)      ;
xi.l(VARE,M)       = StartVerdierMarket('xi',VARE,'',M)    ;
xq.l(VARE,M)       = StartVerdierMarket('xq',VARE,'',M)    ;
xqa.l(VARE,M)      = StartVerdierMarket('xqa',VARE,'',M)   ;
xqb.l(VARE,M)      = StartVerdierMarket('xqb',VARE,'',M)   ;
xqs.l(VARE,M)      = StartVerdierMarket('xqs',VARE,'',M)   ;
*xe.l(VARE,M)       = StartVerdierMarket('xe',VARE,'',M)    ;
p.l(VARE,C,M)      = StartVerdierMarket('p',VARE,C,M)      ;
g.l(B,R)           = StartVerdierMarket('g',B,'',R)        ;
h.l(FP,M)          = StartVerdierMarket('h',FP,'',M)       ;
z.l(VARE,M)        = StartVerdierMarket('z',VARE,'',M)     ;
z.l(VARE,R)        = StartVerdierMarket('z',VARE,'',R)     ;
inntr.l(VARE,M,MM) = StartVerdierMarket('inntr',VARE,M,MM) ;
uttr.l(VARE,M,MM)  = StartVerdierMarket('uttr',VARE,M,MM)  ;


option solprint = on;

option limrow = 999;
option limcol = 999;

execute_unload 'Simulation.gdx';
*abort '';

SOLVE MARKEDSMODELL USING NLP MAXIMIZING OBJ;

MRKINFES(STEP) = markedsmodell.numinfes;

IF ((MRKINFES(STEP) > 0), abort "Infeasibilities i markedsmodellen"; 
                          execute_unload '%SCEN%_infes_marked.gdx';
   );

$endIf.pmp

*******************************
* Here starts storing values for reporting purposes
**********************************
KONVERGESIMDATA('PrisTest','EQU','KMLK','OEST',STEP) = -eqmelkbal.m('KMLK','OEST');
KONVERGESIMDATA('PrisTest','EQU','STFK','OEST',STEP)  = -eqstkkbal.m('OEST');
KONVERGESIMDATA('PrisTest','EQU','KLVK','OEST',STEP)  = -eqstkkbal.m('OEST');
KONVERGESIMDATA('PrisTest','EQU','SAUK','OEST',STEP)  = -eqsagkbal.m('OEST');
KONVERGESIMDATA('PrisTest','EQU','GETK','OEST',STEP)  = -eqsagkbal.m('OEST');
KONVERGESIMDATA('PrisTest','EQU','SVNK','OEST',STEP)  = -eqsvnkbal.m('OEST');
KONVERGESIMDATA('PrisTest','EQU','FJRK','OEST',STEP)  = -eqfjrkbal.m('OEST');

KONVERGESIMDATA('MngdTest','x',VARE,'Norge',STEP)  = SUM(M, x.l(VARE,'CONS',M));
KONVERGESIMDATA('MngdTest','xi',VARE,'Norge',STEP)  = SUM(M, xi.l(VARE,M));
KONVERGESIMDATA('MngdTest','xq',VARE,'Norge',STEP)  = SUM(M, xq.l(VARE,M));
KONVERGESIMDATA('MngdTest','xqa',VARE,'Norge',STEP)  = SUM(M, xqa.l(VARE,M));
KONVERGESIMDATA('MngdTest','xqb',VARE,'Norge',STEP)  = SUM(M, xqb.l(VARE,M));

StartVerdierMarket('x',VARE,C,M)      = x.l(VARE,C,M)      ;
StartVerdierMarket('xi',VARE,'',M)    = xi.l(VARE,M)       ;
StartVerdierMarket('xq',VARE,'',M)    = xq.l(VARE,M)       ;
StartVerdierMarket('xqa',VARE,'',M)   = xqa.l(VARE,M)      ;
StartVerdierMarket('xqb',VARE,'',M)   = xqb.l(VARE,M)      ;
StartVerdierMarket('xqs',VARE,'',M)   = xqs.l(VARE,M)      ;
StartVerdierMarket('xe',VARE,'',M)    = xe.l(VARE,M)       ;
StartVerdierMarket('p',VARE,C,M)      = p.l(VARE,C,M)      ;
StartVerdierMarket('g',B,'',R)        = g.l(B,R)           ;
StartVerdierMarket('h',FP,'',M)       = h.l(FP,M)          ;
StartVerdierMarket('z',VARE,'',M)     = z.l(VARE,M)        ;
StartVerdierMarket('z',VARE,'',R)     = z.l(VARE,R)        ;
StartVerdierMarket('inntr',VARE,M,MM) = inntr.l(VARE,M,MM) ;
StartVerdierMarket('uttr',VARE,M,MM)  = uttr.l(VARE,M,MM)  ;

* Konvergens i markedsmodellen
KONVERGENS('M_MOD','SolveStat','',STEP) = markedsmodell.SolveStat;
KONVERGENS('M_MOD','ModelStat','',STEP) = markedsmodell.ModelStat;
KONVERGENS(M,VARE,'KONS',STEP) = x.l(VARE,'CONS',M);
KONVERGENS(M,VARE,'PROD',STEP) = x.l(VARE,'PRIM',M);
KONVERGENS('NORGE',VARE,'KONS',STEP) = sum(M, x.l(VARE,'CONS',M));
KONVERGENS('NORGE',VARE,'PROD',STEP) = sum(M, x.l(VARE,'PRIM',M));
KONVERGENS('NORGE',VARE,'xi',STEP) = sum(M, xi.l(VARE,M));
KONVERGENS('NORGE',VARE,'xq',STEP) = sum(M, xq.l(VARE,M));
KONVERGENS('NORGE',VARE,'xqa',STEP) = sum(M, xqa.l(VARE,M));
KONVERGENS('NORGE',VARE,'xqb',STEP) = sum(M, xqb.l(VARE,M));
KONVERGENS('NORGE',VARE,'xqs',STEP) = sum(M, xqs.l(VARE,M));
KONVERGENS('NORGE',VARE,'xe',STEP) = sum(M, xe.l(VARE,M));
KONVERGENS(M,VARE,'PRIS',STEP) = p.l(VARE,'CONS',M);
KONVERGENS(B,R,'BRUK',STEP) $ (NOT RBUT(R,B)) = g.l(B,R);
KONVERGENS(B,M,'BRUK',STEP) = SUM(R$R_TIL_M(M,R), KONVERGENS(B,R,'BRUK',STEP));
KONVERGENS(M,SSLK,'ANTL',STEP) = h.l(SSLK,M);
KONVERGENS(M,FSLK,'ANTL',STEP) = h.l(FSLK,M);
KONVERGENS(M,MEIR,'ANTL',STEP) = h.l(MEIR,M);
KONVERGENS(R,'AREA','OMFG',STEP) = SUM((B,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
KONVERGENS(R,'FULL','OMFG',STEP) = SUM((B,PLANTE)$(NOT SAMEAS('GFOS',PLANTE) OR NOT SAMEAS('GFOB',PLANTE)
                                            OR NOT SAMEAS('GFIB',PLANTE) OR NOT SAMEAS('GFUB',PLANTE)
                                            OR NOT SAMEAS('BLOM',PLANTE) OR NOT SAMEAS('GRNV',PLANTE)),
                                   SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
KONVERGENS(R,'MATK','OMFG',STEP) = SUM((B,PLANTE)$(SAMEAS('HVET',PLANTE) OR SAMEAS('RUGH',PLANTE)
                                            OR SAMEAS('AKRN',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
KONVERGENS(M,VARE,'PRIS',STEP) $ MOELINNVARE(VARE) = (-EQMOELINBAL.m(VARE,M));
KONVERGENS(M,VARE,'PRIS',STEP) $ MOELUTVARE(VARE)  = (-EQMOELUTBAL.m(VARE,M));
*
KONVERGENS(R,'NITH',SPRED,STEP)  = intens.up(R,'NITH',SPRED);
KONVERGENS(R,'FOSH',SPRED,STEP)  = intens.up(R,'FOSH',SPRED);
KONVERGENS(R,'KALH',SPRED,STEP)  = intens.up(R,'KALH',SPRED);
KONVERGENS(R,'NITG',SPRED,STEP)  = intens.up(R,'NITG',SPRED);
KONVERGENS(R,'FOSG',SPRED,STEP)  = intens.up(R,'FOSG',SPRED);
KONVERGENS(R,'KALG',SPRED,STEP)  = intens.up(R,'KALG',SPRED);
KONVERGENS(R,'NITR',SPRED,STEP)  = intens.up(R,'NITR',SPRED);
KONVERGENS(R,'FOSF',SPRED,STEP)  = intens.up(R,'FOSF',SPRED);
KONVERGENS(R,'KALI',SPRED,STEP)  = intens.up(R,'KALI',SPRED);


* Lagre modelstatus
SIMDATA('NORGE','SLK','MDST',STEP)  = SLKINFES(STEP) ;
SIMDATA('NORGE','MEI','MDST',STEP)  = MEIINFES(STEP) ;
SIMDATA('NORGE','MRK','MDST',STEP)  = MRKINFES(STEP) ;
*
KONVERGENS('NORGE','CO2AVGXP_EXOG',UTSLIPPAVG,STEP) = CO2AVGXP(UTSLIPPAVG) ;
KONVERGENS('NORGE','CO2AVGXP_ENDO',UTSLIPPAVG,STEP) = SUM(UTSLIPPGHG$UTSLIPPAVG_TIL_UTSLIPPGHG(UTSLIPPGHG,UTSLIPPAVG), .75 * (EQGHGTAK.m)/GHGPOTENSIAL(UTSLIPPGHG)) ;
*
* Beregne konvergensindikatorer
KONVERGENS('NORGE',VARETIL,VARE,STEP) = SATSER(VARETIL,VARE,'0','0');
KONVERGENS('NORGE',PRDKTIL,PRDK,STEP) = SATSER(PRDKTIL,PRDK,'0','0');
KONVERGENS(R,VARETIL,VARE,STEP) = SATSER(VARETIL,VARE,'0',R);
KONVERGENS(R,PRDKTIL,PRDK,STEP) = SATSER(PRDKTIL,PRDK,'0',R);
KONVERGENS(R,'TARBF','ARBF',STEP) = SATSER('TARBF','ARBF','0',R);
KONVERGENS('NORGE','OMFG',PRDK,STEP) = SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
KONVERGENS('NORGE','OMFG',PRDK,'0') = DATA('NORGE',PRDK,'OMFG','BAS');
KONVERGENS(R,'KAPJ','FULLD',STEP) $ SUM(FULLDYRK, SIMDATA(R,'OMFG',FULLDYRK,'Y')) = SUM(FULLDYRK, SIMDATA(R,'KAPJ',FULLDYRK,'Y') * SIMDATA(R,'OMFG',FULLDYRK,'Y')) / SUM(FULLDYRK, SIMDATA(R,'OMFG',FULLDYRK,'Y'));
KONVERGENS(R,'KAPJ','AREAL',STEP) $ SUM(PLANTE,   SIMDATA(R,'OMFG',PLANTE,'Y'))   = SUM(PLANTE,   SIMDATA(R,'KAPJ',PLANTE,'Y')   * SIMDATA(R,'OMFG',PLANTE,'Y'))   / SUM(PLANTE,   SIMDATA(R,'OMFG',PLANTE,'Y'));
KONVERGENS('NORGE','VARE_GLV',VARE,STEP)   = (-EQXPGLV.m(VARE));
KONVERGENS('NORGE','VARE_GLV','KORN',STEP) = (-EQXPKORNGLV.m) ;
KONVERGENS('NORGE','VARE_GLV','STKK',STEP) = (-EQXPSTKKGLV.m) ;
KONVERGENS(R,MOELUTKVARE,'KFORAVG',STEP) = KFORAVG(R,MOELUTKVARE);
KONVERGENS(R,'NITG','KFORAVG',STEP) = KFORAVG(R,'NITG');
*
* PMP-verdi totalt og per vare
KONVERGENS(R,B,'PMP_VERD',STEP) $ SUM(VARE$B_TIL_VARE(B,VARE), SIMDATA(R,B,'MNGD',VARE) * g.l(B,R)) =
                                  (PmpProdCnst(R,B) *  g.l(B,R)
                            + .5 * PmpProdQuad(R,B) * (g.l(B,R)**2) $ (PmpProdQuad(R,B) < 0)
                            - .5 * PmpProdQuad(R,B) * (g.l(B,R)**2) $ (PmpProdQuad(R,B) > 0));
KONVERGENS(R,B,'PMP_MNGD',STEP) $ SUM(VARE$B_TIL_VARE(B,VARE), SIMDATA(R,B,'MNGD',VARE) * g.l(B,R)) =
                                  SUM(VARE$B_TIL_VARE(B,VARE), SIMDATA(R,B,'MNGD',VARE) * g.l(B,R));
KONVERGENS(R,B,'PMP_PRIS',STEP) $ KONVERGENS(R,B,'PMP_MNGD',STEP) =
  KONVERGENS(R,B,'PMP_VERD',STEP) / KONVERGENS(R,B,'PMP_MNGD',STEP);
*
* Fordel husdyrgjoedsel paa bruk uten husdyr i forhold til gjeldende intensitet og areal
* Bruk hele landet siden modellen har for mye spesialisering for kraftforbasert produksjon
* NITH
intens.up(R,'NITH',SPRED) $ SUM((RR,BINHDG,SPREDSPRED), SIMDATA(RR,BINHDG,SPREDSPRED,'OMFG') * g.l(BINHDG,RR))
 = SUM((RR,BUTHDG), SIMDATA(RR,BUTHDG,'MNGD','NITH') * g.l(BUTHDG,RR) * 1000)
 / SUM((RR,BINHDG,SPREDSPRED), SIMDATA(RR,BINHDG,SPREDSPRED,'OMFG') * g.l(BINHDG,RR));
*
* FOSH
intens.up(R,'FOSH',SPRED) $ SUM((RR,BINHDG,SPREDSPRED), SIMDATA(RR,BINHDG,SPREDSPRED,'OMFG') * g.l(BINHDG,RR))
 = SUM((RR,BUTHDG), SIMDATA(RR,BUTHDG,'MNGD','FOSH') * g.l(BUTHDG,RR) * 1000)
 / SUM((RR,BINHDG,SPREDSPRED), SIMDATA(RR,BINHDG,SPREDSPRED,'OMFG') * g.l(BINHDG,RR));
*
* KALH
intens.up(R,'KALH',SPRED) $ SUM((RR,BINHDG,SPREDSPRED), SIMDATA(RR,BINHDG,SPREDSPRED,'OMFG') * g.l(BINHDG,RR))
 = SUM((RR,BUTHDG), SIMDATA(RR,BUTHDG,'MNGD','KALH') * g.l(BUTHDG,RR) * 1000)
 / SUM((RR,BINHDG,SPREDSPRED), SIMDATA(RR,BINHDG,SPREDSPRED,'OMFG') * g.l(BINHDG,RR));
*
* Lagre iterasjonsvise resulater
RESNORGE(R,'NITH',SPRED,STEP)  = intens.l(R,'NITH',SPRED);
RESNORGE(R,'FOSH',SPRED,STEP)  = intens.l(R,'FOSH',SPRED);
RESNORGE(R,'KALH',SPRED,STEP)  = intens.l(R,'KALH',SPRED);
RESNORGE(R,'NITG',SPRED,STEP)  = intens.l(R,'NITG',SPRED);
RESNORGE(R,'FOSG',SPRED,STEP)  = intens.l(R,'FOSG',SPRED);
RESNORGE(R,'KALG',SPRED,STEP)  = intens.l(R,'KALG',SPRED);
RESNORGE(R,'NITR',SPRED,STEP)  = intens.l(R,'NITR',SPRED);
RESNORGE(R,'FOSF',SPRED,STEP)  = intens.l(R,'FOSF',SPRED);
RESNORGE(R,'KALI',SPRED,STEP)  = intens.l(R,'KALI',SPRED);

RESNORGE(R,VARE,PRDK,STEP) $ SUM(B$SIMDATA(R,B,VARE,PRDK), g.l(B,R)) = SUM(B, SIMDATA(R,B,VARE,PRDK) * g.l(B,R)) / SUM(B$SIMDATA(R,B,VARE,PRDK), g.l(B,R));
RESNORGE(R,'GE','MKYR',STEP) $ SUM(B$SIMDATA(R,B,'GE','MKYR'), g.l(B,R)) = SUM(B, SIMDATA(R,B,'GE','MKYR') * g.l(B,R)) / SUM(B$SIMDATA(R,B,'GE','MKYR'), g.l(B,R));
RESNORGE(R,'YM','MKYR',STEP) $ SUM(B$SIMDATA(R,B,'YM','MKYR'), g.l(B,R)) = SUM(B, SIMDATA(R,B,'YM','MKYR') * g.l(B,R)) / SUM(B$SIMDATA(R,B,'YM','MKYR'), g.l(B,R));
*
RESNORGE('NORGE',VARE,PRDK,STEP) $ (SUM((R,B)$SIMDATA(R,B,VARE,PRDK),  SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) > 0.1) = SUM((R,B), SIMDATA(R,B,VARE,PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) / SUM((R,B)$SIMDATA(R,B,VARE,PRDK),  SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));

RESNORGE('NORGE','GE','MKYR',STEP) $ SUM((R,B)$SIMDATA(R,B,'GE','MKYR'), g.l(B,R)) = SUM((R,B), SIMDATA(R,B,'GE','MKYR') * g.l(B,R)) / SUM((R,B)$SIMDATA(R,B,'GE','MKYR'), g.l(B,R));
RESNORGE('NORGE','YM','MKYR',STEP) $ SUM((R,B)$SIMDATA(R,B,'YM','MKYR'), g.l(B,R)) = SUM((R,B), SIMDATA(R,B,'YM','MKYR') * g.l(B,R)) / SUM((R,B)$SIMDATA(R,B,'YM','MKYR'), g.l(B,R));
*
RESNORGE(R,'GFFS','GFFS',STEP) $ SUM(B, SIMDATA(R,B,'OMFG','GFFS') * g.l(B,R)) = x.l('GFFS','PRIM',R) / SUM(B, SIMDATA(R,B,'OMFG','GFFS') * g.l(B,R));
RESNORGE(R,'GFFB','GFFB',STEP) $ SUM(B, SIMDATA(R,B,'OMFG','GFFB') * g.l(B,R)) = x.l('GFFB','PRIM',R) / SUM(B, SIMDATA(R,B,'OMFG','GFFB') * g.l(B,R));
RESNORGE(R,'GFOS','GFOS',STEP) $ SUM(B, SIMDATA(R,B,'OMFG','GFOS') * g.l(B,R)) = x.l('GFOS','PRIM',R) / SUM(B, SIMDATA(R,B,'OMFG','GFOS') * g.l(B,R));
RESNORGE(R,'GFOB','GFOB',STEP) $ SUM(B, SIMDATA(R,B,'OMFG','GFOB') * g.l(B,R)) = x.l('GFOB','PRIM',R) / SUM(B, SIMDATA(R,B,'OMFG','GFOB') * g.l(B,R));
RESNORGE(R,'GFIB','GFIB',STEP) $ SUM(B, SIMDATA(R,B,'OMFG','GFIB') * g.l(B,R)) = x.l('GFIB','PRIM',R) / SUM(B, SIMDATA(R,B,'OMFG','GFIB') * g.l(B,R));
RESNORGE(R,B,'KAPT',STEP) $ SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) =  (SIMDATA(R,B,'MNGD','KAPB') + SIMDATA(R,B,'MNGD','KAPM'))
   / SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));
RESNORGE(DG,B,'KAPT',STEP) $ SUM((R,PRDK) $ (R_TIL_DG(DG,R) $ B_TIL_HRDK(B,PRDK)), SIMDATA(R,B,'OMFG',PRDK)) =  SUM(R$R_TIL_DG(DG,R), SIMDATA(R,B,'MNGD','KAPB') + SIMDATA(R,B,'MNGD','KAPM'))
   / SUM((R,PRDK) $ (R_TIL_DG(DG,R) $ B_TIL_HRDK(B,PRDK)), SIMDATA(R,B,'OMFG',PRDK));
RESNORGE(R,B,'ARBT',STEP) $ SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) = SIMDATA(R,B,'MNGD','ARBF') * TimerPerAarsverk
   / SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK)) ;
RESNORGE(DG,B,'ARBT',STEP) $ SUM((R,PRDK)$(R_TIL_DG(DG,R) $ B_TIL_HRDK(B,PRDK)), SIMDATA(R,B,'OMFG',PRDK)) = SUM(R$R_TIL_DG(DG,R), SIMDATA(R,B,'MNGD','ARBF') * TimerPerAarsverk)
   / SUM((R,PRDK) $ (R_TIL_DG(DG,R) $ B_TIL_HRDK(B,PRDK)), SIMDATA(R,B,'OMFG',PRDK)) ;
RESNORGE(R,B,'ARBK',STEP) $ SIMDATA(R,B,'MNGD','ARBF') = SIMDATA(R,B,'VERD','ARBF') / (SIMDATA(R,B,'MNGD','ARBF') * (TimerPerAarsverk/1000));
RESNORGE(R,B,'ENHK',STEP) $ SUM(VARE$B_TIL_VARE(B,VARE), SIMDATA(R,B,'MNGD',VARE)) = SUM(INNSATS, bidrag.l(R,B,INNSATS))
   / SUM(VARE$B_TIL_VARE(B,VARE), SIMDATA(R,B,'MNGD',VARE));
RESNORGE('NORGE',B,'ENHK',STEP) $ SUM((R,VARE)$B_TIL_VARE(B,VARE), SIMDATA(R,B,'MNGD',VARE) * g.l(B,R)) = SUM((R,INNSATS), bidrag.l(R,B,INNSATS) * g.l(B,R))
   / SUM((R,VARE)$B_TIL_VARE(B,VARE), SIMDATA(R,B,'MNGD',VARE) * g.l(B,R));
RESNORGE(SLK,'PRIS','VERD',STEP) $ SUM(M, h.l(SLK,M)) = SUM(M, SIMDATA(M,SLK,'PRIS','Y') * h.l(SLK,M)) / SUM(M, h.l(SLK,M));
RESNORGE(MEIR,'PRIS','VERD',STEP) $ SUM(M, h.l(MEIR,M)) = SUM(M, SIMDATA(M,MEIR,'PRIS','Y') * h.l(MEIR,M)) / SUM(M, h.l(MEIR,M));
RESNORGE(MOEL,'PRIS','VERD',STEP) $ SUM(M, h.l(MOEL,M)) = SUM(M, SIMDATA(M,MOEL,'PRIS','Y') * h.l(MOEL,M)) / SUM(M, h.l(MOEL,M));
RESNORGE(M,SSLK,'MNGD',STEP) = h.l(SSLK,M);
RESNORGE(M,FSLK,'MNGD',STEP) = h.l(FSLK,M);
RESNORGE(M,KSLK,'MNGD',STEP) = h.l(KSLK,M);
RESNORGE(M,MEIR,'MNGD',STEP) = h.l(MEIR,M);
RESNORGE(M,MOEL,'MNGD',STEP) = h.l(MOEL,M);
RESNORGE(M,SSLK,'PRIS',STEP) = SIMDATA(M,SSLK,'PRIS','Y');
RESNORGE(M,KSLK,'PRIS',STEP) = SIMDATA(M,KSLK,'PRIS','Y');
RESNORGE('NORGE','KSLK','PRIS',STEP) $ SUM((KSLK,M), h.l(KSLK,M))= SUM((M,KSLK), SIMDATA(M,KSLK,'PRIS','Y') * h.l(KSLK,M)) / SUM((M,KSLK), h.l(KSLK,M));
RESNORGE(M,'MEIR','OMFG',STEP) = qmei.l(M);
RESNORGE(M,'MEIR','STOR',STEP) = SUM(MEIINNVARE, zpmei.l(M,MEIINNVARE));
RESNORGE(M,'SSLK','OMFG',STEP) = gs.l(M);
RESNORGE(M,'SLST','STOR',STEP) = zs_.l(M,'SLST');
RESNORGE(M,'SLSA','STOR',STEP) = zs_.l(M,'SLSA');
RESNORGE(M,'SLSV','STOR',STEP) = zs_.l(M,'SLSV');
RESNORGE(M,'SSLK','STOR',STEP) = zs.l(M);
RESNORGE(M,VARE,'KNSMMNGD',STEP) $ x.l(VARE,'CONS',M) = x.l(VARE,'CONS',M);
RESNORGE('KNSM',VARE,'MNGD',STEP) $ SUM(M, x.l(VARE,'CONS',M)) = SUM(M, x.l(VARE,'CONS',M));
RESNORGE('KNSM',VARE,'PRIS',STEP)$ SUM(M, x.l(VARE,'CONS',M)) = SUM(M, p.l(VARE,'CONS',M) * x.l(VARE,'CONS',M)) / SUM(M, x.l(VARE,'CONS',M));
RESNORGE('PROD',VARE,'MNGD',STEP) $ SUM(M, x.l(VARE,'PRIM',M)) = SUM(M, x.l(VARE,'PRIM',M));
RESNORGE('PROD','PRIN','MNGD',STEP) = SUM((M,SSLK), RESNORGE(M,SSLK,'MNGD',STEP) * SLKDATA('PRIN',SSLK));
RESNORGE('PROD','FMKN','MNGD',STEP) = SUM((M,MOEL), RESNORGE(M,MOEL,'MNGD',STEP) * MOLDATA('FMKN',MOEL));
RESNORGE('PROD','FFKN','MNGD',STEP) = SUM((M,MOEL), RESNORGE(M,MOEL,'MNGD',STEP) * MOLDATA('FFKN',MOEL));
RESNORGE('IMPO',VARE,'MNGD',STEP) $ SUM(M, xi.l(VARE,M))  = SUM(M, xi.l(VARE,M));
RESNORGE('IMPQ',VARE,'MNGD',STEP) $ SUM(M, xq.l(VARE,M))  =  SUM(M, xq.l(VARE,M)) ;
RESNORGE('IMPA',VARE,'MNGD',STEP) $ SUM(M, xqa.l(VARE,M)) =  SUM(M, xqa.l(VARE,M));
RESNORGE('IMPB',VARE,'MNGD',STEP) $ SUM(M, xqb.l(VARE,M)) =  SUM(M, xqb.l(VARE,M));
RESNORGE('IMPS',VARE,'MNGD',STEP) $ SUM(M, xqs.l(VARE,M)) =  SUM(M, xqs.l(VARE,M));
RESNORGE('IMPT',VARE,'MNGD',STEP) = RESNORGE('IMPO',VARE,'MNGD',STEP) + RESNORGE('IMPQ',VARE,'MNGD',STEP) + RESNORGE('IMPA',VARE,'MNGD',STEP) + RESNORGE('IMPB',VARE,'MNGD',STEP) + RESNORGE('IMPS',VARE,'MNGD',STEP);
RESNORGE('EKSP',VARE,'MNGD',STEP) $ SUM(M, xe.l(VARE,M))  = SUM(M, xe.l(VARE,M));
RESNORGE('PROD',INNSATS,'VERD',STEP) = SUM(M, z.l(INNSATS,M));
RESNORGE('PRIS','PRIN','VERD',STEP) $ SUM((M,SSLK), RESNORGE(M,SSLK,'MNGD',STEP) * SLKDATA('PRIN',SSLK))
       = SUM((M,SSLK), RESNORGE(M,SSLK,'MNGD',STEP) * SLKDATA('PRIN',SSLK) * EQPRINBAL.m(M)) / SUM((M,SSLK), RESNORGE(M,SSLK,'MNGD',STEP) * SLKDATA('PRIN',SSLK));
RESNORGE('PRIP',VARE,'VERD',STEP)$(SIMVARE(VARE) AND x.l(VARE,'PRIM','NORGE')) = SUM(R, SIMDATA(R,VARE,'TOTP','Y') * x.l(VARE,'PRIM',R)) / x.l(VARE,'PRIM','NORGE');
RESNORGE('PRIP',VARE,'VERD',STEP)$((SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE)) AND SUM((VAREVARE,R)$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',R)))
       = SUM((VAREVARE,R)$MOELFLYT(VARE,VAREVARE), SIMDATA(R,VAREVARE,'TOTP','Y') * x.l(VAREVARE,'PRIM',R)) / SUM((VAREVARE,R)$MOELFLYT(VARE,VAREVARE), x.l(VAREVARE,'PRIM',R));
RESNORGE(R,'JORD','AVRD',STEP) $ EQRRTAKAREAL.l(R) = EQRRTAKAREAL.m(R);
RESNORGE(R,'GROV','AVRD',STEP) $ EQRRTAKGROV.l(R) = EQRRTAKGROV.m(R);
RESNORGE(R,'FULJ','AVRD',STEP) $ EQRRTAKFULLJ.l(R) = EQRRTAKFULLJ.m(R);
RESNORGE(R,'MTKN','AVRD',STEP) $ EQRRTAKMTKRN.l(R)       = EQRRTAKMTKRN.m(R)      ;
RESNORGE(R,'NKRN','AVRD',STEP) $ EQTAKKORN.l             = EQTAKKORN.m            ;
RESNORGE(R,'RKRN','AVRD',STEP) $ EQRRTAKKORN.l(R)        = EQRRTAKKORN.m(R)       ;
RESNORGE(R,'GFUB','AVRD',STEP) $ EQRRTAKGFUB.l(R)        = EQRRTAKGFUB.m(R)       ;
*RESNORGE(R,'PRDK','AVRD',STEP) $ SUM(PRDK, EQRRTAKVEKST.l(R,PRDK))  = SUM(PRDK, EQRRTAKVEKST.m(R,PRDK)) ;
RESNORGE(R,'SPRE','AVRD',STEP) $ (NOT EQSPRED.l(R))= EQSPRED.m(R);
RESNORGE(R,'MKVT','VERD',STEP) $ SUM(F$R_TIL_F(F,R), EQXPKMLKTAK.l(F))  = SUM(F$R_TIL_F(F,R), EQXPKMLKTAK.m(F));
RESNORGE(F,'MKVT','REUT',STEP) $ POL(F,'KMLK','KVOTE')  = SUM(R$R_TIL_F(F,R), x.l('KMLK','PRIM',R)) /  POL(F,'KMLK','KVOTE');
RESNORGE(R,'JORD','REUT',STEP) $ POL(R,'AREAL','TAK') = SUM((B,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R)) / POL(R,'AREAL','TAK');
RESNORGE(R,'FULJ','REUT',STEP) $ POL(R,'FULLJ','TAK') = SUM((B,FULLDYRK), SIMDATA(R,B,'OMFG',FULLDYRK) * g.l(B,R)) / POL(R,'FULLJ','TAK');
RESNORGE('MARG',VARE,'VERD',STEP) $ EQXPGLV.m(VARE) = -EQXPGLV.m(VARE);
RESNORGE('MARG','STFK','VERD',STEP) $ EQXPSTKKGLV.m = RESNORGE('MARG','STFK','VERD',STEP) -EQXPSTKKGLV.m;
RESNORGE('MARG','KLVK','VERD',STEP) $ EQXPSTKKGLV.m = RESNORGE('MARG','KLVK','VERD',STEP) -EQXPSTKKGLV.m;
RESNORGE('LEVL',VARE,'VERD',STEP) $ EQXPGLV.l(VARE) = EQXPGLV.l(VARE);
RESNORGE('LEVL','STFK','VERD',STEP) $ EQXPSTKKGLV.m = MAX(RESNORGE('LEVL','STFK','VERD',STEP), EQXPSTKKGLV.l);
RESNORGE('LEVL','KLVK','VERD',STEP) $ EQXPSTKKGLV.m = MAX(RESNORGE('LEVL','KLVK','VERD',STEP), EQXPSTKKGLV.l);
RESNORGE('KRAV',VARE,'VERD',STEP) $ EQXPGLV.lo(VARE) = EQXPGLV.lo(VARE);
RESNORGE(R,'OMFG',PRDK,STEP) = SUM(B, SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE(R,'OMFG','KORN',STEP) = SUM((B,KORN), SIMDATA(R,B,'OMFG',KORN) * g.l(B,R));
RESNORGE(R,'OMFG','GROV',STEP) = SUM((B,GROV), SIMDATA(R,B,'OMFG',GROV) * g.l(B,R));
RESNORGE(R,'OMFG','AREAL',STEP) = SUM(PLANTE$(NOT SAMEAS('GFUB',PLANTE)), RESNORGE(R,'OMFG',PLANTE,STEP));
RESNORGE(R,'OMFG','ARTAK',STEP) = POL(R,'AREAL','TAK') ;
RESNORGE(R,'OMFG','ARANDL',STEP) $ RESNORGE(R,'OMFG','ARTAK',STEP) = RESNORGE(R,'OMFG','AREAL',STEP) / RESNORGE(R,'OMFG','ARTAK',STEP) ;
RESNORGE(B,'OMFG',PRDK,STEP) = SUM(R, SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE(B,'OMFG','KORN',STEP) = SUM((R,KORN), SIMDATA(R,B,'OMFG',KORN) * g.l(B,R));
RESNORGE(B,'OMFG','GROV',STEP) = SUM((R,GROV), SIMDATA(R,B,'OMFG',GROV) * g.l(B,R));
RESNORGE('NORGE','OMFG',PRDK,STEP) = SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('NORGE','OMFG','KORN',STEP) = SUM((R,B,KORN), SIMDATA(R,B,'OMFG',KORN) * g.l(B,R));
RESNORGE('NORGE','OMFG','GROV',STEP) = SUM((R,B,GROV), SIMDATA(R,B,'OMFG',GROV) * g.l(B,R));
*
RESNORGE('NORGE',PRDK,'OMFG_cal',STEP) = SUM((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('NORGE',PRDK,'OMFG_obs',STEP) = DATA('NORGE',PRDK,'OMFG','BAS');

*
RESNORGE(SD,'OMFG',PRDK,STEP) = SUM(R$R_TIL_SD(SD,R), RESNORGE(R,'OMFG',PRDK,STEP));
RESNORGE(SD,'OMFG','TOTAR',STEP) = SUM((R,PLANTE)$(R_TIL_SD(SD,R) AND (NOT SAMEAS('GFUB',PLANTE))), RESNORGE(R,'OMFG',PLANTE,STEP));
RESNORGE(SD,'OMFG','KORN',STEP) = SUM((R,KORN)$R_TIL_SD(SD,R), RESNORGE(R,'OMFG',KORN,STEP));
RESNORGE(SD,'OMFG','GROV',STEP) = SUM((R,GROV)$R_TIL_SD(SD,R), RESNORGE(R,'OMFG',GROV,STEP));
RESNORGE(SD,'OMFG','ARBF',STEP) = SUM((R,B)$R_TIL_SD(SD,R), SIMDATA(R,B,'MNGD','ARBF') * g.l(B,R)) ;
*
RESNORGE(R,'MNGD',VARE,STEP)  = SUM(B, SIMDATA(R,B,'MNGD',VARE) * g.l(B,R));
RESNORGE(R,'MNGD','ARBF',STEP) = SUM(B, SIMDATA(R,B,'MNGD','ARBF') * g.l(B,R));
RESNORGE(R,'VERD','PI',STEP) = SUM((B,PRODUKT), SIMDATA(R,PRODUKT,'TOTP','Y') * SIMDATA(R,B,'MNGD',PRODUKT) * g.l(B,R)) ;
RESNORGE(R,B,'STOR',STEP) = SUM(PRDK$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK));
RESNORGE(R,B,'ANTL',STEP) $ (NOT RBUT(R,B)) = g.l(B,R);
RESNORGE('NORGE',B,'ANTL',STEP) = SUM(R, RESNORGE(R,B,'ANTL',STEP));
RESNORGE('NORGE',B,'STOR',STEP) $ RESNORGE('NORGE',B,'STOR',STEP) = SUM((R,PRDK)$B_TIL_HRDK(B,PRDK), SIMDATA(R,B,'OMFG',PRDK) * RESNORGE(R,B,'ANTL',STEP)) / RESNORGE('NORGE',B,'ANTL',STEP);
RESNORGE(R,B,TILSKUDD,STEP) = SIMDATA(R,B,'VERD',TILSKUDD) * g.l(B,R);
RESNORGE(R,'BRUK','TIL',STEP) = SUM((B,TILSKUDD), RESNORGE(R,B,TILSKUDD,STEP));
RESNORGE(R,B,INNSATS,STEP) = SIMDATA(R,B,'VERD',INNSATS) * g.l(B,R);
RESNORGE(R,'BRUK','KOST',STEP) = SUM((B,INNSATS), RESNORGE(R,B,INNSATS,STEP));
RESNORGE(R,B,'BRUK',STEP) $ SUM(PRDK, SIMDATA(R,B,'OMFG',PRDK)) = g.l(B,R);
RESNORGE(R,B,'HVET_N',STEP) = SIMDATA(R,B,'NITR','HVET');
RESNORGE(R,B,'RUGH_N',STEP) = SIMDATA(R,B,'NITR','RUGH');
RESNORGE(R,B,'BYGG_N',STEP) = SIMDATA(R,B,'NITR','BYGG');
RESNORGE(R,B,'HAVR_N',STEP) = SIMDATA(R,B,'NITR','HAVR');
RESNORGE(R,B,'GFFS_N',STEP) = SIMDATA(R,B,'NITR','GFFS');
RESNORGE(R,B,'GFFB_N',STEP) = SIMDATA(R,B,'NITR','GFFB');
RESNORGE(R,B,'GFOS_N',STEP) = SIMDATA(R,B,'NITR','GFOS');
RESNORGE(R,B,'GFOB_N',STEP) = SIMDATA(R,B,'NITR','GFOB');
RESNORGE(R,B,'GFIB_N',STEP) = SIMDATA(R,B,'NITR','GFIB');
RESNORGE(M,'MELK','BOND',STEP) = PROD_MEI(M);
RESNORGE(M,'KJOT','BOND',STEP) = PROD_SLK(M);
*
* Skyggepriser Handlingsrom
RESNORGE('NORGE','MAT','OMFG',STEP) = EQDIETT.l('ENER');
RESNORGE('NORGE','MAT','NEDR',STEP) = EQDIETT.lo('ENER');
RESNORGE('NORGE','MAT','AVVK',STEP) $ EQDIETT.l('ENER') = (EQDIETT.l('ENER') - EQDIETT.lo('ENER'))/ EQDIETT.l('ENER');
RESNORGE('NORGE','MAT','PRIS',STEP) = EQDIETT.m('ENER');
RESNORGE('NORGE','AREAL','OMFG',STEP) = EQAREAL.l;
RESNORGE('NORGE','ARTAK','OMFG',STEP) = EQAREAL.up;
RESNORGE('NORGE','ARANDL','OMFG',STEP) $ EQAREAL.up = EQAREAL.l / EQAREAL.up;
RESNORGE('NORGE','AREAL','NEDR',STEP) = EQAREAL.lo;
RESNORGE('NORGE','AREAL','AVVK',STEP) $ EQAREAL.l = (EQAREAL.l - EQAREAL.lo) / EQAREAL.l;
RESNORGE('NORGE','AREAL','PRIS',STEP) = EQAREAL.m;
RESNORGE(DG,'DISTRIKT','OMFG',STEP) = EQDGGLVAREAL.l(DG);
RESNORGE(DG,'DISTRIKT','NEDR',STEP) = EQDGGLVAREAL.lo(DG);
RESNORGE(DG,'DISTRIKT','AVVK',STEP) $ EQDGGLVAREAL.l(DG) = (EQDGGLVAREAL.l(DG) - EQDGGLVAREAL.lo(DG)) / EQDGGLVAREAL.l(DG);
RESNORGE(DG,'DISTRIKT','PRIS',STEP) = EQDGGLVAREAL.m(DG);
*
* Feeding practice
* Feed concentrates roughage and roughage area for ruminants
RESNORGE('NORGE','FDRM','DROV',STEP) = SUM((R,BGROV), SIMDATA(R,BGROV,'MNGD','FDRM') * g.l(BGROV,R));
RESNORGE('NORGE','FDRA','DROV',STEP) = SUM((R,BGROV), SIMDATA(R,BGROV,'MNGD','FDRA') * g.l(BGROV,R));
RESNORGE('NORGE','FGRV','DROV',STEP) = SUM((R,BGROV), SIMDATA(R,BGROV,'MNGD','FGRV') * g.l(BGROV,R));
RESNORGE('NORGE','GROV','DROV',STEP) = SUM((R,BGROV,GROV), SIMDATA(R,BGROV,'OMFG',GROV) * g.l(BGROV,R));
*
RESNORGE('Norge','Sum_FGRV',PRDK,STEP) = Sum((R,B), SIMDATA(R,B,'FGRV',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Sum_FDRM',PRDK,STEP) = Sum((R,B), SIMDATA(R,B,'FDRM',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Sum_FDRA',PRDK,STEP) = Sum((R,B), SIMDATA(R,B,'FDRA',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Sum_FSVN',PRDK,STEP) = Sum((R,B), SIMDATA(R,B,'FSVN',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Sum_FKYL',PRDK,STEP) = Sum((R,B), SIMDATA(R,B,'FKYL',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Sum_FEGG',PRDK,STEP) = Sum((R,B), SIMDATA(R,B,'FEGG',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
*
RESNORGE('Norge','Intens_FGRV',PRDK,STEP) $ (Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) > 1) = Sum((R,B), SIMDATA(R,B,'FGRV',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) / Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Intens_FDRM',PRDK,STEP) $ (Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) > 1) = Sum((R,B), SIMDATA(R,B,'FDRM',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) / Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Intens_FDRA',PRDK,STEP) $ (Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) > 1) = Sum((R,B), SIMDATA(R,B,'FDRA',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) / Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Intens_FSVN',PRDK,STEP) $ (Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) > 1) = Sum((R,B), SIMDATA(R,B,'FSVN',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) / Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Intens_FKYL',PRDK,STEP) $ (Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) > 1) = Sum((R,B), SIMDATA(R,B,'FKYL',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) / Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
RESNORGE('Norge','Intens_FEGG',PRDK,STEP) $ (Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) > 1) = Sum((R,B), SIMDATA(R,B,'FEGG',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) / Sum((R,B), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R));
*
* Feed concentrate per kg beef total
RESNORGE('NORGE','FDRA','STFKT',STEP) $ SUM((R,BSTFK), SIMDATA(R,BSTFK,'MNGD','STFK') * g.l(BSTFK,R)) = SUM((R,BSTFK), SIMDATA(R,BSTFK,'MNGD','FDRA') * g.l(BSTFK,R)) / SUM((R,BSTFK), SIMDATA(R,BSTFK,'MNGD','STFK') * g.l(BSTFK,R));
* Feed concentrate per kg beef from suckler cows
RESNORGE('NORGE','FDRA','STFKA',STEP) $ SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R)) = SUM(R, SIMDATA(R,'BAKY','MNGD','FDRA') * g.l('BAKY',R)) / SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R));
* Fodder area per dairy cow
RESNORGE('NORGE','GFOR','MKYR',STEP) $ SUM(R, SIMDATA(R,'BKMK','OMFG','MKYR') * g.l('BKMK',R)) = SUM((R,GROV), SIMDATA(R,'BKMK','OMFG',GROV) * g.l('BKMK',R)) / SUM(R, SIMDATA(R,'BKMK','OMFG','MKYR') * g.l('BKMK',R));
* Fodder area per livestock
RESNORGE('NORGE','GFOR','LVST',STEP) $ SUM((R,BSTFK,STORFE), SIMDATA(R,BSTFK,'OMFG',STORFE) * ATILVEKT(STORFE) * g.l(BSTFK,R))  = SUM((R,BSTFK,GROV), SIMDATA(R,BSTFK,'OMFG',GROV) * g.l(BSTFK,R)) / SUM((R,BSTFK,STORFE), SIMDATA(R,BSTFK,'OMFG',STORFE) * ATILVEKT(STORFE) * g.l(BSTFK,R));
* Fodder area per sheep
RESNORGE('NORGE','GFOR','SOEY',STEP) $ SUM(R, SIMDATA(R,'BSAU','OMFG','SOEY') * g.l('BSAU',R)) = SUM((R,GROV), SIMDATA(R,'BSAU','OMFG',GROV) * g.l('BSAU',R)) / SUM(R, SIMDATA(R,'BSAU','OMFG','SOEY') * g.l('BSAU',R));
* Slaktevekt ungdyr storfe
RESNORGE('NORGE','STFK','UNGD',STEP) $ SUM((R,B,UNGD)$(SAMEAS('BKMK',B) OR SAMEAS('BAKY',B)), SIMDATA(R,B,'OMFG',UNGD) * g.l(B,R)) = SUM((R,B,UNGD)$(SAMEAS('BKMK',B) OR SAMEAS('BAKY',B)),(SIMDATA(R,B,'STFK',UNGD) + SIMDATA(R,B,'KLVK',UNGD)) * SIMDATA(R,B,'OMFG',UNGD) * g.l(B,R)) / SUM((R,B,UNGD)$(SAMEAS('BKMK',B) OR SAMEAS('BAKY',B)), SIMDATA(R,B,'OMFG',UNGD) * g.l(B,R));
*
* Opptak av klimatiltak per bruk
RESNORGE(R,B,KLTK,STEP) = SIMDATA(R,B,'OPPTAK',KLTK);
* Andel klimatiltak p? regionsniv?
RESNORGE(R,'BRUK',KLTK,STEP)  $ SUM(B, g.l(B,R)) = SUM(B, SIMDATA(R,B,'OPPTAK',KLTK) * g.l(B,R)) / SUM(B, g.l(B,R));
* Andel klimatiltak p? bruksniv?
RESNORGE('NORGE',B,KLTK,STEP)  $ SUM(R, g.l(B,R)) = SUM(R, SIMDATA(R,B,'OPPTAK',KLTK) * g.l(B,R)) / SUM(R, g.l(B,R));
* Andel klimatiltak p? landsbasis
RESNORGE('NORGE','BRUK',KLTK,STEP)  $ SUM((R,B), g.l(B,R)) = SUM((R,B), SIMDATA(R,B,'OPPTAK',KLTK) * g.l(B,R)) / SUM((R,B), g.l(B,R));

* Utslipp pr aktivitet
RESNORGE(R,UTSLIPPRSK,'MNGD',STEP) = SUM((B,PRDK,UTSLIPPGHG)$UTSLIPPGHG_TIL_UTSLIPP(UTSLIPPGHG,UTSLIPPRSK), SIMDATA(R,B,PRDK,UTSLIPPRSK) * GHGPOTENSIAL(UTSLIPPGHG) * g.l(B,R));
RESNORGE('NITRATDIR',UTSLIPPRSK,'MNGD',STEP) = SUM((B,PRDK,UTSLIPPGHG,NITRATDIR)$UTSLIPPGHG_TIL_UTSLIPP(UTSLIPPGHG,UTSLIPPRSK), SIMDATA(NITRATDIR,B,PRDK,UTSLIPPRSK) * GHGPOTENSIAL(UTSLIPPGHG) * g.l(B,NITRATDIR));
RESNORGE('NORDSJOE',UTSLIPPRSK,'MNGD',STEP)  = RESNORGE('NITRATDIR',UTSLIPPRSK,'MNGD',STEP) + SUM((B,PRDK,UTSLIPPGHG,NORDSJOE)$UTSLIPPGHG_TIL_UTSLIPP(UTSLIPPGHG,UTSLIPPRSK), SIMDATA(NORDSJOE,B,PRDK,UTSLIPPRSK) * GHGPOTENSIAL(UTSLIPPGHG) * g.l(B,NORDSJOE));
RESNORGE('NITRATDIR','NTAP','MNGD',STEP) = SUM((B,NITRATDIR), SIMDATA(NITRATDIR,B,'MNGD','NTAP') * g.l(B,NITRATDIR));
RESNORGE('NORDSJOE','NTAP','MNGD',STEP)  = RESNORGE('NITRATDIR','NTAP','MNGD',STEP) + SUM((B,NORDSJOE), SIMDATA(NORDSJOE,B,'MNGD','NTAP') * g.l(B,NORDSJOE));
*
RESNORGE('PRDK',UTSLIPPRSK,PRDK,STEP) = SUM((R,B,UTSLIPPGHG)   $UTSLIPPGHG_TIL_UTSLIPP(UTSLIPPGHG,UTSLIPPRSK), KLIMADATA(R,B,PRDK,UTSLIPPRSK) * GHGPOTENSIAL(UTSLIPPGHG) * g.l(B,R));
RESNORGE('PRDK',UTSLIPPGHG,PRDK,STEP) = SUM(UTSLIPPRSK$UTSLIPPGHG_TIL_UTSLIPP(UTSLIPPGHG,UTSLIPPRSK), RESNORGE('PRDK',UTSLIPPRSK,PRDK,STEP));
RESNORGE('PRDK','UTSLIPPGHG',PRDK,STEP) = SUM(UTSLIPPGHG, RESNORGE('PRDK',UTSLIPPGHG,PRDK,STEP));
RESNORGE('PRDK',UTSLIPPRSK,'MNGD',STEP) = SUM((R,B,PRDK), KLIMADATA(R,B,PRDK,UTSLIPPRSK) * g.l(B,R));
RESNORGE('PRDK',UTSLIPPGHG,'MNGD',STEP) = SUM((R,B), SIMDATA(R,B,'MNGD',UTSLIPPGHG) * g.l(B,R));
RESNORGE('PRDK','UTSLIPPGHG','MNGD',STEP) = SUM((R,B,UTSLIPPGHG), SIMDATA(R,B,'MNGD',UTSLIPPGHG) * g.l(B,R) * GHGPOTENSIAL(UTSLIPPGHG));
*
* Utslipp pr vare
RESNORGE('VARE',UTSLIPPRSK,VARE,STEP)$(PRJBVARE(VARE) AND PRODUKT(VARE)) = SUM((R,B,UTSLIPPGHG)$UTSLIPPGHG_TIL_UTSLIPP(UTSLIPPGHG,UTSLIPPRSK), SIMDATA(R,B,UTSLIPPRSK,VARE) * GHGPOTENSIAL(UTSLIPPGHG) * g.l(B,R));
RESNORGE('VARE',UTSLIPPGHG,VARE,STEP)$(PRJBVARE(VARE) AND PRODUKT(VARE)) = SUM(UTSLIPPRSK$UTSLIPPGHG_TIL_UTSLIPP(UTSLIPPGHG,UTSLIPPRSK), RESNORGE('VARE',UTSLIPPRSK,VARE,STEP));
RESNORGE('VARE','UTSLIPPGHG',VARE,STEP)$(PRJBVARE(VARE) AND PRODUKT(VARE)) = SUM(UTSLIPPGHG, RESNORGE('VARE',UTSLIPPGHG,VARE,STEP));
RESNORGE('VARE',UTSLIPPGHG,'MNGD',STEP) = SUM(VARE$(PRJBVARE(VARE) AND PRODUKT(VARE)), RESNORGE('VARE',UTSLIPPGHG,VARE,STEP));
RESNORGE('VARE','UTSLIPPGHG','MNGD',STEP) = SUM(VARE$(PRJBVARE(VARE) AND PRODUKT(VARE)), RESNORGE('VARE','UTSLIPPGHG',VARE,STEP));
*
* Utslipp kraftforraavre
RESNORGE('KFRAV',UTSLIPPGHG,'MNGD',STEP) = SUM((M,KMOEL), h.l(KMOEL,M) * .15 * GHGMOELUTVARE(UTSLIPPGHG) * GHGPOTENSIAL(UTSLIPPGHG));
RESNORGE('KFRAV','UTSLIPPGHG','MNGD',STEP) = SUM(UTSLIPPGHG, RESNORGE('KFRAV',UTSLIPPGHG,'MNGD',STEP));
*
* Utslipp handelsgjoedsel
RESNORGE('HGJOD',UTSLIPPGHG,'MNGD',STEP) = SUM((R,B,HGJOD), SIMDATA(R,B,UTSLIPPGHG,HGJOD) * GHGPOTENSIAL(UTSLIPPGHG) * g.l(B,R));
RESNORGE('HGJOD','UTSLIPPGHG','MNGD',STEP) = SUM(UTSLIPPGHG, RESNORGE('HGJOD',UTSLIPPGHG,'MNGD',STEP));
*
* Utslipp knyttet til importert vare
RESNORGE('IMPT','UTSLIPPGHG','MNGD',STEP) =
SUM((M,VARE),(xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE));
*
RESNORGE('MNGD',VARE,B,STEP) = SUM(R, SIMDATA(R,B,'MNGD',VARE) * g.l(B,R) ) ;
RESNORGE('VERD',VARE,B,STEP) = SUM(R, SIMDATA(R,B,'VERD',VARE) * g.l(B,R) ) ;
*
* N?ringsinnhold produsert per bruk
RESNORGE(B,'MNGD',NSTOFF,STEP) = SUM((R,PRODUKT)$((NOT SAMEAS('BYGG',PRODUKT)) AND (NOT SAMEAS('HAVR',PRODUKT))), SIMDATA(R,B,'MNGD',PRODUKT) * NAERING(PRODUKT,NSTOFF) * g.l(B,R) ) ;
RESNORGE(B,'MNGD',PRODUKT,STEP)= SUM(R$((NOT SAMEAS('BYGG',PRODUKT)) AND (NOT SAMEAS('HAVR',PRODUKT))), SIMDATA(R,B,'MNGD',PRODUKT) * g.l(B,R) ) ;
*
* Utslipp per bruk
RESNORGE('NORGE','MNGD',UTSLIPPGHG,STEP) = SUM((R,B), SIMDATA(R,B,'MNGD',UTSLIPPGHG) * GHGPOTENSIAL(UTSLIPPGHG) * g.l(B,R));
RESNORGE(B,'MNGD',UTSLIPPGHG,STEP)       = SUM(R, SIMDATA(R,B,'MNGD',UTSLIPPGHG)     * GHGPOTENSIAL(UTSLIPPGHG) * g.l(B,R));
RESNORGE(R,'MNGD',UTSLIPPGHG,STEP)       = SUM(B, SIMDATA(R,B,'MNGD',UTSLIPPGHG)     * GHGPOTENSIAL(UTSLIPPGHG) * g.l(B,R));
*
** Landskapsindikatorer
** Regional indicator value equals national indicator value by default
** Shannon
*RESNORGE('NORGE','SHAN','VERD',STEP) $ SUM((R,FULLDYRK), RESNORGE(R,'OMFG',FULLDYRK,STEP)) =
*  MIN(1,
*SUM(FULLDYRK $ SUM(R, RESNORGE(R,'OMFG',FULLDYRK,STEP)),
*         - SUM(R, RESNORGE(R,'OMFG',FULLDYRK,STEP)) / SUM((R,FULLFULLDYRK), RESNORGE(R,'OMFG',FULLFULLDYRK,STEP))
*   * LOG10(SUM(R, RESNORGE(R,'OMFG',FULLDYRK,STEP)) / SUM((R,FULLFULLDYRK), RESNORGE(R,'OMFG',FULLFULLDYRK,STEP)))
*   ));
**
*RESNORGE(R,'SHAN','VERD',STEP) = RESNORGE('NORGE','SHAN','VERD',STEP) ;
* Fertilizing practise
* N run-off in kg pr ha
*RESNORGE('NORGE','NSUP','KORN',STEP) $ (SUM((R,B,KORN), SIMDATA(R,B,'OMFG',KORN)*g.l(B,R)) AND SUM((R,B,KORN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',KORN)*g.l(B,R))) = MIN(1, MAX(0, 2.25-0.97*LOG10(SUM((R,B,KORN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',KORN)*g.l(B,R)) / SUM((R,B,KORN), SIMDATA(R,B,'OMFG',KORN)*g.l(B,R)))));
*RESNORGE('NORGE','NSUP','GROV',STEP) $ (SUM((R,B,GROV), SIMDATA(R,B,'OMFG',GROV)*g.l(B,R)) AND SUM((R,B,GROV), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',GROV)*g.l(B,R))) = MIN(1, MAX(0, 2.25-0.97*LOG10(SUM((R,B,GROV), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',GROV)*g.l(B,R)) / SUM((R,B,GROV), SIMDATA(R,B,'OMFG',GROV)*g.l(B,R)))));
*RESNORGE('NORGE','NSUP','APLN',STEP) $ (SUM((R,B,APLN), SIMDATA(R,B,'OMFG',APLN)*g.l(B,R)) AND SUM((R,B,APLN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',APLN)*g.l(B,R))) = MIN(1, MAX(0, 2.25-0.97*LOG10(SUM((R,B,APLN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',APLN)*g.l(B,R)) / SUM((R,B,APLN), SIMDATA(R,B,'OMFG',APLN)*g.l(B,R)))));
**
*RESNORGE(R,'NSUP','KORN',STEP) = RESNORGE('NORGE','NSUP','KORN',STEP) ;
*RESNORGE(R,'NSUP','GROV',STEP) = RESNORGE('NORGE','NSUP','GROV',STEP) ;
*RESNORGE(R,'NSUP','APLN',STEP) = RESNORGE('NORGE','NSUP','APLN',STEP) ;
**
*RESNORGE(R,'NSUP','KORN',STEP) $ (SUM((B,KORN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',KORN)*g.l(B,R)) AND SUM((B,KORN), SIMDATA(R,B,'OMFG',KORN)*g.l(B,R))) =
*   MIN(1, MAX(0, 2.25-0.97*LOG10(SUM((B,KORN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',KORN)*g.l(B,R)) / SUM((B,KORN), SIMDATA(R,B,'OMFG',KORN)*g.l(B,R)))));
*RESNORGE(R,'NSUP','GROV',STEP) $ (SUM((B,GROV), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',GROV)*g.l(B,R)) AND  SUM((B,GROV), SIMDATA(R,B,'OMFG',GROV)*g.l(B,R))) =
*   MIN(1, MAX(0, 2.25-0.97*LOG10(SUM((B,GROV), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',GROV)*g.l(B,R)) / SUM((B,GROV), SIMDATA(R,B,'OMFG',GROV)*g.l(B,R)))));
*RESNORGE(R,'NSUP','APLN',STEP) $ (SUM((B,APLN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',APLN)*g.l(B,R)) AND SUM((B,APLN), SIMDATA(R,B,'OMFG',APLN)*g.l(B,R))) =
*   MIN(1, MAX(0, 2.25-0.97*LOG10(SUM((B,APLN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',APLN)*g.l(B,R)) / SUM((B,APLN), SIMDATA(R,B,'OMFG',APLN)*g.l(B,R)))));
*
* Ruminant stocking density
RESNORGE(R,B,'LUDen',STEP) $ SUM(GROV, omfang.l(R,B,GROV)) = (SUM(MHUSDYR, omfang.l(R,B,MHUSDYR) * LU(MHUSDYR)) + SUM(AHUSDYR, omfang.l(R,B,AHUSDYR) * LU(AHUSDYR))) / SUM(GROV, omfang.l(R,B,GROV)) ;
RESNORGE('NORGE',B,'LUDen',STEP) $ SUM(R$RESNORGE(R,B,'LUDen',STEP), g.l(B,R)) = SUM(R, RESNORGE(R,B,'LUDen',STEP) * g.l(B,R)) / SUM(R$RESNORGE(R,B,'LUDen',STEP), g.l(B,R));
RESNORGE('NORGE','BRUK','LUDen',STEP) $ SUM((R,B)$RESNORGE(R,B,'LUDen',STEP), g.l(B,R)) = SUM((R,B), RESNORGE(R,B,'LUDen',STEP) * g.l(B,R)) / SUM((R,B)$RESNORGE(R,B,'LUDen',STEP), g.l(B,R));
*
* in LU pr ha fodder area
RESNORGE('NORGE','RUMD','VERD',STEP) $ (SUM((R,B,PRDK), LU(PRDK)*SIMDATA(R,B,'OMFG',PRDK)*g.l(B,R)) AND (SUM((R,B,GROV), SIMDATA(R,B,'OMFG',GROV)*g.l(B,R)/10))) =
   MIN(1, MAX(0, 1.6-1.2*SQRT(SUM((R,B,PRDK), LU(PRDK)*SIMDATA(R,B,'OMFG',PRDK)*g.l(B,R)) / (SUM((R,B,GROV), SIMDATA(R,B,'OMFG',GROV)*g.l(B,R))/10))));
*
RESNORGE(R,'RUMD','VERD',STEP) = RESNORGE('NORGE','RUMD','VERD',STEP);
RESNORGE(R,'RUMD','VERD',STEP) $ (SUM((B,PRDK), LU(PRDK)*SIMDATA(R,B,'OMFG',PRDK)*g.l(B,R)) AND (SUM((B,GROV), SIMDATA(R,B,'OMFG',GROV)*g.l(B,R)/10))) =
 MIN(1, MAX(0, 1.6-1.2*SQRT(SUM((B,PRDK), LU(PRDK)*SIMDATA(R,B,'OMFG',PRDK)*g.l(B,R)) / (SUM((B,GROV), SIMDATA(R,B,'OMFG',GROV)*g.l(B,R))/10))));

** High Nature Farmland Index
** Use national share of crop group by default
*RESNORGE('NORGE','HNFI','KORN',STEP) $ SUM((R,PKGA), RESNORGE(R,'OMFG',PKGA,STEP)) = SUM((R,KORN), RESNORGE(R,'OMFG',KORN,STEP)) / SUM((R,PKGA), RESNORGE(R,'OMFG',PKGA,STEP)) ;
*RESNORGE('NORGE','HNFI','GROV',STEP) $ SUM((R,PKGA), RESNORGE(R,'OMFG',PKGA,STEP)) = SUM((R,GROV), RESNORGE(R,'OMFG',GROV,STEP)) / SUM((R,PKGA), RESNORGE(R,'OMFG',PKGA,STEP)) ;
*RESNORGE('NORGE','HNFI','APLN',STEP) $ SUM((R,PKGA), RESNORGE(R,'OMFG',PKGA,STEP)) = SUM((R,APLN), RESNORGE(R,'OMFG',APLN,STEP)) / SUM((R,PKGA), RESNORGE(R,'OMFG',PKGA,STEP)) ;
** Bound national crop shares to unity
*RESNORGE('NORGE','HNFI','PLNT',STEP) = RESNORGE('NORGE','HNFI','KORN',STEP) + RESNORGE('NORGE','HNFI','GROV',STEP) + RESNORGE('NORGE','HNFI','APLN',STEP);
*RESNORGE('NORGE','HNFI','KORN',STEP) $ RESNORGE('NORGE','HNFI','PLNT',STEP) = RESNORGE('NORGE','HNFI','KORN',STEP) * 1/RESNORGE('NORGE','HNFI','PLNT',STEP);
*RESNORGE('NORGE','HNFI','GROV',STEP) $ RESNORGE('NORGE','HNFI','PLNT',STEP) = RESNORGE('NORGE','HNFI','GROV',STEP) * 1/RESNORGE('NORGE','HNFI','PLNT',STEP);
*RESNORGE('NORGE','HNFI','APLN',STEP) $ RESNORGE('NORGE','HNFI','PLNT',STEP) = RESNORGE('NORGE','HNFI','APLN',STEP) * 1/RESNORGE('NORGE','HNFI','PLNT',STEP);
**
*RESNORGE(R,'HNFI','KORN',STEP) = RESNORGE('NORGE','HNFI','KORN',STEP) ;
*RESNORGE(R,'HNFI','GROV',STEP) = RESNORGE('NORGE','HNFI','GROV',STEP) ;
*RESNORGE(R,'HNFI','APLN',STEP) = RESNORGE('NORGE','HNFI','APLN',STEP) ;
**
** Use regional share if present in region
*RESNORGE(R,'HNFI','KORN',STEP) $ SUM(PKGA, RESNORGE(R,'OMFG',PKGA,STEP)) = SUM(KORN, RESNORGE(R,'OMFG',KORN,STEP)) / SUM(PKGA, RESNORGE(R,'OMFG',PKGA,STEP)) ;
*RESNORGE(R,'HNFI','GROV',STEP) $ SUM(PKGA, RESNORGE(R,'OMFG',PKGA,STEP)) = SUM(GROV, RESNORGE(R,'OMFG',GROV,STEP)) / SUM(PKGA, RESNORGE(R,'OMFG',PKGA,STEP)) ;
*RESNORGE(R,'HNFI','APLN',STEP) $ SUM(PKGA, RESNORGE(R,'OMFG',PKGA,STEP)) = SUM(APLN, RESNORGE(R,'OMFG',APLN,STEP)) / SUM(PKGA, RESNORGE(R,'OMFG',PKGA,STEP)) ;
** Bound regional crop shares to unity
*RESNORGE(R,'HNFI','PLNT',STEP) = RESNORGE(R,'HNFI','KORN',STEP) + RESNORGE(R,'HNFI','GROV',STEP) + RESNORGE(R,'HNFI','APLN',STEP);
*RESNORGE(R,'HNFI','KORN',STEP) $ RESNORGE(R,'HNFI','PLNT',STEP) = RESNORGE(R,'HNFI','KORN',STEP) * 1/RESNORGE(R,'HNFI','PLNT',STEP);
*RESNORGE(R,'HNFI','GROV',STEP) $ RESNORGE(R,'HNFI','PLNT',STEP) = RESNORGE(R,'HNFI','GROV',STEP) * 1/RESNORGE(R,'HNFI','PLNT',STEP);
*RESNORGE(R,'HNFI','APLN',STEP) $ RESNORGE(R,'HNFI','PLNT',STEP) = RESNORGE(R,'HNFI','APLN',STEP) * 1/RESNORGE(R,'HNFI','PLNT',STEP);
**
*RESNORGE(R,'HNFI','VERD',STEP) =
*   (RESNORGE(R,'SHAN','VERD',STEP) * RESNORGE(R,'NSUP','KORN',STEP)) * RESNORGE(R,'HNFI','KORN',STEP)
* + (RESNORGE(R,'RUMD','VERD',STEP) * RESNORGE(R,'NSUP','GROV',STEP)) * RESNORGE(R,'HNFI','GROV',STEP)
* +                                   RESNORGE(R,'NSUP','APLN',STEP)  * RESNORGE(R,'HNFI','APLN',STEP);
**
*RESNORGE('NORGE','HNFI','VERD',STEP)  =
*   (RESNORGE('NORGE','SHAN','VERD',STEP) * RESNORGE('NORGE','NSUP','KORN',STEP)) * RESNORGE('NORGE','HNFI','KORN',STEP)
* + (RESNORGE('NORGE','RUMD','VERD',STEP) * RESNORGE('NORGE','NSUP','GROV',STEP)) * RESNORGE('NORGE','HNFI','GROV',STEP)
* +                                         RESNORGE('NORGE','NSUP','APLN',STEP)  * RESNORGE('NORGE','HNFI','APLN',STEP);
*
* Ecosystem services and public health                                                           ;
RESNORGE(R,'ESLA','VERD',STEP) = landest.l(R)           ;
RESNORGE(R,'ESBD','VERD',STEP) = biodiv.l(R)            ;
RESNORGE(R,'ESCH','VERD',STEP) = culther.l(R)           ;
RESNORGE(R,'ESRC','VERD',STEP) = recreat.l(R)           ;
RESNORGE(KostGrp,'HELT','VERD',STEP) = 
   (( SUM(Vare$KostVare(KostGrp,Vare), x.l(Vare,'CONS','NORGE') * (1 - Sum(CCons, FoodLossWaste(VARE,CCons))/100)) * 1000 / (POPBAS * (1+POP)**(Y-%BAS%)) / 365)
   * DALYPerG(KostGrp,'act') * VSL) $ (GBDDiet(KostGrp) < TMREL(KostGrp))
+  ( (GBDDiet(KostGrp) - (SUM(Vare$KostVare(KostGrp,Vare), x.l(Vare,'CONS','NORGE') * (1 - Sum(CCons, FoodLossWaste(VARE,CCons))/100)) * 1000 / (POPBAS * (1+POP)**(Y-%BAS%)) / 365))
   * DALYPerG(KostGrp,'act') * VSL) $ (GBDDiet(KostGrp) > TMREL(KostGrp));
*
RESNORGE(FoodGrp,'MAAL','VERD',STEP) = EQTargetFoodConsMax.m(FoodGrp) + EQTargetFoodConsMin.m(FoodGrp) ;
RESNORGE(FoodGrp,'MAAL','MNGD',STEP) = POL('NORGE',FoodGrp,'MAAL');
*
RESNORGE('NORGE','ESLA','VERD',STEP) = SUM(R, RESNORGE(R,'ESLA','VERD',STEP));   
RESNORGE('NORGE','ESBD','VERD',STEP)  = SUM(R,  RESNORGE(R,'ESBD','VERD',STEP));    
RESNORGE('NORGE','ESCH','VERD',STEP) = SUM(R, RESNORGE(R,'ESCH','VERD',STEP));   
RESNORGE('NORGE','ESRC','VERD',STEP) = SUM(R, RESNORGE(R,'ESRC','VERD',STEP));   
RESNORGE('NORGE','HELT','VERD',STEP) = SUM(KostGrp, RESNORGE(KostGrp,'HELT','VERD',STEP));
*
* Naeringsinnhold i matvarer
RESNORGE('NORGE','PROD',NSTOFF,STEP) = SUM(PRODUKT$((NOT SAMEAS('BYGG',PRODUKT)) AND (NOT SAMEAS('HAVR',PRODUKT))), RESNORGE('PROD',PRODUKT,'MNGD',STEP) * NAERING(PRODUKT,NSTOFF)) / 1000;
RESNORGE('NORGE','KNSM',NSTOFF,STEP) = SUM(SLTVARE, RESNORGE('KNSM',SLTVARE,'MNGD',STEP) * NAERING(SLTVARE,NSTOFF)) / 1000;
RESNORGE('NORGE','IMPT',NSTOFF,STEP) = SUM(SLTVARE, (RESNORGE('IMPO',SLTVARE,'MNGD',STEP) + RESNORGE('IMPQ',SLTVARE,'MNGD',STEP) +
                                                     RESNORGE('IMPA',SLTVARE,'MNGD',STEP) + RESNORGE('IMPB',SLTVARE,'MNGD',STEP) +
                                                     RESNORGE('IMPA',SLTVARE,'MNGD',STEP)) * NAERING(SLTVARE,NSTOFF)) / 1000;
RESNORGE('NORGE','EKSP',NSTOFF,STEP) = SUM(SLTVARE, RESNORGE('EKSP',SLTVARE,'MNGD',STEP) * NAERING(SLTVARE,NSTOFF)) / 1000;
*
* Selvforsyning basert paa norsk produksjon i forhold til konsum og eksport
RESNORGE('NORGE','SFOR',NSTOFF,STEP) $ (RESNORGE('NORGE','EKSP',NSTOFF,STEP) + RESNORGE('NORGE','KNSM',NSTOFF,STEP)) =
                   RESNORGE('NORGE','PROD',NSTOFF,STEP) / (RESNORGE('NORGE','EKSP',NSTOFF,STEP) + RESNORGE('NORGE','KNSM',NSTOFF,STEP));
* Diett
RESNORGE('NORGE','DIET',NSTOFF,STEP) = RESNORGE('NORGE','KNSM',NSTOFF,STEP) / 365 / (POPBAS * (1 + POP)  ** (Y - %BAS%)) * 1000;
*
*
* Norskandel av matkonsumet
RESNORGE('NORGE','SSDG','VEGE',STEP) $ (x.l('POTE','CONS','NORGE') * NAERING('POTE','ENER') + SUM(HAGE,  x.l(HAGE,'CONS','NORGE')* NAERING(HAGE,'ENER'))) = (x.l('POTE','PRIM','NORGE') * NAERING('POTE','ENER') + SUM(HAGE,  x.l(HAGE,'PRIM','NORGE')* NAERING(HAGE,'ENER')))
                                     / (x.l('POTE','CONS','NORGE') * NAERING('POTE','ENER') + SUM(HAGE,  x.l(HAGE,'CONS','NORGE')* NAERING(HAGE,'ENER')));

RESNORGE('NORGE','SSDG','CERE',STEP) $ SUM(VARE $ (PRODUKT(VARE) AND MOELUTVARE(VARE)), x.l(VARE,'CONS','NORGE') * NAERING(VARE,'ENER')) =  SUM(VARE$(PRODUKT(VARE) AND MOELUTVARE(VARE)), x.l(VARE,'PRIM','NORGE') * NAERING(VARE,'ENER')) / SUM(VARE$(PRODUKT(VARE) AND MOELUTVARE(VARE)), x.l(VARE,'CONS','NORGE') * NAERING(VARE,'ENER'));

RESNORGE('NORGE','SSDG','OVEG',STEP) $ SUM(VARE $ (PLANSLTVARE(VARE) AND (NOT MOELUTVARE(VARE))), NAERING(VARE,'ENER') * x.l(VARE,'CONS','NORGE')) =  SUM(VARE $ (PLANSLTVARE(VARE) AND (NOT MOELUTVARE(VARE))), x.l(VARE,'PRIM','NORGE')*NAERING(VARE,'ENER')) / SUM(VARE $ (PLANSLTVARE(VARE) AND (NOT MOELUTVARE(VARE))), NAERING(VARE,'ENER') * x.l(VARE,'CONS','NORGE'));

RESNORGE('NORGE','SSDG','DARY',STEP) =  SUM(MEIINNVARE, NAERING(MEIINNVARE,'ENER') * x.l(MEIINNVARE,'PRIM','NORGE'))
                                     /  SUM((MEIDVARE,MEIR)$ SAMEAS(MEIDVARE,MEIR), NAERING(MEIDVARE,'ENER')*x.l(MEIDVARE,'CONS','NORGE') / MEIDATA(MEIDVARE,MEIR));

RESNORGE('NORGE','SSDG','MEAT',STEP) =  (SUM(SLKINNVARE$(SAMEAS('STFK',SLKINNVARE) OR SAMEAS('KLVK',SLKINNVARE)), NAERING(SLKINNVARE,'ENER')*x.l(SLKINNVARE,'PRIM','NORGE')) * SUM(RENTKJOETT, SLKDATA(RENTKJOETT,'SLST'))
                                       + SUM(SLKINNVARE$(SAMEAS('SAUK',SLKINNVARE) OR SAMEAS('GETK',SLKINNVARE)), NAERING(SLKINNVARE,'ENER')*x.l(SLKINNVARE,'PRIM','NORGE')) * SUM(RENTKJOETT, SLKDATA(RENTKJOETT,'SLSA'))
                                       + SUM(SLKINNVARE$SAMEAS('SVNK',SLKINNVARE),                                NAERING(SLKINNVARE,'ENER')*x.l(SLKINNVARE,'PRIM','NORGE')) * SUM(RENTKJOETT, SLKDATA(RENTKJOETT,'SLSV'))
                                       + (SUM((KSLK,M), h.l(KSLK,M)) * NAERING('FJRK','ENER') * SUM(M, x.l('FJRK','PRIM',M)) / SUM(M, x.l('FJRK','PRIM',M)+xi.l('FJRK',M)+xq.l('FJRK',M)+xqa.l('FJRK',M)+xqb.l('FJRK',M)+xqs.l('FJRK',M)))
                                       + (SUM((SSLK,M), SLKDATA('PRIN',SSLK) * h.l(SSLK,M)) * SUM(SLKINNVARE, NAERING(SLKINNVARE,'ENER')*x.l(SLKINNVARE,'PRIM','NORGE'))
                                       / SUM(SLKINNVARE, NAERING(SLKINNVARE,'ENER')*(x.l(SLKINNVARE,'PRIM','NORGE')+xi.l(SLKINNVARE,'NORGE')+xq.l(SLKINNVARE,'NORGE')+xqa.l(SLKINNVARE,'NORGE')+xqb.l(SLKINNVARE,'NORGE')+xqs.l(SLKINNVARE,'NORGE')))) )
                                       / (SUM(RENTKJOETT, NAERING(RENTKJOETT,'ENER')*x.l(RENTKJOETT,'CONS','NORGE'))
                                       + SUM(FJRKMKVARE, NAERING(FJRKMKVARE,'ENER')*x.l(FJRKMKVARE,'CONS','NORGE'))
                                       + SUM((BEARBKJOETT,FSLK)$SAMEAS(BEARBKJOETT,FSLK), NAERING(BEARBKJOETT,'ENER')*x.l(BEARBKJOETT,'CONS','NORGE')));

RESNORGE('NORGE','SSDG','BEEF',STEP) =  SUM(SLKINNVARE$(SAMEAS('STFK',SLKINNVARE) OR SAMEAS('KLVK',SLKINNVARE)), NAERING(SLKINNVARE,'ENER')*x.l(SLKINNVARE,'PRIM','NORGE')) * SUM(RENTKJOETT, SLKDATA(RENTKJOETT,'SLST'))
                                     /  SUM(VARE$(RENTKJOETT(VARE) AND SLKDATA(VARE,'SLST')), NAERING(VARE,'ENER')*x.l(VARE,'CONS','NORGE'));

RESNORGE('NORGE','SSDG','SHEP',STEP) =  SUM(SLKINNVARE$(SAMEAS('SAUK',SLKINNVARE) OR SAMEAS('GETK',SLKINNVARE)), NAERING(SLKINNVARE,'ENER')*x.l(SLKINNVARE,'PRIM','NORGE')) * SUM(RENTKJOETT, SLKDATA(RENTKJOETT,'SLSA'))
                                     /  SUM(VARE$(RENTKJOETT(VARE) AND SLKDATA(VARE,'SLSA')), NAERING(VARE,'ENER')*x.l(VARE,'CONS','NORGE'));

RESNORGE('NORGE','SSDG','PORK',STEP) =  SUM(SLKINNVARE$SAMEAS('SVNK',SLKINNVARE), NAERING(SLKINNVARE,'ENER')*x.l(SLKINNVARE,'PRIM','NORGE')) * SUM(RENTKJOETT, SLKDATA(RENTKJOETT,'SLSV'))
                                     /  SUM(VARE$(RENTKJOETT(VARE) AND SLKDATA(VARE,'SLSV')), NAERING(VARE,'ENER')*x.l(VARE,'CONS','NORGE'));

RESNORGE('NORGE','SSDG','POUL',STEP) =

         SUM((KSLK,M), h.l(KSLK,M)) * (SUM(M, x.l('FJRK','PRIM',M)) / SUM(M, x.l('FJRK','PRIM',M)+xi.l('FJRK',M)+xq.l('FJRK',M)+xqa.l('FJRK',M)+xqb.l('FJRK',M)+xqs.l('FJRK',M)))
       / SUM(FJRKMKVARE, x.l(FJRKMKVARE,'CONS','NORGE'));

RESNORGE('NORGE','SSDG','PRCM',STEP) =  (SUM((SSLK,M), SLKDATA('PRIN',SSLK) * h.l(SSLK,M)) * SUM(SLKINNVARE, NAERING(SLKINNVARE,'ENER')*x.l(SLKINNVARE,'PRIM','NORGE'))
        / SUM(SLKINNVARE, NAERING(SLKINNVARE,'ENER')*(x.l(SLKINNVARE,'PRIM','NORGE')+xi.l(SLKINNVARE,'NORGE')+xq.l(SLKINNVARE,'NORGE')+xqa.l(SLKINNVARE,'NORGE')+xqb.l(SLKINNVARE,'NORGE')+xqs.l(SLKINNVARE,'NORGE'))) )
                                      / SUM((BEARBKJOETT,FSLK)$SAMEAS(BEARBKJOETT,FSLK), NAERING(BEARBKJOETT,'ENER')*x.l(BEARBKJOETT,'CONS','NORGE') / SLKDATA('PRIN',FSLK));

RESNORGE('NORGE','SSDG','EGGS',STEP) $ (NAERING('EGGS','ENER')*x.l('EGGS','CONS','NORGE')) =  NAERING('EGGS','ENER')*x.l('EGGS','PRIM','NORGE') / (NAERING('EGGS','ENER')*x.l('EGGS','CONS','NORGE'));


RESNORGE('NORGE','SFOR','PROD',STEP) =  SUM(PRODUKT$((NOT SAMEAS('BYGG',PRODUKT)) AND (NOT SAMEAS('HAVR',PRODUKT))), x.l(PRODUKT,'PRIM','NORGE'));
RESNORGE('NORGE','SFOR','KONS',STEP) =  SUM(SLTVARE,                                                                 x.l(SLTVARE,'CONS','NORGE'));

* Forbalanse
RESNORGE('PRKN','FORB','FFEM',STEP) =  SUM(FFEMKORN, RESNORGE('PROD',FFEMKORN,'MNGD',STEP) * NAERING(FFEMKORN,'FFEM'));
RESNORGE('PRGR','FORB','FFEM',STEP) =  SUM(FFEMGRAS, RESNORGE('PROD',FFEMGRAS,'MNGD',STEP) * NAERING(FFEMGRAS,'FFEM'));
RESNORGE('PRAP','FORB','FFEM',STEP) =  SUM(FFEMAPLN, RESNORGE('PROD',FFEMAPLN,'MNGD',STEP) * NAERING(FFEMAPLN,'FFEM'));
RESNORGE('IMPF','FORB','FFEM',STEP) =  SUM(FFEMPROD,
                                                      ( RESNORGE('IMPO',FFEMPROD,'MNGD',STEP) + RESNORGE('IMPQ',FFEMPROD,'MNGD',STEP)
                                                      + RESNORGE('IMPA',FFEMPROD,'MNGD',STEP) + RESNORGE('IMPB',FFEMPROD,'MNGD',STEP)
                                                      + RESNORGE('IMPS',FFEMPROD,'MNGD',STEP)) * NAERING(FFEMPROD,'FFEM'));

RESNORGE('IMPS','FORB','FFEM',STEP) = SUM(MOELUTVARE, z.l(MOELUTVARE,'NORGE'))-(SUM(VARE$MOELFLYT('FFKN',VARE), RESNORGE('PROD',VARE,'MNGD',STEP) * NAERING('FFKN','FFEM')));

RESNORGE('FBAL','FORB','FFEM',STEP) $ (RESNORGE('PRKN','FORB','FFEM',STEP) + RESNORGE('PRGR','FORB','FFEM',STEP) + RESNORGE('PRAP','FORB','FFEM',STEP)
                                     + RESNORGE('IMPF','FORB','FFEM',STEP) + RESNORGE('IMPS','FORB','FFEM',STEP))  =
                                      (RESNORGE('PRKN','FORB','FFEM',STEP) + RESNORGE('PRGR','FORB','FFEM',STEP) + RESNORGE('PRAP','FORB','FFEM',STEP)) /
                                      (RESNORGE('PRKN','FORB','FFEM',STEP) + RESNORGE('PRGR','FORB','FFEM',STEP) + RESNORGE('PRAP','FORB','FFEM',STEP)
                                     + RESNORGE('IMPF','FORB','FFEM',STEP) + RESNORGE('IMPS','FORB','FFEM',STEP));

* Sjekk grovforbalanse
RESNORGE('BAS-FGRV',HUSDYR,'MNGD',STEP)$SUM(R, IOBAS('FGRV',HUSDYR,R)) =  SUM(R, ROMFGBAS(HUSDYR,R) * IOBAS('FGRV',HUSDYR,R)) / 1000;
RESNORGE('BAS-FGRV',HUSDYR,'OMFG',STEP)$SUM(R, IOBAS('FGRV',HUSDYR,R)) =  SUM(R, ROMFGBAS(HUSDYR,R));
RESNORGE('BAS-FGRV',HUSDYR,'KOEF',STEP) $ (RESNORGE('BAS-FGRV',HUSDYR,'OMFG',STEP) GT EPS) =  RESNORGE('BAS-FGRV',HUSDYR,'MNGD',STEP) / RESNORGE('BAS-FGRV',HUSDYR,'OMFG',STEP) * 1000;

RESNORGE('BAS-FGRV','NORGE','MNGD',STEP) = SUM(HUSDYR, RESNORGE('BAS-FGRV',HUSDYR,'MNGD',STEP));
RESNORGE('BAS-FGRV','NORGE','OMFG',STEP) = SUM(HUSDYR, RESNORGE('BAS-FGRV',HUSDYR,'OMFG',STEP));
RESNORGE('BAS-FGRV','NORGE','KOEF',STEP) $ (RESNORGE('BAS-FGRV','NORGE','OMFG',STEP) GT EPS) =  RESNORGE('BAS-FGRV','NORGE','MNGD',STEP) / RESNORGE('BAS-FGRV','NORGE','OMFG',STEP) * 1000;

RESNORGE('MOD-FGRV',HUSDYR,'MNGD',STEP) $ SUM(R, IOBAS('FGRV',HUSDYR,R)) = SUM((R,B), SIMDATA(R,B,'OMFG',HUSDYR) * g.l(B,R) * intens.l(R,'FGRV',HUSDYR)) / 1000;
RESNORGE('MOD-FGRV',HUSDYR,'OMFG',STEP) $ SUM(R, IOBAS('FGRV',HUSDYR,R)) = SUM((R,B), SIMDATA(R,B,'OMFG',HUSDYR) * g.l(B,R));
RESNORGE('MOD-FGRV',HUSDYR,'KOEF',STEP) $ (RESNORGE('MOD-FGRV',HUSDYR,'OMFG',STEP) GT EPS) =  RESNORGE('MOD-FGRV',HUSDYR,'MNGD',STEP) / RESNORGE('MOD-FGRV',HUSDYR,'OMFG',STEP) * 1000;

RESNORGE('MOD-FGRV','NORGE','MNGD',STEP) = SUM(HUSDYR, RESNORGE('MOD-FGRV',HUSDYR,'MNGD',STEP));
RESNORGE('MOD-FGRV','NORGE','OMFG',STEP) = SUM(HUSDYR, RESNORGE('MOD-FGRV',HUSDYR,'OMFG',STEP));
RESNORGE('MOD-FGRV','NORGE','KOEF',STEP) $ (RESNORGE('MOD-FGRV','NORGE','OMFG',STEP) GT EPS) =  RESNORGE('MOD-FGRV','NORGE','MNGD',STEP) / RESNORGE('MOD-FGRV','NORGE','OMFG',STEP) * 1000;
*
* Fodder production and consumption management
RESNORGE(R,B,'FGRV_PROD',STEP) =  SUM(GROV, SIMDATA(R,B,'MNGD','GROV'));
RESNORGE(R,B,'FGRV_KONS',STEP) =  SUM(GROV, SIMDATA(R,B,'MNGD','FGRV'));
RESNORGE(R,'BRUK','FGRV_PROD',STEP) =  SUM((GROV,B), SIMDATA(R,B,'MNGD','GROV') * g.l(B,R));
RESNORGE(R,'BRUK','FGRV_KONS',STEP) =  SUM((GROV,B), SIMDATA(R,B,'MNGD','FGRV') * g.l(B,R));
RESNORGE('Norge',B,'FGRV_PROD',STEP) =  SUM((GROV,R), SIMDATA(R,B,'MNGD','GROV') * g.l(B,R));
RESNORGE('Norge',B,'FGRV_KONS',STEP) =  SUM((GROV,R), SIMDATA(R,B,'MNGD','FGRV') * g.l(B,R));
RESNORGE('Norge','Bruk','FGRV_PROD',STEP) =  SUM((GROV,R,B)$RB(R,B), SIMDATA(R,B,'MNGD','GROV') * g.l(B,R));
RESNORGE('Norge','Bruk','FGRV_KONS',STEP) =  SUM((GROV,R,B)$RB(R,B), SIMDATA(R,B,'MNGD','FGRV') * g.l(B,R));
*
* Etterspoersel
RESNORGE(M,VARE,'ETRM',STEP) = x.l(VARE,'CONS',M);
RESNORGE(M,VARE,'ETRP',STEP) = p.l(VARE,'CONS',M);
RESNORGE(M,VARE,'ETRV',STEP) = x.l(VARE,'CONS',M) * p.l(VARE,'CONS',M);
RESNORGE('NORGE',VARE,'ETRM',STEP) = SUM(M, x.l(VARE,'CONS',M));
RESNORGE('NORGE',VARE,'ETRV',STEP) = SUM(M, x.l(VARE,'CONS',M) * p.l(VARE,'CONS',M));
RESNORGE('NORGE',VARE,'ETRP',STEP) $ RESNORGE('NORGE',VARE,'ETRM',STEP) = RESNORGE('NORGE',VARE,'ETRV',STEP)  / RESNORGE('NORGE',VARE,'ETRM',STEP) ;
RESNORGE('NORGE',VARE,'P_CAL',STEP) = RESNORGE('NORGE',VARE,'ETRP',STEP);
RESNORGE('NORGE',VARE,'P_OBS',STEP) = P0(VARE);
RESNORGE('NORGE',VARE,'X_CAL',STEP) = RESNORGE('NORGE',VARE,'ETRM',STEP);
RESNORGE('NORGE',VARE,'X_OBS',STEP) = SUM(M, X0(VARE,M));
*
* Jordbrukssektor som helhet
RESNORGE('TOTK','SINN','VERD',STEP) = SUM((VARE,M)$SLTVARE(VARE), p.l(VARE,'CONS',M)*x.l(VARE,'CONS',M));
RESNORGE('TOTK','XINN','VERD',STEP) = SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE)), (PE(VARE)-TRKOSTEKS(VARE,M))*xe.l(VARE,M));
RESNORGE('TOTK','IORD','VERD',STEP) = SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE)), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
RESNORGE('TOTK','IKVT','VERD',STEP) = SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE)), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                    + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE)), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                    + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE)), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                    + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE)), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('TOTK','TENDO','VERD',STEP)= (EQARBEID.l * (-EQARBEID.m ))
                                    + SUM(R, EQRARBEID.l(R) * (-EQRARBEID.m(R)    ))
                                    + SUM(SD, EQSDARBEID.l(SD) * (-EQSDARBEID.m(SD)  ))
                                    + SUM(M, EQMARBEID.l(M) * (-EQMARBEID.m(M)  ))
                                    + SUM(PRDK, EQPRDKGLV.l(PRDK) * (-EQPRDKGLV.m(PRDK) ))
                                    + SUM(M, EQMKORNGLV.l(M) * (-EQMKORNGLV.m(M) ))
                                    + (EQAREAL.l * (-EQAREAL.m ))
                                    + (EQAREAGLV.l * (-EQAREAGLV.m ))
                                    + SUM(M, EQAREAMGLV.l(M) * (-EQAREAMGLV.m(M)  ))
                                    + (EQKORNGLV.l * (-EQKORNGLV.m ))
                                    + (EQGROVGLV.l * (-EQGROVGLV.m ))
                                    + SUM(FULLDYRK, EQFULLGLV.l(FULLDYRK) * (-EQFULLGLV.m(FULLDYRK) ))
                                    + SUM(F, EQOVERGLV.l(F) * (-EQOVERGLV.m(F) ))
                                    + (EQXPKORNGLV.l * (-EQXPKORNGLV.m ))
                                    + (EQXPSTKKGLV.l * (-EQXPSTKKGLV.m ))
                                    + SUM(F, EQXPFKORNGLV.l(F) * (-EQXPFKORNGLV.m(F)))
                                    + SUM(R, EQXPRKORNGLV.l(R) * (-EQXPRKORNGLV.m(R)))
                                    + SUM(DG, EQDGGLVAREAL.l(DG) * (-EQDGGLVAREAL.m(DG)    ))
                                    + SUM((PRDK,SD), EQPRDKSDGLV.l(PRDK,SD) * (-EQPRDKSDGLV.m(PRDK,SD)))
                                    + SUM((PRDK,F), EQPRDKFGLV.l(PRDK,F) * (-EQPRDKFGLV.m(PRDK,F)  ))
                                    + SUM((PRDK,M), EQPRDKMGLV.l(PRDK,M) * (-EQPRDKMGLV.m(PRDK,M)  ))
                                    + SUM(F, EQFKORNGLV.l(F) * (-EQFKORNGLV.m(F)))
                                    + SUM(F, EQFGROVGLV.l(F) * (-EQFGROVGLV.m(F)))
                                    + SUM(VARE, EQXPGLV.l(VARE) * (-EQXPGLV.m(VARE)       ))
                                    + SUM((VARE,SD), EQXPSDGLV.l(VARE,SD) * (-EQXPSDGLV.m(VARE,SD)))
                                    + SUM((VARE,F),  EQXPFGLV.l(VARE,F)   * (-EQXPFGLV.m(VARE,F)))
                                    + SUM((VARE,R),  EQXPRGLV.l(VARE,R)   * (-EQXPRGLV.m(VARE,R)))
                                    + SUM(NSTOFF, EQPRODSFOR.l(NSTOFF) * (-EQPRODSFOR.m(NSTOFF)));
*RESNORGE('TOTK','KOSTH','VERD',STEP) = SUM(NSTOFF, EQKONSSFOR.l(NSTOFF) * (-EQKONSSFOR.m(NSTOFF)))  ;
*
RESNORGE('TOTK','TTIL','VERD',STEP) = SUM(VARE$TILSKUDD(VARE), x.l(VARE,'PRIM','NORGE'))
                                    + SUM((MM,MOELINNVARE), uttr.l(MOELINNVARE,'OEST',MM) * SUM(R$R_til_M(MM,R), INNFRAKTTIL(R,MOELINNVARE)))
                                    + SUM((PRODUKT,M), x.l(PRODUKT,'PRIM',M) * SUM(R$R_til_M(M,R), INNFRAKTTIL(R,PRODUKT)))
                                    + SUM((M,VARE), x.l(VARE,'PRIM',M) * PRISNED(VARE))
                                    + RESNORGE('TOTK','TENDO','VERD',STEP);
RESNORGE('TOTK','TFRK','VERD',STEP) = SUM((PRODUKT,M), x.l(PRODUKT,'PRIM',M) * SUM(R$R_til_M(M,R), INNFRAKTTIL(R,PRODUKT)))+ SUM((M,INNSATS), z.l(INNSATS,M) * SUM(R$R_til_M(M,R), INNFRAKTTIL(R,INNSATS)));
RESNORGE('TOTK','TPNS','VERD',STEP) = SUM((M,VARE), x.l(VARE,'PRIM',M) * PRISNED(VARE));

RESNORGE('TOTK','TBRK','VERD',STEP) = SUM((R,B), g.l(B,R) * (-g.m(B,R)));
*
RESNORGE('TOTK','XTIL','VERD',STEP) = SUM((MEIXVARE,M), EKSSUB(MEIXVARE) * xe.l(MEIXVARE,M));
RESNORGE('TOTK','KOST','VERD',STEP) = SUM((VARE,R)$INNSATS(VARE), x.l(VARE,'PRIM',R)) - SUM((VARE,R)$INNSVL(VARE),  x.l(VARE,'PRIM',R));
RESNORGE('TOTK','ARKP','VERD',STEP) = SUM((VARE,R)$INNSVL(VARE),  x.l(VARE,'PRIM',R));
RESNORGE('TOTK','KAPB','VERD',STEP) = SUM(R, x.l('KAPB','PRIM',R));
RESNORGE('TOTK','KAPM','VERD',STEP) = SUM(R, x.l('KAPM','PRIM',R));
RESNORGE('TOTK','KAPD','VERD',STEP) = SUM(R, x.l('KAPD','PRIM',R));
RESNORGE('TOTK','KAPJ','VERD',STEP) = SUM(R, x.l('KAPJ','PRIM',R));
RESNORGE('TOTK','KAPK','VERD',STEP) = SUM(R, x.l('KAPK','PRIM',R));
RESNORGE('TOTK','ARBF','VERD',STEP) = SUM(R, x.l('ARBF','PRIM',R));
RESNORGE('TOTK','ARBL','VERD',STEP) = SUM(R, x.l('ARBL','PRIM',R));
RESNORGE('TOTK','SLK','VERD',STEP) =  SUM((SLK,M),  SIMDATA(M,SLK,'PRIS','Y') * h.l(SLK,M));
RESNORGE('TOTK','MEIR','VERD',STEP) = SUM((MEIR,M), SIMDATA(M,MEIR,'PRIS','Y') * h.l(MEIR,M));
RESNORGE('TOTK','NTIU','VERD',STEP) = SUM((M,FP), IU(FP) * h.l(FP,M));
RESNORGE('TOTK','NTPU','VERD',STEP) = SUM((MEIR,M), PUSATS(MEIR) * h.l(MEIR,M))
                                + SUM((M,MEIR,VARE)$MEIINNVARE(VARE), MEIDATA(VARE,MEIR) * PUSATS(MEIR) * xe.l(VARE,M))
                                + SUM((M,VARE)$MEIINNVARE(VARE), PUINNT(M) * x.l(VARE,'PRIM',M))
                                + SUM((MEIR,M), PUDISB(MEIR,M) * h.l(MEIR,M))
                                + SUM((MEIR,VARE,M),   PUBISATS(VARE) * h.l(MEIR,M) * MEIDATA(VARE,MEIR));
RESNORGE('TOTK','OMST','VERD',STEP) = SUM(VARE, OMSET(VARE) * x.l(VARE,'PRIM','NORGE'));
RESNORGE('TOTK','MOEL','VERD',STEP) = SUM((M,MOEL), SIMDATA(M,MOEL,'PRIS','Y') * h.l(MOEL,M));
RESNORGE('TOTK','AIND','VERD',STEP) = SUM((VARE,M)$SLTVARE(VARE), FK(VARE,M)*x.l(VARE,'CONS',M));
RESNORGE('TOTK','KFAV','VERD',STEP) = SUM((MOELUTVARE,R), z.l(MOELUTVARE,R) * KFORAVG(R,MOELUTVARE)) + SUM(R, z.l('NITG',R) * KFORAVG(R,'NITG'));
RESNORGE('TOTK',MOELUTVARE,'AVG-VERD',STEP) = SUM(R, z.l(MOELUTVARE,R) * KFORAVG(R,MOELUTVARE));
RESNORGE('TOTK',MOELUTVARE,'AVG-MNGD',STEP) = SUM(R, z.l(MOELUTVARE,R));
RESNORGE('TOTK',MOELUTVARE,'AVG-PRIS',STEP) $ SUM(R, z.l(MOELUTVARE,R)) = SUM(R, z.l(MOELUTVARE,R) * KFORAVG(R,MOELUTVARE)) / SUM(R, z.l(MOELUTVARE,R));

RESNORGE('TOTK','TRSP','VERD',STEP) = SUM((VARE,M,MM)$(SLTVARE(VARE) OR SAMEAS('PRIN',VARE) OR SAMEAS('FDRM',VARE) OR SAMEAS('FDRA',VARE)
                       OR SAMEAS('FSVN',VARE) OR SAMEAS('FKYL',VARE)  OR SAMEAS('FEGG',VARE)), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));
RESNORGE('TOTK','KNSO','VERD',STEP) = 0.5 * SUM((VARE,SVARE,M), x.l(VARE,'CONS',M)*invBeta(VARE,SVARE,M)*x.l(SVARE,'CONS',M));
RESNORGE('TOTK','OBJV','VERD',STEP) = obj.l ;
RESNORGE('TOTK','RARE','VERD',STEP) = SUM(R, EQRRTAKAREAL.l(R) * EQRRTAKAREAL.m(R)) ;
RESNORGE('TOTK','RGRV','VERD',STEP) = SUM(R, EQRRTAKGROV.l(R)  * EQRRTAKGROV.m(R)) ;
RESNORGE('TOTK','RMKN','VERD',STEP) = SUM(R, EQRRTAKMTKRN.l(R) * EQRRTAKMTKRN.m(R)) ;
RESNORGE('TOTK','RKRN','VERD',STEP) = SUM(R, EQRRTAKKORN.l(R) * EQRRTAKKORN.m(R)) ;
RESNORGE('TOTK','RFUL','VERD',STEP) = SUM(R, EQRRTAKFULLJ.l(R) * EQRRTAKFULLJ.m(R));
RESNORGE('TOTK','RGUB','VERD',STEP) = SUM(R, EQRRTAKGFUB.l(R) * EQRRTAKGFUB.m(R)) ;
*RESNORGE('TOTK','RPRK','VERD',STEP) = SUM((R,PRDK), EQRRTAKVEKST.l(R,PRDK) * EQRRTAKVEKST.m(R,PRDK));
RESNORGE('TOTK','RNKN','VERD',STEP) = EQTAKKORN.l * EQTAKKORN.m ;
RESNORGE('TOTK','RENT','VERD',STEP) = RESNORGE('TOTK','RARE','VERD',STEP)
                                    + RESNORGE('TOTK','RMKN','VERD',STEP)
                                    + RESNORGE('TOTK','RKRN','VERD',STEP)
                                    + RESNORGE('TOTK','RFUL','VERD',STEP)
                                    + RESNORGE('TOTK','RGRV','VERD',STEP)
                                    + RESNORGE('TOTK','RGUB','VERD',STEP)
                                    + RESNORGE('TOTK','RNKN','VERD',STEP);
*
RESNORGE(R,'RENT','VERD',STEP) =   EQRRTAKAREAL.l(R) * EQRRTAKAREAL.m(R)
                                 + EQRRTAKGROV.l(R)  * EQRRTAKGROV.m(R)
                                 + EQRRTAKFULLJ.l(R) * EQRRTAKFULLJ.m(R)
                                 + EQRRTAKGFUB.l(R) * EQRRTAKGFUB.m(R);
                                 
*                                 + SUM(PRDK, EQRRTAKVEKST.l(R,PRDK) * EQRRTAKVEKST.m(R,PRDK));

RESNORGE('TOTK','SPRD','VERD',STEP) = SUM((R,B)$(SIMDATA(R,B,'OMFG','SPRE') < 0), SIMDATA(R,B,'OMFG','SPRE') * g.l(B,R) * EQSPRED.m(R));
RESNORGE('TOTK','SPRD','MNGD',STEP) = SUM(R$(EQSPRED.l(R) = 0), SUM((B,PRDK)$(SPREDKOEFF(PRDK) > 0), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)));
RESNORGE('TOTK','SPRD','ANDL',STEP) = RESNORGE('TOTK','SPRD','MNGD',STEP)  / SUM((R,B,PRDK)$(SPREDKOEFF(PRDK) > 0), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) ;



RESNORGE(F,'KVOT','VERD',STEP) = EQXPKMLKTAK.l(F) * EQXPKMLKTAK.m(F) + EQXPGMLKTAK.l(F) * EQXPGMLKTAK.m(F);

RESNORGE('TOTK','KVOT','VERD',STEP) = SUM(F, EQXPKMLKTAK.l(F) * EQXPKMLKTAK.m(F)) + SUM(F, EQXPGMLKTAK.l(F) * EQXPGMLKTAK.m(F));
RESNORGE('TOTK','IRNT','VERD',STEP) = SUM(VARE, xi.l(VARE,'NORGE') * xi.m(VARE,'NORGE'))
                                    + SUM(VARE, xq.l(VARE,'NORGE') * xq.m(VARE,'NORGE'))
                                    + SUM(VARE, xqa.l(VARE,'NORGE') * xqa.m(VARE,'NORGE'))
                                    + SUM(VARE, xqb.l(VARE,'NORGE') * xqb.m(VARE,'NORGE'))
                                    + SUM(VARE, xqs.l(VARE,'NORGE') * xqs.m(VARE,'NORGE'));
RESNORGE(R,B,'PROF',STEP) = SIMDATA(R,B,'VERD','PROF');
RESNORGE(R,B,'MDST',STEP) = SIMDATA(R,B,'MDST',STEP);
RESNORGE('TOTK','BINT','VERD',STEP) = SUM((R,B,PRODUKT),  SIMDATA(R,B,'MNGD',PRODUKT)  * SIMDATA(R,PRODUKT,'TOTP','Y') * g.l(B,R) ) ;
RESNORGE('TOTK','BTIL','VERD',STEP) = SUM((R,B,TILSKUDD), SIMDATA(R,B,'VERD',TILSKUDD) * g.l(B,R) );
RESNORGE('TOTK','BKST','VERD',STEP) = SUM((R,B,INNSATS),  SIMDATA(R,B,'VERD',INNSATS)  * g.l(B,R) );
RESNORGE('TOTK','BRNT','VERD',STEP) = RESNORGE('TOTK','BINT','VERD',STEP) + RESNORGE('TOTK','BTIL','VERD',STEP) - RESNORGE('TOTK','BKST','VERD',STEP);
RESNORGE('TOTK','MIAV','VERD',STEP) = ghgavgift.l + emis_n.l;
*
*
****************************
* Regnskap for melkesektoren
****************************
RESNORGE('MEIK','MINT','VERD',STEP) = SUM((M,VARE)$ MEIDVARE(VARE), p.l(VARE,'CONS',M)*x.l(VARE,'CONS',M));
RESNORGE('MEIK','XINT','VERD',STEP) = SUM((M,VARE)$ MEIVARE(VARE), (PE(VARE)-TRKOSTEKS(VARE,M))*xe.l(VARE,M));
RESNORGE('MEIK','IUTG','VERD',STEP) = SUM((M,VARE)$ MEIVARE(VARE), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
RESNORGE('MEIK','IUTQ','VERD',STEP) = SUM((M,VARE)$ MEIVARE(VARE), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                    + SUM((M,VARE)$ MEIVARE(VARE), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                    + SUM((M,VARE)$ MEIVARE(VARE), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                    + SUM((M,VARE)$ MEIVARE(VARE), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('MEIK','XTIL','VERD',STEP) = SUM((MEIXVARE,M), EKSSUB(MEIXVARE) * xe.l(MEIXVARE,M));
RESNORGE('MEIK','TRTL','VERD',STEP) = SUM((R,VARE)$ MEIVARE(VARE), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE));
RESNORGE('MEIK','NTPU','VERD',STEP) =  SUM((MEIR,M), PUSATS(MEIR) * h.l(MEIR,M))
                                     + SUM((M,MEIR,VARE)$MEIINNVARE(VARE), MEIDATA(VARE,MEIR) * PUSATS(MEIR) * xe.l(VARE,M))
                                     + SUM((M,VARE)$MEIINNVARE(VARE), PUINNT(M) * x.l(VARE,'PRIM',M))
                                     + SUM((MEIR,M), PUDISB(MEIR,M) * h.l(MEIR,M))
                                     + SUM((MEIR,VARE,M), PUBISATS(VARE) * h.l(MEIR,M) * MEIDATA(VARE,MEIR));
RESNORGE('MEIK','IUMK','VERD',STEP) = SUM((M,MEIR), IUMEIR(MEIR) * h.l(MEIR,M));
RESNORGE('MEIK','OMST','VERD',STEP) = SUM(VARE$MEIINNVARE(VARE), OMSET(VARE) * x.l(VARE,'PRIM','NORGE'));
RESNORGE('MEIK','PROC','VERD',STEP) = SUM((M,MEIR), SIMDATA(M,MEIR,'PRIS','Y') * h.l(MEIR,M));
RESNORGE('MEIK','TRSP','VERD',STEP) = SUM((VARE,M,MM)$MEIVARE(VARE), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));
RESNORGE('MEIK','RAAV','VERD',STEP)  = SUM((R,B,VARE)$ MEIINNVARE(VARE),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R) ) ;
RESNORGE('MEIK','GHGI','VERD',STEP) = SUM((VARE,M)$(MEIVARE(VARE) OR MEIINNVARE(VARE)),
                              (xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));
RESNORGE('MEIK','MARG','VERD',STEP)  = SUM((M,VARE)$ (MEIVARE(VARE) AND SLTVARE(VARE)), (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M))
                                     + SUM((M,VARE)$ (MEIVARE(VARE) AND SLTVARE(VARE)),  MARGIN(VARE,M,'WHLS')                      * xe.l(VARE,M));
RESNORGE('MEIK','PROF','VERD',STEP) = RESNORGE('MEIK','MINT','VERD',STEP) + RESNORGE('MEIK','XINT','VERD',STEP)
                                    - RESNORGE('MEIK','IUTG','VERD',STEP) - RESNORGE('MEIK','IUTQ','VERD',STEP)
                                    + RESNORGE('MEIK','XTIL','VERD',STEP) + RESNORGE('MEIK','NTPU','VERD',STEP)
                                    + RESNORGE('MEIK','IUMK','VERD',STEP) - RESNORGE('MEIK','OMST','VERD',STEP)
                                    - RESNORGE('MEIK','PROC','VERD',STEP) - RESNORGE('MEIK','TRSP','VERD',STEP)
                                    - RESNORGE('MEIK','RAAV','VERD',STEP) - RESNORGE('MEIK','GHGI','VERD',STEP)
                                    - RESNORGE('MEIK','MARG','VERD',STEP);
*
RESNORGE('MEIK','MINT','MNGD',STEP) = SUM((M,VARE)$ MEIDVARE(VARE), x.l(VARE,'CONS',M));
RESNORGE('MEIK','MINT','PRIS',STEP) $ RESNORGE('MEIK','MINT','MNGD',STEP) = RESNORGE('MEIK','MINT','VERD',STEP) / RESNORGE('MEIK','MINT','MNGD',STEP);
RESNORGE('MEIK','XINT','MNGD',STEP) = SUM((M,VARE)$MEIVARE(VARE), xe.l(VARE,M));
*
RESNORGE('MEIK',VARE,'MNGD_MOD',STEP) $ MEIVARE(VARE) = SUM(M, x.l(VARE,'CONS',M));
RESNORGE('MEIK',VARE,'MNGD_OBS',STEP) $ MEIVARE(VARE) = X0TOT(VARE);
RESNORGE('MEIK',VARE,'MNGD_IMP',STEP) $ MEIVARE(VARE) = SUM(M, xi.l(VARE,M)+xq.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M));


RESNORGE('MEIK',VARE,'IUTG',STEP) $ MEIVARE(VARE) = SUM(M, (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
RESNORGE('MEIK',VARE,'IUTQ',STEP) $ MEIVARE(VARE) = SUM(M, (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                    + SUM(M, (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                    + SUM(M, (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                    + SUM(M, (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('MEIK',MEIR,'PUSA',STEP) =  SUM(M, PUSATS(MEIR) * h.l(MEIR,M))
                                   + SUM((M,VARE)$MEIINNVARE(VARE), MEIDATA(VARE,MEIR) * PUSATS(MEIR) * xe.l(VARE,M))
                                   + SUM((VARE,M), PUBISATS(VARE) * h.l(MEIR,M) * MEIDATA(VARE,MEIR));
RESNORGE('MEIK',VARE,'PUIN',STEP) =  SUM(M$MEIINNVARE(VARE), PUINNT(M) * x.l(VARE,'PRIM',M));
RESNORGE('MEIK',MEIR,'PUDB',STEP) =  SUM(M, PUDISB(MEIR,M) * h.l(MEIR,M));
RESNORGE('MEIK',MEIR,'IUMK',STEP) =  SUM(M, IUMEIR(MEIR) * h.l(MEIR,M));
RESNORGE('MEIK',VARE,'OMST',STEP) $ MEIVARE(VARE) = OMSET(VARE) * x.l(VARE,'PRIM','NORGE');
RESNORGE('MEIK',MEIR,'PROC',STEP) = SUM(M, SIMDATA(M,MEIR,'PRIS','Y') * h.l(MEIR,M));
RESNORGE('MEIK',VARE,'TRSP',STEP) $ MEIVARE(VARE) = SUM((M,MM), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));
RESNORGE('MEIK',VARE,'RAAV',STEP) $ MEIINNVARE(VARE) = SUM((R,B),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R) ) ;
RESNORGE('MEIK',VARE,'MAIM',STEP) $(MEIVARE(VARE) OR MEIINNVARE(VARE)) = SUM(M,
                           (xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));
RESNORGE('MEIK',VARE,'MARG',STEP) $ (MEIVARE(VARE) AND SLTVARE(VARE)) = SUM(M, (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M));

****************************
* Regnskap for kjøttsektoren unntatt fjørfe
****************************
RESNORGE('SLKK','MINT','VERD',STEP) = SUM((M,VARE)$ SLKVARE(VARE), p.l(VARE,'CONS',M)*x.l(VARE,'CONS',M));
RESNORGE('SLKK','XINT','VERD',STEP) = SUM((M,VARE)$ SLKVARE(VARE), (PE(VARE)-TRKOSTEKS(VARE,M))*xe.l(VARE,M));
RESNORGE('SLKK','IUTG','VERD',STEP) = SUM((M,VARE)$ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
RESNORGE('SLKK','IUTQ','VERD',STEP) = SUM((M,VARE)$ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                    + SUM((M,VARE)$ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                    + SUM((M,VARE)$ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                    + SUM((M,VARE)$ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('SLKK','XTIL','VERD',STEP) = SUM((SLKVARE,M), EKSSUB(SLKVARE) * xe.l(SLKVARE,M));
RESNORGE('SLKK','IUSL','VERD',STEP) = SUM((M,SLK), IU(SLK) * h.l(SLK,M));
RESNORGE('SLKK','TRTL','VERD',STEP) = SUM((R,VARE)$ (PRODUKT(VARE) AND SLKINNVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE));
RESNORGE('SLKK','OMST','VERD',STEP) = SUM(VARE$SLKINNVARE(VARE), OMSET(VARE) * x.l(VARE,'PRIM','NORGE'));
RESNORGE('SLKK','PROC','VERD',STEP) = SUM((M,SLK), SIMDATA(M,SLK,'PRIS','Y') * h.l(SLK,M));
RESNORGE('SLKK','TRSP','VERD',STEP) = SUM((VARE,M,MM)$SLKVARE(VARE), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));
RESNORGE('SLKK','RAAV','VERD',STEP)  = SUM((R,B,VARE)$ SLKINNVARE(VARE),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R) ) ;
RESNORGE('SLKK','GHGI','VERD',STEP) = SUM((VARE,M)$(SLKVARE(VARE) OR SLKINNVARE(VARE)),
                              (xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));
RESNORGE('SLKK','MARG','VERD',STEP)  = SUM((M,VARE)$ (SLKVARE(VARE) AND SLTVARE(VARE)), (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M))
                                     + SUM((M,VARE)$ (SLKVARE(VARE) AND SLTVARE(VARE)),  MARGIN(VARE,M,'WHLS')                        * xe.l(VARE,M));
RESNORGE('SLKK','PROF','VERD',STEP) = RESNORGE('SLKK','MINT','VERD',STEP) + RESNORGE('SLKK','XINT','VERD',STEP)
                                    - RESNORGE('SLKK','IUTG','VERD',STEP) - RESNORGE('SLKK','IUTQ','VERD',STEP)
                                    + RESNORGE('SLKK','XTIL','VERD',STEP) + RESNORGE('SLKK','IUSL','VERD',STEP)
                                    + RESNORGE('SLKK','TRTL','VERD',STEP) - RESNORGE('SLKK','OMST','VERD',STEP)
                                    - RESNORGE('SLKK','PROC','VERD',STEP) - RESNORGE('SLKK','TRSP','VERD',STEP)
                                    - RESNORGE('SLKK','RAAV','VERD',STEP) - RESNORGE('SLKK','GHGI','VERD',STEP)
                                    - RESNORGE('SLKK','MARG','VERD',STEP);
*            
RESNORGE('SLKK','MINT','MNGD',STEP) = SUM((M,VARE)$ SLKVARE(VARE), x.l(VARE,'CONS',M));
RESNORGE('SLKK','MINT','PRIS',STEP) $ RESNORGE('SLKK','MINT','MNGD',STEP) = RESNORGE('SLKK','MINT','VERD',STEP) / RESNORGE('SLKK','MINT','MNGD',STEP);
RESNORGE('SLKK','XINT','MNGD',STEP) = SUM((M,VARE)$SLKVARE(VARE), xe.l(VARE,M));
*         
RESNORGE('SLKK',VARE,'MNGD_MOD',STEP) $ SLKVARE(VARE) = SUM(M, x.l(VARE,'CONS',M));
RESNORGE('SLKK',VARE,'MNGD_OBS',STEP) $ SLKVARE(VARE) = X0TOT(VARE);
RESNORGE('SLKK',VARE,'MNGD_IMP',STEP) $ SLKVARE(VARE) = SUM(M, xi.l(VARE,M)+xq.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M));
          
RESNORGE('SLKK',VARE,'IUTG',STEP) $ (SLKVARE(VARE) OR SLKINNVARE(VARE)) = SUM(M, (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
RESNORGE('SLKK',VARE,'IUTQ',STEP) $ (SLKVARE(VARE) OR SLKINNVARE(VARE)) = SUM(M, (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                                                        + SUM(M, (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                                                        + SUM(M, (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                                                        + SUM(M, (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('SLKK',VARE,'TRTL',STEP) $(SLKVARE(VARE) OR SLKINNVARE(VARE)) = SUM(R, x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE));
RESNORGE('SLKK',SLK,'IUSL',STEP)  = SUM(M, IU(SLK) * h.l(SLK,M));
RESNORGE('SLKK',VARE,'OMST',STEP) $ SLKVARE(VARE) = OMSET(VARE) * x.l(VARE,'PRIM','NORGE');
RESNORGE('SLKK',SLK,'PROC',STEP)  = SUM(M, SIMDATA(M,SLK,'PRIS','Y') * h.l(SLK,M));
RESNORGE('SLKK',VARE,'TRSP',STEP) $ SLKVARE(VARE) = SUM((M,MM), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));
RESNORGE('SLKK',VARE,'RAAV',STEP) $ SLKINNVARE(VARE) = SUM((R,B),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R) ) ;
RESNORGE('SLKK',VARE,'MAIM',STEP) $(SLKVARE(VARE) OR SLKINNVARE(VARE)) = SUM(M,
                           (xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));
RESNORGE('SLKK',VARE,'MARG',STEP) $ (SLKVARE(VARE) AND SLTVARE(VARE)) = SUM(M, (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M));
*
* Marginal PRIN fra markedsmodellen
RESNORGE('SLKK','PRIN',M,STEP) = EQPRINBAL.m(M);
*
* Beregnet marginal PRIN
RESNORGE('SLKK',SSLK,M,STEP) $ (SUM(SLKINNVARE$SSLK_SLKINN(SSLK,SLKINNVARE), SIMDATA(M,SLKINNVARE,'MNGD','Y'))
           AND SUM(VARE$(SLTVARE(VARE) AND SLKVARE(VARE)), SIMDATA(M,VARE,'MNGD','Y'))) =
* Raavare
 (  ( SUM(SLKINNVARE$SSLK_SLKINN(SSLK,SLKINNVARE), SIMDATA(M,SLKINNVARE,'TOTP','Y') * SIMDATA(M,SLKINNVARE,'MNGD','Y'))
   /  SUM(SLKINNVARE$SSLK_SLKINN(SSLK,SLKINNVARE), SIMDATA(M,SLKINNVARE,'MNGD','Y')) )
* Foredling
 +  SIMDATA(M,SSLK,'PRIS','Y')
* Inntekt ferskvare
 -  (  SUM(VARE$(SLTVARE(VARE) AND SLKVARE(VARE)), SLKDATA(VARE,SSLK) *
       SIMDATA(M,VARE,'TOTP','Y') * SIMDATA(M,VARE,'MNGD','Y'))
    /  SUM(VARE$(SLTVARE(VARE) AND SLKVARE(VARE)), SIMDATA(M,VARE,'MNGD','Y')))  )
 / SLKDATA('PRIN',SSLK);
*
* Gjennomsnittlig PRIN med overskudd
RESNORGE('SLKK','SSLK',M,STEP) $ SUM(SLKINNVARE, SIMDATA(M,SLKINNVARE,'MNGD','Y')) =
  ( SUM(SSLK, ( RESNORGE('SLKK',SSLK,M,STEP) * SUM(SLKINNVARE$SSLK_SLKINN(SSLK,SLKINNVARE), SIMDATA(M,SLKINNVARE,'MNGD','Y'))))
* Overskudd
 - (  SUM(VARE$(SLTVARE(VARE) AND SLKVARE(VARE)), SIMDATA(M,VARE,'TOTP','Y') * SIMDATA(M,VARE,'MNGD','Y'))
    - rkslk.l(M) - cfslk.l(M) - ctslk.l(M)
    + SUM(SLKINNVARE, SIMDATA(M,SLKINNVARE,'MNGD','Y') * SUM(R$R_til_M(M,R), INNFRAKTTIL(R,SLKINNVARE)))
    - transsslk.l(M) - transfslk.l(M)
   )
  )
  /  SUM(SLKINNVARE, SIMDATA(M,SLKINNVARE,'MNGD','Y')) ;

****************************
* Regnskap for moeller
****************************
RESNORGE('MOEL','MINT','VERD',STEP) = SUM((M,VARE)$ MOELVARE(VARE), p.l(VARE,'CONS',M)*x.l(VARE,'CONS',M));
RESNORGE('MOEL','JINT','VERD',STEP) = SUM((R,B,VARE)$ MOELUTKVARE(VARE),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R));
RESNORGE('MOEL','XINT','VERD',STEP) = SUM((M,VARE)$ MOELVARE(VARE), (PE(VARE)-TRKOSTEKS(VARE,M))*xe.l(VARE,M));
RESNORGE('MOEL','IUTG','VERD',STEP) = SUM((M,VARE)$ MOELVARE(VARE), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
RESNORGE('MOEL','IUTQ','VERD',STEP) = SUM((M,VARE)$ MOELVARE(VARE), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                    + SUM((M,VARE)$ MOELVARE(VARE), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                    + SUM((M,VARE)$ MOELVARE(VARE), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                    + SUM((M,VARE)$ MOELVARE(VARE), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M))
                                    + SUM((M,MOEL), MOLDATA('FSOY',MOEL) * (PI('FSOY')+KVOTETOLLA('FSOY')) * h.l(MOEL,M))
                                    + SUM((M,MOEL), MOLDATA('FANT',MOEL) * (PI('FANT')+KVOTETOLLA('FANT')) * h.l(MOEL,M));
RESNORGE('MOEL','XTIL','VERD',STEP) = SUM((MOELVARE,M), EKSSUB(MOELVARE) * xe.l(MOELVARE,M));
RESNORGE('MOEL','TRTL','VERD',STEP) = SUM((R,VARE)$ (PRODUKT(VARE) AND MOELINNVARE(VARE) AND MOELUTVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                                    + SUM((R,VARE)$ MOELUTKVARE(VARE), z.l(VARE,R)        * INNFRAKTTIL(R,VARE)) ;
RESNORGE('MOEL','PRND','VERD',STEP) = SUM((M,VARE), x.l(VARE,'PRIM',M) * PRISNED(VARE));
RESNORGE('MOEL','OMST','VERD',STEP) = SUM(VARE$MOELVARE(VARE), OMSET(VARE) * x.l(VARE,'PRIM','NORGE'));
RESNORGE('MOEL','PROC','VERD',STEP) = SUM((M,MOEL), SIMDATA(M,MOEL,'PRIS','Y') * h.l(MOEL,M));
RESNORGE('MOEL','TRSP','VERD',STEP) = SUM((VARE,M,MM)$MOELVARE(VARE), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));
RESNORGE('MOEL','RAAV','VERD',STEP)  = SUM((R,B,VARE)$ MOELINNVARE(VARE),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R));
RESNORGE('MOEL','GHGI','VERD',STEP) = SUM((VARE,M)$(MOELVARE(VARE) OR SAMEAS('FANT',VARE) OR SAMEAS('FSOY',VARE)),
                              (xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));
RESNORGE('MOEL','MARG','VERD',STEP)  = SUM((M,VARE)$ (MOELVARE(VARE) AND SLTVARE(VARE)), (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M))
                                     + SUM((M,VARE)$ (MOELVARE(VARE) AND SLTVARE(VARE)),  MARGIN(VARE,M,'WHLS')                        * xe.l(VARE,M));
RESNORGE('MOEL','PROF','VERD',STEP) = RESNORGE('MOEL','MINT','VERD',STEP) + RESNORGE('MOEL','XINT','VERD',STEP)
                                    + RESNORGE('MOEL','JINT','VERD',STEP) - RESNORGE('MOEL','IUTG','VERD',STEP)
                                    - RESNORGE('MOEL','IUTQ','VERD',STEP) + RESNORGE('MOEL','XTIL','VERD',STEP)
                                    + RESNORGE('MOEL','TRTL','VERD',STEP) + RESNORGE('MOEL','PRND','VERD',STEP)
                                    - RESNORGE('MOEL','OMST','VERD',STEP) - RESNORGE('MOEL','PROC','VERD',STEP)
                                    - RESNORGE('MOEL','TRSP','VERD',STEP) - RESNORGE('MOEL','RAAV','VERD',STEP)
                                    - RESNORGE('MOEL','GHGI','VERD',STEP) - RESNORGE('MOEL','MARG','VERD',STEP);
*             
RESNORGE('MOEL','MINT','MNGD',STEP) = SUM((M,VARE)$ MOELVARE(VARE), x.l(VARE,'CONS',M));
RESNORGE('MOEL','MINT','PRIS',STEP) $ RESNORGE('MOEL','MINT','MNGD',STEP) = RESNORGE('MOEL','MINT','VERD',STEP) / RESNORGE('MOEL','MINT','MNGD',STEP);
RESNORGE('MOEL','XINT','MNGD',STEP) = SUM((M,VARE)$MOELVARE(VARE), xe.l(VARE,M));
*         
RESNORGE('MOEL',VARE,'MNGD_MOD',STEP) $ MOELVARE(VARE) = SUM(M, x.l(VARE,'CONS',M));
RESNORGE('MOEL',VARE,'MNGD_OBS',STEP) $ MOELVARE(VARE) = X0TOT(VARE);
RESNORGE('MOEL',VARE,'PRIS_MOD',STEP) $ (MOELVARE(VARE) AND SUM(M, x.l(VARE,'CONS',M))) = SUM(M, p.l(VARE,'CONS',M) * x.l(VARE,'CONS',M)) /  SUM(M, x.l(VARE,'CONS',M));
RESNORGE('MOEL',VARE,'PRIS_OBS',STEP) $ MOELVARE(VARE) = P0(VARE);
*
RESNORGE('MOEL',VARE,'IMPT_VERD',STEP) $ MOELVARE(VARE) = SUM(M, (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M)
                                                               +(PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M)
                                                               +(PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M)
                                                               +(PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M)
                                                               +(PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('MOEL',VARE,'IMPT_MNGD',STEP) $ MOELVARE(VARE) = SUM(M, xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M));
RESNORGE('MOEL',VARE,'IMPT_PRIS',STEP) $ (MOELVARE(VARE) AND SUM(M, xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M))) =
   SUM(M, (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M)
         +(PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M)
         +(PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M)
         +(PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M)
         +(PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M)) /
   SUM(M, xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M));
          
RESNORGE('MOEL',VARE,'TRTL',STEP)   = SUM(R$(MOELVARE(VARE) OR MOELINNVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE))
                                    + SUM(MM$MOELUTKVARE(VARE), uttr.l(VARE,'OEST',MM) * TRKOST(VARE,'OEST',MM))                                    
                                    + SUM(M, x.l(VARE,'PRIM',M) * PRISNED(VARE));
RESNORGE('MOEL',VARE,'PRSN_VERD',STEP) = SUM(M, x.l(VARE,'PRIM',M) * PRISNED(VARE));
RESNORGE('MOEL',VARE,'PRSN_MNGD',STEP) = SUM(M, x.l(VARE,'PRIM',M));
RESNORGE('MOEL',VARE,'PRSN_PRIS',STEP) = PRISNED(VARE);
*
RESNORGE('MOEL',VARE,'OMST_VERD',STEP) $ MOELVARE(VARE) = OMSET(VARE) * x.l(VARE,'PRIM','NORGE');
RESNORGE('MOEL',VARE,'OMST_MNGD',STEP) $ MOELVARE(VARE) = x.l(VARE,'PRIM','NORGE');
RESNORGE('MOEL',VARE,'OMST_PRIS',STEP) $ MOELVARE(VARE) = OMSET(VARE);
RESNORGE('MOEL',MOEL,'PROC_VERD',STEP)  = SUM(M, SIMDATA(M,MOEL,'PRIS','Y') * h.l(MOEL,M));
RESNORGE('MOEL',MOEL,'PROC_MNGD',STEP)  = SUM(M, h.l(MOEL,M));
RESNORGE('MOEL',MOEL,'PROC_PRIS',STEP) $ SUM(M, h.l(MOEL,M)) = SUM(M, SIMDATA(M,MOEL,'PRIS','Y') * h.l(MOEL,M)) / SUM(M, h.l(MOEL,M));
*
RESNORGE('MOEL',VARE,'MARG_VERD',STEP) $ (MOELVARE(VARE) AND SLTVARE(VARE)) = SUM(M, (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M));
RESNORGE('MOEL',VARE,'MARG_MNGD',STEP) $ (MOELVARE(VARE) AND SLTVARE(VARE)) = SUM(M, x.l(VARE,'CONS',M));
RESNORGE('MOEL',VARE,'MARG_PRIS',STEP) $ (MOELVARE(VARE) AND SLTVARE(VARE)) = SUM(M, MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL'));
*
RESNORGE('MOEL',VARE,'RAAV_VERD',STEP)  = SUM((R,B)$ MOELINNVARE(VARE),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R));
RESNORGE('MOEL',VARE,'RAAV_MNGD',STEP)  = SUM((R,B)$ MOELINNVARE(VARE),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R));
RESNORGE('MOEL',VARE,'RAAV_PRIS',STEP) $ (RESNORGE('MOEL',VARE,'RAAV_MNGD',STEP) GT eps)= RESNORGE('MOEL',VARE,'RAAV_VERD',STEP) / RESNORGE('MOEL',VARE,'RAAV_MNGD',STEP);
*
RESNORGE('MOEL',VARE,'TRSP',STEP) $ MOELVARE(VARE) = SUM((M,MM), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));

RESNORGE('MOEL',VARE,'IUTG',STEP) $ MOELVARE(VARE) = SUM(M, (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
RESNORGE('MOEL',VARE,'IUTQ',STEP) $ MOELVARE(VARE) = SUM(M, (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                    + SUM(M, (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                    + SUM(M, (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                    + SUM(M, (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('MOEL','FSOY','IUTQ',STEP) = SUM((M,MOEL), MOLDATA('FSOY',MOEL) * (PI('FSOY')+KVOTETOLLA('FSOY')) * h.l(MOEL,M));
RESNORGE('MOEL','FANT','IUTQ',STEP) = SUM((M,MOEL), MOLDATA('FANT',MOEL) * (PI('FANT')+KVOTETOLLA('FANT')) * h.l(MOEL,M));
*
RESNORGE('MOEL','FSOY','VERD',STEP) = SUM((M,MOEL), MOLDATA('FSOY',MOEL) * (PI('FSOY')+KVOTETOLLA('FSOY')) * h.l(MOEL,M));
RESNORGE('MOEL','FSOY','MNGD',STEP) = SUM((M,MOEL), MOLDATA('FSOY',MOEL) * h.l(MOEL,M));
RESNORGE('MOEL','FSOY','PRIS',STEP) = RESNORGE('MOEL','FSOY','VERD',STEP) / RESNORGE('MOEL','FSOY','MNGD',STEP);
RESNORGE('MOEL','FANT','VERD',STEP) = SUM((M,MOEL), MOLDATA('FANT',MOEL) * (PI('FANT')+KVOTETOLLA('FANT')) * h.l(MOEL,M));
RESNORGE('MOEL','FANT','MNGD',STEP) = SUM((M,MOEL), MOLDATA('FANT',MOEL) * h.l(MOEL,M));
RESNORGE('MOEL','FANT','PRIS',STEP) = RESNORGE('MOEL','FANT','VERD',STEP) / RESNORGE('MOEL','FANT','MNGD',STEP);
*
RESNORGE('MOEL',VARE,'RAAV',STEP) $ MOELINNVARE(VARE) = SUM((R,B),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R) ) ;
RESNORGE('MOEL',VARE,'MAIM',STEP) $(MOELVARE(VARE) OR MOELINNVARE(VARE)) = SUM(M,
                           (xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));
RESNORGE('MOEL',VARE,'MARG',STEP) $ (MOELVARE(VARE) AND SLTVARE(VARE)) = SUM(M, (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M));
*
RESNORGE(M,VARE,'MOELIN_MNGD',STEP)  =  SUM(MOEL $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h.l(MOEL,M)) ;
RESNORGE('MOEL',VARE,'MOELIN_MNGD',STEP)  =  SUM(M, RESNORGE(M,VARE,'MOELIN_MNGD',STEP)) ;
RESNORGE('MOEL',VARE,'MOELIN_VERD',STEP)  =  SUM(M, -EQMOELINBAL.m(VARE,M) * RESNORGE(M,VARE,'MOELIN_MNGD',STEP)) ;
RESNORGE('MOEL',VARE,'MOELIN_PRIS',STEP)  $ RESNORGE('MOEL',VARE,'MOELIN_MNGD',STEP) =  RESNORGE('MOEL',VARE,'MOELIN_VERD',STEP) / RESNORGE('MOEL',VARE,'MOELIN_MNGD',STEP);
*
RESNORGE(M,VARE,'MOELUT_MNGD',STEP) = z.l(VARE,M) $ MOELUTKVARE(VARE) + x.l(VARE,'WHLS',M) $ SLTVARE(VARE);
RESNORGE('MOEL',VARE,'MOELUT_MNGD',STEP) = SUM(M, RESNORGE(M,VARE,'MOELUT_MNGD',STEP));
RESNORGE('MOEL',VARE,'MOELUT_VERD',STEP)  =  SUM(M, -EQMOELUTBAL.m(VARE,M) * RESNORGE(M,VARE,'MOELUT_MNGD',STEP)) ;
RESNORGE('MOEL',VARE,'MOELUT_PRIS',STEP)  $ RESNORGE('MOEL',VARE,'MOELUT_MNGD',STEP) =  RESNORGE('MOEL',VARE,'MOELUT_VERD',STEP) / RESNORGE('MOEL',VARE,'MOELUT_MNGD',STEP);
*
RESNORGE('MOEL',VARE,'PRIS',STEP) $ SUM(M, EQMOELUTBAL.l(VARE,M)) =  SUM(M, -EQMOELUTBAL.m(VARE,M) * EQMOELUTBAL.l(VARE,M)) / SUM(M, EQMOELUTBAL.l(VARE,M));
RESNORGE('MOEL',VARE,'TOTP',STEP)  $ SUM(VAREVARE$MOELFLYT(VAREVARE,VARE), RESNORGE('MOEL',VAREVARE,'PRIS',STEP)) =  SUM(VAREVARE$MOELFLYT(VAREVARE,VARE), RESNORGE('MOEL',VAREVARE,'PRIS',STEP));
*
****************************
* Regnskap for annen matindustri industri (frukt grønt potet fjørfe egg ull)
****************************
RESNORGE('AIND','MINT','VERD',STEP) = SUM((M,VARE)$ AINDVARE(VARE), p.l(VARE,'CONS',M)*x.l(VARE,'CONS',M));
RESNORGE('AIND','XINT','VERD',STEP) = SUM((M,VARE)$ AINDVARE(VARE), (PE(VARE)-TRKOSTEKS(VARE,M))*xe.l(VARE,M));
RESNORGE('AIND','IUTG','VERD',STEP) = SUM((M,VARE)$ AINDVARE(VARE), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
RESNORGE('AIND','IUTQ','VERD',STEP) = SUM((M,VARE)$ AINDVARE(VARE), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                    + SUM((M,VARE)$ AINDVARE(VARE), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                    + SUM((M,VARE)$ AINDVARE(VARE), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                    + SUM((M,VARE)$ AINDVARE(VARE), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('AIND','XTIL','VERD',STEP) = SUM((VARE,M)$ AINDVARE(VARE), EKSSUB(VARE) * xe.l(VARE,M));
RESNORGE('AIND','TRTL','VERD',STEP) = SUM((R,VARE)$ AINDVARE(VARE), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE));
RESNORGE('AIND','OMST','VERD',STEP) = SUM(VARE$AINDVARE(VARE), OMSET(VARE)   * x.l(VARE,'PRIM','NORGE'));
RESNORGE('AIND','PROC','VERD',STEP) = SUM((KSLK,M), SIMDATA(M,KSLK,'PRIS','Y') * h.l(KSLK,M))
                                    + SUM((VARE,M)$SLTVARE(VARE), FK(VARE,M) * x.l(VARE,'WHLS',M));
RESNORGE('AIND','TRSP','VERD',STEP) = SUM((VARE,M,MM)$AINDVARE(VARE), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));
RESNORGE('AIND','RAAV','VERD',STEP) = SUM((R,B,VARE)$AINDVARE(VARE),       SIMDATA(R,B,'VERD',VARE) * g.l(B,R) );
RESNORGE('AIND','GHGI','VERD',STEP) = SUM((VARE,M)$AINDVARE(VARE),
                              (xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));
RESNORGE('AIND','MARG','VERD',STEP)  = SUM((M,VARE)$ AINDVARE(VARE), (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M))
                                     + SUM((M,VARE)$ AINDVARE(VARE),  MARGIN(VARE,M,'WHLS')                        * xe.l(VARE,M));
RESNORGE('AIND','PROF','VERD',STEP) = RESNORGE('AIND','MINT','VERD',STEP) + RESNORGE('AIND','XINT','VERD',STEP)
                                    - RESNORGE('AIND','IUTG','VERD',STEP) - RESNORGE('AIND','IUTQ','VERD',STEP)
                                    + RESNORGE('AIND','XTIL','VERD',STEP) + RESNORGE('AIND','TRTL','VERD',STEP)
                                    - RESNORGE('AIND','OMST','VERD',STEP) - RESNORGE('AIND','PROC','VERD',STEP)
                                    - RESNORGE('AIND','TRSP','VERD',STEP) - RESNORGE('AIND','RAAV','VERD',STEP)
                                    - RESNORGE('AIND','MARG','VERD',STEP) - RESNORGE('AIND','GHGI','VERD',STEP);
*
RESNORGE('AIND','MINT','MNGD',STEP) = SUM((M,VARE)$ AINDVARE(VARE), x.l(VARE,'CONS',M));
RESNORGE('AIND','MINT','PRIS',STEP) $ RESNORGE('AIND','MINT','MNGD',STEP) = RESNORGE('AIND','MINT','VERD',STEP) / RESNORGE('AIND','MINT','MNGD',STEP);
RESNORGE('AIND','XINT','MNGD',STEP) = SUM((M,VARE) $ AINDVARE(VARE), xe.l(VARE,M));
*         
RESNORGE('AIND',VARE,'MNGD_MOD',STEP) $ AINDVARE(VARE) = SUM(M, x.l(VARE,'CONS',M));
RESNORGE('AIND',VARE,'MNGD_OBS',STEP) $ AINDVARE(VARE) = X0TOT(VARE);
RESNORGE('AIND',VARE,'MNGD_IMP',STEP) $ AINDVARE(VARE) = SUM(M, xi.l(VARE,M)+xq.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M));
              
RESNORGE('AIND',VARE,'IUTG',STEP) $ AINDVARE(VARE) = SUM(M, (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
RESNORGE('AIND',VARE,'IUTQ',STEP) $ AINDVARE(VARE) = SUM(M, (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                    + SUM(M, (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                    + SUM(M, (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                    + SUM(M, (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('AIND',VARE,'TRTL',STEP) $ AINDVARE(VARE) = SUM(R, x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE));
RESNORGE('AIND',VARE,'OMST',STEP) $ AINDVARE(VARE) = OMSET(VARE) * x.l(VARE,'PRIM','NORGE');
RESNORGE('AIND',KSLK,'PROC',STEP) = SUM(M, SIMDATA(M,KSLK,'PRIS','Y') * h.l(KSLK,M));
RESNORGE('AIND',VARE,'TRSP',STEP) $ AINDVARE(VARE) = SUM((M,MM), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));
RESNORGE('AIND',VARE,'RAAV',STEP) $ (AINDVARE(VARE) OR SAMEAS('FJRK',VARE))
                                  = SUM((R,B)$AINDVARE(VARE),       SIMDATA(R,B,'VERD',VARE) * g.l(B,R) )
                                  + SUM((R,B)$SAMEAS('FJRK',VARE),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R) );
RESNORGE('AIND',VARE,'MAIM',STEP) $ AINDVARE(VARE) = SUM(M,
                           (xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));
RESNORGE('AIND',VARE,'MARG',STEP) $ AINDVARE(VARE) = SUM(M, (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M));
                                    

SIMDATACHECK(R,VARE,'TOTP','0') = SIMDATA(R,VARE,'TOTP','Y');

******************
* Primaerjordbruk
*****************
RESNORGE('PJBK','MINT','VERD',STEP) = SUM((R,B,VARE)$ PRODUKT(VARE),  SIMDATA(R,B,'VERD',VARE)  * g.l(B,R)) ;
RESNORGE('PJBK','KOST','VERD',STEP) = SUM((R,B,VARE)$ INNSATSUKFOR(VARE),  SIMDATA(R,B,'VERD',VARE)  * g.l(B,R)) ;
RESNORGE('PJBK','KSTF','VERD',STEP) = SUM((R,B,VARE)$ MOELUTKVARE(VARE),   SIMDATA(R,B,'VERD',VARE)  * g.l(B,R));
RESNORGE('PJBK','TIL','VERD',STEP)  = SUM((R,B,VARE)$ TIlSKUDD(VARE), SIMDATA(R,B,'VERD',VARE)  * g.l(B,R)) ;
RESNORGE('PJBK','PMP','VERD',STEP)  = SUM((B,R),      PmpProdCnst(R,B) *  g.l(B,R))
                                    + SUM((B,R), .5 * PmpProdQuad(R,B) * (g.l(B,R)**2) $ (PmpProdQuad(R,B) < 0))
                                    - SUM((B,R), .5 * PmpProdQuad(R,B) * (g.l(B,R)**2) $ (PmpProdQuad(R,B) > 0));
RESNORGE('PJBK','AVKF','VERD',STEP) = SUM((MOELUTVARE,R), z.l(MOELUTVARE,R) * KFORAVG(R,MOELUTVARE)) ;
RESNORGE('PJBK','AVNI','VERD',STEP) = SUM(R, z.l('NITG',R) * KFORAVG(R,'NITG')) ;
RESNORGE('PJBK','GHGD','VERD',STEP) = SUM((R,B,UTSLIPPAVG), SIMDATA(R,B,'MNGD',UTSLIPPAVG) * g.l(B,R) * CO2AVGXP(UTSLIPPAVG));
RESNORGE('PJBK','PROF','VERD',STEP) = RESNORGE('PJBK','MINT','VERD',STEP) - RESNORGE('PJBK','KOST','VERD',STEP)
                                    - RESNORGE('PJBK','KSTF','VERD',STEP) + RESNORGE('PJBK','TIL','VERD',STEP)
                                    - RESNORGE('PJBK','AVKF','VERD',STEP) - RESNORGE('PJBK','AVNI','VERD',STEP)
                                    - RESNORGE('PJBK','GHGD','VERD',STEP) + RESNORGE('PJBK','PMP','VERD',STEP); 
*
RESNORGE('PJBK',VARE,'MINT',STEP) = SUM((R,B)$ PRODUKT(VARE),  SIMDATA(R,B,'VERD',VARE)  * g.l(B,R)) ;


RESNORGE('TEST','VEDB',PRDK,STEP) = SUM((R,B), SIMDATA(R,B,'VEDB',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R) ) ;
RESNORGE('TEST','VEDM',PRDK,STEP) = SUM((R,B), SIMDATA(R,B,'VEDM',PRDK) * SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R) ) ;
* Tall for gaardsbruk
RESNORGE('PJBK','MIAV','VERD',STEP) = SUM((R,B,UTSLIPPAVG), SIMDATA(R,B,'VERD',UTSLIPPAVG) * g.l(B,R));
*
RESNORGE('PJBK',SIMVARE,F,STEP) = SUM((R,B)$R_TIL_F(F,R),  SIMDATA(R,B,'MNGD',SIMVARE) * g.l(B,R) ) ;
RESNORGE('PJBK',SIMVARE,M,STEP) = SUM((R,B)$R_TIL_M(M,R),  SIMDATA(R,B,'MNGD',SIMVARE) * g.l(B,R) ) ;
RESNORGE('PJBK',VARE,'MNGD',STEP) = SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R) ) ;
*
* Ikke dobbeltelling av husdyrgj?dsel
RESNORGE('PJBK','NITH','MNGD',STEP) = SUM((R,BHUSDJG,HUSDYR),  SIMDATA(R,BHUSDJG,'OMFG',HUSDYR) * SIMDATA(R,BHUSDJG,'NITH',HUSDYR) * g.l(BHUSDJG,R) ) ;
RESNORGE('PJBK','FOSH','MNGD',STEP) = SUM((R,BHUSDJG,HUSDYR),  SIMDATA(R,BHUSDJG,'OMFG',HUSDYR) * SIMDATA(R,BHUSDJG,'FOSH',HUSDYR) * g.l(BHUSDJG,R) ) ;
RESNORGE('PJBK','KALH','MNGD',STEP) = SUM((R,BHUSDJG,HUSDYR),  SIMDATA(R,BHUSDJG,'OMFG',HUSDYR) * SIMDATA(R,BHUSDJG,'KALH',HUSDYR) * g.l(BHUSDJG,R) ) ;

RESNORGE('PJBK',INNSATS,'VERD',STEP) = SUM((R,B),  SIMDATA(R,B,'VERD',INNSATS) * g.l(B,R)) ;

TESTBRUK(R,B,INNSATS) $ (SIMDATA(R,B,'MNGD',INNSATS) NE SIMDATA(R,B,'VERD',INNSATS)) = YES;

RESNORGE(R,B,'AKST',STEP) $ SUM(INNSATS, SIMDATA(R,B,'VERD',INNSATS)) = SIMDATA(R,B,'VERD','AKST') / SUM(INNSATS, SIMDATA(R,B,'VERD',INNSATS)) ;

RESNORGE('PJBK','KFOR','VERD',STEP) = RESNORGE('PJBK','FDRM','VERD',STEP) + RESNORGE('PJBK','FDRA','VERD',STEP) + RESNORGE('PJBK','FSVN','VERD',STEP) + RESNORGE('PJBK','FKYL','VERD',STEP) + RESNORGE('PJBK','FEGG','VERD',STEP);
RESNORGE('PJBK',PRODUKT,'VERD',STEP) = SUM((R,B),  SIMDATA(R,PRODUKT,'TOTP','Y') * SIMDATA(R,B,'MNGD',PRODUKT) * g.l(B,R)) ;
RESNORGE('PJBK',VARE,'PRIS',STEP) $ (RESNORGE('PJBK',VARE,'MNGD',STEP) GT EPS) = RESNORGE('PJBK',VARE,'VERD',STEP) / RESNORGE('PJBK',VARE,'MNGD',STEP)  ;
RESNORGE('PJBK',TILSKUDD,R,STEP) = SUM(B, SIMDATA(R,B,'VERD',TILSKUDD) * g.l(B,R));
RESNORGE('PJBK','TILSKUDD',F,STEP) $ SUM((R,B,PLANTE)$(R_TIL_F(F,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R))
  = SUM((R,TILSKUDD)$R_TIL_F(F,R), RESNORGE('PJBK',TILSKUDD,R,STEP)) / SUM((R,B,PLANTE)$(R_TIL_F(F,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
RESNORGE('PJBK','TILSKUDD',S,STEP) $  SUM((R,B,PLANTE)$(R_TIL_S(S,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R))
  = SUM((R,TILSKUDD)$R_TIL_S(S,R), RESNORGE('PJBK',TILSKUDD,R,STEP)) / SUM((R,B,PLANTE)$(R_TIL_S(S,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
RESNORGE('PJBK','TILSKUDD',DG,STEP) $ SUM((R,B,PLANTE)$(R_TIL_DG(DG,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R))
  =  SUM((R,TILSKUDD)$R_TIL_DG(DG,R), RESNORGE('PJBK',TILSKUDD,R,STEP)) / SUM((R,B,PLANTE)$(R_TIL_DG(DG,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
RESNORGE('PJBK','AREAL',R,STEP) =  SUM((B,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
RESNORGE('PJBK','AREAL',F,STEP) =  SUM((R,B,PLANTE)$(R_TIL_F(F,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
RESNORGE('PJBK','AREAL',S,STEP) =  SUM((R,B,PLANTE)$(R_TIL_S(S,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
RESNORGE('PJBK','AREAL',DG,STEP) = SUM((R,B,PLANTE)$(R_TIL_DG(DG,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R));
RESNORGE('PJBK','FDAD',R,STEP) $ SUM(FULLDYRK, DATA(R,FULLDYRK,'OMFG','BAS')) = SUM((B,FULLDYRK), SIMDATA(R,B,'OMFG',FULLDYRK) * g.l(B,R)) / SUM(FULLDYRK, DATA(R,FULLDYRK,'OMFG','BAS'));
RESNORGE('PJBK','ARAD',R,STEP) $ SUM(PLANTE,   DATA(R,PLANTE,'OMFG','BAS'))   = SUM((B,PLANTE),   SIMDATA(R,B,'OMFG',PLANTE)   * g.l(B,R)) / SUM(PLANTE,   DATA(R,PLANTE,'OMFG','BAS'));
RESNORGE('PJBK','FDAD','NORGE',STEP) $ SUM((R,FULLDYRK), DATA(R,FULLDYRK,'OMFG','BAS')) = SUM((R,B,FULLDYRK), SIMDATA(R,B,'OMFG',FULLDYRK) * g.l(B,R)) / SUM((R,FULLDYRK),   DATA(R,FULLDYRK,'OMFG','BAS'));
RESNORGE('PJBK','ARAD','NORGE',STEP) $ SUM((R,PLANTE),   DATA(R,PLANTE,'OMFG','BAS'))   = SUM((R,B,PLANTE),   SIMDATA(R,B,'OMFG',PLANTE)   * g.l(B,R)) / SUM((R,PLANTE),     DATA(R,PLANTE,'OMFG','BAS'));

RESNORGE('PJBK',TILSKUDD,B,STEP)      = SUM(R, SIMDATA(R,B,'VERD',TILSKUDD) * g.l(B,R));
RESNORGE('PJBK',TILSKUDD,'VERD',STEP) = SUM(B, RESNORGE('PJBK',TILSKUDD,B,STEP));

RESNORGE(R,B,'PFDA',STEP) = SIMDATA(R,B,'VERD','PFDA');
RESNORGE(R,B,'DB',STEP) = SIMDATA(R,B,'VERD','DB');

RESNORGE('PJBK','TENDO','VERD',STEP) = RESNORGE('TOTK','TENDO','VERD',STEP);
RESNORGE('PJBK','BTIL','VERD',STEP) = SUM((R,B,TILSKUDD), SIMDATA(R,B,'VERD',TILSKUDD) * g.l(B,R))
                                    + RESNORGE('PJBK','TENDO','VERD',STEP);
RESNORGE('PJBK','BKST','VERD',STEP) = SUM((R,B,INNSATS)$ (NOT (SAMEAS('FDRM',INNSATS) OR SAMEAS('FDRA',INNSATS) OR SAMEAS('FSVN',INNSATS) OR SAMEAS('FKYL',INNSATS) OR SAMEAS('FEGG',INNSATS))),
                               SIMDATA(R,B,'VERD',INNSATS)  * g.l(B,R));
RESNORGE('PJBK','BFOR','VERD',STEP) = SUM((R,B,INNSATS)$ (SAMEAS('FDRM',INNSATS) OR SAMEAS('FDRA',INNSATS) OR SAMEAS('FSVN',INNSATS) OR SAMEAS('FKYL',INNSATS) OR SAMEAS('FEGG',INNSATS)),
                               SIMDATA(R,B,'VERD',INNSATS)  * g.l(B,R));
*
* Endogene pristilskudd
RESNORGE('PRIS',VARE,'TENDO',STEP)   = (-EQXPGLV.m(VARE));
RESNORGE('PRIS','KORN','TENDO',STEP) = (-EQXPKORNGLV.m) ;
RESNORGE('PRIS','STKK','TENDO',STEP) = (-EQXPSTKKGLV.m) ;
*
* Distriktsandel
RESNORGE('DIS','OMFG','AREA',STEP) $ SUM((R,PRDK)$(PLANTE(PRDK) AND (NOT SAMEAS('GFUB',PRDK))), RESNORGE(R,'OMFG',PRDK,STEP)) = SUM((R,PRDK)$(R_TIL_SD('000200',R) AND PLANTE(PRDK) AND (NOT SAMEAS('GFUB',PRDK))), RESNORGE(R,'OMFG',PRDK,STEP)) /
SUM((R,PRDK)$(PLANTE(PRDK) AND (NOT SAMEAS('GFUB',PRDK))), RESNORGE(R,'OMFG',PRDK,STEP)) * 100;
RESNORGE('DIS','OMFG','KORN',STEP) $ (SUM((R,PRDK)$KORN(PRDK), RESNORGE(R,'OMFG',PRDK,STEP)) GT EPS) = SUM((R,PRDK)$(R_TIL_SD('000200',R) AND KORN(PRDK)), RESNORGE(R,'OMFG',PRDK,STEP)) / SUM((R,PRDK)$KORN(PRDK), RESNORGE(R,'OMFG',PRDK,STEP)) * 100;
RESNORGE('DIS','OMFG','GROV',STEP) $ (SUM((R,PRDK)$GROV(PRDK), RESNORGE(R,'OMFG',PRDK,STEP)) GT EPS) = SUM((R,PRDK)$(R_TIL_SD('000200',R) AND GROV(PRDK)), RESNORGE(R,'OMFG',PRDK,STEP)) / SUM((R,PRDK)$GROV(PRDK), RESNORGE(R,'OMFG',PRDK,STEP)) * 100;
RESNORGE('DIS','MNGD',VARE,STEP) $ (SUM(R, RESNORGE(R,'MNGD',VARE,STEP)) GT EPS) = SUM(R$R_TIL_SD('000200',R), RESNORGE(R,'MNGD',VARE,STEP)) / SUM(R, RESNORGE(R,'MNGD',VARE,STEP)) * 100;
RESNORGE('DIS','OMFG',PRDK,STEP) $ (SUM(R, RESNORGE(R,'OMFG',PRDK,STEP)) GT EPS) = SUM(R$R_TIL_SD('000200',R), RESNORGE(R,'OMFG',PRDK,STEP)) / SUM(R, RESNORGE(R,'OMFG',PRDK,STEP)) * 100;
*
*
* Samfunnsoekonomi
RESNORGE('SKJM',VARE,'PDFF',STEP) = P0(VARE) - PI(VARE);
RESNORGE('SKJM',VARE,'PI',STEP) = PI(VARE) $(PRODUKT(VARE) AND RESNORGE('PJBK',VARE,'PRIS',STEP));
RESNORGE('SKJM',VARE,'PNO',STEP) = RESNORGE('PJBK',VARE,'PRIS',STEP);
RESNORGE('SKJM',VARE,'MNGD',STEP) =  RESNORGE('PJBK',VARE,'MNGD',STEP) ;
RESNORGE('SKJM',VARE,'SKJM',STEP) = (RESNORGE('PJBK',VARE,'PRIS',STEP) - PI(VARE)) *  RESNORGE('PJBK',VARE,'MNGD',STEP);

RESNORGE('SFO','SKJM','VERD',STEP) = SUM(VARE$(PRODUKT(VARE) AND (RESNORGE('PJBK',VARE,'PRIS',STEP) - PI(VARE) GT 0)), (RESNORGE('PJBK',VARE,'PRIS',STEP) - PI(VARE)) *  RESNORGE('PJBK',VARE,'MNGD',STEP));
*
RESNORGE('SFO','OBJW','VERD',STEP) = obj.l;
RESNORGE('SFO','MINT','VERD',STEP) = SUM((VARE,M)$SLTVARE(VARE), p.l(VARE,'CONS',M)*x.l(VARE,'CONS',M));
RESNORGE('SFO','XINT','VERD',STEP) = SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PE(VARE)-TRKOSTEKS(VARE,M))*xe.l(VARE,M));
RESNORGE('SFO','IKST','VERD',STEP) = SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+TRKOSTIMP(VARE,M))*xi.l(VARE,M))
                                   + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                   + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                   + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                   + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M))
                                   + SUM((M,MOEL), MOLDATA('FSOY',MOEL) * PI('FSOY') * h.l(MOEL,M))
                                   + SUM((M,MOEL), MOLDATA('FANT',MOEL) * PI('FANT') * h.l(MOEL,M));
*
RESNORGE('SFO','TOLL','VERD',STEP) = SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), TOLL(VARE)      *xi.l(VARE,M))
                                   + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), KVOTETOLL(VARE) *xq.l(VARE,M))
                                   + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), KVOTETOLLA(VARE)*xqa.l(VARE,M))
                                   + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), KVOTETOLLB(VARE)*xqb.l(VARE,M))
                                   + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), KVOTETOLLS(VARE)*xqs.l(VARE,M))
                                   + SUM((M,MOEL), MOLDATA('FSOY',MOEL) * KVOTETOLLA('FSOY') * h.l(MOEL,M))
                                   + SUM((M,MOEL), MOLDATA('FANT',MOEL) * KVOTETOLLA('FANT') * h.l(MOEL,M));
*
RESNORGE('SFO','TTIL','VERD',STEP) = SUM((VARE,R) $ TILSKUDD(VARE), x.l(VARE,'PRIM',R));
RESNORGE('SFO','GHGD','VERD',STEP) = SUM((R,B,UTSLIPPAVG), SIMDATA(R,B,'MNGD',UTSLIPPAVG) * g.l(B,R) * CO2AVGXP(UTSLIPPAVG) );
RESNORGE('SFO','GHGI','VERD',STEP) = SUM((M,VARE), (xi.l(VARE,M)+xq.l(VARE,M)+xqa.l(VARE,M)+xqb.l(VARE,M)+xqs.l(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));
RESNORGE('SFO','PJBK','VERD',STEP) = SUM((VARE,R)$INNSATSUKFOR(VARE), x.l(VARE,'PRIM',R));
RESNORGE('SFO','SLKK','VERD',STEP) = SUM((SLK,M),  SIMDATA(M,SLK,'PRIS','Y') * h.l(SLK,M));
RESNORGE('SFO','MEIK','VERD',STEP) = SUM((MEIR,M), SIMDATA(M,MEIR,'PRIS','Y') * h.l(MEIR,M));
RESNORGE('SFO','MOEL','VERD',STEP) = SUM((M,MOEL), SIMDATA(M,MOEL,'PRIS','Y') * h.l(MOEL,M));
RESNORGE('SFO','KYLK','VERD',STEP) = SUM((KSLK,M), SIMDATA(M,KSLK,'PRIS','Y') * h.l(KSLK,M));
RESNORGE('SFO','AIND','VERD',STEP) = SUM((VARE,M)$SLTVARE(VARE), FK(VARE,M) * x.l(VARE,'WHLS',M));
RESNORGE('SFO','MARG','VERD',STEP) = SUM((VARE,M)$SLTVARE(VARE), (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x.l(VARE,'CONS',M))
                                   + SUM((VARE,M)$SLTVARE(VARE), (MARGIN(VARE,M,'WHLS')                      ) * xe.l(VARE,M));

RESNORGE('SFO','NTPU','VERD',STEP) =   SUM((MEIR,M), PUSATS(MEIR) * h.l(MEIR,M))
                                     + SUM((M,MEIR,VARE)$MEIINNVARE(VARE), MEIDATA(VARE,MEIR) * PUSATS(MEIR) * xe.l(VARE,M))
                                     + SUM((M,VARE)$MEIINNVARE(VARE), PUINNT(M) * x.l(VARE,'PRIM',M))
                                     + SUM((MEIR,M), PUDISB(MEIR,M) * h.l(MEIR,M))
                                     + SUM((MEIR,VARE,M), PUBISATS(VARE) * h.l(MEIR,M) * MEIDATA(VARE,MEIR));                                   
RESNORGE('SFO','NTIU','VERD',STEP) = SUM((M,SSLK), IU(SSLK) * h.l(SSLK,M));
RESNORGE('SFO','MKIU','VERD',STEP) = SUM((MEIR,M), IUMEIR(MEIR) * h.l(MEIR,M));
RESNORGE('SFO','XTIL','VERD',STEP) = SUM((VARE,M), EKSSUB(VARE) * xe.l(VARE,M));
RESNORGE('SFO','TRTL','VERD',STEP) = SUM((R,VARE)$ (PRODUKT(VARE) AND MEIINNVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                                   + SUM((R,VARE)$ (PRODUKT(VARE) AND SLKINNVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                                   + SUM((R,VARE)$ (PRODUKT(VARE) AND AINDVARE(VARE))  , x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                                   + SUM((R,VARE)$ (PRODUKT(VARE) AND MOELINNVARE(VARE) AND MOELUTVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                                   + SUM((R,VARE)$ MOELUTKVARE(VARE), z.l(VARE,R) * INNFRAKTTIL(R,VARE))
                                   + SUM((MM,VARE)$SUM(VAREVARE, MOELFLYT(VARE,VAREVARE)), uttr.l(VARE,'OEST',MM) * TRKOST(VARE,'OEST',MM));
RESNORGE('SFO','PRND','VERD',STEP) = SUM((M,VARE), x.l(VARE,'PRIM',M) * PRISNED(VARE));
RESNORGE('SFO','MCPF','VERD',STEP) =
                  SUM((VARE,R) $ TILSKUDD(VARE), (MCPF/100) * x.l(VARE,'PRIM',R))
                + SUM((VARE,M), (MCPF/100) * EKSSUB(VARE) * xe.l(VARE,M))
                + SUM((R,VARE)$ (PRODUKT(VARE) AND MEIINNVARE(VARE)) , (MCPF/100) * x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ (PRODUKT(VARE) AND SLKINNVARE(VARE)) , (MCPF/100) * x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ (PRODUKT(VARE) AND AINDVARE(VARE))   , (MCPF/100) * x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ (PRODUKT(VARE) AND MOELINNVARE(VARE) AND MOELUTVARE(VARE)), (MCPF/100) * x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ MOELUTKVARE(VARE)  , z.l(VARE,R)   *    (MCPF/100) * INNFRAKTTIL(R,VARE)) 
                + SUM((MM,VARE)$SUM(VAREVARE, MOELFLYT(VARE,VAREVARE)), (MCPF/100) * uttr.l(VARE,'OEST',MM) * TRKOST(VARE,'OEST',MM))
                + SUM((M,VARE), (MCPF/100) * x.l(VARE,'PRIM',M) * PRISNED(VARE))
                -  SUM((MOELUTVARE,R), (MCPF/100) * z.l(MOELUTVARE,R) * KFORAVG(R,MOELUTVARE))
                -  SUM(R, (MCPF/100) * z.l('NITG',R)  * KFORAVG(R,'NITG'));
*
RESNORGE('SFO','OMST','VERD',STEP) = SUM(VARE, OMSET(VARE) * x.l(VARE,'PRIM','NORGE'));
RESNORGE('SFO','TRSP','VERD',STEP) = SUM((VARE,M,MM), uttr.l(VARE,M,MM)*TRKOST(VARE,M,MM));
RESNORGE('SFO','AVKF','VERD',STEP) = SUM((MOELUTVARE,R), z.l(MOELUTVARE,R) * KFORAVG(R,MOELUTVARE)) ;
RESNORGE('SFO','AVNI','VERD',STEP) = SUM(R, z.l('NITG',R) * KFORAVG(R,'NITG'));
*
$ifthenI.Ecosys %Ecosys%==YES
RESNORGE('SFO','ESLA','VERD',STEP) = SUM(R, landest.l(R) * WTPLandest(R)) ;
RESNORGE('SFO','ESBD','VERD',STEP) = SUM(R, biodiv.l(R)  * WTPBiodiv(R))  ;
RESNORGE('SFO','ESCH','VERD',STEP) = SUM(R, culther.l(R) * WTPCulther(R)) ;
RESNORGE('SFO','ESRC','VERD',STEP) = SUM(R, recreat.l(R) * WTPRecreat(R)) ;
RESNORGE('SFO','EMIS','VERD',STEP) = emis_n.l ;
$endIf.Ecosys
*
$ifthenI.PubHealth %PubHealth%==YES
RESNORGE('SFO','HELS','VERD',STEP) = SUM(KostGrp, helse.l(KostGrp));
$endIf.PubHealth
*
$ifthenI.LUC %LUC%==YES
RESNORGE('SFO','AFOL','VERD',STEP) = SUM((R,CropTypeObj), LUCInn.l(R,CropTypeObj) * LUCCoeff(R,'OTHER',CropTypeObj) * LUCAvg) 
                                   + SUM((R,CropTypeObj), LUCOut.l(R,CropTypeObj) * LUCCoeff(R,CropTypeObj,'OTHER') * LUCAvg); 
$endIf.LUC
*
RESNORGE('SFO','CSWF','VERD',STEP) = 0.5 * SUM((VARE,SVARE,M), x.l(VARE,'CONS',M)*invBeta(VARE,SVARE,M)*x.l(SVARE,'CONS',M));

RESNORGE('SFO','PMP','VERD',STEP) =
                  + SUM((B,R),      PmpProdCnst(R,B) *  g.l(B,R))
                  + SUM((B,R), .5 * PmpProdQuad(R,B) * (g.l(B,R)**2) $ (PmpProdQuad(R,B) < 0))
                  - SUM((B,R), .5 * PmpProdQuad(R,B) * (g.l(B,R)**2) $ (PmpProdQuad(R,B) > 0));
*
RESNORGE(B,'PMP','VERD',STEP) =
                  + SUM(R,      PmpProdCnst(R,B) *  g.l(B,R))
                  + SUM(R, .5 * PmpProdQuad(R,B) * (g.l(B,R)**2) $ (PmpProdQuad(R,B) < 0))
                  - SUM(R, .5 * PmpProdQuad(R,B) * (g.l(B,R)**2) $ (PmpProdQuad(R,B) > 0));
*
RESNORGE('SFO',VARE,'TRTL',STEP) =
                + SUM(R, x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE))
;
RESNORGE('SFO',VARE,'IKST',STEP) $ (PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE))
                                   = SUM(M, (PI(VARE)+TOLL(VARE)+TRKOSTIMP(VARE,M))*xi.l(VARE,M))
                                   + SUM(M, (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
                                   + SUM(M, (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
                                   + SUM(M, (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
                                   + SUM(M, (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
RESNORGE('SFO',VARE,'CSWF',STEP) = 0.5 * SUM((SVARE,M), x.l(VARE,'CONS',M)*invBeta(VARE,SVARE,M)*x.l(SVARE,'CONS',M));
RESNORGE('SFO',VARE,'EgenCSWF',STEP) = 0.5 * SUM((SVARE,M)$SAMEAS(VARE,SVARE),       x.l(VARE,'CONS',M)*invBeta(VARE,SVARE,M)*x.l(SVARE,'CONS',M));
RESNORGE('SFO',VARE,'KrysCSWF',STEP) = 0.5 * SUM((SVARE,M)$(NOT SAMEAS(VARE,SVARE)), x.l(VARE,'CONS',M)*invBeta(VARE,SVARE,M)*x.l(SVARE,'CONS',M));

*Check negative consumer surplus and abort if present
CSWVARE(STEP) = SUM(VARE $ (RESNORGE('SFO',VARE,'CSWF',STEP) < 0), 1);
CSWSET(VARE) $ (RESNORGE('SFO',VARE,'CSWF',STEP) < 0) = YES;
IF ((CSWVARE(STEP) > 1), display CSWSET; abort "Negative consumer surplus"; );

$ifthenI.PubHealth %PubHealth%==YES
RESNORGE('SFO',KostGrp,'HELS',STEP) = helse.l(KostGrp);
$endIf.PubHealth
*
$ifthenI.LUC %LUC%==YES
RESNORGE('SFO',CropTypeObj,'AFOL',STEP) = SUM(R, LUCInn.l(R,CropTypeObj) * LUCCoeff(R,'OTHER',CropTypeObj) * LUCAvg) 
                                        + SUM(R, LUCOut.l(R,CropTypeObj) * LUCCoeff(R,CropTypeObj,'OTHER') * LUCAvg); 

$endIf.LUC

*
* Markedsadgang og markedsregulering
RESNORGE('MAG','PI',VARE,STEP)         =  PI(VARE)      ;
RESNORGE('MAG','PE',VARE,STEP)         =  PE(VARE)      ;
RESNORGE('MAG','TOLL',VARE,STEP)       =  TOLL(VARE)      ;
RESNORGE('MAG','KVOTETOLL',VARE,STEP)  =  KVOTETOLL(VARE) ;
RESNORGE('MAG','KVOTETOLLA',VARE,STEP) =  KVOTETOLLA(VARE);
RESNORGE('MAG','KVOTETOLLB',VARE,STEP) =  KVOTETOLLB(VARE);
RESNORGE('MAG','KVOTETOLLS',VARE,STEP) =  KVOTETOLLS(VARE);
RESNORGE('MAG','Prisned',VARE,STEP)    =  Prisned(VARE);
*
* Skyggepriser balancing
RESNORGE('MC','AREA','NORGE',STEP) = EQAREAL.m;
RESNORGE('MC','AREA',M,STEP) = EQAREAMGLV.m(M);
RESNORGE('MC','KORN','NORGE',STEP) = EQKORNGLV.m;
RESNORGE('MC','KORN',M,STEP) = EQMKORNGLV.m(M);
RESNORGE('MC',PRDK,'NORGE',STEP) = EQPRDKGLV.m(PRDK);
RESNORGE('MC',FULLDYRK,'NORGE',STEP) = RESNORGE('MC',FULLDYRK,'NORGE',STEP) + EQFULLGLV.m(FULLDYRK);
RESNORGE('MC',PRDK,M,STEP) = EQPRDKMGLV.m(PRDK,M);
RESNORGE('MC','ARBF','NORGE',STEP) = EQARBEID.m;
RESNORGE('MC','OVER',F,STEP) = EQOVERGLV.m(F);
RESNORGE('MC','GHG','NORGE',STEP) = EQGHGTAK.m;
RESNORGE('MC','DIETT','NORGE',STEP) = EQDIETT.m('ENER');
*
RESNORGE('LV','AREA','NORGE',STEP) = EQAREAL.l;
RESNORGE('LV','AREA',M,STEP) = EQAREAMGLV.l(M);
RESNORGE('LV','KORN','NORGE',STEP) = EQKORNGLV.l;
RESNORGE('LV','KORN',M,STEP) = EQMKORNGLV.l(M);
RESNORGE('LV',PRDK,'NORGE',STEP) = EQPRDKGLV.l(PRDK);
RESNORGE('LV',FULLDYRK,'NORGE',STEP) = RESNORGE('LV',FULLDYRK,'NORGE',STEP) + EQFULLGLV.l(FULLDYRK);
RESNORGE('LV',PRDK,M,STEP) = EQPRDKMGLV.l(PRDK,M);
RESNORGE('LV','ARBF','NORGE',STEP) = EQARBEID.l;
RESNORGE('LV','OVER',F,STEP) = EQOVERGLV.l(F);
RESNORGE('LV','GHG','NORGE',STEP) = EQGHGTAK.l;
RESNORGE('LV','DIETT','NORGE',STEP) = EQDIETT.l('ENER');

RESNORGE(R,B,'DPAY','VERD') = SUM(TILSKUDD, SIMDATA(R,B,'VERD',TILSKUDD) * g.l(B,R));
RESNORGE(R,B,PRODUKT,'MNGD') = SIMDATA(R,B,'MNGD',PRODUKT) * g.l(B,R);
RESNORGE(R,B,PRODUKT,'PRIS') = SIMDATA(R,PRODUKT,'TOTP','Y');
*
* Tilskudd per produkt
RESNORGE('RIKS','KORN','TIL',STEP)  $ SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R))                          = SUM((R,TILSKUDD), SIMDATA(R,'BKRN','VERD',TILSKUDD) * g.l('BKRN',R)) / SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R));
RESNORGE('RIKS','POTE','TIL',STEP)  $ SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R))                                       = SUM((R,TILSKUDD), SIMDATA(R,'BPTE','VERD',TILSKUDD) * g.l('BPTE',R)) / SUM(R,  SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R));
RESNORGE('RIKS','FRKT','TIL',STEP)  $ SUM(R,(SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R)) = SUM((R,TILSKUDD), SIMDATA(R,'BFRK','VERD',TILSKUDD) * g.l('BFRK',R)) / SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R));
RESNORGE('RIKS','HAGE','TIL',STEP)  $ SUM(R,(SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R)) = SUM((R,TILSKUDD), SIMDATA(R,'BHGE','VERD',TILSKUDD) * g.l('BHGE',R)) / SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R));
RESNORGE('RIKS','KMLK','TIL',STEP)  $ SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R))                                       = SUM((R,TILSKUDD), SIMDATA(R,'BKMK','VERD',TILSKUDD) * g.l('BKMK',R)) / SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R));
RESNORGE('RIKS','STFK','TIL',STEP)  $ SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R))                                       = SUM((R,TILSKUDD), SIMDATA(R,'BAKY','VERD',TILSKUDD) * g.l('BAKY',R)) / SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R));
RESNORGE('RIKS','SAUK','TIL',STEP)  $ SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R))                                       = SUM((R,TILSKUDD), SIMDATA(R,'BSAU','VERD',TILSKUDD) * g.l('BSAU',R)) / SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R));
RESNORGE('RIKS','SVNK','TIL',STEP)  $ SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R))                                       = SUM((R,TILSKUDD), SIMDATA(R,'BGRI','VERD',TILSKUDD) * g.l('BGRI',R)) / SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R));
RESNORGE('RIKS','FJRK','TIL',STEP)  $ SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R))                                       = SUM((R,TILSKUDD), SIMDATA(R,'BKYL','VERD',TILSKUDD) * g.l('BKYL',R)) / SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R));
RESNORGE('RIKS','EGGS','TIL',STEP)  $ SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R))                                       = SUM((R,TILSKUDD), SIMDATA(R,'BHOE','VERD',TILSKUDD) * g.l('BHOE',R)) / SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R));
*
* Kalorier per produkt
RESNORGE('RIKS','KORN','ENER',STEP) $ SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R))                      = SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * NAERING(FFEMKORN,'ENER') * g.l('BKRN',R))                                        / SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R));
RESNORGE('RIKS','POTE','ENER',STEP) $ SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R))                                   = SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * NAERING('POTE','ENER') * g.l('BPTE',R))                                                    / SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R));
RESNORGE('RIKS','FRKT','ENER',STEP) $ SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R)) = SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')*NAERING('EPLE','ENER')+SIMDATA(R,'BFRK','MNGD','AFRU')*NAERING('AFRU','ENER')) * g.l('BFRK',R))  / SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R));
RESNORGE('RIKS','HAGE','ENER',STEP) $ SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R)) = SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')*NAERING('GRNV','ENER')+SIMDATA(R,'BHGE','MNGD','GRNF')*NAERING('GRNF','ENER')) * g.l('BHGE',R))  / SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R));
RESNORGE('RIKS','KMLK','ENER',STEP) $ SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R))                                   = SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * NAERING('KMLK','ENER') * g.l('BKMK',R))                                                     / SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R));
RESNORGE('RIKS','STFK','ENER',STEP) $ SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R))                                   = SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * NAERING('STFK','ENER') * g.l('BAKY',R))                                                     / SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R));
RESNORGE('RIKS','SAUK','ENER',STEP) $ SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R))                                   = SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * NAERING('SAUK','ENER') * g.l('BSAU',R))                                                     / SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R));
RESNORGE('RIKS','SVNK','ENER',STEP) $ SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R))                                   = SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * NAERING('SVNK','ENER') * g.l('BGRI',R))                                                     / SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R));
RESNORGE('RIKS','FJRK','ENER',STEP) $ SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R))                                   = SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * NAERING('FJRK','ENER') * g.l('BKYL',R))                                                     / SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R));
RESNORGE('RIKS','EGGS','ENER',STEP) $ SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R))                                   = SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * NAERING('EGGS','ENER') * g.l('BHOE',R))                                                     / SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R));
*
* Protein per produkt
RESNORGE('RIKS','KORN','PROT',STEP) $ SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R))              = SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * NAERING(FFEMKORN,'PROT') * g.l('BKRN',R))                                        / SUM((R,FFEMKORN,B), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R));
RESNORGE('RIKS','POTE','PROT',STEP) $ SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R))                              = SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * NAERING('POTE','PROT') * g.l('BPTE',R))                                                     / SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R));
RESNORGE('RIKS','FRKT','PROT',STEP) $ SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R)) = SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')*NAERING('EPLE','PROT')+SIMDATA(R,'BFRK','MNGD','AFRU') * NAERING('AFRU','PROT')) * g.l('BFRK',R))  / SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R));
RESNORGE('RIKS','HAGE','PROT',STEP) $ SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R)) = SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')*NAERING('GRNV','PROT')+SIMDATA(R,'BHGE','MNGD','GRNF') * NAERING('GRNF','PROT')) * g.l('BHGE',R))  / SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R));
RESNORGE('RIKS','KMLK','PROT',STEP) $ SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R))                              = SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * NAERING('KMLK','PROT') * g.l('BKMK',R))                                                     / SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R));
RESNORGE('RIKS','STFK','PROT',STEP) $ SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R))                              = SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * NAERING('STFK','PROT') * g.l('BAKY',R))                                                     / SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R));
RESNORGE('RIKS','SAUK','PROT',STEP) $ SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R))                              = SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * NAERING('SAUK','PROT') * g.l('BSAU',R))                                                     / SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R));
RESNORGE('RIKS','SVNK','PROT',STEP) $ SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R))                              = SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * NAERING('SVNK','PROT') * g.l('BGRI',R))                                                     / SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R));
RESNORGE('RIKS','FJRK','PROT',STEP) $ SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R))                              = SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * NAERING('FJRK','PROT') * g.l('BKYL',R))                                                     / SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R));
RESNORGE('RIKS','EGGS','PROT',STEP) $ SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R))                              = SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * NAERING('EGGS','PROT') * g.l('BHOE',R))                                                     / SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R));
*
* CO2 per produkt
RESNORGE('RIKS','KORN','CO2',STEP)  $ SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R))                    = SUM(R, SIMDATA(R,'BKRN','MNGD','CO2') * g.l('BKRN',R)) / SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R));
RESNORGE('RIKS','POTE','CO2',STEP)  $ SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R))                                   = SUM(R, SIMDATA(R,'BPTE','MNGD','CO2') * g.l('BPTE',R)) / SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R));
RESNORGE('RIKS','FRKT','CO2',STEP)  $ SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R)) = SUM(R, SIMDATA(R,'BFRK','MNGD','CO2') * g.l('BFRK',R)) / SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R));
RESNORGE('RIKS','HAGE','CO2',STEP)  $ SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R)) = SUM(R, SIMDATA(R,'BHGE','MNGD','CO2') * g.l('BHGE',R)) / SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BFRK','MNGD','GRNF')) * g.l('BHGE',R));
RESNORGE('RIKS','KMLK','CO2',STEP)  $ SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R))                               = SUM(R, SIMDATA(R,'BKMK','MNGD','CO2') * g.l('BKMK',R)) / SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R));
RESNORGE('RIKS','STFK','CO2',STEP)  $ SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R))                               = SUM(R, SIMDATA(R,'BAKY','MNGD','CO2') * g.l('BAKY',R)) / SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R));
RESNORGE('RIKS','SAUK','CO2',STEP)  $ SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R))                               = SUM(R, SIMDATA(R,'BSAU','MNGD','CO2') * g.l('BSAU',R)) / SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R));
RESNORGE('RIKS','SVNK','CO2',STEP)  $ SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R))                               = SUM(R, SIMDATA(R,'BGRI','MNGD','CO2') * g.l('BGRI',R)) / SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R));
RESNORGE('RIKS','FJRK','CO2',STEP)  $ SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R))                               = SUM(R, SIMDATA(R,'BKYL','MNGD','CO2') * g.l('BKYL',R)) / SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R));
RESNORGE('RIKS','EGGS','CO2',STEP)  $ SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R))                               = SUM(R, SIMDATA(R,'BHOE','MNGD','CO2') * g.l('BHOE',R)) / SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R));
*
* CH4 per produkt
RESNORGE('RIKS','KORN','CH4',STEP)  $ SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R))                  = SUM(R, SIMDATA(R,'BKRN','MNGD','CH4') * g.l('BKRN',R)) / SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R));
RESNORGE('RIKS','POTE','CH4',STEP)  $ SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R))                               = SUM(R, SIMDATA(R,'BPTE','MNGD','CH4') * g.l('BPTE',R)) / SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R));
RESNORGE('RIKS','FRKT','CH4',STEP)  $ SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R))  = SUM(R, SIMDATA(R,'BFRK','MNGD','CH4') * g.l('BFRK',R)) / SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R));
RESNORGE('RIKS','HAGE','CH4',STEP)  $ SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R))  = SUM(R, SIMDATA(R,'BHGE','MNGD','CH4') * g.l('BHGE',R)) / SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R));
RESNORGE('RIKS','KMLK','CH4',STEP)  $ SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R))                               = SUM(R, SIMDATA(R,'BKMK','MNGD','CH4') * g.l('BKMK',R)) / SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R));
RESNORGE('RIKS','STFK','CH4',STEP)  $ SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R))                               = SUM(R, SIMDATA(R,'BAKY','MNGD','CH4') * g.l('BAKY',R)) / SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R));
RESNORGE('RIKS','SAUK','CH4',STEP)  $ SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R))                               = SUM(R, SIMDATA(R,'BSAU','MNGD','CH4') * g.l('BSAU',R)) / SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R));
RESNORGE('RIKS','SVNK','CH4',STEP)  $ SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R))                               = SUM(R, SIMDATA(R,'BGRI','MNGD','CH4') * g.l('BGRI',R)) / SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R));
RESNORGE('RIKS','FJRK','CH4',STEP)  $ SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R))                               = SUM(R, SIMDATA(R,'BKYL','MNGD','CH4') * g.l('BKYL',R)) / SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R));
RESNORGE('RIKS','EGGS','CH4',STEP)  $ SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R))                               = SUM(R, SIMDATA(R,'BHOE','MNGD','CH4') * g.l('BHOE',R)) / SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R));
*
* N2O per produkt
RESNORGE('RIKS','KORN','N2O',STEP)  $ SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R))                    = SUM(R, SIMDATA(R,'BKRN','MNGD','N2O') * g.l('BKRN',R)) / SUM((R,FFEMKORN,B), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R));
RESNORGE('RIKS','POTE','N2O',STEP)  $ SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R))                               = SUM(R, SIMDATA(R,'BPTE','MNGD','N2O') * g.l('BPTE',R)) / SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R));
RESNORGE('RIKS','FRKT','N2O',STEP)  $ SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R))  = SUM(R, SIMDATA(R,'BFRK','MNGD','N2O') * g.l('BFRK',R)) / SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R));
RESNORGE('RIKS','HAGE','N2O',STEP)  $ SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R))  = SUM(R, SIMDATA(R,'BHGE','MNGD','N2O') * g.l('BHGE',R)) / SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R));
RESNORGE('RIKS','KMLK','N2O',STEP)  $ SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R))                               = SUM(R, SIMDATA(R,'BKMK','MNGD','N2O') * g.l('BKMK',R)) / SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R));
RESNORGE('RIKS','STFK','N2O',STEP)  $ SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R))                               = SUM(R, SIMDATA(R,'BAKY','MNGD','N2O') * g.l('BAKY',R)) / SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R));
RESNORGE('RIKS','SAUK','N2O',STEP)  $ SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R))                               = SUM(R, SIMDATA(R,'BSAU','MNGD','N2O') * g.l('BSAU',R)) / SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R));
RESNORGE('RIKS','SVNK','N2O',STEP)  $ SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R))                               = SUM(R, SIMDATA(R,'BGRI','MNGD','N2O') * g.l('BGRI',R)) / SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R));
RESNORGE('RIKS','FJRK','N2O',STEP)  $ SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R))                               = SUM(R, SIMDATA(R,'BKYL','MNGD','N2O') * g.l('BKYL',R)) / SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R));
RESNORGE('RIKS','EGGS','N2O',STEP)  $ SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R))                               = SUM(R, SIMDATA(R,'BHOE','MNGD','N2O') * g.l('BHOE',R)) / SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R));
*
* Areal per produkt
RESNORGE('RIKS','KORN','AREA',STEP) $ SUM((R,FFEMKORN), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R))                 = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BKRN','OMFG',PLANTE) * g.l('BKRN',R)) / SUM((R,FFEMKORN,B), SIMDATA(R,'BKRN','MNGD',FFEMKORN) * g.l('BKRN',R));
RESNORGE('RIKS','POTE','AREA',STEP) $ SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R))                              = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BPTE','OMFG',PLANTE) * g.l('BPTE',R)) / SUM(R, SIMDATA(R,'BPTE','MNGD','POTE') * g.l('BPTE',R));
RESNORGE('RIKS','FRKT','AREA',STEP) $ SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R)) = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BFRK','OMFG',PLANTE) * g.l('BFRK',R)) / SUM(R, (SIMDATA(R,'BFRK','MNGD','EPLE')+SIMDATA(R,'BFRK','MNGD','AFRU')) * g.l('BFRK',R));
RESNORGE('RIKS','HAGE','AREA',STEP) $ SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R)) = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BHGE','OMFG',PLANTE) * g.l('BHGE',R)) / SUM(R, (SIMDATA(R,'BHGE','MNGD','GRNV')+SIMDATA(R,'BHGE','MNGD','GRNF')) * g.l('BHGE',R));
RESNORGE('RIKS','KMLK','AREA',STEP) $ SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R))                              = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BKMK','OMFG',PLANTE) * g.l('BKMK',R)) / SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R));
RESNORGE('RIKS','STFK','AREA',STEP) $ SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R))                              = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BAKY','OMFG',PLANTE) * g.l('BAKY',R)) / SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R));
RESNORGE('RIKS','SAUK','AREA',STEP) $ SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R))                              = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BSAU','OMFG',PLANTE) * g.l('BSAU',R)) / SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R));
RESNORGE('RIKS','SVNK','AREA',STEP) $ SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R))                              = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BGRI','OMFG',PLANTE) * g.l('BGRI',R)) / SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R));
RESNORGE('RIKS','FJRK','AREA',STEP) $ SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R))                              = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BKYL','OMFG',PLANTE) * g.l('BKYL',R)) / SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R));
RESNORGE('RIKS','EGGS','AREA',STEP) $ SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R))                              = SUM((R,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,'BHOE','OMFG',PLANTE) * g.l('BHOE',R)) / SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R));
*
* Kraftf?r
RESNORGE('RIKS','KMLK','KFOR',STEP) $ SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R)) = SUM(R, SIMDATA(R,'BKMK','MNGD','FDRM') * g.l('BKMK',R)) / SUM(R, SIMDATA(R,'BKMK','MNGD','KMLK') * g.l('BKMK',R));
RESNORGE('RIKS','STFK','KFOR',STEP) $ SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R)) = SUM(R, SIMDATA(R,'BAKY','MNGD','FDRA') * g.l('BAKY',R)) / SUM(R, SIMDATA(R,'BAKY','MNGD','STFK') * g.l('BAKY',R));
RESNORGE('RIKS','SAUK','KFOR',STEP) $ SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R)) = SUM(R, SIMDATA(R,'BSAU','MNGD','FDRM') * g.l('BSAU',R)) / SUM(R, SIMDATA(R,'BSAU','MNGD','SAUK') * g.l('BSAU',R));
RESNORGE('RIKS','SVNK','KFOR',STEP) $ SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R)) = SUM(R, SIMDATA(R,'BGRI','MNGD','FSVN') * g.l('BGRI',R)) / SUM(R, SIMDATA(R,'BGRI','MNGD','SVNK') * g.l('BGRI',R));
RESNORGE('RIKS','FJRK','KFOR',STEP) $ SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R)) = SUM(R, SIMDATA(R,'BKYL','MNGD','FKYL') * g.l('BKYL',R)) / SUM(R, SIMDATA(R,'BKYL','MNGD','FJRK') * g.l('BKYL',R));
RESNORGE('RIKS','EGGS','KFOR',STEP) $ SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R)) = SUM(R, SIMDATA(R,'BHOE','MNGD','FEGG') * g.l('BHOE',R)) / SUM(R, SIMDATA(R,'BHOE','MNGD','EGGS') * g.l('BHOE',R));

*************************
*** Update to next iteration
***********************
*Beregne nye mengder kjoett (lower bound to ensure feasibility)
SIMDATA(M,VARE,'MNGD','Y')$(SLTVARE(VARE) AND SLKVARE(VARE)) = MAX[SIMDATA(M,VARE,'MNGD','BAS') * .25, x.l(VARE,'CONS',M)];
SIMDATA(M,VARE,'MNGD','Y')$SLKINNVARE(VARE) = MAX[SIMDATA(M,VARE,'MNGD','BAS') * .25, x.l(VARE,'PRIM',M) + xi.l(VARE,M) + xq.l(VARE,M) + xqa.l(VARE,M) + xqb.l(VARE,M) + xqs.l(VARE,M) - xe.l(VARE,M)];
*
KonvergensTest(M,VARE,'MNGD','Y',STEP)$(SLTVARE(VARE) AND SLKVARE(VARE)) = MAX[SIMDATA(M,VARE,'MNGD','BAS') * .25, x.l(VARE,'CONS',M)];
KonvergensTest(M,VARE,'MNGD','Y',STEP)$SLKINNVARE(VARE) = MAX[SIMDATA(M,VARE,'MNGD','BAS') * .25, x.l(VARE,'PRIM',M) + xi.l(VARE,M) + xq.l(VARE,M) + xqa.l(VARE,M) + xqb.l(VARE,M) + xqs.l(VARE,M) - xe.l(VARE,M)];
*
* Beregning av samlet raavare  kjoett
KJRAAVARE(M) = SUM(SLKINNVARE, SIMDATA(M,SLKINNVARE,'MNGD','Y'));
SIMDATA(M,'STKK','MNGD','Y') = SIMDATA(M,'STFK','MNGD','Y') + SIMDATA(M,'KLVK','MNGD','Y');
SIMDATA(M,'SAGK','MNGD','Y') = SIMDATA(M,'SAUK','MNGD','Y') + SIMDATA(M,'GETK','MNGD','Y');
*
* Beregne nye mengder melk
SIMDATA(M,MEIVARE,'MNGD','Y') = x.l(MEIVARE,'PRIM',M);
SIMDATA(M,MEIINNVARE,'MNGD','Y') = x.l(MEIINNVARE,'PRIM',M);
*
KonvergensTest(M,MEIVARE,'MNGD','Y',STEP) = x.l(MEIVARE,'PRIM',M);
KonvergensTest(M,MEIINNVARE,'MNGD','Y',STEP) = x.l(MEIINNVARE,'PRIM',M);

* Beregne nytt antall melke og kjoettprodusenter
PROD_SLK(M) = SUM((R,BSLK)$(R_TIL_M(M,R) $ RBActive(R,BSLK)), g.l(BSLK,R)) * 1000;
PROD_MEI(M) = SUM((R,BMEI)$(R_TIL_M(M,R) $ RBActive(R,BMEI)), g.l(BMEI,R)) * 1000;
RESNORGE('NORGE','GARD','SLK',STEP)  = SUM((R,BSLK), g.l(BSLK,R)) * 1000;
RESNORGE('NORGE','GARD','MEI',STEP)  = SUM((R,BMEI), g.l(BMEI,R)) * 1000;
***
KonvergensTest(M,'Prod_SLK','','',STEP) = SUM((R,BSLK)$(R_TIL_M(M,R) $ RBActive(R,BSLK)), g.l(BSLK,R)) * 1000;
KonvergensTest(M,'Prod_MEI','','',STEP) = SUM((R,BMEI)$(R_TIL_M(M,R) $ RBActive(R,BMEI)), g.l(BMEI,R)) * 1000;
KonvergensTest('NORGE','GARD','SLK','',STEP) = SUM((R,BSLK), g.l(BSLK,R)) * 1000;
KonvergensTest('NORGE','GARD','MEI','',STEP) = SUM((R,BMEI), g.l(BMEI,R)) * 1000;

*** Update market regulation for cereals
* Assumption: Target producer price for cereals and feed concentrates
SIMDATA(R,VARE,'TOTP','Y') $ MOELINNVARE(VARE) = MaalPris(VARE);
SIMDATA('NORGE',VARE,'TOTP','Y') $ ((     SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R)) gt eps) AND MOELINNVARE(VARE)) =  SUM((R,B),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R)) / SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R));
SIMDATA('NORGE',VARE,'TOTP','Y') $ ((NOT SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R))) AND MOELINNVARE(VARE)) =  SIMDATA('011101',VARE,'TOTP','Y');
*
KonvergensTest(R,VARE,'TOTP','Y','0') $ MOELINNVARE(VARE) = Data(R,VARE,'TOTP','BAS');
KonvergensTest(R,VARE,'TOTP','Y',STEP) $ MOELINNVARE(VARE) = MaalPris(VARE);
KonvergensTest('NORGE',VARE,'TOTP','Y',STEP) $ ((     SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R)) gt eps) AND MOELINNVARE(VARE)) =  SUM((R,B),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R)) / SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R));
KonvergensTest('NORGE',VARE,'TOTP','Y',STEP) $ ((NOT SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R))) AND MOELINNVARE(VARE)) =  SIMDATA('011101',VARE,'TOTP','Y');
*
KonvergensTest(R,VARE,'TOTP','Y','0') $ MOELINNVARE(VARE) = MaalPris(VARE);
KonvergensTest('NORGE',VARE,'TOTP','Y','0') $ ((     SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R)) gt eps) AND MOELINNVARE(VARE)) =  DATA('NORGE',VARE,'TOTP','BAS');
KonvergensTest('NORGE',VARE,'TOTP','Y','0') $ ((NOT SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R))) AND MOELINNVARE(VARE)) =  DATA('011101',VARE,'TOTP','BAS');

* Transport subsidies Update innfrakttilskudd moellevarer
INNFRAKTTIL(R,VARE) $ MOELUTKVARE(VARE) = max(0, SUM(M$R_til_M(M,R), (-EQMOELUTBAL.m(VARE,M))) - (-EQMOELUTBAL.m(VARE,'OEST')) );
*
KonvergensTest('INNFRAKTTIL',R,VARE,'',STEP) $ MOELUTKVARE(VARE) = max(0, SUM(M$R_til_M(M,R), (-EQMOELUTBAL.m(VARE,M))) - (-EQMOELUTBAL.m(VARE,'OEST')) );
*
* Update parameter for market regulation for cereals
KVOTETOLLA(MOELINNVARE)  = MAX(0, MaalPris(MOELINNVARE)  - PRISNED(MOELINNVARE) - PI(MOELINNVARE));
PRISNED(MOELINNVARE) = PRISNEDBAS(MOELINNVARE);
*
KonvergensTest('KVOTETOLLA',MOELINNVARE,'','',STEP)  = MAX(0, MaalPris(MOELINNVARE)  - PRISNED(MOELINNVARE) - PI(MOELINNVARE));
KonvergensTest('KVOTETOLLA',MOELINNVARE,'','','0')  = MagTest('NORGE',MOELINNVARE,'KVOTETOLLA','test');
KonvergensTest('PRISNED',MOELINNVARE,'','',STEP) = PRISNEDBAS(MOELINNVARE);
KonvergensTest('PRISNED',MOELINNVARE,'','','0') = PRISNEDBAS(MOELINNVARE);
*
* Prices for feed concentrates changes with deviation from calibration price
SIMDATA(R,VARE,'TOTP','Y') $ (MOELUTKVARE(VARE) $ SUM(M$R_TIL_M(M,R), -EQMOELUTBAL.m(VARE,M))) =
 DATA(R,VARE,'TOTP','BAS') * SUM(M$R_TIL_M(M,R), -EQMOELUTBAL.m(VARE,M)) / StartProducerPrice(R,VARE) ;
*
KonvergensTest(R,VARE,'TOTP','Y',STEP) $ (MOELUTKVARE(VARE) $ SUM(M$R_TIL_M(M,R), -EQMOELUTBAL.m(VARE,M))) =
 DATA(R,VARE,'TOTP','BAS') * SUM(M$R_TIL_M(M,R), -EQMOELUTBAL.m(VARE,M)) / StartProducerPrice(R,VARE) ;

SIMDATA('NORGE',VARE,'TOTP','Y') $ (SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R)) AND MOELUTKVARE(VARE)) =  SUM((R,B),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R)) / SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R));
KonvergensTest('NORGE',VARE,'TOTP','Y',STEP) $ (SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R)) AND MOELUTKVARE(VARE)) =  SUM((R,B),  SIMDATA(R,B,'VERD',VARE) * g.l(B,R)) / SUM((R,B),  SIMDATA(R,B,'MNGD',VARE) * g.l(B,R));
*
SIMDATA(R,'SAAK','TOTP','Y') = DATA(R,'SAAK','TOTP','BAS') + SIMDATA(R,'BYGF','TOTP','Y') - DATA(R,'BYGF','TOTP','BAS');
KonvergensTest(R,'SAAK','TOTP','Y',STEP) = DATA(R,'SAAK','TOTP','BAS') + SIMDATA(R,'BYGF','TOTP','Y') - DATA(R,'BYGF','TOTP','BAS');
KonvergensTest(R,'SAAK','TOTP','Y','0') = DATA(R,'SAAK','TOTP','BAS') ;
*
* Nye priser for meierivarer
SIMDATA(R,VARE,'TOTP','Y') $ (SUM(M$R_TIL_M(M,R), EQMELKBAL.m(VARE,M)) AND SUM(M$R_TIL_M(M,R),x.l(VARE,'PRIM',M))) =
        DATA(R,VARE,'TOTP','BAS')  * SUM(M$R_TIL_M(M,R), EQMELKBAL.m(VARE,M)) / StartProducerPrice(R,VARE) ;

KonvergensTest(R,VARE,'TOTP','Y',STEP) $ (SUM(M$R_TIL_M(M,R), EQMELKBAL.m(VARE,M)) AND SUM(M$R_TIL_M(M,R),x.l(VARE,'PRIM',M))) =
        DATA(R,VARE,'TOTP','BAS')  * SUM(M$R_TIL_M(M,R), EQMELKBAL.m(VARE,M)) / StartProducerPrice(R,VARE) ;

SIMDATA('NORGE',MEIINNVARE,'TOTP','Y') $  SUM(M, x.l(MEIINNVARE,'PRIM',M)) = SUM(M, EQMELKBAL.m(MEIINNVARE,M) * x.l(MEIINNVARE,'PRIM',M)) / SUM(M, x.l(MEIINNVARE,'PRIM',M));
KonvergensTest('NORGE',MEIINNVARE,'TOTP','Y',STEP) $  SUM(M, x.l(MEIINNVARE,'PRIM',M)) = SUM(M, EQMELKBAL.m(MEIINNVARE,M) * x.l(MEIINNVARE,'PRIM',M)) / SUM(M, x.l(MEIINNVARE,'PRIM',M));

** Bruk regional pris for kjoettprodukter
SIMDATA(R,'STFK','TOTP','Y') $ SUM(M, EQSTKKBAL.m(M)) = DATA(R,'STFK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSTKKBAL.m(M)) / StartProducerPrice(R,'STFK');
SIMDATA(R,'KLVK','TOTP','Y') $ SUM(M, EQSTKKBAL.m(M)) = DATA(R,'KLVK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSTKKBAL.m(M)) / StartProducerPrice(R,'KLVK');
SIMDATA(R,'SAUK','TOTP','Y') $ SUM(M, EQSAGKBAL.m(M)) = DATA(R,'SAUK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSAGKBAL.m(M)) / StartProducerPrice(R,'SAUK');
SIMDATA(R,'GETK','TOTP','Y') $ SUM(M, EQSAGKBAL.m(M)) = DATA(R,'GETK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSAGKBAL.m(M)) / StartProducerPrice(R,'GETK');
SIMDATA(R,'SVNK','TOTP','Y') $ SUM(M, EQSVNKBAL.m(M)) = DATA(R,'SVNK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSVNKBAL.m(M)) / StartProducerPrice(R,'SVNK');
SIMDATA(R,'FJRK','TOTP','Y') $ SUM(M, EQFJRKBAL.m(M)) = DATA(R,'FJRK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQFJRKBAL.m(M)) / StartProducerPrice(R,'FJRK');
*
KonvergensTest(R,'STFK','TOTP','Y',STEP) $ SUM(M, EQSTKKBAL.m(M)) = DATA(R,'STFK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSTKKBAL.m(M)) / StartProducerPrice(R,'STFK');
KonvergensTest(R,'KLVK','TOTP','Y',STEP) $ SUM(M, EQSTKKBAL.m(M)) = DATA(R,'KLVK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSTKKBAL.m(M)) / StartProducerPrice(R,'KLVK');
KonvergensTest(R,'SAUK','TOTP','Y',STEP) $ SUM(M, EQSAGKBAL.m(M)) = DATA(R,'SAUK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSAGKBAL.m(M)) / StartProducerPrice(R,'SAUK');
KonvergensTest(R,'GETK','TOTP','Y',STEP) $ SUM(M, EQSAGKBAL.m(M)) = DATA(R,'GETK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSAGKBAL.m(M)) / StartProducerPrice(R,'GETK');
KonvergensTest(R,'SVNK','TOTP','Y',STEP) $ SUM(M, EQSVNKBAL.m(M)) = DATA(R,'SVNK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQSVNKBAL.m(M)) / StartProducerPrice(R,'SVNK');
KonvergensTest(R,'FJRK','TOTP','Y',STEP) $ SUM(M, EQFJRKBAL.m(M)) = DATA(R,'FJRK','TOTP','BAS') * SUM(M$R_TIL_M(M,R), EQFJRKBAL.m(M)) / StartProducerPrice(R,'FJRK');

** Beregne produsentpris for kjoettprodukter per markedsregion
SIMDATA(M,SLKINNVARE,'TOTP','Y') $ SUM(R$R_TIL_M(M,R), x.l(SLKINNVARE,'PRIM',R)) =
SUM(R$R_TIL_M(M,R), SIMDATA(R,SLKINNVARE,'TOTP','Y') * x.l(SLKINNVARE,'PRIM',R))
 / SUM(R$R_TIL_M(M,R), x.l(SLKINNVARE,'PRIM',R));

KonvergensTest(M,SLKINNVARE,'TOTP','Y',STEP) $ SUM(R$R_TIL_M(M,R), x.l(SLKINNVARE,'PRIM',R)) =
SUM(R$R_TIL_M(M,R), SIMDATA(R,SLKINNVARE,'TOTP','Y') * x.l(SLKINNVARE,'PRIM',R))
 / SUM(R$R_TIL_M(M,R), x.l(SLKINNVARE,'PRIM',R));

SIMDATA(M,'STKK','TOTP','Y') $ (SIMDATA(M,'STFK','MNGD','Y') + SIMDATA(M,'KLVK','MNGD','Y')) =
( SIMDATA(M,'STFK','TOTP','Y') * SIMDATA(M,'STFK','MNGD','Y')
+ SIMDATA(M,'KLVK','TOTP','Y') * SIMDATA(M,'KLVK','MNGD','Y')
) / (SIMDATA(M,'STFK','MNGD','Y') + SIMDATA(M,'KLVK','MNGD','Y'));
*
SIMDATA(M,'SAGK','TOTP','Y') $ (SIMDATA(M,'SAUK','MNGD','Y') + SIMDATA(M,'GETK','MNGD','Y')) =
( SIMDATA(M,'SAUK','TOTP','Y') * SIMDATA(M,'SAUK','MNGD','Y')
+ SIMDATA(M,'GETK','TOTP','Y') * SIMDATA(M,'GETK','MNGD','Y')
) / (SIMDATA(M,'SAUK','MNGD','Y') + SIMDATA(M,'GETK','MNGD','Y'));

KonvergensTest(M,'STKK','TOTP','Y',STEP) $ (SIMDATA(M,'STFK','MNGD','Y') + SIMDATA(M,'KLVK','MNGD','Y')) =
( SIMDATA(M,'STFK','TOTP','Y') * SIMDATA(M,'STFK','MNGD','Y')
+ SIMDATA(M,'KLVK','TOTP','Y') * SIMDATA(M,'KLVK','MNGD','Y')
) / (SIMDATA(M,'STFK','MNGD','Y') + SIMDATA(M,'KLVK','MNGD','Y'));

KonvergensTest(M,'SAGK','TOTP','Y',STEP) $ (SIMDATA(M,'SAUK','MNGD','Y') + SIMDATA(M,'GETK','MNGD','Y')) =
( SIMDATA(M,'SAUK','TOTP','Y') * SIMDATA(M,'SAUK','MNGD','Y')
+ SIMDATA(M,'GETK','TOTP','Y') * SIMDATA(M,'GETK','MNGD','Y')
) / (SIMDATA(M,'SAUK','MNGD','Y') + SIMDATA(M,'GETK','MNGD','Y'));

* Update transport subsidies for meat
INNFRAKTTIL(R,VARE) $ (PRODUKT(VARE) AND SLKINNVARE(VARE)) = INNFRAKTTILKJOETT(R,VARE);
KonvergensTest('INNFRAKTTIL',R,VARE,'',STEP) $ (PRODUKT(VARE) AND SLKINNVARE(VARE)) = INNFRAKTTILKJOETT(R,VARE);
*
* Nye priser for varer med faste foredlingskostnader
SIMDATA(R,VARE,'TOTP','Y') $ (SUM(M$R_TIL_M(M,R), FK(VARE,M)) > 0) = DATA(R,VARE,'TOTP','BAS') * SUM(M$R_TIL_M(M,R), p.l(VARE,'CONS',M) - FK(VARE,M)) / StartProducerPrice(R,VARE);
KonvergensTest(R,VARE,'TOTP','Y',STEP) $ (SUM(M$R_TIL_M(M,R), FK(VARE,M)) > 0) = DATA(R,VARE,'TOTP','BAS') * SUM(M$R_TIL_M(M,R), p.l(VARE,'CONS',M) - FK(VARE,M)) / StartProducerPrice(R,VARE);
*
* Ensure non-negative producer prices (it happens that equilibrium prices become negative)
SIMDATA(R,VARE,'TOTP','Y') = MAX(0, SIMDATA(R,VARE,'TOTP','Y'));
SIMDATA(M,VARE,'TOTP','Y') = MAX(0, SIMDATA(M,VARE,'TOTP','Y'));
*
KonvergensTest(R,VARE,'TOTP_Maks','Y',STEP) = MAX(0, SIMDATA(R,VARE,'TOTP','Y'));
KonvergensTest(M,VARE,'TOTP_Maks','Y',STEP) = MAX(0, SIMDATA(M,VARE,'TOTP','Y'));

KonvergensTest(R,B,'','',STEP) = g.l(B,R);


**** Lagre og oppdatere endogene tilskudd skrives til TENDO
*SATSER('TENDO',PLANTE,'0','0') $ ((NOT SAMEAS('GFUB',PLANTE)) $ EQAREAL.l) =  SATSER('TENDO',PLANTE,'0','0') + (-EQAREAL.m) * .5 ;
*SATSER('TENDO',PLANTE,'0','0') $ ((NOT SAMEAS('GFUB',PLANTE)) $ EQAREALUBENG.l) =  SATSER('TENDO',PLANTE,'0','0') + (-EQAREALUBENG.m) * .5 ;
*SATSER('TENDO',PLANTE,'0','0') $ EQAREAGLV.l =  SATSER('TENDO',PLANTE,'0','0') + (-EQAREAGLV.m) * .5 ;
*SATSER('TENDO',PLANTE,'0',R) $ ((NOT SAMEAS('GFUB',PLANTE)) $ SUM(M $ R_TIL_M(M,R), EQAREAMGLV.l(M))) =  SATSER('TENDO',PLANTE,'0',R) + SUM(M $ R_TIL_M(M,R), (-EQAREAMGLV.m(M))) * .5 ;
*SATSER('TENDO',GROV,'0','0') $ EQGROVGLV.l =  SATSER('TENDO',GROV,'0','0') + (-EQGROVGLV.m) * .5 ;
*SATSER('TENDO',FULLDYRK,'0','0') $ EQFULLGLV.l(FULLDYRK) =  SATSER('TENDO',FULLDYRK,'0','0') + (-EQFULLGLV.m(FULLDYRK)) * .5 ;
*SATSER('TENDO',OVERDYRK,'0',R) $ SUM(F $ R_TIL_F(F,R), EQOVERGLV.l(F)) =  SATSER('TENDO',OVERDYRK,'0',R) + SUM(F $ R_TIL_F(F,R), (-EQOVERGLV.m(F))) * .5 ;
*SATSER('TENDO',PRDK,'0','0') $ (BEIT(PRDK) $ EQBEITE.l) =  SATSER('TENDO',PRDK,'0','0') + (-EQBEITE.m) * .5 ;
*SATSER('TENDO',PLANTE,'0',R) $ ((NOT SAMEAS('GFUB',PLANTE)) $ EQRRGLVAREAL.l(R)) =  SATSER('TENDO',PLANTE,'0',R) + (-EQRRGLVAREAL.m(R)) * .5 ;
*SATSER('TENDO',PLANTE,'0',R) $ ((NOT SAMEAS('GFUB',PLANTE)) $ R_TIL_SD('000100',R) $ EQSENGLVAREAL.l) =  SATSER('TENDO',PLANTE,'0',R) + (-EQSENGLVAREAL.m) * .5 ;
*SATSER('TENDO',PLANTE,'0',R) $ ((NOT SAMEAS('GFUB',PLANTE)) $ R_TIL_SD('000100',R) $ EQDISGLVAREAL.l) =  SATSER('TENDO',PLANTE,'0',R) + (-EQDISGLVAREAL.m) * .5 ;
*SATSER('TENDO',PLANTE,'0',R) $ ((NOT SAMEAS('GFUB',PLANTE)) $ SUM(DG $ R_TIL_DG(DG,R), EQDGGLVAREAL.l(DG))) =  SATSER('TENDO',PLANTE,'0',R) + SUM(DG $ R_TIL_DG(DG,R), (-EQDGGLVAREAL.m(DG))) * .5 ;
*SATSER('TENDO',KORN,'0','0') $ EQKORNGLV.l =  SATSER('TENDO',KORN,'0','0') + (-EQKORNGLV.m) * .5 ;
*SATSER('TENDO',KORN,'0',R) $ SUM(M $ R_TIL_M(M,R), EQMKORNGLV.l(M)) =  SATSER('TENDO',KORN,'0',R) + SUM(M $ R_TIL_M(M,R), (-EQMKORNGLV.m(M))) * .5 ;
*SATSER('TENDO',KORN,'0',R) $ EQKORNRGLV.l(R) =  SATSER('TENDO',KORN,'0',R) + (-EQKORNRGLV.m(R)) * .001 * .5 ;
*SATSER('TENDO',KORN,'0',R) $ SUM(F $ R_TIL_F(F,R), EQFKORNGLV.l(F)) =  SATSER('TENDO',KORN,'0',R) + SUM(F $ R_TIL_F(F,R), (-EQFKORNGLV.m(F))) * .5 ;
*SATSER('TENDO',GRNS,'0',R) $ EQGRNSRGLV.l(R) =  SATSER('TENDO',GRNS,'0',R) + (-EQGRNSRGLV.m(R)) * .5 ;
*SATSER('TENDO',FRBA,'0',R) $ EQFRBARGLV.l(R) =  SATSER('TENDO',FRBA,'0',R) + (-EQFRBARGLV.m(R)) * .5 ;
*SATSER('TENDO',GROV,'0',R) $ SUM(F $ R_TIL_F(F,R), EQFGROVGLV.l(F)) =  SATSER('TENDO',GROV,'0',R) + SUM(F $ R_TIL_F(F,R), (-EQFGROVGLV.m(F))) * .5 ;
*SATSER('TENDO','ARBF','0','0') $ EQARBEID.l = SATSER('TENDO','ARBF','0','0') + (-EQARBEID.m) * .5 * 1000 / TimerPerAarsverk;
*SATSER('TENDO','ARBF','0',R) $ SUM(M $ R_TIL_M(M,R), EQMARBEID.l(M)) = SATSER('TARBF','ARBF','0',R) + SUM(M $ R_TIL_M(M,R), (-EQMARBEID.m(M))) * .5 * 1000 / TimerPerAarsverk;
*SATSER('TENDO','ARBF','0',R) $ EQRARBEID.l(R) = SATSER('TENDO','ARBF','0',R) + (-EQRARBEID.m(R)) * .5 * 1000 / TimerPerAarsverk;
*SATSER('TENDO','ARBF','0',R) $ SUM(SD $ R_TIL_SD(SD,R), EQSDARBEID.l(SD)) = SATSER('TENDO','ARBF','0',R) + SUM(SD $ R_TIL_SD(SD,R), (-EQSDARBEID.m(SD))) * .5 * 1000 / TimerPerAarsverk;
*SATSER('TENDO',PLANTE,'0','0') $ ((NOT SAMEAS('GFUB',PLANTE)) $ EQPRDKGLV.l(PLANTE)) =  SATSER('TENDO',PLANTE,'0','0') + (-EQPRDKGLV.m(PLANTE)) * .5 ;
*SATSER('TENDO',HUSDYR,'0','0')                                $ EQPRDKGLV.l(HUSDYR)  =  SATSER('TENDO',HUSDYR,'0','0') + (-EQPRDKGLV.m(HUSDYR)) * .5 ;
*SATSER('TENDO',PLANTE,'0',R) $ ((NOT SAMEAS('GFUB',PLANTE)) $ SUM(M $ R_TIL_M(M,R), EQPRDKMGLV.l(PLANTE,M))) =  SATSER('TENDO',PLANTE,'0',R) + SUM(M $ R_TIL_M(M,R), (-EQPRDKMGLV.m(PLANTE,M))) * .5 ;
*SATSER('TENDO',HUSDYR,'0',R) $ (                              SUM(M $ R_TIL_M(M,R), EQPRDKMGLV.l(HUSDYR,M))) =  SATSER('TENDO',HUSDYR,'0',R) + SUM(M $ R_TIL_M(M,R), (-EQPRDKMGLV.m(HUSDYR,M))) * .5 ;
*SATSER('TENDO',PLANTE,'0',R) $ ((NOT SAMEAS('GFUB',PLANTE)) $ EQPRDKRGLV.l(PLANTE,R)) =  SATSER('TENDO',PLANTE,'0',R) + (-EQPRDKRGLV.m(PLANTE,R)) * .5 ;
*SATSER('TENDO',HUSDYR,'0',R)                                $ EQPRDKRGLV.l(HUSDYR,R)  =  SATSER('TENDO',HUSDYR,'0',R) + (-EQPRDKRGLV.m(HUSDYR,R)) * .5 ;
*SATSER('TENDO',PLANTE,'0',R) $ ((NOT SAMEAS('GFUB',PLANTE)) $ SUM(SD $ R_TIL_SD(SD,R), EQPRDKSDGLV.l(PLANTE,SD))) =  SATSER('TENDO',PLANTE,'0',R) + SUM(SD $ R_TIL_SD(SD,R), (-EQPRDKSDGLV.m(PLANTE,SD))) * .5 ;
*SATSER('TENDO',HUSDYR,'0',R) $ (                              SUM(SD $ R_TIL_SD(SD,R), EQPRDKSDGLV.l(HUSDYR,SD))) =  SATSER('TENDO',HUSDYR,'0',R) + SUM(SD $ R_TIL_SD(SD,R), (-EQPRDKSDGLV.m(HUSDYR,SD))) * .5 ;
*SATSER('TENDO',PLANTE,'0',R) $ ((NOT SAMEAS('GFUB',PLANTE)) $ SUM(F $ R_TIL_F(F,R), EQPRDKFGLV.l(PLANTE,F))) =  SATSER('TENDO',PLANTE,'0',R) + SUM(F $ R_TIL_F(F,R), (-EQPRDKFGLV.m(PLANTE,F))) * .5 ;
*SATSER('TENDO',HUSDYR,'0',R) $ (                              SUM(F $ R_TIL_F(F,R), EQPRDKFGLV.l(HUSDYR,F))) =  SATSER('TENDO',HUSDYR,'0',R) + SUM(F $ R_TIL_F(F,R), (-EQPRDKFGLV.m(HUSDYR,F))) * .5 ;
*SATSER('TENDO',VARE,'0','0') $ (MOELINNVARE(VARE) $ EQXPKORNGLV.l) =  SATSER('TENDO',VARE,'0','0')   + (-EQXPKORNGLV.m)  * .5;
*SATSER('TENDO',VARE,'0','0')   $ (PRODUKT(VARE) $ EQXPGLV.l(VARE)) =  SATSER('TENDO',VARE,'0','0')   + (-EQXPGLV.m(VARE))   * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ (MOELINNVARE(VARE)$ EQXPRGLV.l(VARE,R)) =  SATSER('TENDO',VARE,'0',R)   + (-EQXPRGLV.m(VARE,R))   * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ (HAGE(VARE)       $ EQXPRGLV.l(VARE,R)) =  SATSER('TENDO',VARE,'0',R)   + (-EQXPRGLV.m(VARE,R))   * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ (MEIINNVARE(VARE) $ EQXPRGLV.l(VARE,R)) =  SATSER('TENDO',VARE,'0',R)   + (-EQXPRGLV.m(VARE,R))   * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ (SLKINNVARE(VARE) $ EQXPRGLV.l(VARE,R)) =  SATSER('TENDO',VARE,'0',R)   + (-EQXPRGLV.m(VARE,R))   * .001 * .5;
*SATSER('TENDO','POTE','0',R) $ EQXPRGLV.l('POTE',R)                    =  SATSER('TENDO','POTE','0',R) + (-EQXPRGLV.m('POTE',R)) * .001 * .5;
*SATSER('TENDO','FJRK','0',R) $ EQXPRGLV.l('FJRK',R)                    =  SATSER('TENDO','FJRK','0',R) + (-EQXPRGLV.m('FJRK',R)) * .001 * .5;
*SATSER('TENDO','EGGS','0',R) $ EQXPRGLV.l('EGGS',R)                    =  SATSER('TENDO','EGGS','0',R) + (-EQXPRGLV.m('EGGS',R)) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(M $ (R_TIL_M(M,R) $ MOELINNVARE(VARE)), EQXPMGLV.l(VARE,M)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(M $ R_TIL_M(M,R), (-EQXPMGLV.m(VARE,M))  ) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(M $ (R_TIL_M(M,R) $ HAGE(VARE)      ),  EQXPMGLV.l(VARE,M)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(M $ R_TIL_M(M,R), (-EQXPMGLV.m(VARE,M))  ) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(M $ (R_TIL_M(M,R) $ MEIINNVARE(VARE)),  EQXPMGLV.l(VARE,M)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(M $ R_TIL_M(M,R), (-EQXPMGLV.m(VARE,M))  ) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(M $ (R_TIL_M(M,R) $ SLKINNVARE(VARE)),  EQXPMGLV.l(VARE,M)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(M $ R_TIL_M(M,R), (-EQXPMGLV.m(VARE,M))  ) * .001 * .5;
*SATSER('TENDO','POTE','0',R) $ SUM(M $ (R_TIL_M(M,R)                   ),  EQXPMGLV.l('POTE',M)) =  SATSER('TENDO','POTE','0',R) + SUM(M $ R_TIL_M(M,R), (-EQXPMGLV.m('POTE',M))) * .001 * .5;
*SATSER('TENDO','FJRK','0',R) $ SUM(M $ (R_TIL_M(M,R)                   ),  EQXPMGLV.l('FJRK',M)) =  SATSER('TENDO','FJRK','0',R) + SUM(M $ R_TIL_M(M,R), (-EQXPMGLV.m('FJRK',M))) * .001 * .5;
*SATSER('TENDO','EGGS','0',R) $ SUM(M $ (R_TIL_M(M,R)                   ),  EQXPMGLV.l('EGGS',M)) =  SATSER('TENDO','EGGS','0',R) + SUM(M $ R_TIL_M(M,R), (-EQXPMGLV.m('EGGS',M))) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(F $ (R_TIL_F(F,R) $ MOELINNVARE(VARE)), EQXPFGLV.l(VARE,F)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(F $ R_TIL_F(F,R), (-EQXPFGLV.m(VARE,F))  ) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(F $ (R_TIL_F(F,R) $ HAGE(VARE)       ), EQXPFGLV.l(VARE,F)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(F $ R_TIL_F(F,R), (-EQXPFGLV.m(VARE,F))  ) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(F $ (R_TIL_F(F,R) $ MEIINNVARE(VARE) ), EQXPFGLV.l(VARE,F)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(F $ R_TIL_F(F,R), (-EQXPFGLV.m(VARE,F))  ) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(F $ (R_TIL_F(F,R) $ SLKINNVARE(VARE) ), EQXPFGLV.l(VARE,F)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(F $ R_TIL_F(F,R), (-EQXPFGLV.m(VARE,F))  ) * .001 * .5;
*SATSER('TENDO','POTE','0',R) $ SUM(F $ (R_TIL_F(F,R)                    ), EQXPFGLV.l('POTE',F)) =  SATSER('TENDO','POTE','0',R) + SUM(F $ R_TIL_F(F,R), (-EQXPFGLV.m('POTE',F))) * .001 * .5;
*SATSER('TENDO','FJRK','0',R) $ SUM(F $ (R_TIL_F(F,R)                    ), EQXPFGLV.l('FJRK',F)) =  SATSER('TENDO','FJRK','0',R) + SUM(F $ R_TIL_F(F,R), (-EQXPFGLV.m('FJRK',F))) * .001 * .5;
*SATSER('TENDO','EGGS','0',R) $ SUM(F $ (R_TIL_F(F,R)                    ), EQXPFGLV.l('EGGS',F)) =  SATSER('TENDO','EGGS','0',R) + SUM(F $ R_TIL_F(F,R), (-EQXPFGLV.m('EGGS',F))) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(SD $ (R_TIL_SD(SD,R) $ MOELINNVARE(VARE)), EQXPSDGLV.l(VARE,SD)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(SD $ R_TIL_SD(SD,R), (-EQXPSDGLV.m(VARE,SD))  ) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(SD $ (R_TIL_SD(SD,R) $ HAGE(VARE)       ), EQXPSDGLV.l(VARE,SD)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(SD $ R_TIL_SD(SD,R), (-EQXPSDGLV.m(VARE,SD))  ) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(SD $ (R_TIL_SD(SD,R) $ MEIINNVARE(VARE) ), EQXPSDGLV.l(VARE,SD)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(SD $ R_TIL_SD(SD,R), (-EQXPSDGLV.m(VARE,SD))  ) * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ SUM(SD $ (R_TIL_SD(SD,R) $ SLKINNVARE(VARE) ), EQXPSDGLV.l(VARE,SD)  ) =  SATSER('TENDO',VARE,'0',R)   + SUM(SD $ R_TIL_SD(SD,R), (-EQXPSDGLV.m(VARE,SD))  ) * .001 * .5;
*SATSER('TENDO','POTE','0',R) $ SUM(SD $ (R_TIL_SD(SD,R)                    ), EQXPSDGLV.l('POTE',SD)) =  SATSER('TENDO','POTE','0',R) + SUM(SD $ R_TIL_SD(SD,R), (-EQXPSDGLV.m('POTE',SD))) * .001 * .5;
*SATSER('TENDO','FJRK','0',R) $ SUM(SD $ (R_TIL_SD(SD,R)                    ), EQXPSDGLV.l('FJRK',SD)) =  SATSER('TENDO','FJRK','0',R) + SUM(SD $ R_TIL_SD(SD,R), (-EQXPSDGLV.m('FJRK',SD))) * .001 * .5;
*SATSER('TENDO','EGGS','0',R) $ SUM(SD $ (R_TIL_SD(SD,R)                    ), EQXPSDGLV.l('EGGS',SD)) =  SATSER('TENDO','EGGS','0',R) + SUM(SD $ R_TIL_SD(SD,R), (-EQXPSDGLV.m('EGGS',SD))) * .001 * .5;
*SATSER('TENDO',VARE,'0',R) $ (MOELINNVARE(VARE) $ EQXPRKORNGLV.l(R)) =  SATSER('TENDO',VARE,'0',R)   + (-EQXPRKORNGLV.m(R))   * .001 * .5;
*SATSER('TENDO',VARE,'0',R) $ (SUM(M $ R_TIL_M(M,R), EQXPMKORNGLV.l(M)) $ MOELINNVARE(VARE)) =  SATSER('TENDO',VARE,'0',R)  + SUM(M $ R_TIL_M(M,R), (-EQXPMKORNGLV.m(M)))  * .001 * .5;
*SATSER('TENDO',VARE,'0',R) $ (SUM(F $ R_TIL_F(F,R), EQXPFKORNGLV.l(F)) $ MOELINNVARE(VARE)) =  SATSER('TENDO',VARE,'0',R)  + SUM(F $ R_TIL_F(F,R), (-EQXPFKORNGLV.m(F)))  * .001 * .5;
*SATSER('TENDO','STFK','0','0') $ EQXPSTKKGLV.l =  SATSER('TENDO','STFK','0','0')   + (-EQXPSTKKGLV.m)   * .001 * .5;
*SATSER('TENDO','KLVK','0','0') $ EQXPSTKKGLV.l =  SATSER('TENDO','KLVK','0','0')   + (-EQXPSTKKGLV.m)   * .001 * .5;
*SATSER('TENDO',VARE,'0','0')   $ (PRODUKT(VARE) $ EQXPTAK.l(VARE)) =  SATSER('TENDO',VARE,'0','0')   + (-EQXPTAK.m(VARE))   * .001 * .5;
*SATSER('TENDO',VARE,'0','0')   $ (MOELINNVARE(VARE) $ EQXPKORNTAK.l) =  SATSER('TENDO',VARE,'0','0')   + (-EQXPKORNTAK.m)   * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ (MOELINNVARE(VARE)$ EQXPRTAK.l(VARE,R)) =  SATSER('TENDO',VARE,'0',R)   + (-EQXPRTAK.m(VARE,R))   * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ (HAGE(VARE)       $ EQXPRTAK.l(VARE,R)) =  SATSER('TENDO',VARE,'0',R)   + (-EQXPRTAK.m(VARE,R))   * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ (MEIINNVARE(VARE) $ EQXPRTAK.l(VARE,R)) =  SATSER('TENDO',VARE,'0',R)   + (-EQXPRTAK.m(VARE,R))   * .001 * .5;
*SATSER('TENDO',VARE,'0',R)   $ (SLKINNVARE(VARE) $ EQXPRTAK.l(VARE,R)) =  SATSER('TENDO',VARE,'0',R)   + (-EQXPRTAK.m(VARE,R))   * .001 * .5;
*SATSER('TENDO','POTE','0',R) $ EQXPRGLV.l('POTE',R)                    =  SATSER('TENDO','POTE','0',R) + (-EQXPRTAK.m('POTE',R)) * .001 * .5;
*SATSER('TENDO','FJRK','0',R) $ EQXPRGLV.l('FJRK',R)                    =  SATSER('TENDO','FJRK','0',R) + (-EQXPRTAK.m('FJRK',R)) * .001 * .5;
*SATSER('TENDO','EGGS','0',R) $ EQXPRGLV.l('EGGS',R)                    =  SATSER('TENDO','EGGS','0',R) + (-EQXPRTAK.m('EGGS',R)) * .001 * .5;
*SATSER('TENDO',VARE,'0','0') $ SUM(NSTOFF, (-EQDIETT.l(NSTOFF))) =  SATSER('TENDO',VARE,'0','0') + SUM(NSTOFF, (-EQDIETT.m(NSTOFF)) * NAERING(VARE,NSTOFF)) * .5 ;
** No update in FS scenario
*$ifThenI.Diet %SCEN%==FS
*SATSER('TENDO',VARE,'0','0') = 0;
*$endIf.Diet
*SATSER('TENDO',KLTKA,'0',R) $ SUM(B$(SIMDATA(R,B,'OPPTVD',KLTKA)>0), SIMDATA(R,B,'OPPTAK',KLTKA) * g.l(B,R)) = SATSER('TENDO',KLTKA,'0',R)
* - SUM(B$(SIMDATA(R,B,'OPPTVD',KLTKA)>0), SIMDATA(R,B,'OPPTAK',KLTKA) * ( SIMDATA(R,B,'OPPTVD',KLTKA)) * g.l(B,R)) / SUM(B$(SIMDATA(R,B,'OPPTVD',KLTKA)>0), SIMDATA(R,B,'OPPTAK',KLTKA) * g.l(B,R)) * .5 * 1000;
*SATSER('TENDO',KLTKA,'0',R) $ SUM(B$(SIMDATA(R,B,'OPPTVD',KLTKA)<0), SIMDATA(R,B,'OPPTAK',KLTKA) * g.l(B,R)) = SATSER('TENDO',KLTKA,'0',R)
* + SUM(B$(SIMDATA(R,B,'OPPTVD',KLTKA)<0), SIMDATA(R,B,'OPPTAK',KLTKA) * (-SIMDATA(R,B,'OPPTVD',KLTKA)) * g.l(B,R)) / SUM(B$(SIMDATA(R,B,'OPPTVD',KLTKA)<0), SIMDATA(R,B,'OPPTAK',KLTKA) * g.l(B,R)) * .5 * 1000;
*SATSER('TENDO',KLTKA,'0',R) = MAX[SATSER('TKLIA',KLTKA,'0',R), 0];
**
*KONVERGENS(TILSKUDD,VARE,R,STEP) = SATSER(TILSKUDD,VARE,'0',R) + SATSER(TILSKUDD,VARE,'0','0');
*KONVERGENS(TILSKUDD,PRDK,R,STEP) = SATSER(TILSKUDD,PRDK,'1',R) + SATSER(TILSKUDD,PRDK,'1','0');
*KONVERGENS('NORGE',VARE,'TOTP',STEP) = SIMDATA('NORGE',VARE,'TOTP','Y');
*KONVERGENS(R,VARE,'TOTP',STEP) = SIMDATA(R,VARE,'TOTP','Y');
*KONVERGENS(M,VARE,'FK',STEP)   = SIMDATA(M,VARE,'FK','Y');
*KONVERGENS(R,VARE,'FK',STEP)   = SIMDATA(R,VARE,'FK','Y');
*KONVERGENS(R,VARE,'Innfrakt',STEP)   = INNFRAKTTIL(R,VARE);
*KONVERGENS(R,MOELVARE,'KvoteTollA',STEP)   = KVOTETOLLA(MOELVARE);
*KONVERGENS(R,MOELVARE,'PrisNed',STEP)   = Prisned(MOELVARE);
*KONVERGENS(M,VARE,'MNGD',STEP) = SIMDATA(M,VARE,'MNGD','Y');
**
*KONVERGENS(R,VARE,'LikevektIN',STEP) $ MOELVARE(VARE) = SUM(M$R_TIL_M(M,R), -EQMOELINBAL.m(VARE,M));
*KONVERGENS(M,VARE,'LikevektUT',STEP) $ MOELVARE(VARE) = -EQMOELUTBAL.m(VARE,M);
*KONVERGENS(R,VARE,'NorskPris',STEP)   $ MOELVARE(VARE) = SIMDATA(R,VARE,'TOTP','Y');
*KONVERGENS(R,VARE,'ImportPris',STEP)  $ MOELVARE(VARE) = PI(VARE);
*KONVERGENS(R,VARE,'KvoteTollA',STEP)  $ MOELVARE(VARE) = KVOTETOLLA(VARE);
*KONVERGENS(R,VARE,'Innfrakttil',STEP) $ MOELVARE(VARE) = INNFRAKTTIL(R,VARE);
*KONVERGENS(M,VARE,'PrisNedMngd',STEP) = x.l(VARE,'PRIM',M);
*KONVERGENS(M,VARE,'PrisNedPris',STEP) = PRISNED(VARE);
*KONVERGENS(M,VARE,'PrisNedVerd',STEP) = x.l(VARE,'PRIM',M) * PRISNED(VARE);
**               
**
*KONVERGENS('NORGE','Innfrakt','Kost',STEP)    = SUM((MM,VARE)$SUM(VAREVARE, MOELFLYT(VARE,VAREVARE)), uttr.l(VARE,'OEST',MM) * TRKOST(VARE,'OEST',MM));
*KONVERGENS('NORGE','Innfrakt','SlkInn',STEP)  = SUM((R,VARE)$ (PRODUKT(VARE) AND SLKINNVARE(VARE)) , x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)); 
*KONVERGENS('NORGE','Innfrakt','MoelInn',STEP) = SUM((R,VARE)$ (PRODUKT(VARE) AND MOELINNVARE(VARE) AND MOELUTVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)); 
*KONVERGENS('NORGE','Innfrakt','MoelZ',STEP)   = SUM((R,VARE)$ MOELUTKVARE(VARE)                    , z.l(VARE,R)        * INNFRAKTTIL(R,VARE)); 
*KONVERGENS('NORGE','Innfrakt','PrisNed',STEP) = SUM((M,VARE)$ MOELVARE(VARE), x.l(VARE,'PRIM',M) * PRISNED(VARE));
*KONVERGENS('NORGE','Innfrakt',VARE,STEP)  $ MOELUTKVARE(VARE)    = SIMDATA('011101',VARE,'TOTP','Y');
*KONVERGENS(R,'Innfrakttil',VARE,STEP)  = INNFRAKTTIL(R,VARE);
**
*KONVERGESIMDATA('PrisTest','SIM',VARE,'OEST',STEP)  = SIMDATA('011101',VARE,'TOTP','Y');
**
*
*
*RESNORGETest('SFO','IKST','VERD',VARE) =  SUM(M$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M))
*                                        + SUM(M$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
*                                        + SUM(M$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
*                                        + SUM(M$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
*                                        + SUM(M$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
*                                   
*RESNORGETest('SFO','IKST','VERD',MOEL) = SUM(M, MOLDATA('FSOY',MOEL) * (PI('FSOY')+KVOTETOLLA('FSOY')) * h.l(MOEL,M))
*                                       + SUM(M, MOLDATA('FANT',MOEL) * (PI('FANT')+KVOTETOLLA('FANT')) * h.l(MOEL,M));
*
*RESNORGETest('MEIK','IUTG','VERD',VARE) = SUM(M $ MEIVARE(VARE), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
*RESNORGETest('MEIK','IUTQ','VERD',VARE) = SUM(M $ MEIVARE(VARE), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
*                                        + SUM(M $ MEIVARE(VARE), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
*                                        + SUM(M $ MEIVARE(VARE), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
*                                        + SUM(M $ MEIVARE(VARE), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
*
*RESNORGETest('SLKK','IUTG','VERD',VARE) = SUM(M $ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
*RESNORGETest('SLKK','IUTQ','VERD',VARE) = SUM(M $ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
*                                        + SUM(M $ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
*                                        + SUM(M $ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
*                                        + SUM(M $ (SLKVARE(VARE) OR SLKINNVARE(VARE)), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
*
*RESNORGETest('MOEL','IUTG','VERD',VARE) = SUM(M $ MOELVARE(VARE), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
*RESNORGETest('MOEL','IUTQ','VERD',VARE) = SUM(M $ MOELVARE(VARE), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
*                                        + SUM(M $ MOELVARE(VARE), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
*                                        + SUM(M $ MOELVARE(VARE), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
*                                        + SUM(M $ MOELVARE(VARE), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
*                                    
*RESNORGETest('SFO','IKST','VERD',MOEL) =  SUM(M, MOLDATA('FSOY',MOEL) * (PI('FSOY')+KVOTETOLLA('FSOY')) * h.l(MOEL,M))
*                                        + SUM(M, MOLDATA('FANT',MOEL) * (PI('FANT')+KVOTETOLLA('FANT')) * h.l(MOEL,M));
*
*RESNORGETest('AIND','IUTG','VERD',VARE) = SUM(M $ AINDVARE(VARE), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi.l(VARE,M));
*RESNORGETest('AIND','IUTQ','VERD',VARE) = SUM(M $ AINDVARE(VARE), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq.l(VARE,M))
*                                        + SUM(M $ AINDVARE(VARE), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa.l(VARE,M))
*                                        + SUM(M $ AINDVARE(VARE), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb.l(VARE,M))
*                                        + SUM(M $ AINDVARE(VARE), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs.l(VARE,M));
*
*
*RESNORGETest('MEIK','TRTL','VERD',VARE) = SUM(R$ MEIVARE(VARE), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE));
*RESNORGETest('SLKK','TRTL','VERD',VARE) = SUM(R$ (PRODUKT(VARE) AND SLKINNVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE));
*RESNORGETest('MOEL','TRTL','VERD',VARE) = SUM(R$ (PRODUKT(VARE) AND MOELINNVARE(VARE) AND MOELUTVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
*                                    + SUM(R$ MOELUTKVARE(VARE)                                         , z.l(VARE,R)        * INNFRAKTTIL(R,VARE));
*RESNORGETest('AIND','TRTL','VERD',VARE) = SUM(R $ AINDVARE(VARE), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE));
*
*RESNORGETest('SFO','TRTL','VERD',VARE) = SUM(R $ PRODUKT(VARE), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
*                                   + SUM(R $ (PRODUKT(VARE) AND MOELINNVARE(VARE) AND MOELUTVARE(VARE)), x.l(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
*                                   + SUM(R $ MOELUTKVARE(VARE), z.l(VARE,R) * INNFRAKTTIL(R,VARE));
*
*
*RESNORGETest('MEIK','OMST','VERD',VARE) $ MEIINNVARE(VARE) = OMSET(VARE) * x.l(VARE,'PRIM','NORGE');
*RESNORGETest('SLKK','OMST','VERD',VARE) $ SLKINNVARE(VARE) = OMSET(VARE) * x.l(VARE,'PRIM','NORGE');
*RESNORGETest('MOEL','OMST','VERD',VARE) $ MOELVARE(VARE)   = OMSET(VARE) * x.l(VARE,'PRIM','NORGE');
*RESNORGETest('AIND','OMST','VERD',VARE) $ AINDVARE(VARE)   = OMSET(VARE) * x.l(VARE,'PRIM','NORGE');
*RESNORGETest('SFO','OMST','VERD',VARE)                     = OMSET(VARE) * x.l(VARE,'PRIM','NORGE');
*
**
*** oppdatere endogen miljoavgift
*CO2AVGXP(UTSLIPPAVG) = CO2AVGXP(UTSLIPPAVG) + SUM(UTSLIPPGHG$UTSLIPPAVG_TIL_UTSLIPPGHG(UTSLIPPGHG,UTSLIPPAVG), .75 * (EQGHGTAK.m)/GHGPOTENSIAL(UTSLIPPGHG))  ;
*CO2AVGXI(UTSLIPPAVG) = CO2AVGXP(UTSLIPPAVG) ;
*
*
*AreaChange(CropTypeObj,'Before',r,STEP) = RefArea(R,CropTypeObj);
*AreaChange(CropTypeObj,'Inn',r,STEP)    = LUCInn.l(R,CropTypeObj);
*AreaChange(CropTypeObj,'Out',r,STEP)    = LUCOut.l(R,CropTypeObj);
*AreaChange('CROP','After',r,STEP)  = SUM((B,CROP), SIMDATA(R,B,'OMFG',CROP) * g.l(B,R));
*AreaChange('GRAS','After',r,STEP)  = SUM((B,GRAS), SIMDATA(R,B,'OMFG',GRAS) * g.l(B,R));





* Her stopper loop mellom tilbudsmodell og markedsmodell
);

Parameter Consumption(KostGrp);
Consumption(KostGrp) = 
  SUM(Vare$KostVare(KostGrp,Vare), x.l(Vare,'CONS','NORGE') * (1 - Sum(CCons, FoodLossWaste(VARE,CCons))/100)) * 1000 / (POPBAS * (1+POP)**(Y-%BAS%)) / 365;
  
*
Parameter EcoSysTest(*,*);
EcoSysTest('landest','lev') = SUM(R, landest.l(R)); 
EcoSysTest(' biodiv','lev') = SUM(R, biodiv.l(R) );             ; 
EcoSysTest('culther','lev') = SUM(R, culther.l(R)); 
EcoSysTest('recreat','lev') = SUM(R, recreat.l(R)); 
*                                                  
EcoSysTest('landest','val') = SUM(R, landest.l(R) * WTPLandest(R)) ; 
EcoSysTest(' biodiv','val') = SUM(R, biodiv.l(R)  * WTPBiodiv(R))  ; 
EcoSysTest('culther','val') = SUM(R, culther.l(R) * WTPCulther(R)) ; 
EcoSysTest('recreat','val') = SUM(R, recreat.l(R) * WTPRecreat(R)) ; 
*
EcoSysTest('landest','obs') = SUM(R, landestobs.l(R)) ; 
EcoSysTest(' biodiv','obs') = SUM(R, biodivobs.l(R))  ; 
EcoSysTest('culther','obs') = SUM(R, cultherobs.l(R)) ; 
EcoSysTest('recreat','obs') = SUM(R, recreatobs.l(R)) ; 
*
EcoSysTest('landest','LHS') = SUM(R, Ref_landest(R)) ; 
EcoSysTest(' biodiv','LHS') = SUM(R, Ref_biodiv(R) ) ; 
EcoSysTest('culther','LHS') = SUM(R, Ref_culther(R)) ; 
EcoSysTest('recreat','LHS') = SUM(R, Ref_recreat(R)) ; 
*
EcoSysTest('landest','RHS') =    SUM((PLANTE,R,B), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R))  ;
EcoSysTest(' biodiv','RHS') =    SUM((GROV,R,B),  SIMDATA(R,B,'OMFG',GROV)   * g.l(B,R))   
                               + SUM((R,B),         SIMDATA(R,B,'OMFG','GFUB') * g.l(B,R)) ;
EcoSysTest('culther','RHS') =    SUM((PLANTE,R,B), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R))  ;
EcoSysTest('recreat','RHS') =    SUM((PLANTE,R,B), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R))  ;
*
EcoSysTest('LUC','RHS') = SUM((R,B,PRDK,CropTypeObj)$CropTypeObj_to_PRDK(CropTypeObj,PRDK), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) ;
*
*
Parameter EcoSysTestR(R,*,*);
EcoSysTestR(R,'landest','lev') = landest.l(R); 
EcoSysTestR(R,' biodiv','lev') = biodiv.l(R) ;             ; 
EcoSysTestR(R,'culther','lev') = culther.l(R); 
EcoSysTestR(R,'recreat','lev') = recreat.l(R); 
*                                           
EcoSysTestR(R,'landest','val') = landest.l(R) * WTPLandest(R) ; 
EcoSysTestR(R,' biodiv','val') = biodiv.l(R)  * WTPBiodiv(R) ; 
EcoSysTestR(R,'culther','val') = culther.l(R) * WTPCulther(R) ; 
EcoSysTestR(R,'recreat','val') = recreat.l(R) * WTPRecreat(R) ; 
*
EcoSysTestR(R,'landest','obs') = landestobs.l(R) ; 
EcoSysTestR(R,' biodiv','obs') = biodivobs.l(R) ; 
EcoSysTestR(R,'culther','obs') = cultherobs.l(R) ; 
EcoSysTestR(R,'recreat','obs') = recreatobs.l(R) ; 
*
EcoSysTestR(R,'landest','LHS') = Ref_landest(R) ; 
EcoSysTestR(R,' biodiv','LHS') = Ref_biodiv(R)  ; 
EcoSysTestR(R,'culther','LHS') = Ref_culther(R) ; 
EcoSysTestR(R,'recreat','LHS') = Ref_recreat(R) ; 
*
EcoSysTestR(R,'landest','RHS') = SUM((PRDK,B) $ (PLANTE(PRDK) $ (NOT SAMEAS('GFUB',PRDK))), SIMDATA(R,B,'OMFG',PRDK) * g.l(B,R)) - Ref_landest(R) ;
EcoSysTestR(R,' biodiv','RHS') =  (SUM((GROV,B),  SIMDATA(R,B,'OMFG',GROV)   * g.l(B,R))                  
                                 + SUM(B,         SIMDATA(R,B,'OMFG','GFUB') * g.l(B,R))) - Ref_biodiv(R);              ;
EcoSysTestR(R,'culther','RHS') = SUM((PLANTE,B), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R)) - Ref_culther(R) ;
EcoSysTestR(R,'recreat','RHS') = SUM((PLANTE,B), SIMDATA(R,B,'OMFG',PLANTE) * g.l(B,R)) - Ref_recreat(R) ;


Parameter EmisSysTest(*,*);
EmisSysTest('NTAP',r) = SUM(B, SIMDATA(R,B,'MNGD','NTAP')    * g.l(B,R));
EmisSysTest('NH3',r)  = SUM(B, SIMDATA(R,B,'MNGD','NH3MMNED')* g.l(B,R));
EmisSysTest('N2O',r)  = SUM(B, SIMDATA(R,B,'MNGD','NH3MMAVR')* g.l(B,R));
EmisSysTest('NTAP',r) = SUM(B, SIMDATA(R,B,'MNGD','NH3NED')  * g.l(B,R));
EmisSysTest('NH3',r)  = SUM(B, SIMDATA(R,B,'MNGD','NH3AVR')  * g.l(B,R));
EmisSysTest('N2O',r)  = SUM(B, SIMDATA(R,B,'MNGD','N2O')     * g.l(B,R));




*
execute_unload 'ecoSysTest.gdx', AreaChange, emissystest, ecosystest;
*
* Beregne resultater og skrive ut i scenarioavhengig fil
$include resultater
*
* Skriv ut data for konvergens
$include konvergens
*
execute_unload 'resultater\%scen%_all.gdx';
execute_unload 'resultater\%SCEN%_simdata.gdx', simdata, simdata, simdatacheck, resnorge, konvergesimdata, omfang, bidrag, intens, arbeid, opptak, utslipptest, data, klimatil, klimdata, simprof, itest, endokoeff, fleksgrov, satser, innfrakttil, prisned, konvergens;
