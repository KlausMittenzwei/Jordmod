************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Handelsdata for 2009
*   Kommentarer:
*   Status:
*
************************************************************************
PARAMETER MaalPris(VARE) Målpris for varer på produsentnivå;
MaalPris(VARE) $ MOELINNVARE(VARE) = DATA('NORGE',VARE,'TOTP','BAS');

PARAMETER PI(VARE)  Importpriser 2024 (kr per kg-liter) 
* Kilde: ...\raadata\verdensmarkedspriser.xlsx
/
HVEM    2.4208
HVEF    2.1787
RUGM    2.4208
RUGF    2.1787
BYGM    2.1871
BYGF    1.9684
HAVM    2.7033
HAVF    2.4329
AKRM    2.4208
AKRF    2.1787
RAPM    2.4208
RAPF    2.1787
ERTM    2.4208
ERTF    2.1787
FMKN    2.4208
FFKN    2.1787
FBLG    2.1787
POTE    2.4208
GRNV    26.8793
GRNF    18.5932
EPLE    18.2559
AFRU    79.3350
BLOM    4.6617
FJRK    21.1256
KHEL    23.3397
KFIL    37.6349
KANT    20.0956
EGGS    21.6289
KMLK    5.6885
MLKD    11.9738
MLKI    4.6265
MLKS    11.9738
YOGH    30.7693
OSTD    76.1227
OSTI    49.3925
OSTK    101.0207
OSTM    81.2603
OSTG    81.2603
SKMP    34.6262
FLOT    69.3762
SMOR    52.8774
STFK    55.6044
KLVK    55.6044
SAUK    80.4175
SVNK    23.7359
PRIN    43.6372
KYST    82.9606
KYSA    89.9007
KYSV    26.1095
KBST    80.8829
KBSA    106.0067
KBSV    26.1095
KSST    130.0219
KSSA    107.3069
KSSV    26.1095
KDEI    54.9334
KPOL    56.8944
KPAL    100.0449
KSPP    162.1890
KSPV    208.7666
KDIV    60.8168
*
*... kalibrering.xlsx
FSOY    5.2691  
* assumed minerals, vitamins
FANT    3.00
/;

* Calibration due to infes in base year calibration
PI('YOGH')  = 26;


*
PARAMETER PE(VARE)  Eksportpriser 2024
* Kilde: ...\raadata\verdensmarkedspriser.xlsx
/
OSTE    53.5111
OSTX    61.7999
/;
*
* Beregning av andre eksportpriser
PE(VARE) $ (NOT PE(VARE)) = PI(VARE) * .25;


PARAMETER KRONETOLL(VARE)  kronetoll (kr per kg-liter)
/
          HVEM        2.130
          RUGM        2.130
          BYGM        1.740
          HAVM        1.520
          AKRM        2.130
          RAPM        3.410
          ERTM        2.070

          FMKN        2.130
          FFKN        1.630
          FBLG        0.375
          POTE        2.170
          GRNV        10.297
          GRNF        3.242
          EPLE        4.892
          AFRU        8.048
          BLOM        4.070
          FSOY        0.6
          FANT        0.00
          FJRK        48.400
*
          KHEL        48.40
          KFIL        66.73
          KANT        101.63
*
          EGGS        12.590
          KMLK        4.460
          MLKD        4.460
          MLKI        4.460
          MLKS        11.690
          YOGH        8.450
          OSTD        27.150
          OSTI        27.150
          OSTK        24.680
          OSTM        24.680
          OSTG        24.680
          OSTE        27.150
          OSTX        27.150
          SKMP        22.870
          FLOT        18.530
          SMOR        25.190
          STFK        32.280
          KLVK        32.280
          SAUK        32.490
          SVNK        24.640
          PRIN        64.960
          KYST        66.400
          KYSA        85.270
          KYSV        64.960
          KBST        118.010
          KBSA        76.960
          KBSV        64.960
          KSST        115.140
          KSSA        144.260
          KSSV        121.120
          KDEI        119.010
          KPOL        84.310
          KPAL        101.540
          KSPP        84.310
          KSPV        60.320
          KDIV        129.300
/;
*
PARAMETER PROSENTTOLL(VARE)  Prosenttoll (prosent)
/
          HVEM        347
          RUGM        347
          BYGM        318
          HAVM        233
          AKRM        347
          RAPM        268
          ERTM        214
          FMKN        347
          FFKN        318
          FBLG        268
*check
          FSOY        0
          FANT        0
          POTE        191
          GRNV        134
          GRNF        126
          EPLE        171
          AFRU        83
          BLOM        249
          FJRK        290
*
          KHEL        290
          KFIL        313
          KANT        425
*
          EGGS        272
          KMLK        388
          MLKD        388
          MLKI        388
          MLKS        223
          YOGH        319
          OSTD        277
          OSTI        277
          OSTK        233
          OSTM        233
          OSTG        233
          OSTE        277
          OSTX        277
          SKMP        392
          FLOT        439
          SMOR        343
          STFK        344
          KLVK        344
          SAUK        429
          SVNK        363
          PRIN        363
          KYST        344
          KYSA        429
          KYSV        363
          KBST        343
          KBSA        429
          KBSV        363
          KSST        344
          KSSA        429
          KSSV        363
          KDEI        344
          KPOL        344
          KPAL        363
          KSPP        344
          KSPV        363
          KDIV        344
/;
*
* Definere tollregime
PARAMETER TOLL(VARE) Anvendt toll;
TOLL(VARE) = KRONETOLL(VARE);

* Prosenttoll for MLKD MLKI OSTD OSTI STFK, biff/filet
TOLL('POTE') = PROSENTTOLL('POTE') * PI('POTE') / 100;
TOLL('MLKI') = PROSENTTOLL('MLKI') * PI('MLKI') / 100;
TOLL('MLKD') = PROSENTTOLL('MLKD') * PI('MLKD') / 100;
TOLL('OSTD') = PROSENTTOLL('OSTD') * PI('OSTD') / 100;
TOLL('OSTI') = PROSENTTOLL('OSTI') * PI('OSTI') / 100;
TOLL('STFK') = PROSENTTOLL('STFK') * PI('STFK') / 100;
TOLL('KLVK') = PROSENTTOLL('KLVK') * PI('KLVK') / 100;
TOLL('KYST') = PROSENTTOLL('KYST') * PI('STFK') / 100;
TOLL('KYSA') = PROSENTTOLL('KYSA') * PI('SAUK') / 100;
TOLL('KBST') = PROSENTTOLL('KBST') * PI('STFK') / 100;
TOLL('KBSA') = PROSENTTOLL('KBSA') * PI('SAUK') / 100;
*
*
PARAMETER KVOTETOLL(VARE);
* Tak import MFN kvoter
POL('NORGE',VARE,'MFNIMPT') = 0;
* Minsteadgangskvoter gjeldende WTO avtale
* inkludert 3.2 mill kg storfe fra MUL
POL('NORGE','GRNF','MFNIMPT') =  .268 ;
POL('NORGE','FJRK','MFNIMPT') =  .663 ;
POL('NORGE','EGGS','MFNIMPT') =  1.295;
POL('NORGE','SMOR','MFNIMPT') =  .575 ;
POL('NORGE','STFK','MFNIMPT') =  4.284;
POL('NORGE','SAUK','MFNIMPT') =  .806 ;
POL('NORGE','SVNK','MFNIMPT') =  1.381;
*
KVOTETOLL(VARE) =  TOLL(VARE) ;
KVOTETOLL(VARE) $ (POL('NORGE',VARE,'MFNIMPT')  > 0) = MAX(0, MIN(1/3 * TOLL(VARE), DATA('NORGE',VARE,'TOTP','BAS') - PI(VARE)));
* lavere toll pga storfe fra MUL
KVOTETOLL('STFK') $ (POL('NORGE','STFK','MFNIMPT')  > 0) = .1 * TOLL('STFK');


PARAMETER KVOTETOLLA(VARE);
* Tak import administrative kvoter
POL('NORGE',VARE,'ADMIMPT') = 0;
* Administrativt import grunnet norsk underskudd (se importkjoett.xlsx)
$ifthenI.AdmImp %PMP%==YES
POL('NORGE','STFK','ADMIMPT') = 4.349;
$endif.AdmImp

*
* Administrativt import av korn
POL('NORGE',MOELINNVARE,'ADMIMPT') =  + INF;
* Korn til kraftfôr
POL('NORGE','FMKN','ADMIMPT') =  + INF;
POL('NORGE','FFKN','ADMIMPT') =  + INF;
POL('NORGE','FBLG','ADMIMPT') =  + INF;
POL('NORGE','FSOY','ADMIMPT') =  + INF;
POL('NORGE','FANT','ADMIMPT') =  + INF;

* Administrative tollsatser
KVOTETOLLA(VARE) = TOLL(VARE) ;
* Generelle tollsatser for administrative tollkvoter
KVOTETOLLA(VARE) $ (POL('NORGE',VARE,'ADMIMPT')  > 0) = MAX(0, DATA('NORGE',VARE,'TOTP','BAS') - PI(VARE));
* Tollsatser administrative tollkvoter møllevarer
KVOTETOLLA(MOELINNVARE)  = MAX(0, MaalPris(MOELINNVARE)  - PRISNED(MOELINNVARE) - PI(MOELINNVARE));
KVOTETOLLA('FMKN') = KVOTETOLLA('HVEM');
KVOTETOLLA('FFKN') = KVOTETOLLA('BYGF');
KVOTETOLLA('FBLG') = KVOTETOLLA('RAPM');
KVOTETOLLA('FSOY') = 0.60;
KVOTETOLLA('FBLG') = 1.165;
KVOTETOLLA('FANT') = 0.0;
*
* Tollsatser for administrative tollkvoter potet
KVOTETOLLA('POTE') = MAX(0, MIN[TOLL('POTE'),DATA('NORGE','POTE','TOTP','BAS') - PI('POTE')]);
*
PARAMETER KVOTETOLLB(VARE);
KVOTETOLLB(VARE) = TOLL(VARE) ;
* Tak import bilaterale avtaler
POL('NORGE',VARE,'BILIMPT') = 0;
* EOS kvote paa ost
POL('NORGE','OSTD','BILIMPT') =  7.2;
KVOTETOLLB('OSTD') = 0.0;

PARAMETER KVOTETOLLS(VARE);
KVOTETOLLS(VARE) = TOLL(VARE) ;
* Tak import sensitive produkter
POL('NORGE',VARE,'SENIMPT') = 0;
*
* Tillatt mengde subsidiert eksport
* In principle allow no exports
POL('NORGE',VARE,'KVTEXPT') $ PRODUKT(VARE) = 0;
POL('NORGE',VARE,'KVTEXPT') $ SLTVARE(VARE) = 0;
POL('NORGE','PRIN','KVTEXPT') = 0;
POL('NORGE','FMKN','KVTEXPT') = 0;
POL('NORGE','FFKN','KVTEXPT') = 0;
*
* Give access to export according to export quotas
POL('NORGE','GRNF','KVTEXPT') =  0.664;
POL('NORGE','FJRK','KVTEXPT') =  0.022;
POL('NORGE','EGGS','KVTEXPT') =  1.578;
POL('NORGE','SKMP','KVTEXPT') =  0.024;
POL('NORGE','SMOR','KVTEXPT') =  5.873;
POL('NORGE','OSTE','KVTEXPT') =  9.75;
POL('NORGE','OSTX','KVTEXPT') =  12.15;
POL('NORGE','STFK','KVTEXPT') =  1.497;
POL('NORGE','SAUK','KVTEXPT') =  0.681;
POL('NORGE','SVNK','KVTEXPT') =  3.791;
*
*

Parameter MagTest(*,*,*,*);
*$gdxIn pol_test.gdx
*$load magtest
*$gdxOut

MagTest('NORGE',VARE,'KVTEXPT','test') = POL('NORGE',VARE,'KVTEXPT');
MagTest('NORGE',VARE,'ADMIMPT','test') = POL('NORGE',VARE,'ADMIMPT');
MagTest('NORGE',VARE,'MFNIMPT','test') = POL('NORGE',VARE,'MFNIMPT');
MagTest('NORGE',VARE,'BILIMPT','test') = POL('NORGE',VARE,'BILIMPT');

MagTest('NORGE',VARE,'TOLL','test')       = TOLL(VARE);
MagTest('NORGE',VARE,'KVOTETOLL','test')  = KVOTETOLL(VARE);
MagTest('NORGE',VARE,'KVOTETOLLA','test') = KVOTETOLLA(VARE);
MagTest('NORGE',VARE,'KVOTETOLLB','test') = KVOTETOLLB(VARE);
MagTest('NORGE',VARE,'KVOTETOLLS','test') = KVOTETOLLS(VARE);

Set MagTestFeil(*,*);
*MagTestFeil(VARE,'KVTEXPT')    = YES $ (NOT (MagTest('NORGE',VARE,'KVTEXPT','test')    EQ MagTest('NORGE',VARE,'KVTEXPT','org')));
*MagTestFeil(VARE,'ADMIMPT')    = YES $ (NOT (MagTest('NORGE',VARE,'ADMIMPT','test')    EQ MagTest('NORGE',VARE,'ADMIMPT','org')));
*MagTestFeil(VARE,'MFNIMPT')    = YES $ (NOT (MagTest('NORGE',VARE,'MFNIMPT','test')    EQ MagTest('NORGE',VARE,'MFNIMPT','org')));
*MagTestFeil(VARE,'BILIMPT')    = YES $ (NOT (MagTest('NORGE',VARE,'BILIMPT','test')    EQ MagTest('NORGE',VARE,'BILIMPT','org')));
*MagTestFeil(VARE,'TOLL')       = YES $ (NOT (MagTest('NORGE',VARE,'TOLL','test')       EQ MagTest('NORGE',VARE,'TOLL','org')));
*MagTestFeil(VARE,'KVOTETOLL')  = YES $ (NOT (MagTest('NORGE',VARE,'KVOTETOLL','test')  EQ MagTest('NORGE',VARE,'KVOTETOLL','org')));
*MagTestFeil(VARE,'KVOTETOLLA') = YES $ (NOT (MagTest('NORGE',VARE,'KVOTETOLLA','test') EQ MagTest('NORGE',VARE,'KVOTETOLLA','org')));
*MagTestFeil(VARE,'KVOTETOLLB') = YES $ (NOT (MagTest('NORGE',VARE,'KVOTETOLLB','test') EQ MagTest('NORGE',VARE,'KVOTETOLLB','org')));
*MagTestFeil(VARE,'KVOTETOLLS') = YES $ (NOT (MagTest('NORGE',VARE,'KVOTETOLLS','test') EQ MagTest('NORGE',VARE,'KVOTETOLLS','org')));

execute_unload 'pol_test.gdx', magtest, magtestfeil;
*abort '';