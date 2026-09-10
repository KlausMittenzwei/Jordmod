************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Politiske restriksjoner i basisloesningen
*   Kommentarer:
*   Status:
*
************************************************************************
$ontext
**************************
* Milj�politikk
**************************
* Myrforbud = 1
SCALAR MYRFORBUD ;
MYRFORBUD = 0;
*
* ... gulv tradisjonelt areal hele landet
POL('NORGE','TRADAR','GLV') = 0;
*
* ... tak tradisjonelt areal hele landet
POL('NORGE','TRADAR','TAK') = + INF;
*
* ... gulv alt areal uten utmark hele landet
POL('NORGE','AREAL','GLV') = 0;
*
* ... gulv beiteareal uten utmark hele landet
POL('NORGE','BEITE','GLV') = 0;
*
* Define later
POL(R,'AREAL','GLV') = 0;

* ... gulv alt areal uten utmark sentrale strok
POL('000100','AREAL','GLV') = 0;
*
* ... gulv alt areal uten utmark distrikter
POL('000200','AREAL','GLV') = 0;
*
* ... gulv fulldyrket areal pr produksjon hele landet
* brukes for sikre feasibility for landskapsindikator
POL('NORGE',FULLDYRK,'PRDK_GLV')$(NOT SAMEAS('BRAK',FULLDYRK)) = SUM(R, DATA(R,FULLDYRK,'OMFG','BAS')) * 0.001;
POL('NORGE',FULLDYRK,'PRDK_GLV')$(NOT SAMEAS('BRAK',FULLDYRK)) = 0;
*
* ... arealtak regioner
*POL(R,'AREAL','TAK')    =  SUM(PLANTE$(NOT SAMEAS('GFUB',PLANTE)), DATA(R,PLANTE,'OMFG','BAS')) * 1.15;
*POL(R,'FULLJ','TAK')    =  SUM(FULLDYRK, DATA(R,FULLDYRK,'OMFG','BAS')) * 1.15;
*POL(R,'MATKN','TAK')    =  SUM(FULLDYRKMAT, DATA(R,FULLDYRKMAT,'OMFG','BAS')) * 1.15;
*POL(R,'MATKN','TAK')    =  +INF;
*POL(R,'KORN','TAK')     =  SUM(KORN, DATA(R,KORN,'OMFG','BAS')) * 1.15;
*POL(R,'KORN','TAK')     =  +INF;
*... arealtak alt tilgjengelig areal
*POL(R,'AREAL','TAK') =  SUM(DSONE, MAXAREAL(R,DSONE));
*POL(R,'FULLJ','TAK') =  SUM(DSONE$(NOT SAMEAS('6',DSONE)), MAXAREAL(R,DSONE));
*POL(R,'MATKN','TAK') =  MAXAREAL(R,'1') + MAXAREAL(R,'2');
*POL(R,'KORN','TAK')  =  MAXAREAL(R,'1') + MAXAREAL(R,'2') + MAXAREAL(R,'3') + MAXAREAL(R,'4');
*POL(R,'GFIB','TAK')  =  MAXAREAL(R,'6');
*
* ... arealtak hele landet
*POL('NORGE','KORN','TAK') = SUM(R, POL(R,'KORN','TAK'));

*$ontext
Tabell 4. Fordelingen av vekstskifter p� dyrkingsklasser.
Dyrkings-klasse        Aktuelle vekstskifter
1    Oljevekster - v�rhvete - havre - �kerb�nne (erter) - v�rhvete - bygg
2    Oljevekster - v�rhvete - havre - �kerb�nne (erter) - v�rhvete - bygg
3    Potet (gr�nnsaker) - v�rhvete - havre - bygg - havre
4    Eng - eng - eng - bygg - havre - bygg med gjenlegg
5    Gras, poteter og gr�nnsaker
6    Gras, beite

SET KORN(PRDK) /
       HVET   Hvete
       RUGH   Rug
       BYGG   Bygg
       HAVR   Havre
       AKRN   Annet korn
       RAPS   Oljefroe
       ERTE   Belgfrukter

*$offtext







*
*
* ... gulv sysselsetting regioner
POL('NORGE','ARB','GLV') =  0;
POL(SD,'ARB','GLV')   =  0;
POL(R,'ARB','GLV')     =  0;
*
* ... gulv omfang produksjoner regioner
POL('NORGE',PRDK,'PRDK_GLV')   = 0;
POL('NORGE','KORN','PRDK_GLV') = 0;
POL('NORGE','GROV','PRDK_GLV') = 0;
POL('NORGE','PLNT','PRDK_GLV') = 0;
POL(SD,PRDK,'PRDK_GLV')        = 0;
POL(F,PRDK,'PRDK_GLV')         = 0;
POL(R,PRDK,'PRDK_GLV')         = 0;
POL(F,'KORN','PRDK_GLV')       = 0;
POL(F,'GROV','PRDK_GLV')       = 0;
*
* ... produksjonstak regioner
POL('NORGE',VARE,'VARE_TAK') = +INF;
*
POL(R,VARE,'VARE_TAK') = +INF;
*
* kalibrering regional produksjon av svinekjoett i Nord-Norge
POL(R,'STFK','VARE_TAK') = 2 * DATA(R,'STFK','MNGD','BAS') ;
POL(R,'SAUK','VARE_TAK') = 2 * DATA(R,'SAUK','MNGD','BAS') ;
POL(R,'SVNK','VARE_TAK') = 2 * DATA(R,'SVNK','MNGD','BAS') ;
POL(R,'FJRK','VARE_TAK') = 2 * DATA(R,'FJRK','MNGD','BAS') ;
POL(R,'EGGS','VARE_TAK') = 2 * DATA(R,'EGGS','MNGD','BAS') ;
$offtext

*
* ... produksjonsgulv
*POL('NORGE','POTE','VARE_GLV') = 250;
*POL('NORGE',VARE,'VARE_GLV') = 0;
*POL('NORGE','KMLK','VARE_GLV') = 1500;
*POL('NORGE','STFK','VARE_GLV') = 80 * .8 ;
*POL('NORGE','SAUK','VARE_GLV') = 24 * .8;
*POL('NORGE','KORN','VARE_GLV') = 1000 * .8;

POL(SD,VARE,'VARE_GLV')      = 0;
*
*POL('160000','SAUK','VARE_GLV') = .1;
*POL('170000','SAUK','VARE_GLV') = .1;
*POL('180000','SAUK','VARE_GLV') = .1;
*POL('190000','SAUK','VARE_GLV') = .1;
*POL('200000','SAUK','VARE_GLV') = .1;

*POL('180000','AKYR','PRDK_GLV') = 1;
*POL('190000','AKYR','PRDK_GLV') = 1;
*POL('200000','AKYR','PRDK_GLV') = 1;

*
* ... regionale melkekvoter
* forutsetning referansebane: 50% of change from base year taken domestic production
POL(F,'KMLK','KVOTE') = SUM(R$R_TIL_F(F,R), DATA(R,'KMLK','MNGD','BAS')) * (1.00568 ** (Y - %BAS%)) ;
POL(F,'GMLK','KVOTE') = SUM(R$R_TIL_F(F,R), DATA(R,'GMLK','MNGD','BAS')) * (1.00568 ** (Y - %BAS%)) ;
*
*
* Del av politikk: stoerrelse enkeltbruk
*PARAMETER BRUKSTOR(R,B,*,*) Definisjon av brukstoerrelse paa regionnivaa  ;
*
BRUKSTOR(R,'BKRN','MAKS','Y') = BRUKSTOR(R,'BKRN','MAKS','Y') * 1.5;
BRUKSTOR(R,'BPTE','MAKS','Y') = BRUKSTOR(R,'BPTE','MAKS','Y') * 1.5;
BRUKSTOR(R,'BFRK','MAKS','Y') = BRUKSTOR(R,'BFRK','MAKS','Y') * 1.5;
BRUKSTOR(R,'BHGE','MAKS','Y') = BRUKSTOR(R,'BHGE','MAKS','Y') * 1.5;
BRUKSTOR(R,'BKMK','MAKS','Y') = BRUKSTOR(R,'BKMK','MAKS','Y') * 1.5;
BRUKSTOR(R,'BGMK','MAKS','Y') = BRUKSTOR(R,'BGMK','MAKS','Y') * 1.5;
BRUKSTOR(R,'BAKY','MAKS','Y') = BRUKSTOR(R,'BAKY','MAKS','Y') * 1.5;
BRUKSTOR(R,'BSAU','MAKS','Y') = BRUKSTOR(R,'BSAU','MAKS','Y') * 1.5;
BRUKSTOR(R,'BGRI','MAKS','Y') = BRUKSTOR(R,'BGRI','MAKS','Y') * 1.5;
BRUKSTOR(R,'BHOE','MAKS','Y') = BRUKSTOR(R,'BHOE','MAKS','Y') * 1.5;
BRUKSTOR(R,'BKYL','MAKS','Y') = BRUKSTOR(R,'BKYL','MAKS','Y') * 1.5;
*
BRUKSTOR(R,B,'MIN','Y')  = BRUKSTOR(R,B,'MAKS','Y') * .9;

execute_unload 'brukstorB.gdx', brukstor;


**************************
* Folkehelse
**************************
* YES: include in object function
* NO: include not in object function
$setGlobal PubHealth NO

POL('NORGE','ENER','KONS') = 0;

*Target dietary recommendation of food groups in gram per person per day;
* ... if the target is a minimum recommendation
POL('NORGE',FoodGrp,'MIN')   = 0;
* ... if the target is a maximum recommendation
POL('NORGE',FoodGrp,'MAX') = + INF;


**************************
* Ecosystem services
**************************
* YES: include in object function
* NO: include not in object function
$setGlobal EcoSys NO

**************************
* Milj�politikk
**************************
PARAMETER GJODSELKRAV(PRDK) ;
* Dagens = 4
* LDir = 5
* MDir = 7
GJODSELKRAV(PRDK) = 4;
*
PARAMETER NITRAVRENN(R) ;
* Nordsj�avtale og EUs nitratdirektiv begrenser maksimal nitrogentilf�rsel
* Regioner for EUs nitratdirektiv:
*SET NITRATDIR(R) /011101, 021101, 021103, 041101/;
* Regioner for Nordsj�avtale
*SET NORDSJOE(R) /SET.NITRATDIR, 061101, 071101, 081203, 092205, 102205, 112102, 112205/;

* NITRAVRENN = 0 ingen endring
NITRAVRENN(R) = 0;


* Tak klimagassutslipp i GHG
* Tall fra IG
POL('NORGE','GHG','TAK') =  +INF;
*
* Karbonskatt
* angitt pr miljovare for norsk produksjon
*PARAMETER CO2AVGXP(VARE);
* Source: https://www.regjeringen.no/no/tema/okonomi-og-budsjett/statlig-okonomistyring/karbonprisbaner-for-bruk-i-samfunnsokonomiske-analyser-i-2023/id2878113/
* 2230 2023-kr per t CO2-ekvivalent i 2035
* 1997.71 2021-kr per CO2-ekvivalent i 2035
CO2AVGXP(UTSLIPPAVG) = 1.99771 * GHGPOTENSIAL(UTSLIPPAVG)  * (1 + KPI) ** (Y-%BAS%);
CO2AVGXP(UTSLIPPAVG) = 0;
*
* angitt pr miljovare for importert vare
*PARAMETER CO2AVGXI(VARE);
CO2AVGXI(UTSLIPPAVG) = CO2AVGXP(UTSLIPPAVG);

* Marginal cost of public fund
MCPF = 0;

$ontext
* Krisemeny
* minste verdier pr cap og dag for energi fett og protein
POL('NORGE','ENER','GLV') = 0;
POL('NORGE','PROT','GLV') = 0;
POL('NORGE','FETT','GLV') = 0;

* Del av politikk: antall meierier
POL('OEST','MEIR','MIN') = 17;
POL('SOER','MEIR','MIN') = 7;
POL('VEST','MEIR','MIN') = 5;
POL('MIDT','MEIR','MIN') = 6;
POL('NORD','MEIR','MIN') = 6;
*
POL(M,'MEIR','MIN') = POL(M,'MEIR','MIN') * .9;
*
* Del av politikk: antall slakterier
POL('OEST','SSLK','gs_MIN') =  10;
POL('SOER','SSLK','gs_MIN') =   6;
POL('VEST','SSLK','gs_MIN') =   4;
POL('MIDT','SSLK','gs_MIN') =   9;
POL('NORD','SSLK','gs_MIN') =  10;
*
POL(M,'SSLK','gs_MIN') = POL(M,'SSLK','gs_MIN') * .75;
*
POL(M,'SSLK','gs_MAKS') = 100;
*
* Del av politikk: min stoerrelse slakterier
POL('OEST','SLST','zs_MIN') =  2.192 ;
POL('SOER','SLST','zs_MIN') =  2.471 ;
POL('VEST','SLST','zs_MIN') =  1.204 ;
POL('MIDT','SLST','zs_MIN') =  3.287 ;
POL('NORD','SLST','zs_MIN') =  1.210 ;
*
POL('OEST','SLSV','zs_MIN') =  4.386 ;
POL('SOER','SLSV','zs_MIN') =  3.719 ;
POL('VEST','SLSV','zs_MIN') =  0.482 ;
POL('MIDT','SLSV','zs_MIN') =  3.011 ;
POL('NORD','SLSV','zs_MIN') =  0.805 ;
*
POL('OEST','SLSA','zs_MIN') =  0.586;
POL('SOER','SLSA','zs_MIN') =  0.820;
POL('VEST','SLSA','zs_MIN') =  0.627;
POL('MIDT','SLSA','zs_MIN') =  0.520;
POL('NORD','SLSA','zs_MIN') =  0.563;
*
POL(M,SSLK,'zs_MIN') = POL(M,SSLK,'zs_MIN') * .9;
*
POL(M,'SSLK','zs_MIN') = POL(M,'SLST','zs_MIN') + POL(M,'SLSA','zs_MIN') + POL(M,'SLSV','zs_MIN');
*
POL(M,FSLKVARE,'zk_MIN') = SIMDATA(M,FSLKVARE,'MNGD','BAS') * .9;

$offtext
* Antall ganger slaktebil hos produsent pr aar
POL('BESOEK','KJOTT','ANTL') = 8;


