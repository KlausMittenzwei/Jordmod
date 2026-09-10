************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Kalibrering av meierier til basisaaret 2014
*   Kommentarer:
*
*   Status:
*
************************************************************************
PARAMETER MEIINFES(STEP) Antall infeasibilities i meierimodellen;
*
Parameters
  ALFAMEI(VARE,M)    Konstantledd indirekte ettersporsel
  BETAMEI(VARE,M)    Derivert indirekte ettersporsel ;

BETAMEI(VARE,M) $ (elas(VARE,VARE) * X0(VARE,M)) = P0(VARE) / (elas(VARE,VARE) * X0(VARE,M));
ALFAMEI(VARE,M) $ BETAMEI(VARE,M)                = P0(VARE) + BETAMEI(VARE,M) * X0(VARE,M);

* Kilde: calib.gdx
PARAMETER PROD_MEI(M) Antall melkeprodusenter i 2024
/
OEST    1895
SOER    1558
VEST    1079
MIDT    2295
NORD    733 
/

;
KonvergensTest(M,'Prod_MEI','','','0') = PROD_MEI(M);

*
* Inntransport og foredling
PARAMETER ACT0(M)  Inntransportkostnad per liter melk basisar
/
  OEST      0.30
  SOER      0.29
  VEST      0.39
  MIDT      0.30
  NORD      0.40
/;



* Fremskrivning 2004 til '2021'
* SSB KPI for godstransport paa vei 4K2004 til 1K2021-4K2023
ACT0(M) = ACT0(M) * 129.6 / 79.9;
* Update from '2021' to '2024'
* Source: Tabell 12535... xlsx
ACT0(M) = ACT0(M) * 119.0083 / 93.25417;
*
* Calibration
ACT0(M) = ACT0(M) * .75;

* Fremskriving ACT0 to simulation year
ACT0(M) = ACT0(M) *  (1 + KPI) ** (Y - %BAS%);

*
PARAMETER ZKPMEI0(M) Mottatt kumelk i basisaar;
ZKPMEI0(M) = SUM(R$R_TIL_M(M,R), DATA(R,'KMLK','MNGD','BAS')) * SUM(R$R_TIL_M(M,R), DATA(R,'MKYR','OMFG','BAS')) / DATA('NORGE','MKYR','OMFG','BAS');
*
PARAMETER ZGPMEI0(M) Mottatt geitmelk i basisaar;
ZGPMEI0(M) = SUM(R$R_TIL_M(M,R), DATA(R,'GMLK','MNGD','BAS')) * SUM(R$R_TIL_M(M,R), DATA(R,'GEIT','OMFG','BAS')) / DATA('NORGE','GEIT','OMFG','BAS');
*
PARAMETER ZMEI0(M) Mottatt melk i basisaar;
ZMEI0(M) = ZKPMEI0(M) + ZGPMEI0(M);
*
PARAMETER ACF0(PRDK) Foredlingskostnad prosess per liter melk basisar
/
MLKD    5.9096
MLKI    1.6553
MLKS    5.8394
YOGH    3.6661
OSTK    4.8053
OSTM    3.2707
OSTD    2.7182
OSTI    1.9911
OSTE    1.9911
SKMP    0.7702
OSTG    3.9001
OSTX    1.9911
/;
*
* Kalibrering av ACF0
ACF0(PRDK) = ACF0(PRDK) * .75;
ACF0('MLKI') = ACF0('MLKI') * .25;
ACF0('OSTI') = ACF0('OSTI') * .25;
*
* Update from '2021' to '2024'
* Source: Meierier.xlsx
ACF0(PRDK) = ACF0(PRDK) * 1.15;
*
* Fremskriving ACF0
ACF0(PRDK) = ACF0(PRDK) * (1 + KPI - VEKSTIND/100)  ** (Y - %BAS%);
*
*
* Kilde: Meierier.xlsx
PARAMETER Q0(M) Antall meierier i basisaret
/
  OEST   11
  SOER   5
  VEST   3
  MIDT   8
  NORD   6
/;
*
* Source: Meierier.xlsx
PARAMETER QZ0 Gjennomsnittlig antall meieri per 1000 liter melk;
QZ0  = Sum(M, Q0(M))/(DATA('NORGE','KMLK','MNGD','BAS')+DATA('NORGE','GMLK','MNGD','BAS'))  ;
*
* Intern prising av meieriprosesser
PARAMETER IUMEIR(MEIR);
IUMEIR('MLKD') = 0;
IUMEIR('OSTI') = 0;
*
*
PARAMETERS
    BZ0(M)  Antall produsenter per liter melk
    ZQ0(M)  Innsatsmelk per meieri;

BZ0(M) = PROD_MEI(M)/ZMEI0(M);
ZQ0(M) = ZMEI0(M)/Q0(M);
*
*  Kalibrering av stordriftsulemper for inntransport
*
PARAMETERS
    Q1(M)      Redusert antall meierier
    ACT1(M)    Redusert gjennomsnittlig inntransportkostnad
    ZQ1(M)     Nytt forholdstall melkemengde per meieri
    ATMEI(M)   Parameter inntransportfunksjon
    BTMEI(M)   Parameter inntransportfunksjon
    ACTTEST(M) Gjennomsnittlig inntransportkostnad;
*
    Q1(M)   = Q0(M)   * 0.5;
    ACT1(M) = ACT0(M) * 1.5;
*
    ZQ1(M)  = ZMEI0(M)/Q1(M);
*
BTMEI(M) = (ACT1(M) - ACT0(M))/(ZQ1(M)-ZQ0(M));
ATMEI(M) = (ACT0(M)-(BTMEI(M)*ZQ0(M)))/BZ0(M);

ACTTEST(m) = ATMEI(M)*BZ0(M) + BTMEI(M)*ZQ0(M);

*Display ATMEI, BTMEI, ACTTEST;
*
* Kalibrering av stordriftsfordeler for foredling med utgangspunkt i MLKD
*
Parameters
    QZ1         Forholdstall mellom antall meieri og melkemengde for MLKD etter reduksjon antall meierier
    ACF1        Redusert gjennomsnittlig foredlingskostnad
    BFMEI       Parameter foredlingsfunksjon
    AFMEI(PRDK) Parameter foredlingsfunksjon
    ACFTEST(PRDK)  Gjennomsnittskostnader prosess;
*
QZ1  = QZ0  * 0.5;
ACF1 = ACF0('MLKD') * 0.95;
*
BFmei       = (ACF1 - ACF0('MLKD'))/(QZ1-QZ0);
AFmei(PRDK) = ACF0(PRDK) - BFmei * QZ0;
ACFTEST(PRDK) = AFmei(PRDK) + BFmei * QZ0;

*Display qz1,bfmei,afmei,acftest;

* Produksjonskoeffisient
PARAMETER MEIDATA(VARE,FP);
* MLKD
MEIDATA('MLKD','MLKD') =  0.906;
MEIDATA('FLOT','MLKD') =  0.088;
MEIDATA('KMLK','MLKD') =  1.000;
*
* MLKI
MEIDATA('MLKI','MLKI') =  0.931;
MEIDATA('SMOR','MLKI') =  0.031;
MEIDATA('KMLK','MLKI') =  1.000;
*
* YOGH
MEIDATA('YOGH','YOGH') =  1.105;
MEIDATA('SMOR','YOGH') =  0.017;
MEIDATA('KMLK','YOGH') =  1.000;
*
* MLKS
MEIDATA('MLKS','MLKS') =  0.925;
MEIDATA('SMOR','MLKS') =  0.031;
MEIDATA('KMLK','MLKS') =  1.000;
*
* OSTD
MEIDATA('OSTD','OSTD') =  0.091;
MEIDATA('SMOR','OSTD') =  0.016;
MEIDATA('KMLK','OSTD') =  1.000;
*
* OSTI
MEIDATA('OSTI','OSTI') =  0.091;
MEIDATA('SMOR','OSTI') =  0.018;
MEIDATA('KMLK','OSTI') =  1.000;
*
* OSTK
MEIDATA('OSTK','OSTK') =  0.205;
MEIDATA('SMOR','OSTK') =  0.007;
MEIDATA('KMLK','OSTK') =  1.000;
*
* OSTM
MEIDATA('SMOR','OSTM') =  0.004;
MEIDATA('OSTM','OSTM') =  0.130;
MEIDATA('KMLK','OSTM') =  1.000;
MEIDATA('GMLK','OSTM') =  0.031;
*
* OSTG
MEIDATA('OSTG','OSTG') =  0.140;
MEIDATA('KMLK','OSTG') =  0.013;
MEIDATA('GMLK','OSTG') =  1.000;
*
* OSTE
MEIDATA('OSTE','OSTE') =  0.087;
MEIDATA('SMOR','OSTE') =  0.030;
MEIDATA('KMLK','OSTE') =  1.000;
*
* OSTX
MEIDATA('OSTX','OSTX') =  0.091;
MEIDATA('SMOR','OSTX') =  0.018;
MEIDATA('KMLK','OSTX') =  1.000;
*
* SKMP
MEIDATA('SKMP','SKMP') =  0.180;
MEIDATA('SMOR','SKMP') =  0.013;
MEIDATA('KMLK','SKMP') =  1.000;
*
*
* Miljoavgift foredlede importerte meierivarer
GHGXIPOT('MLKD') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'MLKD')) * MEIDATA('MLKD','MLKD') ;
GHGXIPOT('MLKI') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'MLKI')) * MEIDATA('MLKI','MLKI') ;
GHGXIPOT('MLKS') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'MLKS')) * MEIDATA('MLKS','MLKS') ;
GHGXIPOT('YOGH') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'YOGH')) * MEIDATA('YOGH','YOGH') ;
GHGXIPOT('OSTD') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'OSTD')) * MEIDATA('OSTD','OSTD') ;
GHGXIPOT('OSTI') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'OSTI')) * MEIDATA('OSTI','OSTI') ;
GHGXIPOT('OSTK') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'OSTK')) * MEIDATA('OSTK','OSTK') ;
GHGXIPOT('OSTM') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'OSTM')) * MEIDATA('OSTM','OSTM') ;
GHGXIPOT('OSTG') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'OSTG')) * MEIDATA('OSTG','OSTG') ;
GHGXIPOT('OSTE') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'OSTE')) * MEIDATA('OSTE','OSTE') ;
GHGXIPOT('OSTX') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'OSTX')) * MEIDATA('OSTX','OSTX') ;
GHGXIPOT('SKMP') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'SKMP')) * MEIDATA('SKMP','SKMP') ;
GHGXIPOT('FLOT') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'MLKD')) * MEIDATA('FLOT','MLKD') ;
GHGXIPOT('SMOR') = SUM(MEIINNVARE, GHGXIPOT(MEIINNVARE) * MEIDATA(MEIINNVARE,'SKMP')) * MEIDATA('SMOR','SKMP') ;
*
* Markedsregulering melk
* Omsetningsavgift [kr per ltr]
* Kilde: TINE Årsrapport 2025: 139
OMSET(MEIINNVARE) = (0.07 + 0.12) / 2;
*
* Fremskriving OMSET
OMSET(MEIINNVARE) = OMSET(MEIINNVARE) * (1 + KPI) ** (Y - %BAS%);
*
* Prisutjevningsordning
*
* PU - Distribusjonstilskudd
* kilde: innfrakttilskudd 2014
PARAMETER PUDISB(FP,M)
/
MLKD.NORD   0.2003
MLKD.MIDT   0.1111
MLKD.VEST   0.1111
MLKD.SOER   0.1111
MLKD.OEST   0.1111
MLKI.NORD   0.2003
MLKI.MIDT   0.1111
MLKI.VEST   0.1111
MLKI.SOER   0.1111
MLKI.OEST   0.1111
MLKS.NORD   0.2003
MLKS.MIDT   0.1111
MLKS.VEST   0.1111
MLKS.SOER   0.1111
MLKS.OEST   0.1111
YOGH.NORD   0.2003
YOGH.MIDT   0.1111
YOGH.VEST   0.1111
YOGH.SOER   0.1111
YOGH.OEST   0.1111
/;
* Fremskriving PUDISB
PUDISB(FP,M) = PUDISB(FP,M) * (1 + KPI) ** (Y - %BAS%);
*
*
* PU - Sats pr prosess
* positivt tall: tilskudd
* negativt tall: avgift
* Kilde: Meierier.xlsx, PU-Prosess
PARAMETER PUSATS(FP)
/
   MLKD    -1.985  
   MLKI     0.000  
   MLKS     0.000  
   YOGH    -1.985  
   OSTD     0.255  
   OSTI     0.255 
   OSTK     0.000 
   OSTM     0.255  
   OSTG     0.255  
   OSTE     0.000  
   OSTX     0.000  
   SKMP     0.795
 /;
 

* positivt tall: tilskudd
* negativt tall: avgift
* Kilde: Meierier.xlsx, PU-Prosess
PARAMETER PUBISATS(VARE) PU-sats for biprodukter /
   FLOT   -13.520
   SMOR    -3.000
/;
*
* Fremskriving PUSATS
PUSATS(FP) = PUSATS(FP) * (1 + KPI) ** (Y - %BAS%);
*
* PU - Inntransporttilskudd
* kilde:Meierier.xlsx, PU-Innfrakt
PARAMETER PUINNT(M)
/
OEST 0.3402
SOER 0.2756
VEST 0.4779
MIDT 0.3373
NORD 0.5673
/;
*
* Fremskriving PUINNT
PUINNT(M) = PUINNT(M) * (1 + KPI) ** (Y - %BAS%);
*
* Eksportstoette ost
PARAMETER EKSSUB(VARE);
EKSSUB(MEIXVARE) = 0;
*
*
SIMDATA(M,MEIVARE,'MNGD','BAS') = X0(MEIVARE,M);
SIMDATA(M,MEIVARE,'PRIS','BAS') = P0(MEIVARE);
*
SIMDATA(M,MEIVARE,'MNGD','Y') = SIMDATA(M,MEIVARE,'MNGD','BAS');
SIMDATA(M,MEIVARE,'PRIS','Y') = SIMDATA(M,MEIVARE,'PRIS','BAS');
*
*