f
************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Definisjon av modellen som beregner optimale enkeltbruk
*   Kommentarer: Oppdatert med utslipp, 25 jan 11, KMi
*   Status:
************************************************************************
*
Variable
objbruk                Overskudd pr bruk og region i 1000 kr
balans(R,B,VARE)       Innsatsfaktorer med regional endogen likevekt i daa
pmpfeed(R,B,PRDK)      PMP Feed allocation i 1000 kr
pmpAlloc(R,B,PRDK)     Feed allocation compenation in 1000 kr
profitt(R,B)           Profitt paa bruket
opptak(R,B,KLTK)       Opptak av klimatiltak KLTK p? bruk B i region R

*
Positive variables
omfang(R,B,PRDK)        Omfang av aktiviteter pr bruk og region i dyr og daa
intens(R,VARE,PRDK)     Intensitet i kg ltr eller FEM pr daa eller dyr
arbeid(R,B,VARE)        Arbeidsmengde pr bruk og region i timer
bidrag(R,B,VARE)       Oekonomisk bidrag (inntekt tilskudd kostnad eller miljoavgifter) pr bruk og region i 1000 kr
pris(R,B,VARE)          Endogen pris for varer i kr pr enhet
flatbidrag(R,B,TILSKUDD) Oekonomisk bidrag flate tilskudd pr bruk og region
trinnbidrag(R,B,*,TILSKUDD) Oekonomisk bidrag trinnvise tilskudd pr PRDK PRODUKT eller aggregat av PRDK bruk og region
beiteand(R,B)           Andel grovfor produsert paa beite i prosent
;
*
EQUATIONS
EQOBJEKTBRUK               Optimeringsligning for enkeltbruk i 1000 kr
EQPROFITTBRUK(R,B)         Krav om ikke-negativ profitt paa enkeltbruk
EQINTEKSO(R,VARE,PRDK)     Eksogen intensitet i alle produksjoner
EQINTKMLK(R,VARE,PRDK)     Endogen intensitet i melkeproduksjonen
EQMAXFGRVAHUSDYR(R,VARE,PRDK)  Max grovf?r for dr?vtyggere uten melkekyr
EQFORAHUSDYR(R,PRDK)   Maks kraftf?rprosent for dr?vtyggere uten melkekyr
EQINTKJOETT(R,VARE,PRDK)   Endogen slaktevekt for dr?vtyggere uten melkekyr
EQMAXKFORMELK(R)           Maks kraftforprosent i melkeproduksjonen
EQMINKFORMELK(R)           Min kraftforprosent i melkeproduksjonen
EQMAXFORMELK(R)            Maks foropptakt i melkeproduksjon
EQVAREKVOT(R,VARE)         Produksjonskvote for jordbruksprodukter
EQINTGROV(R,VARE,PRDK)     Enodgen intensitet i produksjon av grovfor
EQINTKORN(R,VARE,PRDK)     Enodgen intensitet i produksjon av korn
EQIntVerdDGKoeff(R,B,VARE)    Endogen verd intensitet for DGKOEFF
EQIntMngdDGKoeff(R,VARE,PRDK) Endogen mngd intensitet for DGKOEFF
EQINTAVSB(R,B)             Endogen intensitet for avskrivninger paa bygningskapital
EQINTAVSM(R,B)             Endogen intensitet for avskrivninger paa maskinkapital
EQINTARBF(R,B)             Endogen intensitet for arbeid
EQPRSARBF(R,B,VARE)        Endogen pris for familiearbeid
EQKSTARBF(R,B,INNSATS)     Bidrag arbeidskostnader
EQINNTEKT(R,B,VARE)        Markedsinntekter
EQKOSTNAD(R,B,VARE)        Kostnader
EQPMPFEED(R,B,PRDK)        PMP for allocation of feed
EQPRDKTIL(R,B,TILSKUDD,PRDK,TTIL) Trinntilskudd for aktiviteter
EQFLATTIL(R,B,TILSKUDD)         Flate tilskudd
EQUNGDTIL(R,B,TILSKUDD,TTIL)    Trinntilskudd for ungdyr
EQGAKFTIL(R,B,TILSKUDD,TTIL)    Trinntilskudd for grovfor uten avgrensning
EQGAKRTIL(R,B,TILSKUDD,TTIL)    Trinntilskudd for grovfor med avgrensning
EQKORNTIL(R,B,TILSKUDD,TTIL)    Trinntilskudd for korn
EQFRBATIL(R,B,TILSKUDD,TTIL)    Trinntilskudd for frukt og baer
EQFRADRAGTIL(R,B,TILSKUDD)      Ligning for bunnfradrag
EQSKATTIL(R,B,TRINNTIL,TTIL)    Ligning for jordbruksfradrag
EQTARBF(R,B)                    Ligning for pipetilskudd definert som tilskudd til arbeid
EQBALIKYR(R,B,VARE)        Balanse for unge kyr
EQBALIKVG(R,B,VARE)        Balanse for unge kviger
EQBALIOKS(R,B,VARE)        Balanse for unge okser
EQBALIKVK(R,B,VARE)        Balanse for unge kvigekalver
EQBALIOKK(R,B,VARE)        Balanse for unge oksekalver
EQBALIKLV(R,B)             Balanse for alle kalver
EQMINKALVAND(R,KALV,B)     Minimumsandel  av de ulike kalvekategoriene i prosent
EQMAXKALVAND(R,KALV,B)     Maksimumsandel av de ulike kalvekategoriene i prosent
EQBALIPRK(R,B,VARE)        Balanse for unge griser
EQBALISAU(R,B,VARE)        Balanse for unge sauer
EQBALIGET(R,B,VARE)        Balanse for unge geiter
EQBALFGRV(R,B,*)           Balanse for grovfor
EQBALVFOR(R,B)             Balanse for vinterfor
EQBALBEIT(R,B)             Balanse for beitetilskudd
EQMINGROVAND(R,GROV,B)      Minimumsandel av de ulike grovforvekstene i prosent
EQMAKSGROVAND(R,GROV,B)     Maksimumsandel av de ulike grovforvekstene i prosent
EQBALKRNMIN(R,B,KORN)      Balanse for minimum vekstskifte i kornproduksjonen
EQBALKRNMAX(R,B,KORN)      Balanse for maksimum vekstskifte i kornproduksjonen
EQBALGRNMIN(R,B,GRNS)      Balanse for minimum vekstskifte i hagebruk
EQBALGRNMAX(R,B,GRNS)      Balanse for maksimum vekstskifte i hagebruk
EQBALFRKMIN(R,B,FRBA)      Balanse for minimum vekstskifte i frukt og baer
EQBALFRKMAX(R,B,FRBA)      Balanse for maksimum vekstskifte i frukt og baer
EQBALNITR(R,B)             Balanse for nitrogen
EQBALNPRD(R,B,PLANTE)      Balanse for nitrogen pr PRDK
EQBALFOSF(R,B)             Balanse for fosfor
EQBALFPRD(R,B,PLANTE)      Balanse for fosfor pr PRDK
EQBALKALI(R,B)             Balanse for kali
EQBALKPRD(R,B,PLANTE)      Balanse for kali pr PRDK
EQSPREDAR(R,B)             Overskudd paa spredeareal pr bruk og region
EQBALKORNMAX(R,B)          Bruksstoerrelse kornproduksjon
EQBALFRBAMAX(R,B)          Bruksstoerrelse fruktproduksjon
EQBALGRNSMAX(R,B)          Bruksstoerrelse groennsaksproduksjon
EQMAKSGFFP(R,B)             Maksimumsandel gras protein areal
EQBALKORNMIN(R,B)          Bruksstoerrelse kornproduksjon
EQBALFRBAMIN(R,B)          Bruksstoerrelse fruktproduksjon
EQBALGRNSMIN(R,B)          Bruksstoerrelse groennsaksproduksjon
EQCO2AVG(R,B,VARE)         Beregning av miljoavgifter
EQEMIS_N(R,B)              Beregning av avgifte for nitrogenutslipp
EQGE(R)                    Bruttoenergiinntak for melkekyr i MJ pr dyr og dag
EQYM(R)                    Andel GE som omdannes til metan (absolutt eller prosent?)
EQVSDM(R)                  Volatile solids (nedbrytbar organisk materiale fra husdyrgjodsel regnet i torrstoff

EQCH4ENTERIC(R,PRDK)      Utslipp av enteric metan fra fordoyelsesprosess i kg metan pr ku og ar
EQCH4MANURE(R,PRDK)       Utslipp av metan fra husdyrgjodselhantering i kg metan pr ku og ar
EQCH4BURNING(R,PRDK)      Utslipp av metan fra brenning av restavling i kg metan pr ku og ar

EQN2OMM(R,PRDK)            Direkte utslipp av lystgass fra gjodselhandtering i kg N2O pr region og bruk
EQN2OM(R,PRDK)             Direkte utslipp av lystgass fra gjodsling med husdyrgjodsel i kg N2O pr region og bruk
EQN2OB(R,PRDK)             Direkte utslipp av lystgass fra beiting i kg N2O pr region og bruk
EQN2OS(R,PRDK)             Direkte utslipp av lystgass fra gjodsling med kunstgjodsel i kg N2O pr region og bruk

EQN2ONH3MMNED(R,PRDK)      Indirekte utslipp av lystgass fra gjodselhandtering via nedfall av ammoniak i kg N2O pr region og bruk
EQN2ONH3MMAVR(R,PRDK)      Indirekte utslipp av lystgass fra gjodselhandtering via avrenning i kg N2O pr region og bruk
EQN2ONH3NED(R,PRDK)        Indirekte utslipp av lystgass fra gj?dsel gjennom nedfall
EQN2ONH3AVR(R,PRDK)        Indirekte utslipp av lystgass fra gj?dsel gjennom avrenning

EQNAVL(R,PRDK)             Avlingsrester
EQN2ONAVL(R,PRDK)          Utslipp av lystgass fra avlingsrester
EQN2OBRN(R,PRDK)           Utslipp av lystgass fra brenning av avlingsrester

EQN2OMYR(R,PRDK)           Utslipp av lystgass fra myr

EQCO2KALK(R,PRDK)          Utslipp av CO2 fra kalking
EQCO2SOUR(R,PRDK)          Utslipp av CO2 fra jord
EQCO2SINK(R,PRDK)          Opptak av CO2 fra jord

EQNH3MMNED(R,PRDK)         Ammoniak til beregning av n2onh3mmned pr region og bruk
EQNH3MMAVR(R,PRDK)         Ammoniak til beregning av n2onh3mmavr pr region og bruk
EQNH3NED(R,PRDK)           Ammoniak til beregning av n2onh3ned pr region og bruk
EQNH3AVR(R,PRDK)           Ammoniak til beregning av n2onh3avr pr region og bruk

EQNITH(R)                  Virksomt N som gjodsel pr ku pr region
EQFOSH(R)                  Virksomt P som gjodsel pr ku pr region
EQKALH(R)                  Virksomt K som gjodsel pr ku pr region

EQBEITEAND(R,B)            Andel grovfor produsert paa beite i prosent
;
*
* Definisjon av ligninger
*
*                     Totaltbidraget for bruket som sum av inntekter plus tilskudd fratrukket kostnader
*                     Ligningen aktiveres alltid
EQOBJEKTBRUK..        objbruk  =E=
* Profitt
                       SUM(RB(R,B)$ (RRR(R) AND BBB(B)), profitt(R,B)
* PMP feed allocation
*                     - SUM((PRDK,R,B) $ (RB(R,B) AND RRR(R) AND BBB(B) AND PRDKOPT(PRDK) AND AHUSDYR(PRDK)), PMPFeed(R,B,PRDK))
                      )
;
*
EQPROFITTBRUK(R,B) $ (RRR(R) AND BBB(B))
..  profitt(R,B) =E= SUM(RB(R,B)$ (RRR(R) AND BBB(B)),
* Salgsinntekter inkl spredareal
                       SUM(PRODUKT$(SUM(PRDKOPT, B_TIL_PRDK(PRDKOPT,B) * ENHDATA(R,PRODUKT,PRDKOPT,'BAS'))),  bidrag(R,B,PRODUKT))
* Tilskudd
                     + SUM(TILSKUDD $ TILOPT(TILSKUDD), bidrag(R,B,TILSKUDD))
* Kostnader
                     - SUM(INNSATS $(SUM(PRDKOPT, B_TIL_PRDK(PRDKOPT,B) * ENHDATA(R,INNSATS,PRDKOPT,'BAS'))),  bidrag(R,B,INNSATS))
* Miljoavgifter
                     - SUM(UTSLIPPAVG$(SUM(PRDKOPT, B_TIL_PRDK(PRDKOPT,B) * ENHDATA(R,UTSLIPPAVG,PRDKOPT,'BAS'))),    bidrag(R,B,UTSLIPPAVG))
* Kraftforavgift
                     - SUM((MOELUTKVARE,PRDKOPT)$(B_TIL_PRDK(PRDKOPT,B) AND ENHDATA(R,MOELUTKVARE,PRDKOPT,'BAS')), KFORAVG(R,MOELUTKVARE) * intens(R,MOELUTKVARE,PRDKOPT) * omfang(R,B,PRDKOPT) * .001 )
* Nitrogenavgift
                     - SUM(PRDKOPT$(B_TIL_PRDK(PRDKOPT,B) AND ENHDATA(R,'NITG',PRDKOPT,'BAS')), KFORAVG(R,'NITG') * intens(R,'NITG',PRDKOPT) * omfang(R,B,PRDKOPT) * .001 )
* Avgift utslipp nitrogen bare hvis ecosystem services tas med
$ifThenI.EmisN %EcoSys%==YES
                     - bidrag(R,B,'EMIS_N')
$endif.EmisN                     
)
;
*
*                     Eksogen intensitet i alle produksjoner
*                     Ligningen aktiveres kun dersom det finnes en VARE/aktivitet med en eksogen intensitet
EQINTEKSO(R,VARE,PRDK)$(EKSI(VARE,PRDK) AND ENHDATA(R,VARE,PRDK,'BAS') AND (NOT SAMEAS('SPRE',VARE)) AND RRR(R) AND SUM(BBB, B_TIL_PRDK(PRDK,BBB)))
.. intens(R,VARE,PRDK)  =E= (ENHDATA(R,VARE,PRDK,'Y') + SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,PRDK,VARE,'','ABS',KLTKA)*opptak(R,BBB,KLTKA)) * (1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,PRDK,VARE,'','REL',KLTKA)*opptak(R,BBB,KLTKA))))
                          + (EPS * ENHDATA(R,VARE,PRDK,'Y')) $ (SUM(B$BBB(B), 1) AND SAMEAS('AKST',VARE));
*
*                     Endogen intensitet i melkeproduksjonen
*                     Ligningen aktiveres kun dersom det finnes melkekyr
EQINTKMLK(R,'KMLK','MKYR') $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB)))
.. intens(R,'KMLK','MKYR') =E=  KALIBKMLK   *
  [AMELK*((intens(R,'FGRV','MKYR')-mFGRV)**(-EMELK))
 + BMELK*((intens(R,'FDRM','MKYR')*(1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,'FDRM','','MKYR','REL',KLTKA)*opptak(R,BBB,KLTKA))))**(-EMELK))
 + CMELK*((intens(R,'FDRM','MKYR')+(intens(R,'FGRV','MKYR')*(1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,'FDRM','','MKYR','REL',KLTKA)*opptak(R,BBB,KLTKA))))-mF)**(-EMELK))
 + DMELK*(FMELK**(-EMELK))]**(-1/EMELK);
*
*                     Maksimal kraftforprosent for melkekyr
*                     Ligningen aktiveres kun dersom det finnes melkekyr
EQMAXKFORMELK(R) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB)))
.. (intens(R,'FDRM','MKYR')*(1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,'FDRM','','MKYR','REL',KLTKA)*opptak(R,BBB,KLTKA)))) / ((intens(R,'FDRM','MKYR')*(1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,'FDRM','','MKYR','REL',KLTKA)*opptak(R,BBB,KLTKA)))) + intens(R,'FGRV','MKYR')) =L= KFORMAX ;
*
*                     Minimal kraftforprosent for melkekyr
*                     Ligningen aktiveres kun dersom det finnes melkekyr
EQMINKFORMELK(R) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB)))
.. (intens(R,'FDRM','MKYR')*(1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,'FDRM','','MKYR','REL',KLTKA)*opptak(R,BBB,KLTKA)))) / ((intens(R,'FDRM','MKYR')*(1+SUM((KLTKA,BBB),KLIMAEFFEKT(R,BBB,'FDRM','','MKYR','REL',KLTKA)*opptak(R,BBB,KLTKA)))) + intens(R,'FGRV','MKYR')) =G= KFORMIN ;
*
*                     Maksimal foropptak i melkeproduksjonen
*                     Ligningen aktiveres kun dersom det finnes melkekyr
EQMAXFORMELK(R) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB)))
.. (intens(R,'FDRM','MKYR')*(1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,'FDRM','','MKYR','REL',KLTKA)*opptak(R,BBB,KLTKA)))) + intens(R,'FGRV','MKYR') =L= FORMELK ;
*
*                     Max grovforprosent av drovtyggere uten melkekyr
*                     Ligningen aktiveres kun dersom det finnes dr?vtyggere uten melkekyr
EQMAXFGRVAHUSDYR(R,'FGRV',AHUSDYR) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK(AHUSDYR,BBB)))
..     intens(R,'FGRV',AHUSDYR) / (intens(R,'FGRV',AHUSDYR) + intens(R,'FDRA',AHUSDYR) + intens(R,'FDRM',AHUSDYR)) =L= (1 - MINKFORAHUSDYR(R,AHUSDYR));
*
*                     For til drovtyggere uten husdyr
*                     Ligningen aktiveres kun dersom det finnes dr?vtyggere uten husdyr
EQFORAHUSDYR(R,AHUSDYR) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK(AHUSDYR,BBB)))
.. intens(R,'FFEM',AHUSDYR) =E= SUM(VARE$(AHUSDYR_TIL_MOEL(AHUSDYR,VARE) AND (NOT SAMEAS('FFEM',VARE))), intens(R,VARE,AHUSDYR)) ;
*
*                     Endogen slaktevekt ved foring av drovtyggere uten melkekyr
EQINTKJOETT(R,VARE,AHUSDYR) $ (RRR(R) AND VAREOPT(VARE) AND AHUSDYR_TIL_VARE(AHUSDYR,VARE) AND SUM(BBB, B_TIL_PRDK(AHUSDYR,BBB)))
.. intens(R,VARE,AHUSDYR) =E= (intens(R,'FGRV',AHUSDYR) + intens(R,'FDRA',AHUSDYR) + intens(R,'FDRM',AHUSDYR)) * ProdIntens(R,AHUSDYR,VARE) ;
*
*                     Produksjonskvoter
*                     Ligningen aktiveres kun naar en varekvote er definert
EQVAREKVOT(R,VAREOPT)$ (RRR(R) AND (VAREKVOT(R,VAREOPT) LT INF) AND SUM((BBB,PRDKOPT), B_TIL_PRDK(PRDKOPT,BBB)* ENHDATA(R,VAREOPT,PRDKOPT,'BAS')))
.. SUM((PRDKOPT,BBB)$ENHDATA(R,VAREOPT,PRDKOPT,'BAS'), intens(R,VAREOPT,PRDKOPT) * omfang(R,BBB,PRDKOPT)) =E= VAREKVOT(R,VAREOPT) ;
*
*                     Endogen intensitet i produksjon av korn
*                     Ligningen aktiveres kun dersom det finnes den respektive aktiviteten i basisaaret og bruket har minst en aktivitet med det respektive produktet
EQINTKORN(R,VARE,PRDK)$((NOT EKSI(VARE,PRDK)) AND (MINAVL(PRDK,R) GT 0) AND DATA(R,PRDK,'OMFG','BAS') AND PRDK_TIL_VARE(PRDK,VARE) AND RRR(R)  AND SUM(BBB, B_TIL_PRDK(PRDK,BBB)))
.. intens(R,VARE,PRDK) =E= (MINAVL(PRDK,R) + SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,PRDK,VARE,'','ABS',KLTKA)*opptak(R,BBB,KLTKA)) + [INTPL(R,'APL',PRDK)**(-INTPL(R,'EPL',PRDK)) + INTPL(R,'BPL',PRDK)*(intens(R,'NITR',PRDK)*KALIBAVLKORN)**(-INTPL(R,'EPL',PRDK))]**(-1/INTPL(R,'EPL',PRDK))) * (1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,PRDK,VARE,'','REL',KLTKA)*opptak(R,BBB,KLTKA)));
*
*                     Endogen intensitet i produksjon av grovfor
*                     Ligningen aktiveres kun dersom det finnes den respektive aktiviteten i basisaaret og bruket har minst en aktivitet med det respektive produktet
EQINTGROV(R,VARE,GROV)$(NOT EKSI(VARE,GROV) AND DATA(R,GROV,'OMFG','BAS') AND PRDK_TIL_VARE(GROV,VARE) AND RRR(R)  AND SUM(BBB, B_TIL_PRDK(GROV,BBB)))
.. intens(R,VARE,GROV) =E=  (1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,GROV,'GROV','','REL',KLTKA)*opptak(R,BBB,KLTKA))) * (GROVAVL(GROV,'0',R) + GROVAVL(GROV,'1',R)*(intens(R,'NITR',GROV)*KALIBAVLGRAS) + GROVAVL(GROV,'2',R)*(intens(R,'NITR',GROV)*KALIBAVLGRAS)**2);
*
*
*                     Endogen intensitet for exp model: KAPB, KAPM and linear model: VEDB, VEDM, PLVR, VETM, AKST
EQIntVerdDGKoeff(R,B,VARE) $ (
    RRR(R) AND BBB(B) AND DGVARE(VARE) AND VAREOPT(VARE) 
*    AND EndoCoeffE(B,VARE) 
    AND  SUM((BBB,PRDKOPT) $ B_TIL_PRDK(PRDKOPT,BBB), ENHDATA(R,VARE,PRDKOPT,'BAS'))
                         )
.. bidrag(R,B,VARE) * 1000 / SIMDATA(R,VARE,'TOTP','Y') =E=
* linear model
   {
        FarmEndoKoeff(R,B,'',VARE)
      + SUM(KLTKA,     KLIMAEFFEKT(R,B,'BRUK',VARE,'0','ABS',KLTKA)*opptak(R,B,KLTKA))
      + SUM(PRDKOPT,  (FarmEndoKoeff(R,B,PRDKOPT,VARE) + SUM(KLTKA, KLIMAEFFEKT(R,B,'BRUK',PRDKOPT,'1','ABS',KLTKA)*opptak(R,B,KLTKA))) *  omfang(R,B,PRDKOPT))
   } $ DGVARELIN(VARE)

* exponential model
* + {[  SUM(KLTKA,     KLIMAEFFEKT(R,B,'BRUK',VARE,'0','ABS',KLTKA)*opptak(R,B,KLTKA))
*    + SUM(PRDKOPT $ B_TIL_HRDK(B,PRDKOPT), omfang(R,B,PRDKOPT)) * 
*      SUM(PRDKOPT $ (omfang.lo(R,B,PRDKOPT) > 0),  (EndoCoeffA(R,B,PRDKOPT,VARE) + SUM(KLTKA, KLIMAEFFEKT(R,B,'BRUK',PRDKOPT,'1','ABS',KLTKA)*opptak(R,B,KLTKA))) *  omfang(R,B,PRDKOPT)**EndoCoeffE(B,VARE))
*    ] * 1000 } $ DGVAREEXP(VARE)

 + {[  SUM(KLTKA,     KLIMAEFFEKT(R,B,'BRUK',VARE,'0','ABS',KLTKA)*opptak(R,B,KLTKA))
   +  SUM(PRDKOPT $ B_TIL_HRDK(B,PRDKOPT), omfang(R,B,PRDKOPT)) 
   *  SUM(PRDKOPT $ B_TIL_HRDK(B,PRDKOPT), EndoCoeffA(R,B,PRDKOPT,VARE)) 
   *  [SUM(PRDKOPT $ B_TIL_PRDK(PRDKOPT,B), ShareEndoIntens(R,B,PRDKOPT,VARE) * omfang(R,B,PRDKOPT))]**EndoCoeffE(B,VARE) 
    ] * 1000 } $ DGVAREEXP(VARE)
;
*
*                     Endogen intensitet for KAPB, KAPM, VEDB, VEDM, PLVR, VETM, AKST
EQIntMngdDGKoeff(R,VARE,PRDK) $ (RRR(R) AND PRDKOPT(PRDK) AND VAREOPT(VARE) AND DGVARE(VARE)
    AND Sum(B $ BBB(B), EndoCoeffE(B,VARE)) AND  ENHDATA(R,VARE,PRDK,'BAS')
    )
.. intens(R,VARE,PRDK) =E=
* linear model
  {
* prdk-specific
    (ENDOKOEFF(R,PRDK,VARE) + SUM((B,KLTKA)$BBB(B), KLIMAEFFEKT(R,B,'BRUK',PRDK,'1','ABS',KLTKA)*opptak(R,B,KLTKA)))
* farm-specific allocated to all prdk with specific coefficient
  +  SUM(B$BBB(B), ENDOKOEFF(R,B,VARE)) /  SUM((B,PRDKPRDK)$(BBB(B) $ PRDKOPT(PRDKPRDK) $ ENDOKOEFF(R,PRDKPRDK,VARE)), omfang(R,B,PRDKPRDK))
  } $ DGVARELIN(VARE)
  
* exponential model
* --- total quantity
 + {   SUM(B$BBB(B),
   [  SUM(KLTKA,     KLIMAEFFEKT(R,B,'BRUK',VARE,'0','ABS',KLTKA)*opptak(R,B,KLTKA))
   +  SUM(PRDKOPT $ B_TIL_HRDK(B,PRDKOPT), omfang(R,B,PRDKOPT)) 
   *  SUM(PRDKOPT $ B_TIL_HRDK(B,PRDKOPT), EndoCoeffA(R,B,PRDKOPT,VARE)) 
   *  [SUM(PRDKOPT $ B_TIL_PRDK(PRDKOPT,B), ShareEndoIntens(R,B,PRDKOPT,VARE) * omfang(R,B,PRDKOPT))]**EndoCoeffE(B,VARE) 
   ]  ) 
     
* multiplied by share of PRDK without exponent
 *   ((SUM(B$BBB(B), ENDOKOEFF(R,PRDK,VARE) * omfang(R,B,PRDK))  /  SUM((B,PRDKPRDK) $ (BBB(B) $ PRDKOPT(PRDKPRDK)),  ENDOKOEFF(R,PRDKPRDK,VARE) * omfang(R,B,PRDKPRDK))))
* divided by activity level (pluss some small value to ensure feasibility)
  / (SUM(B$BBB(B), omfang(R,B,PRDK) + 1E-3))
  * 1000  } $ DGVAREEXP(VARE)
;
*
*                     Avskrivninger paa bygningskapital for 30 aar
EQINTAVSB(R,B)$ (RRR(R) AND BBB(B) AND SUM((BBB,PRDKOPT), B_TIL_PRDK(PRDKOPT,BBB) * ENHDATA(R,'KAPB',PRDKOPT,'BAS')))
.. bidrag(R,B,'AVSB') =E= 2 * ( bidrag(R,B,'KAPB') / SIMDATA(R,'KAPB','TOTP','Y')) / 40;
*
*                     Avskrivninger paa maskinkapital for 20 aar
EQINTAVSM(R,B)$ (RRR(R) AND BBB(B) AND SUM((BBB,PRDKOPT), B_TIL_PRDK(PRDKOPT,BBB) * ENHDATA(R,'KAPM',PRDKOPT,'BAS')))
.. bidrag(R,B,'AVSM') =E= 2 * ( bidrag(R,B,'KAPM') / SIMDATA(R,'KAPM','TOTP','Y')) / 20;
*
*                     Endogen intensitet for arbeid i timer
EQINTARBF(R,B)$ (RRR(R) AND BBB(B) AND SUM((BBB,PRDKOPT), B_TIL_PRDK(PRDKOPT,BBB) * ENHDATA(R,'ARBF',PRDKOPT,'BAS')))
.. arbeid(R,B,'ARBF') + arbeid(R,B,'ARBL') =E=
* linear model
*                ENDOKOEFF(R,B,'ARBT')
*+ SUM(PRDKOPT $ ENDOKOEFF(R,PRDKOPT,'ARBT'),  ENDOKOEFF(R,PRDKOPT,'ARBT')  * omfang(R,B,PRDKOPT))
*
* exponential model with Endokoeff(R,B,'ARBT') as exponential term
      SUM(PRDKOPT $ B_TIL_HRDK(B,PRDKOPT), omfang(R,B,PRDKOPT)) 
  *   SUM(PRDKOPT $ B_TIL_HRDK(B,PRDKOPT), EndoCoeffA(R,B,PRDKOPT,'ARBT')) 
  *  [SUM(PRDKOPT $ B_TIL_PRDK(PRDKOPT,B), ShareEndoIntens(R,B,PRDKOPT,'ARBT') * omfang(R,B,PRDKOPT))]**EndoCoeffE(B,'ARBT') 
;
*
*                     Pris for familiearbeid i 1000 kr
EQPRSARBF(R,B,'ARBF') $ (RRR(R) AND BBB(B) AND SUM((BBB,PRDKOPT), B_TIL_PRDK(PRDKOPT,BBB) * ENHDATA(R,'ARBF',PRDKOPT,'BAS')))

* linear model
.. arbeid(R,B,'ARBF') * pris(R,B,'ARBF') + arbeid(R,B,'ARBL') * SIMDATA(R,'ARBL','TOTP','Y') =G=
                FarmEndoKoeff(R,B,'','ARBP')
+ SUM(PRDKOPT $ FarmEndoKoeff(R,B,PRDKOPT,'ARBP'),  FarmEndoKoeff(R,B,PRDKOPT,'ARBP')  * omfang(R,B,PRDKOPT))
*
* exponential model with Endokoeff(R,B,'ARBP') as exponential term
*.. pris(R,B,'ARBF') =E=
*      SUM(PRDKOPT $ B_TIL_HRDK(B,PRDKOPT), EndoCoeffA(R,B,PRDKOPT,'ARBP')) 
*  *  [SUM(PRDKOPT $ B_TIL_PRDK(PRDKOPT,B), ShareEndoIntens(R,B,PRDKOPT,'ARBP') * omfang(R,B,PRDKOPT))]**EndoCoeffE(B,'ARBP') 
;
*
*                     Kostnader for familiearbeid i kr pr time
*                     Kostnader for arbeid i 1000 kr
EQKSTARBF(R,B,'ARBF')$ (RB(R,B) AND SUM(PRDKOPT, B_TIL_PRDK(PRDKOPT,B) * ENHDATA(R,'ARBF',PRDKOPT,'BAS')))
.. bidrag(R,B,'ARBF') * 1000 =E= arbeid(R,B,'ARBF') * pris(R,B,'ARBF')
                               + arbeid(R,B,'ARBL') * SIMDATA(R,'ARBL','TOTP','Y')
;

*                     Balanser: Minimumsandel grovforvekster
*                     Ligningen aktiveres kun dersom det finnes grovfor for bruket
EQMINGROVAND(R,GROV,B) $ (RB(R,B) AND BBB(B) AND SUM(BBB, B_TIL_PRDK(GROV,BBB) * ENHDATA(R,GROV,GROV,'BAS')))
..   GROVAND(R,GROV,'MIN') * SUM(GROVGROV, omfang(R,B,GROVGROV)) =L=  omfang(R,B,GROV) ;
*
*                     Balanser: Maksimumsandel grovforvekster
*                     Ligningen aktiveres kun dersom det finnes grovfor for bruket
EQMAKSGROVAND(R,GROV,B) $ (RB(R,B) AND BBB(B) AND SUM(BBB, B_TIL_PRDK(GROV,BBB) * ENHDATA(R,GROV,GROV,'BAS')))
..    GROVAND(R,GROV,'MAX') * SUM(GROVGROV, omfang(R,B,GROVGROV)) =G=  omfang(R,B,GROV) ;
*
*                     Balanser: Maksimum areal gras protein
*                     Ligningen aktiveres kun dersom det finnes grovfor for bruket
EQMAKSGFFP(R,B) $ (RB(R,B) AND BBB(B) AND SUM((BBB,GROV), B_TIL_PRDK(GROV,BBB) * ENHDATA(R,GROV,GROV,'BAS')))
..    OMFGGFFP(R,B,'GFFP') =E= omfang(R,B,'GFFP')  ;
*
*                     Balanser: Grovfor i FEm
*                     Ligningen aktiveres kun dersom det finnes grovfor for minst en husdyraktivitet som er definert for bruket
*                     Det tillates at ikke alt produsert f?r blir brukt
EQBALFGRV(R,B,'GROV') $ (RB(R,B) AND BBB(B) AND SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'FGRV',HUSDYR,'BAS')))
..    SUM((GROV,PRODUKT)$(PRDK_TIL_VARE(GROV,PRODUKT) AND B_TIL_PRDK(GROV,B)), intens(R,PRODUKT,GROV)  * omfang(R,B,GROV)) + intens(R,'GFUB','GFUB') * omfang(R,B,'GFUB')
*=G=   SUM(HUSDYR$(ENHDATA(R,'FGRV',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)),    intens(R,'FGRV',HUSDYR) * omfang(R,B,HUSDYR)) * (1 + FGRVOverskd/100);
=E=   SUM(HUSDYR$(ENHDATA(R,'FGRV',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)),    intens(R,'FGRV',HUSDYR) * omfang(R,B,HUSDYR)) * (1 + FGRVOverskd/100);
*
*                     Balanser: Ungdyr
*                     Ligningen aktiveres kun dersom det finnes input av det respektive produktet for minst en husdyraktivitet som er definert for bruket
EQBALIKYR(R,B,'IKYR')$(RB(R,B) AND BBB(B) AND (SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'IKYR',HUSDYR,'BAS')) OR SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'OKYR',HUSDYR,'BAS'))))
..    SUM(HUSDYR$(ENHDATA(R,'IKYR',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'IKYR',HUSDYR) * omfang(R,B,HUSDYR))
=E=   SUM(HUSDYR$(ENHDATA(R,'OKYR',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'OKYR',HUSDYR) * omfang(R,B,HUSDYR));
*
EQBALIKVG(R,B,'IKVG')$(RB(R,B) AND BBB(B) AND (SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'IKVG',HUSDYR,'BAS')) OR SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'OKVG',HUSDYR,'BAS'))))
..    SUM(HUSDYR$(ENHDATA(R,'IKVG',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'IKVG',HUSDYR) * omfang(R,B,HUSDYR))
=E=   SUM(HUSDYR$(ENHDATA(R,'OKVG',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'OKVG',HUSDYR) * omfang(R,B,HUSDYR));
*
EQBALIOKS(R,B,'IOKS')$(RB(R,B) AND BBB(B) AND (SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'IOKS',HUSDYR,'BAS')) OR SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'OOKS',HUSDYR,'BAS'))))
..    SUM(HUSDYR$(ENHDATA(R,'IOKS',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'IOKS',HUSDYR) * omfang(R,B,HUSDYR))
=E=   SUM(HUSDYR$(ENHDATA(R,'OOKS',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'OOKS',HUSDYR) * omfang(R,B,HUSDYR));
*
EQBALIKVK(R,B,'IKVK')$(RB(R,B) AND BBB(B) AND (SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'IKVK',HUSDYR,'BAS')) OR SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'OKVK',HUSDYR,'BAS'))))
..    SUM(HUSDYR$(ENHDATA(R,'IKVK',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'IKVK',HUSDYR) * omfang(R,B,HUSDYR))
=E=   SUM(HUSDYR$(ENHDATA(R,'OKVK',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'OKVK',HUSDYR) * omfang(R,B,HUSDYR));
*
EQBALIOKK(R,B,'IOKK')$(RB(R,B) AND BBB(B) AND (SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'IOKK',HUSDYR,'BAS')) OR SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'IOKK',HUSDYR,'BAS'))))
..    SUM(HUSDYR$(ENHDATA(R,'IOKK',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'IOKK',HUSDYR) * omfang(R,B,HUSDYR))
=E=   SUM(HUSDYR$(ENHDATA(R,'OOKK',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'OOKK',HUSDYR) * omfang(R,B,HUSDYR));

* Sum kalver
EQBALIKLV(R,B)$(RB(R,B) AND BBB(B) AND (SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'IOKK',HUSDYR,'BAS')) OR SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'IOKK',HUSDYR,'BAS'))))
..    SUM(HUSDYR$(ENHDATA(R,'IOKK',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'IOKK',HUSDYR) * omfang(R,B,HUSDYR)) + SUM(HUSDYR$(ENHDATA(R,'IKVK',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'IKVK',HUSDYR) * omfang(R,B,HUSDYR))
=E=   SUM(HUSDYR$(ENHDATA(R,'OOKK',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'OOKK',HUSDYR) * omfang(R,B,HUSDYR)) + SUM(HUSDYR$(ENHDATA(R,'OKVK',HUSDYR,'BAS') AND B_TIL_PRDK(HUSDYR,B)), intens(R,'OKVK',HUSDYR) * omfang(R,B,HUSDYR));

* Allocation of calves bulls and heifers
* Minimum share of the different young cattle categories
EQMINKALVAND(R,KALV,B) $ (RB(R,B) AND BBB(B) AND RRR(R) AND B_TIL_PRDK(KALV,B))
..   omfang(R,B,KALV)
=G=  KALVAND(R,KALV,'MIN') * sum(KALVKALV, omfang(R,B,KALVKALV))
;
*
* Maximum share of the different young cattle categories
EQMAXKALVAND(R,KALV,B) $ (RB(R,B) AND BBB(B) AND RRR(R) AND B_TIL_PRDK(KALV,B))
..   omfang(R,B,KALV)
=L=  KALVAND(R,KALV,'MAX')  * sum(KALVKALV, omfang(R,B,KALVKALV))
;
*
EQBALIPRK(R,B,'IPRK')$(RB(R,B) AND BBB(B) AND SUM(BBB, B_TIL_PRDK('PURK',BBB) * ENHDATA(R,'IPRK','PURK','BAS')))
..    omfang(R,B,'GRIS')
=E=   omfang(R,B,'PURK') * ENHDATA(R,'IPRK','PURK','Y');

*
EQBALISAU(R,B,'ISAU')$(RB(R,B) AND BBB(B) AND SUM(BBB, B_TIL_PRDK('SOEY',BBB) * ENHDATA(R,'ISAU','SOEY','BAS')))
..    omfang(R,B,'LAMS')
=E=   omfang(R,B,'SOEY') * ENHDATA(R,'ISAU','SOEY','Y');
*
EQBALIGET(R,B,'IGET')$(RB(R,B) AND BBB(B) AND SUM(BBB, B_TIL_PRDK('GEIT',BBB) * ENHDATA(R,'IGET','GEIT','BAS')))
..    omfang(R,B,'KJES')
=E=   omfang(R,B,'GEIT') * ENHDATA(R,'IGET','GEIT','Y');
*
*                     Balanser: Krav til vinterfor med slatt
*                     Ligningen aktiveres kun dersom det finnes grovfor for minst en husdyraktivitet som er definert for bruket
EQBALVFOR(R,B)$(RB(R,B)AND BBB(B)  AND SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'FGRV',HUSDYR,'BAS')))
..                     intens(R,'GFFS','GFFS') * omfang(R,B,'GFFS') + intens(R,'GFOS','GFOS') * omfang(R,B,'GFOS')
=G= VFORKRAV(R)/52 * ( intens(R,'GFFS','GFFS') * omfang(R,B,'GFFS') + intens(R,'GFOS','GFOS') * omfang(R,B,'GFOS')
                     + intens(R,'GFFB','GFFB') * omfang(R,B,'GFFB') + intens(R,'GFOB','GFOB') * omfang(R,B,'GFOB')
                     + intens(R,'GFIB','GFIB') * omfang(R,B,'GFIB') + intens(R,'GFUB','GFUB') * omfang(R,B,'GFUB')
*);
                     + intens(R,'FGRJ','GFFP') * omfang(R,B,'GFFP'));
*
*                     Balanser: Beitetilskudd
*                     Ligningen aktiveres kun dersom det finnes grovfor for minst en husdyraktivitet som er definert for bruket
*                     Krav til beitetilskudd
EQBALBEIT(R,B)$(RB(R,B) AND (BBB('BKMK') OR BBB('BAKY')))
..   omfang(R,B,'GFFB') + omfang(R,B,'GFOB') + omfang(R,B,'GFIB') + omfang(R,B,'GFUB')
=G=  BEITUKE(R)/52 * 10 * (omfang(R,B,'MKYR') $ B('BKMK') + omfang(R,B,'AKYR') $ B('BAKYR'));

*                     Balanser: Nitrogen fra husdyrgj?dsel til planter
*                     Ligningen aktiveres kun dersom bruket har husdyr med planteproduksjon
EQBALNITR(R,B)$(RB(R,B)AND RRR(R) AND BBB(B)
                       AND SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'NITH',HUSDYR,'BAS'))
                       AND SUM((BBB,PLANTE), B_TIL_PRDK(PLANTE,BBB) * ENHDATA(R,'NITR',PLANTE,'BAS')))
..
     SUM(PLANTE$B_TIL_PRDK(PLANTE,B), intens(R,'NITH',PLANTE) * omfang(R,B,PLANTE) * (1+SUM(KLTKA, KLIMAEFFEKT(R,B,PLANTE,'NITH','','REL',KLTKA)*opptak(R,B,KLTKA))))
=E=  SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), intens(R,'NITH',HUSDYR) * omfang(R,B,HUSDYR))
   - SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), (28/44) * intens(R,'N2OMM',HUSDYR) * omfang(R,B,HUSDYR))
   - SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), (28/44) * intens(R,'N2OB',HUSDYR) * omfang(R,B,HUSDYR))
   - SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), (28/44) * intens(R,'N2ONH3NED',HUSDYR) * omfang(R,B,HUSDYR))
   - SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), (28/44) * intens(R,'N2ONH3MMNED',HUSDYR) * omfang(R,B,HUSDYR))
   - SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), (28/44) * intens(R,'N2ONH3MMAVR',HUSDYR) * omfang(R,B,HUSDYR))
   - SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), (28/44) * intens(R,'N2ONH3NED',HUSDYR) * omfang(R,B,HUSDYR))
   - SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), (28/44) * intens(R,'N2ONH3AVR',HUSDYR) * omfang(R,B,HUSDYR))  ;
*
*                     Balanser: Nitrogen pr PRDK inkl N-tap fra gj?dsling og avrenning
*                     Ligningen aktiveres kun dersom bruket trenger nitrogen i planteproduksjon
EQBALNPRD(R,B,PLANTE)$(RB(R,B) AND RRR(R) AND BBB(B)
                       AND SUM(BBB, B_TIL_PRDK(PLANTE,BBB) * ENHDATA(R,'NITR',PLANTE,'BAS')))
..   intens(R,'NTAP',PLANTE)
=E=  intens(R,'NITH',PLANTE) + intens(R,'NITG',PLANTE)
   - intens(R,'NITR',PLANTE) - intens(R,'NAVL',PLANTE)
                 - (22/48)   * intens(R,'N2OS',PLANTE);
*
*                     Balanser: Fosfor
*                     Ligningen aktiveres kun dersom bruket har husdyr og plante
EQBALFOSF(R,B)$(RB(R,B)AND RRR(R) AND BBB(B)
                       AND SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'FOSH',HUSDYR,'BAS'))
                       AND SUM((BBB,PLANTE), B_TIL_PRDK(PLANTE,BBB) * ENHDATA(R,'FOSF',PLANTE,'BAS')))
..   SUM(PLANTE$B_TIL_PRDK(PLANTE,B), intens(R,'FOSH',PLANTE) * omfang(R,B,PLANTE))
=L=  SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), intens(R,'FOSH',HUSDYR) * omfang(R,B,HUSDYR));
*
*                     Balanser: Fosfor pr PRDK
*                     Ligningen aktiveres kun dersom bruket trenger fosfor i planteproduksjon
EQBALFPRD(R,B,PLANTE)$(RB(R,B)AND RRR(R) AND BBB(B) AND SUM(BBB, B_TIL_PRDK(PLANTE,BBB) * ENHDATA(R,'FOSF',PLANTE,'BAS')))
..   intens(R,'FOSF',PLANTE) =E=  intens(R,'FOSH',PLANTE) + intens(R,'FOSG',PLANTE) ;
*
*                     Balanser: Kali
*                     Ligningen aktiveres kun dersom bruket har husdyr
EQBALKALI(R,B)$(RB(R,B)AND RRR(R) AND BBB(B)
                       AND SUM((BBB,HUSDYR), B_TIL_PRDK(HUSDYR,BBB) * ENHDATA(R,'KALH',HUSDYR,'BAS'))
                       AND SUM((BBB,PLANTE), B_TIL_PRDK(PLANTE,BBB) * ENHDATA(R,'KALI',PLANTE,'BAS')))
..   SUM(PLANTE$B_TIL_PRDK(PLANTE,B), intens(R,'KALH',PLANTE) * omfang(R,B,PLANTE))
=L=  SUM(HUSDYR$B_TIL_PRDK(HUSDYR,B), intens(R,'KALH',HUSDYR) * omfang(R,B,HUSDYR));
*
*                     Balanser: Kali pr PRDK
*                     Ligningen aktiveres kun dersom bruket trenger kali i planteproduksjon
EQBALKPRD(R,B,PLANTE)$(RB(R,B)AND RRR(R) AND BBB(B) AND SUM(BBB, B_TIL_PRDK(PLANTE,BBB) * ENHDATA(R,'KALI',PLANTE,'BAS')))
..   intens(R,'KALI',PLANTE) =E=   intens(R,'KALH',PLANTE) + intens(R,'KALG',PLANTE) ;
*
*                     Balanser: Mimumumsandel vekst i kornproduksjon
*                     Ligningen aktiveres kun for kornbruk
EQBALKRNMIN(R,B,KORN)$(RB(R,'BKRN') AND RRR(R) AND BBB(B) AND (DATA(R,KORN,'OMFG','BAS') > .1))
..   KORNAND(R,KORN,'MIN') * (1+SUM(KLTKA, KLIMAEFFEKT(R,B,KORN,'','MINAND','REL',KLTKA)*opptak(R,B,KLTKA))) *  SUM(KORNKORN$(DATA(R,KORNKORN,'OMFG','BAS') > .1), omfang(R,B,KORNKORN)) =L=  omfang(R,B,KORN);
*
*                     Balanser: Maksimumsandel vekst i kornproduksjon
*                     Ligningen aktiveres kun for kornbruk
EQBALKRNMAX(R,B,KORN)$(RB(R,'BKRN') AND RRR(R)  AND BBB(B) AND (DATA(R,KORN,'OMFG','BAS') > .1))
..   KORNAND(R,KORN,'MAX') * (1+SUM(KLTKA, KLIMAEFFEKT(R,B,KORN,'','MAXAND','REL',KLTKA)*opptak(R,B,KLTKA))) * SUM(KORNKORN$(DATA(R,KORNKORN,'OMFG','BAS') > .1), omfang(R,B,KORNKORN)) =G=  omfang(R,B,KORN) ;
*
*                     Balanser: Mimumumsandel vekst i hagebruk
*                     Ligningen aktiveres kun for hagebruk
EQBALGRNMIN(R,B,GRNS)$(RB(R,'BHGE') AND RRR(R)  AND BBB(B) AND (DATA(R,GRNS,'OMFG','BAS') > .00001))
..   GRNSAND(R,GRNS,'MIN') * SUM(GRNSGRNS$(DATA(R,GRNSGRNS,'OMFG','BAS') > .00001), omfang(R,B,GRNSGRNS)) =L=  omfang(R,B,GRNS) ;
*
*                     Balanser: Maksimumsandel vekst i hagebruk
*                     Ligningen aktiveres kun for GRNSbruk
EQBALGRNMAX(R,B,GRNS)$(RB(R,'BHGE') AND RRR(R)  AND BBB(B) AND (DATA(R,GRNS,'OMFG','BAS') > .00001))
..   GRNSAND(R,GRNS,'MAX') * SUM(GRNSGRNS$(DATA(R,GRNSGRNS,'OMFG','BAS') > .00001), omfang(R,B,GRNSGRNS)) =G=  omfang(R,B,GRNS) ;
*
*                     Balanser: Mimumumsandel vekst i frukt og baer
*                     Ligningen aktiveres kun for fruktbruk
EQBALFRKMIN(R,B,FRBA)$(RB(R,'BFRK') AND RRR(R)  AND BBB(B) AND (DATA(R,FRBA,'OMFG','BAS') > .0001))
..   FRBAAND(R,FRBA,'MIN') * SUM(FRBAFRBA$(DATA(R,FRBAFRBA,'OMFG','BAS') > .0001), omfang(R,B,FRBAFRBA)) =L=  omfang(R,B,FRBA)  ;
*
*                     Balanser: Maksimumsandel vekst i frukt og baer
*                     Ligningen aktiveres kun for fruktbruk
EQBALFRKMAX(R,B,FRBA)$(RB(R,'BFRK') AND RRR(R)  AND BBB(B) AND (DATA(R,FRBA,'OMFG','BAS') > .0001))
..   FRBAAND(R,FRBA,'MAX') * SUM(FRBAFRBA$(DATA(R,FRBAFRBA,'OMFG','BAS') > .0001), omfang(R,B,FRBAFRBA)) =G=  omfang(R,B,FRBA) ;
*
*                     Beregning av spredeareal
*                     Ligningen aktiveres for alle bruk
EQSPREDAR(R,B)$(RB(R,B) AND RRR(R) AND BBB(B))
..   balans(R,B,'SPRE') =E=  SUM(PRDKOPT$SPREDKOEFF(PRDKOPT), omfang(R,B,PRDKOPT) * SPREDKOEFF(PRDKOPT));
*
*                     Balanser: Stoerrelse bruk i kornproduksjon
*                     Ligningen aktiveres kun dersom bruket har korn
EQBALKORNMAX(R,B)$(RB(R,B) AND RRR(R) AND BBB(B) AND SUM((BBB,KORN), B_TIL_PRDK(KORN,BBB)))
..   KORNOMFANGMAX =G=  SUM(KORN$B_TIL_PRDK(KORN,B), omfang(R,B,KORN));
*
*                     Balanser: Stoerrelse bruk i kornproduksjon
*                     Ligningen aktiveres kun dersom bruket har korn
EQBALKORNMIN(R,B)$(RB(R,B) AND RRR(R) AND BBB(B) AND SUM((BBB,KORN), B_TIL_PRDK(KORN,BBB)))
..   KORNOMFANGMIN =L=  SUM(KORN$B_TIL_PRDK(KORN,B), omfang(R,B,KORN));
*
*                     Balanser: Stoerrelse bruk i groennsaksproduksjon
*                     Ligningen aktiveres kun dersom bruket har gr?nt
EQBALGRNSMAX(R,B)$(RB(R,B) AND RRR(R) AND BBB(B) AND SUM((BBB,GRNS), B_TIL_PRDK(GRNS,BBB)))
..   GRNSOMFANGMAX =G=  SUM(GRNS$B_TIL_PRDK(GRNS,B), omfang(R,B,GRNS));
*
*                     Balanser: Stoerrelse bruk i groennsaksproduksjon
*                     Ligningen aktiveres kun dersom bruket har gr?nt
EQBALGRNSMIN(R,B)$(RB(R,B) AND RRR(R) AND BBB(B) AND SUM((BBB,GRNS), B_TIL_PRDK(GRNS,BBB)))
..   GRNSOMFANGMIN =L=  SUM(GRNS$B_TIL_PRDK(GRNS,B), omfang(R,B,GRNS));
*
*                     Balanser: Stoerrelse bruk i fruktproduksjon
*                     Ligningen aktiveres kun dersom bruket har frukt
EQBALFRBAMAX(R,B)$(RB(R,B) AND RRR(R) AND BBB(B) AND SUM((BBB,FRBA), B_TIL_PRDK(FRBA,BBB)))
..   FRBAOMFANGMAX =G=  SUM(FRBA$B_TIL_PRDK(FRBA,B), omfang(R,B,FRBA));
*
*                     Balanser: Stoerrelse bruk i fruktproduksjon
*                     Ligningen aktiveres kun dersom bruket har frukt
EQBALFRBAMIN(R,B)$(RB(R,B) AND RRR(R) AND BBB(B) AND SUM((BBB,FRBA), B_TIL_PRDK(FRBA,BBB)))
..   FRBAOMFANGMIN =L=  SUM(FRBA$B_TIL_PRDK(FRBA,B), omfang(R,B,FRBA));
*
*                     Inntekter inkl. spredareal ekskl. husdyrgjoedsel og grovfor
*                     Ligningen aktiveres kun dersom det finnes minst en inntektsposisjon for en aktivitet som er definert for bruket
EQINNTEKT(R,B,PRODUKT) $ (RB(R,B) AND BBB(B) AND SUM((BBB,PRDK), B_TIL_PRDK(PRDK,BBB) * ENHDATA(R,PRODUKT,PRDK,'BAS')))
.. bidrag(R,B,PRODUKT) * 1000 =E= SUM(PRDK$(B_TIL_PRDK(PRDK,B) * ENHDATA(R,PRODUKT,PRDK,'BAS')), omfang(R,B,PRDK) * intens(R,PRODUKT,PRDK) * SIMDATA(R,PRODUKT,'TOTP','Y'));
*
*                     Kostnader ekskl. husdyrgjoedsel grovfor og kraftforkomponenter
*                     Ligningen aktiveres kun dersom det finnes minst en kostnadsposisjon for en aktivitet som er definert for bruket
EQKOSTNAD(R,B,INNSATS) $ (RB(R,B) AND SUM((BBB,PRDK), B_TIL_PRDK(PRDK,BBB) * ENHDATA(R,INNSATS,PRDK,'BAS'))
                                  AND (NOT SAMEAS('ARBF',INNSATS)) AND (NOT SAMEAS('ARBL',INNSATS))
                                  AND (NOT SAMEAS('KAPB',INNSATS)) AND (NOT SAMEAS('AVSB',INNSATS))
                                  AND (NOT SAMEAS('KAPM',INNSATS)) AND (NOT SAMEAS('AVSM',INNSATS))
                                  AND (NOT SAMEAS('VETM',INNSATS)) AND (NOT SAMEAS('AKST',INNSATS))
                                  AND (NOT SAMEAS('VEDB',INNSATS)) AND (NOT SAMEAS('VEDM',INNSATS))
                                  AND (NOT SAMEAS('PLVR',INNSATS))
                                  )
.. bidrag(R,B,INNSATS) * 1000 =E= SUM(PRDK$(B_TIL_PRDK(PRDK,B) * ENHDATA(R,INNSATS,PRDK,'Y')), omfang(R,B,PRDK) * intens(R,INNSATS,PRDK) * (SIMDATA(R,INNSATS,'TOTP','Y') + SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,INNSATS,'','TOTP','ABS',KLTKA)*opptak(R,BBB,KLTKA))))  * (1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,'',INNSATS,'TOTP','REL',KLTKA)*opptak(R,BBB,KLTKA))) ;
*
*                     PMP for feed
*                     Ligningen aktiveres kun dersom det finnes minst en aktivitet paa bruket som er med i PRDKALLOK
EQPMPFEED(R,B,PRDK) $(RB(R,B) AND PRDKOPT(PRDK) AND SUM(VARE, AHUSDYR_TIL_MOEL(PRDK,VARE)) AND AHUSDYR(PRDK) AND RRR(R) AND BBB(B))
..   PMPFeed(R,B,PRDK) =E=
*              Sum(VARE$AHUSDYR_TIL_MOEL(PRDK,VARE),
        (       PmpFeedCnst(R,B,'FDRA',PRDK) * (ENHDATA(R,'FDRA',PRDK,'BAS') - intens(R,'FDRA',PRDK))       ) $ ENHDATA(R,'FDRA',PRDK,'BAS')
      + ((0.5 * PmpFeedQuad(R,B,'FDRA',PRDK) * (ENHDATA(R,'FDRA',PRDK,'BAS') - intens(R,'FDRA',PRDK))**2 )  ) $ ENHDATA(R,'FDRA',PRDK,'BAS')
*                                                                                                       
      + (       PmpFeedCnst(R,B,'FGRV',PRDK) * (ENHDATA(R,'FGRV',PRDK,'BAS') - intens(R,'FGRV',PRDK))       ) $ ENHDATA(R,'FGRV',PRDK,'BAS')
      + ((0.5 * PmpFeedQuad(R,B,'FGRV',PRDK) * (ENHDATA(R,'FGRV',PRDK,'BAS') - intens(R,'FGRV',PRDK))**2 )  ) $ ENHDATA(R,'FGRV',PRDK,'BAS')
      
;
*
*                    Beregning og verdsetting av utslipp
*                    CH4 (enteric fermentation)
*                    Endogen for melkekyr (funksjon av produksjon og grovforandel)
*                    Ligningen aktiveres kun dersom det finnes melkekyr
*                    Kilde: Norwegian Emission Inventory 2016, s. 283
EQGE(R) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB))).. intens(R,'GE','MKYR')  =E= (137.9 + 0.0249 * (intens(R,'KMLK','MKYR')*ANDMEILEV*1.05) + 0.2806 * intens(R,'FDRM','MKYR') / (intens(R,'FDRM','MKYR') + intens(R,'FGRV','MKYR'))) ;
*
EQYM(R) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB))).. intens(R,'YM','MKYR')  =E= (7.15 - 0.00004 * (intens(R,'KMLK','MKYR')*ANDMEILEV*1.05) - 0.00988 * intens(R,'FDRM','MKYR') / (intens(R,'FDRM','MKYR') + intens(R,'FGRV','MKYR')));
*
EQCH4ENTERIC(R,PRDK)$(PRDKOPT(PRDK) AND RRR(R))
.. intens(R,'CH4E',PRDK) =E= (EFCH4ENDairy * (((intens(R,'GE',PRDK)*(intens(R,'YM',PRDK)/100))/55.65)*365) * (1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,'MKYR','CH4E','','REL',KLTKA)*opptak(R,BBB,KLTKA)))) $ SAMEAS(PRDK,'MKYR')
                           + (CH4EN(PRDK)                                                   * (1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,PRDK,'CH4E','','REL',KLTKA)*opptak(R,BBB,KLTKA)))) $ (NOT SAMEAS(PRDK,'MKYR'));

*
*                    CH4 (gjodselhandtering)
*                    Endogen for melkekyr (funksjon av foring og dermed mengde gjodsel)
*                    Ligningen aktiveres kun dersom det finnes melkekyr
*                    Kilde: Karlengen et al 2012, s. 5 Ligning for Gjd?selTs utsk med vekt 500 kg og kalibreringsfaktor av melkeytelse 0.55 slik at VSDM
*                           tilsvarer 1522 VS fra National Inventory 2016, s. 173 table 6.8
EQVSDM(R) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB)))..  intens(R,'VSDM','MKYR') =E=  795.219 + 0.09481813 * intens(R,'KMLK','MKYR')*ANDMEILEV*1.05;
*
EQCH4MANURE(R,PRDK)$(PRDKOPT(PRDK) AND RRR(R))
.. intens(R,'CH4M',PRDK) =E=   (intens(R,'VSDM',PRDK)*365*B0*MCP*0.67 * (1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,'MKYR','CH4M','','REL',KLTKA)*opptak(R,BBB,KLTKA)))) $ SAMEAS(PRDK,'MKYR')
                             + (CH4MM(PRDK)                           * (1+SUM((KLTKA,BBB), KLIMAEFFEKT(R,BBB,PRDK,'CH4M','','REL',KLTKA)*opptak(R,BBB,KLTKA)))) $ (NOT SAMEAS(PRDK,'MKYR'));
*
*                    CH4 (brenning av restavling)
*                    Ligningen aktiveres kun dersom det finnes korn oljevekster m.m.
EQCH4BURNING(R,PRDK)$(PRDKOPT(PRDK) AND KORN(PRDK) AND RRR(R) AND SUM((BBB,VAREOPT), B_PRDK_VARE(BBB,PRDK,VAREOPT)))
.. intens(R,'CH4B',PRDK) =E= SUM((BBB,VARE)$(B_PRDK_VARE(BBB,PRDK,VARE) $ KLIM_VARE_TIL_PRDK(PRDK,VARE)), intens(R,VARE,PRDK) * EFCH4BRN * DRMCERE * FRACCEREBRN);
*
*                    Virksomt N, P og K som gjodsel per melkeku
*                    Ligningen aktiveres kun dersom det finnes melkekyr
EQNITH(R) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB))).. intens(R,'NITH','MKYR') =E= intens(R,'VSDM','MKYR')*VIRKSOMTNPRVS * (1+SUM((BBB,KLTKA), KLIMAEFFEKT(R,BBB,'NITH','MKYR','','REL',KLTKA)*opptak(R,BBB,KLTKA)));
*
EQFOSH(R) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB))).. intens(R,'FOSH','MKYR') =E= intens(R,'VSDM','MKYR')*VIRKSOMTPPRVS ;
*
EQKALH(R) $ (RRR(R) AND SUM(BBB, B_TIL_PRDK('MKYR',BBB))).. intens(R,'KALH','MKYR') =E= intens(R,'VSDM','MKYR')*VIRKSOMTKPRVS ;
*
*                    Avhengig av endogen beiteandel som viser andel av grovfor fra beite og som benyttes som anslag paa andel av total mokk utskilt paa beite
EQBEITEAND(R,B)$ (RRR(R) AND BBB(B) AND BEITEBRUK(B))..
beiteand(R,B) =E=  (omfang(R,B,'GFFB')*intens(R,'GFFB','GFFB') + omfang(R,B,'GFOB')*intens(R,'GFOB','GFOB') + omfang(R,B,'GFIB')*intens(R,'GFIB','GFIB') + omfang(R,B,'GFUB')*intens(R,'GFUB','GFUB')) /
                (SUM((GROV,PRODUKT)$PRDK_TIL_VARE(GROV,PRODUKT), omfang(R,B,GROV)*intens(R,PRODUKT,GROV)) + omfang(R,B,'GFUB')*intens(R,'GFUB','GFUB') + 0.001) ;
*
*                    Direkte lystgass pr bruk gjodselhandtering
*                    Rapporteres pr bruk med gjodselproduksjon
EQN2OMM(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK) AND BRUTTODYRGJOEDSEL(PRDK,'NITH')).. intens(R,'N2OMM',PRDK) =E=  SUM(BBB, intens(R,'NITH',PRDK) * (1 - beiteand(R,BBB)) * EFN2OMM(PRDK) * (1+SUM(KLTKA, KLIMAEFFEKT(R,BBB,PRDK,'N2OMM','','REL',KLTKA)*opptak(R,BBB,KLTKA))));
*
*                    Indirekte lystgass pr bruk gjodselhandtering: Nedfall
*                    Rapporteres pr bruk med gjodselproduksjon
EQNH3MMNED(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK) AND BRUTTODYRGJOEDSEL(PRDK,'NITH'))..    intens(R,'NH3MMNED',PRDK) =E= SUM(BBB, intens(R,'NITH',PRDK) * EFN2ONH3MMNED * FRACMMNED) ;
EQN2ONH3MMNED(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK) AND BRUTTODYRGJOEDSEL(PRDK,'NITH')).. intens(R,'N2ONH3MMNED',PRDK) =E= intens(R,'NH3MMNED',PRDK) * (44/28);
*
*                    Indirekte lystgass pr bruk gjodselhandtering: Avrenning
*                    Rapporteres pr bruk med gjodselproduksjon
EQNH3MMAVR(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK) AND BRUTTODYRGJOEDSEL(PRDK,'NITH'))..    intens(R,'NH3MMAVR',PRDK) =E= SUM(BBB, intens(R,'NITH',PRDK) * EFN2ONH3MMAVR * FRACMMAVR * (1+SUM(KLTKA, KLIMAEFFEKT(R,BBB,'NH3MMAVR',PRDK,'','REL',KLTKA)*opptak(R,BBB,KLTKA)))) ;
EQN2ONH3MMAVR(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK) AND BRUTTODYRGJOEDSEL(PRDK,'NITH')).. intens(R,'N2ONH3MMAVR',PRDK) =E= intens(R,'NH3MMAVR',PRDK) * (44/28);
*
*                    Direkte lystgass fra gjodsling med husdyrgjodsel
*                    Rapporteres pa bruk med husdyr, antas at all gjodsel brukes
*                    Trekker fra tapt N fra gjodselshaantering direkte og indirekte
EQN2OM(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK) AND BRUTTODYRGJOEDSEL(PRDK,'NITH'))..    intens(R,'N2OM',PRDK) =E= SUM(BBB, intens(R,'NITH',PRDK) * (1 - beiteand(R,BBB)) * (1+SUM(KLTKA, KLIMAEFFEKT(R,BBB,PRDK,'N2OM','','REL',KLTKA)*opptak(R,BBB,KLTKA))) * EFN2OM * (44/28)) ;
*
*                    Direkte lystgass fra kunstgjodsel
EQN2OS(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK) AND PLANTE(PRDK))..    intens(R,'N2OS',PRDK) =E= intens(R,'NITG',PRDK) * EFN2OS * (44/28) * (1+SUM((BBB,KLTKA), KLIMAEFFEKT(R,BBB,PRDK,'N2OS','','REL',KLTKA)*opptak(R,BBB,KLTKA))) ;

*
*                    Direkte lystgass fra beiting
*                    Rapporteres pr bruk med gjodselproduksjon
EQN2OB(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK) AND BRUTTODYRGJOEDSEL(PRDK,'NITH')).. intens(R,'N2OB',PRDK) =E=  SUM(BBB, (44/28) * beiteand(R,BBB) * intens(R,'NITH',PRDK) * EFN2OB );
*
*                    Direkte lystgass fra restavling
*                    uavhengig av gjodseltype
EQNAVL(R,PRDK)      $ (RRR(R) AND PRDKOPT(PRDK) AND PLANTE(PRDK)).. intens(R,'NAVL',PRDK)    =E=  EFN2OAVL * intens(R,'NITR',PRDK) * FRACAVL  ;
EQN2ONAVL(R,PRDK)   $ (RRR(R) AND PRDKOPT(PRDK) AND PLANTE(PRDK)).. intens(R,'N2OAVL',PRDK)  =E= (44/28) * intens(R,'NAVL',PRDK);

*                    Indirekte lystgass fra gj?dsling: Nedfall
EQNH3NED(R,PRDK)    $ (RRR(R) AND PRDKOPT(PRDK)).. intens(R,'NH3NED',PRDK)   =E= SUM(BBB$HUSDYR(PRDK), intens(R,'NITH',PRDK)* (1 - beiteand(R,BBB)) * EFN2ONH3NED * FRACGASM
                                                                                                     + intens(R,'NITG',PRDK)                        * EFN2ONH3NED * FRACGASF );
EQN2ONH3NED(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK)).. intens(R,'N2ONH3NED',PRDK) =E= intens(R,'NH3NED',PRDK) * (44/28) * (1+SUM((BBB,KLTKA), KLIMAEFFEKT(R,BBB,PRDK,'N2ONH3NED','','REL',KLTKA)*opptak(R,BBB,KLTKA))) ;
*
*                    Indirekte lystgass fra gj?dsling: Avrenning
EQNH3AVR(R,PRDK)    $ (RRR(R) AND PRDKOPT(PRDK)).. intens(R,'NH3AVR',PRDK)   =E= SUM(BBB$HUSDYR(PRDK), intens(R,'NITH',PRDK) * (1 - beiteand(R,BBB)) * EFN2ONH3AVR * FRACAVR)
                                                                               +                       intens(R,'NITG',PRDK)                         * EFN2ONH3AVR * FRACAVR
                                                                               + SUM(BBB$HUSDYR(PRDK), intens(R,'NITH',PRDK) *      beiteand(R,BBB)  * EFN2ONH3AVR * FRACAVR)
                                                                               +                       intens(R,'NAVL',PRDK)                         * EFN2ONH3AVR * FRACAVR   ;
EQN2ONH3AVR(R,PRDK) $ (RRR(R) AND PRDKOPT(PRDK)).. intens(R,'N2ONH3AVR',PRDK) =E= intens(R,'NH3AVR',PRDK) * (44/28) * (1+SUM((BBB,KLTKA), KLIMAEFFEKT(R,BBB,PRDK,'N2ONH3AVR','','REL',KLTKA)*opptak(R,BBB,KLTKA))) ;
*
*
*                    Lystgass ved brenning av restavling
*                    Ligningen aktiveres kun dersom det finnes korn oljevekster m.m.
EQN2OBRN(R,PRDK)$(PRDKOPT(PRDK) AND KORN(PRDK) AND RRR(R) AND SUM((BBB,VAREOPT), B_PRDK_VARE(BBB,PRDK,VAREOPT)))
.. intens(R,'N2OBRN',PRDK) =E= SUM((BBB,VARE)$(B_PRDK_VARE(BBB,PRDK,VARE) $ KLIM_VARE_TIL_PRDK(PRDK,VARE)), (44/28) * intens(R,VARE,PRDK) * EFN2OBRN * DRMCERE * FRACCEREBRN );
*
*                    Lystgass ved myr
EQN2OMYR(R,PRDK)$(PRDKOPT(PRDK) AND PLANTE(PRDK) AND RRR(R) AND (NOT SAMEAS('GFUB',PRDK)))
.. intens(R,'N2OMYR',PRDK) =E= (44/28) * ANDELMYR(R) * EFN2OMYR  ;
*
*                    Karbondioksid ved kalking
EQCO2KALK(R,PRDK)$(PRDKOPT(PRDK) AND PLANTE(PRDK) AND RRR(R) AND (NOT SAMEAS('GFUB',PRDK)))
.. intens(R,'CO2KALK',PRDK) =E=  SUM(BBB, 3.66667 * intens(R,'KALK',PRDK) * EFCO2KALK ) ;
*
*                    Karbondioksid ved utslipp fra jord
EQCO2SOUR(R,PRDK)$(PRDKOPT(PRDK) AND PLANTE(PRDK) AND RRR(R))
.. intens(R,'CO2SOUR',PRDK) =E=  ENHDATA(R,'CO2SOUR',PRDK,'BAS');
*
*                    Karbondioksid ved opptak fra jord
EQCO2SINK(R,PRDK)$(PRDKOPT(PRDK) AND PLANTE(PRDK) AND RRR(R))
.. intens(R,'CO2SINK',PRDK) =E=  ENHDATA(R,'CO2SINK',PRDK,'BAS');

*                    Beregning av miljoavgift pr utslippvare
EQCO2AVG(R,B,UTSLIPPAVG)$ (RRR(R) AND BBB(B))..
     bidrag(R,B,UTSLIPPAVG) * 1000 =E=   SUM((PRDK,UTSLIPP)$(PRDKOPT(PRDK) AND UTSLIPPAVG_TIL_UTSLIPP(UTSLIPPAVG,UTSLIPP)), intens(R,UTSLIPP,PRDK) * omfang(R,B,PRDK)) * CO2AVGXP(UTSLIPPAVG) ;

*                    Beregning av miljoavgift for nitrogen utslipp
EQEMIS_N(R,B)    $ (RRR(R) AND BBB(B))..
     bidrag(R,B,'EMIS_N') * 1000 =E=
                         SUM(PRDKOPT, intens(R,'NTAP',PRDKOPT)     * omfang(R,B,PRDKOPT) * EmisCost('NTAP',R)
                                    + intens(R,'NH3MMNED',PRDKOPT) * omfang(R,B,PRDKOPT) * EmisCost('NH3',R)
                                    + intens(R,'NH3MMAVR',PRDKOPT) * omfang(R,B,PRDKOPT) * EmisCost('NH3',R)
                                    + intens(R,'NH3NED',PRDKOPT)   * omfang(R,B,PRDKOPT) * EmisCost('NH3',R)
                                    + intens(R,'NH3AVR',PRDKOPT)   * omfang(R,B,PRDKOPT) * EmisCost('NH3',R)
                                    + intens(R,'N2O',PRDKOPT)      * omfang(R,B,PRDKOPT) * EmisCost('N2O',R))
;
*
*
*                     Direkte tilskudd med strukturprofil
*                     Ligningene aktiveres kun dersom det finnes en aktivitet som er definert for bruket og trinn med grense null utelukkes
* Trinnbidrag for PRDK og aggregater av PRDK
* for PRDK
EQPRDKTIL(R,B,TRINNTIL,PRDK,TTIL)      $(RB(R,B) AND PRDKOPT(PRDK) AND SUM(BBB, B_TIL_PRDK(PRDK,BBB)) AND (NOT TRINN(TRINNTIL,PRDK,TTIL) EQ 0))
.. trinnbidrag(R,B,PRDK,TRINNTIL) $ B_TIL_PRDK(PRDK,B)   =L=
         ( omfang(R,B,PRDK) * SATSER(TRINNTIL,PRDK,TTIL,R)
        +  SUM(TTTIL $ ((ORD(TTTIL) LE ORD(TTIL)) AND (NOT SAMEAS('0',TTTIL))),
         (SATSER(TRINNTIL,PRDK,TTTIL-1,R) - SATSER(TRINNTIL,PRDK,TTTIL,R)) * TRINN(TRINNTIL,PRDK,TTTIL-1))
         ) $ PRDKTIL(TRINNTIL)
;
* for UNGD og PRDKTIL
EQUNGDTIL(R,B,TRINNTIL,TTIL)      $(RB(R,B) AND SUM((BBB,UNGD), B_TIL_PRDK(UNGD,BBB)) AND (NOT TRINN(TRINNTIL,'UNGD',TTIL) EQ 0))
.. trinnbidrag(R,B,'UNGD',TRINNTIL)  =L=
          (  SUM(UNGD$B_TIL_PRDK(UNGD,B), omfang(R,B,UNGD)) * SATSER(TRINNTIL,'UNGD',TTIL,R)
          +  SUM(TTTIL $ ((ORD(TTTIL) LE ORD(TTIL)) AND (NOT SAMEAS('0',TTTIL))),
            (SATSER(TRINNTIL,'UNGD',TTTIL-1,R) - SATSER(TRINNTIL,'UNGD',TTTIL,R)) * TRINN(TRINNTIL,'UNGD',TTTIL-1))
          ) $ PRDKTIL(TRINNTIL)
;
*
* for KORN og PRDKTIL
EQKORNTIL(R,B,TRINNTIL,TTIL)      $(RB(R,B) AND SUM((BBB,KORN), B_TIL_PRDK(KORN,BBB)) AND (NOT TRINN(TRINNTIL,'KORN',TTIL) EQ 0))
.. trinnbidrag(R,B,'KORN',TRINNTIL)  =L=
          (  SUM(KORN$B_TIL_PRDK(KORN,B), omfang(R,B,KORN)) * SATSER(TRINNTIL,'KORN',TTIL,R)
          +  SUM(TTTIL $ ((ORD(TTTIL) LE ORD(TTIL)) AND (NOT SAMEAS('0',TTTIL))),
            (SATSER(TRINNTIL,'KORN',TTTIL-1,R) - SATSER(TRINNTIL,'KORN',TTTIL,R)) * TRINN(TRINNTIL,'KORN',TTTIL-1))
          ) $ PRDKTIL(TRINNTIL)
;
*
* for GAKF og PRDKTIL
EQGAKFTIL(R,B,TRINNTIL,TTIL)      $(RB(R,B) AND SUM((BBB,GAKF), B_TIL_PRDK(GAKF,BBB)) AND (NOT TRINN(TRINNTIL,'GAKF',TTIL) EQ 0))
.. trinnbidrag(R,B,'GAKF',TRINNTIL)  =L=
          (
   SUM(GAKF$B_TIL_PRDK(GAKF,B), omfang(R,B,GAKF))
  * SATSER(TRINNTIL,'GAKF',TTIL,R)
          +  SUM(TTTIL $ ((ORD(TTTIL) LE ORD(TTIL)) AND (NOT SAMEAS('0',TTTIL))),
            (SATSER(TRINNTIL,'GAKF',TTTIL-1,R) - SATSER(TRINNTIL,'GAKF',TTTIL,R)) * TRINN(TRINNTIL,'GAKF',TTTIL-1))
          ) $ PRDKTIL(TRINNTIL)
;
*
* for GAKR og PRDKTIL
* Avgrensning: kun 60 prosent av GAKR
EQGAKRTIL(R,B,TRINNTIL,TTIL)      $(RB(R,B) AND SUM((BBB,GAKR), B_TIL_PRDK(GAKR,BBB)) AND (NOT TRINN(TRINNTIL,'GAKR',TTIL) EQ 0))
.. trinnbidrag(R,B,'GAKR',TRINNTIL)  =L=
          (
   SUM(GAKR$B_TIL_PRDK(GAKR,B), omfang(R,B,GAKR) * .6)
  * SATSER(TRINNTIL,'GAKR',TTIL,R)
          +  SUM(TTTIL $ ((ORD(TTTIL) LE ORD(TTIL)) AND (NOT SAMEAS('0',TTTIL))),
            (SATSER(TRINNTIL,'GAKR',TTTIL-1,R) - SATSER(TRINNTIL,'GAKR',TTTIL,R)) * TRINN(TRINNTIL,'GAKR',TTTIL-1))
          ) $ PRDKTIL(TRINNTIL)
;
*
* for FRBA og PRDKTIL
EQFRBATIL(R,B,TRINNTIL,TTIL)      $(RB(R,B) AND SUM((BBB,FRBA), B_TIL_PRDK(FRBA,BBB)) AND (NOT TRINN(TRINNTIL,'FRBA',TTIL) EQ 0))
.. trinnbidrag(R,B,'FRBA',TRINNTIL) =L=
          (  SUM(FRBA$B_TIL_PRDK(FRBA,B), omfang(R,B,FRBA)) * SATSER(TRINNTIL,'FRBA',TTIL,R)
          +  SUM(TTTIL $ ((ORD(TTTIL) LE ORD(TTIL)) AND (NOT SAMEAS('0',TTTIL))),
            (SATSER(TRINNTIL,'FRBA',TTTIL-1,R) - SATSER(TRINNTIL,'FRBA',TTTIL,R)) * TRINN(TRINNTIL,'FRBA',TTTIL-1))
          ) $ PRDKTIL(TRINNTIL)
;
*                     Jordbruksfradrag
*                     Ligningene aktiveres alltid
* for arbeids- og kapitalinntekt
EQSKATTIL(R,B,TRINNTIL,TTIL)      $(RB(R,B) AND RRR(R) AND BBB(B) AND (SAMEAS('TSKAT',TRINNTIL)) AND (NOT TRINN(TRINNTIL,'ARBF',TTIL) EQ 0))
.. trinnbidrag(R,B,'SKAT',TRINNTIL) *  (1/KALIBSKATT) =L=
          ((  [bidrag(R,B,'ARBF') + bidrag(R,B,'KAPB') + bidrag(R,B,'KAPM')] * SATSER(TRINNTIL,'ARBF',TTIL,R) * ALMINNT
          +  SUM(TTTIL $ ((ORD(TTTIL) LE ORD(TTIL)) AND (NOT SAMEAS('0',TTTIL))),
            (SATSER(TRINNTIL,'ARBF',TTTIL-1,R) - SATSER(TRINNTIL,'ARBF',TTTIL,R)) * TRINN(TRINNTIL,'ARBF',TTTIL-1) * ALMINNT)
           ) / (1 - MARGSKATT)) $ PRDKTIL(TRINNTIL)
;
*                     Direkte tilskudd uten strukturprofil dvs flate satser
*                     Ligningene aktiveres kun dersom det finnes en aktivitet som er definert for bruket og trinn med grense null utelukkes
EQFLATTIL(R,B,TILSKUDD)  $(RB(R,B) AND RRR(R) AND BBB(B) AND TILOPT(TILSKUDD) AND (NOT SAMEAS('TARBF',TILSKUDD)) AND (NOT SAMEAS('TBMLK',TILSKUDD)))
.. flatbidrag(R,B,TILSKUDD) $ (RRR(R) AND BBB(B) AND TILOPT(TILSKUDD))
         =L= SUM((PRDK,PRODUKT)$(((SATSER(TILSKUDD,PRODUKT,'0',R) + SATSER(TILSKUDD,PRODUKT,'0','0')) > 0) AND PRDKOPT(PRDK) AND B_TIL_PRDK(PRDK,B) * ENHDATA(R,PRODUKT,PRDK,'BAS')),
                  omfang(R,B,PRDK)  * intens(R,PRODUKT,PRDK) * (SATSER(TILSKUDD,PRODUKT,'0',R) + SATSER(TILSKUDD,PRODUKT,'0','0'))) $ VARETIL(TILSKUDD)
          +  SUM(PRDK$(B_TIL_PRDK(PRDK,B)), omfang(R,B,PRDK)  * (SATSER(TILSKUDD,PRDK,'0','0')   + SATSER(TILSKUDD,PRDK,'0',R)))   $ PRDKTIL(TILSKUDD)
          +  SUM(KORN$(B_TIL_PRDK(KORN,B)), omfang(R,B,KORN)) * (SATSER(TILSKUDD,'KORN','0','0') + SATSER(TILSKUDD,'KORN','0',R))  $ PRDKTIL(TILSKUDD)
          +  SUM(GAKF$(B_TIL_PRDK(GAKF,B)), omfang(R,B,GAKF)) * (SATSER(TILSKUDD,'GAKF','0','0') + SATSER(TILSKUDD,'GAKF','0',R))  $ PRDKTIL(TILSKUDD)
          +  SUM(GAKR$(B_TIL_PRDK(GAKR,B)), omfang(R,B,GAKR)) * (SATSER(TILSKUDD,'GAKR','0','0') + SATSER(TILSKUDD,'GAKR','0',R))  $ PRDKTIL(TILSKUDD)
          +  SUM(FRBA$(B_TIL_PRDK(FRBA,B)), omfang(R,B,FRBA)) * (SATSER(TILSKUDD,'FRBA','0','0') + SATSER(TILSKUDD,'FRBA','0',R))  $ PRDKTIL(TILSKUDD)
          +  SUM(UNGD$(B_TIL_PRDK(UNGD,B)), omfang(R,B,UNGD)) * (SATSER(TILSKUDD,'UNGD','0','0') + SATSER(TILSKUDD,'UNGD','0',R))  $ PRDKTIL(TILSKUDD)
          +  SUM(KLTKA,                     opptak(R,B,KLTKA) * (SATSER(TILSKUDD,KLTKA,'0','0')  + SATSER(TILSKUDD,KLTKA,'0',R)))  $ PRDKTIL(TILSKUDD)
;

* Alle tilskudd
EQFRADRAGTIL(R,B,TILSKUDD) $(RB(R,B) AND RRR(R) AND TILOPT(TILSKUDD))
.. bidrag(R,B,TILSKUDD) $ (RRR(R) AND BBB(B) AND TILOPT(TILSKUDD) AND (NOT SAMEAS('TARBF',TILSKUDD)))
          =E= SUM(PRDK $ (B_TIL_PRDK(PRDK,B) AND TRINNTIL(TILSKUDD) AND SUM(TTIL, SATSER(TILSKUDD,PRDK,TTIL,R))), trinnbidrag(R,B,PRDK,TILSKUDD))
          +   trinnbidrag(R,B,'UNGD',TILSKUDD) $ SUM(UNGD, B_TIL_PRDK(UNGD,B) AND TRINNTIL(TILSKUDD) AND SUM(TTIL, SATSER(TILSKUDD,'UNGD',TTIL,R) + SATSER(TILSKUDD,'UNGD',TTIL,'0')))
          +   trinnbidrag(R,B,'KORN',TILSKUDD) $ SUM(KORN, B_TIL_PRDK(KORN,B) AND TRINNTIL(TILSKUDD) AND SUM(TTIL, SATSER(TILSKUDD,'KORN',TTIL,R) + SATSER(TILSKUDD,'KORN',TTIL,'0')))
          +   trinnbidrag(R,B,'GAKF',TILSKUDD) $ SUM(GAKF, B_TIL_PRDK(GAKF,B) AND TRINNTIL(TILSKUDD) AND SUM(TTIL, SATSER(TILSKUDD,'GAKF',TTIL,R) + SATSER(TILSKUDD,'GAKF',TTIL,'0')))
          +   trinnbidrag(R,B,'GAKR',TILSKUDD) $ SUM(GAKR, B_TIL_PRDK(GAKR,B) AND TRINNTIL(TILSKUDD) AND SUM(TTIL, SATSER(TILSKUDD,'GAKR',TTIL,R) + SATSER(TILSKUDD,'GAKR',TTIL,'0')))
          +   trinnbidrag(R,B,'FRBA',TILSKUDD) $ SUM(FRBA, B_TIL_PRDK(FRBA,B) AND TRINNTIL(TILSKUDD) AND SUM(TTIL, SATSER(TILSKUDD,'FRBA',TTIL,R) + SATSER(TILSKUDD,'FRBA',TTIL,'0')))
          +   trinnbidrag(R,B,'SKAT',TILSKUDD) $ SUM(PRDK, B_TIL_PRDK(PRDK,B) AND TRINNTIL(TILSKUDD) AND SUM(TTIL, SATSER(TILSKUDD,'ARBF',TTIL,R) + SATSER(TILSKUDD,'ARBF',TTIL,'0')))
          +   flatbidrag(R,B,TILSKUDD)
          -   BUNNFRADRAG(TILSKUDD)
;
*
*                     Pipetilskudd definert som tilskudd til arbeid
*                     Ligningene aktiveres alltid
EQTARBF(R,B) $ (RB(R,B) AND RRR(R))
.. bidrag(R,B,'TARBF') =L=  SATSER('TARBF','ARBF','0',R) * (arbeid(R,B,'ARBF') + arbeid(R,B,'ARBL')) / 1000;

MODEL TILBUDSMODELL
/
EQOBJEKTBRUK,
EQPROFITTBRUK,
EQINTEKSO,
EQINTKMLK,
EQINTKJOETT,
EQFORAHUSDYR,
EQMAXFGRVAHUSDYR,
EQMAXKFORMELK,
EQMINKFORMELK,
EQMAXFORMELK
EQVAREKVOT,
EQINTKORN,
EQINTGROV,
EQIntVerdDGKoeff
EQIntMngdDGKoeff
EQINTAVSB,
EQINTAVSM,
EQINTARBF,
EQPRSARBF,
EQKSTARBF,
EQINNTEKT,
EQKOSTNAD,
*EQPMPFEED,
EQPRDKTIL,
EQFLATTIL,
EQUNGDTIL,
EQGAKFTIL,
EQGAKRTIL,
EQKORNTIL,
EQFRBATIL,
EQFRADRAGTIL,
EQSKATTIL,
EQTARBF,
EQBALFGRV,
EQBALIKYR,
EQBALIKVG,
EQBALIOKS,
EQBALIKVK,
EQBALIOKK,
EQBALIKLV,
EQBALIPRK,
EQBALISAU,
EQBALIGET,
EQBALVFOR,
*EQMAKSGFFP,
EQBALBEIT,
EQMINGROVAND,
EQMAKSGROVAND,
EQMINKALVAND, 
EQMAXKALVAND,
EQBALKRNMIN,
EQBALKRNMAX,
EQBALGRNMIN,
EQBALGRNMAX,
EQBALFRKMIN,
EQBALFRKMAX,
EQBALNITR,
EQBALNPRD,
EQBALFOSF,
EQBALFPRD,
EQBALKALI,
EQBALKPRD,
EQSPREDAR,
EQBALKORNMAX,
EQBALFRBAMAX,
EQBALGRNSMAX,
EQBALKORNMIN,

EQBALFRBAMIN,
EQBALGRNSMIN,
EQCO2AVG,
EQGE,
EQYM,
EQVSDM,

EQEMIS_N

EQCH4ENTERIC,
EQCH4MANURE,
EQCH4BURNING,
EQN2OMM,
EQNH3NED,
EQNH3AVR,

EQN2ONH3MMNED,
EQN2ONH3MMAVR,
EQN2ONH3NED,
EQN2ONH3AVR,

EQN2OM,
EQN2OS,
EQN2OB,

EQNAVL,
EQN2ONAVL,

EQN2OMYR,
EQN2OBRN,

EQCO2KALK,
EQCO2SOUR,
EQCO2SINK,

EQNH3MMNED,
EQNH3MMAVR,

EQNITH,
EQFOSH,
EQKALH,
EQBEITEAND
/;
