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
* Scale to increase base area to maxarea at national level
SCALAR SCAREAL / .0/;
*$ontext
* Prosjekt Effektiv arealutnyttelse
* ... arealtak regioner i basis

POL(R,'AREAL','TAK')    =  SUM(DSONE, BASEAREAL(R,DSONE))
                        + (SUM(DSONE, MAXAREAL(R,DSONE))- SUM(DSONE, BASEAREAL(R,DSONE)))*SCAREAL*(1-MYRFORBUD)
                        + (SUM(DSONE, MAXAREAL(R,DSONE))- SUM(DSONE, BASEAREAL(R,DSONE)))*SCAREAL*AREALRESERVE(R)*(MYRFORBUD);
POL(R,'FULLJ','TAK')    =  SUM(DSONE$(NOT SAMEAS('6',DSONE)), BASEAREAL(R,DSONE))
                        + (SUM(DSONE$(NOT SAMEAS('6',DSONE)), MAXAREAL(R,DSONE)) - SUM(DSONE$(NOT SAMEAS('6',DSONE)), BASEAREAL(R,DSONE)))*SCAREAL*(1-MYRFORBUD)
                        + (SUM(DSONE$(NOT SAMEAS('6',DSONE)), MAXAREAL(R,DSONE)) - SUM(DSONE$(NOT SAMEAS('6',DSONE)), BASEAREAL(R,DSONE)))*SCAREAL*AREALRESERVE(R)*(MYRFORBUD);
POL(R,'MATKN','TAK')    =  BASEAREAL(R,'1') + BASEAREAL(R,'2') + (MAXAREAL(R,'1') - BASEAREAL(R,'1'))*SCAREAL + (MAXAREAL(R,'2') - BASEAREAL(R,'2'))*SCAREAL;
POL(R,'KORN','TAK')     =  BASEAREAL(R,'1') + BASEAREAL(R,'2') + BASEAREAL(R,'3') + BASEAREAL(R,'4')
                        +  (MAXAREAL(R,'1') - BASEAREAL(R,'1'))*SCAREAL + (MAXAREAL(R,'2') - BASEAREAL(R,'2'))*SCAREAL + (MAXAREAL(R,'3') - BASEAREAL(R,'3'))*SCAREAL
                        +  (MAXAREAL(R,'4') - BASEAREAL(R,'4'))*SCAREAL ;

* Tak utmarksbeite
POL(R,'GFUB','TAK') = DATA(R,'GFUB','OMFG','BAS') * 10;
*
*
* Check that available agricultural area is at least 10 per cent higher than observed area
POL(R,'AREAL','TAK') = MAX(POL(R,'AREAL','TAK'), SUM(PLANTE$ (NOT SAMEAS('GFUB',PLANTE)), DATA(R,PLANTE,'OMFG','BAS')) * 1.1);
POL(R,'FULLJ','TAK') = MAX(POL(R,'FULLJ','TAK'), SUM(FULLJ, DATA(R,FULLJ,'OMFG','BAS')) * 1.1);
POL(R,'MATKN','TAK') = MAX(POL(R,'MATKN','TAK'), SUM(MATKN, DATA(R,MATKN,'OMFG','BAS')) * 1.1);
POL(R,'KORN','TAK')  = MAX(POL(R,'KORN','TAK') , SUM(KORN,   DATA(R,KORN,'OMFG','BAS')) * 1.1);
*
POL('041101','AREAL','TAK') = POL('041101','AREAL','TAK') * 1.02;
POL('112203','AREAL','TAK') = POL('112203','AREAL','TAK') * 1.04;
*
* Tak grasareal = Tak areal + GFUB;
POL(R,'GRAS','TAK')    = POL(R,'AREAL','TAK') + POL(R,'GFUB','TAK');
*
*
PARAMETER ArealTak(R,*) Tilgjengelig jord per arealklasse og region;
ArealTak(R,'AREAL') = POL(R,'AREAL','TAK');
ArealTak(R,'FULLJ') = POL(R,'FULLJ','TAK');
ArealTak(R,'KORN')  = POL(R,'KORN','TAK');
ArealTak(R,'MATKN') = POL(R,'MATKN','TAK');
ArealTak(R,'GRAS')  = POL(R,'GRAS','TAK');
ArealTak(R,'GFUB')  = POL(R,'GFUB','TAK');
*
$ifThenI.Pmp %PMP%==YES
** Remove upper bounds on agricultural area in calibration mode
POL(R,'AREAL','TAK') = +INF;
POL(R,'FULLJ','TAK') = +INF;
POL(R,'KORN','TAK')  = +INF;
POL(R,'MATKN','TAK') = +INF;
POL(R,'GRAS','TAK')  = +INF;
POL(R,'GFUB','TAK')  = +INF;
$endif.Pmp

* Omdisponering av jord prosentvis per aar
PARAMETER OMDISP(R) /
011101        -0.089582451
021101        -0.153149543
021103        -0.11017932
041203        -0.094419108
041101        -0.164771174
04125A        -0.096341901
051103        -0.065131504
05125A        -0.100164179
061101        -0.079171056
06125A        -0.119353673
071101        -0.073041156
081103        -0.084553984
08125A        -0.246655722
081203        -0.082384568
09225A        -0.149156928
10225A        -0.163513106
11225B        -0.348516152
112102        -0.157823103
112203        -0.305916782
11215B        -0.065554852
12325B        -0.18453679
14325B        -0.12311131
15325B        -0.251187636
164104        -0.083298045
16425A        -0.188860207
164204        -0.099442985
174104        -0.018651546
17425A        -0.093351746
185206        -0.098330753
195206        -0.19814743
195207        -0.232625792
205207        -0.424868785
/;
*
POL(R,'AREAL','TAK')  = POL(R,'AREAL','TAK') * (1 + OMDISP(R)/100) ** (Y - %BAS%);
POL(R,'FULLJ','TAK')  = POL(R,'FULLJ','TAK') * (1 + OMDISP(R)/100) ** (Y - %BAS%);
POL(R,'MATKN','TAK')  = POL(R,'MATKN','TAK') * (1 + OMDISP(R)/100) ** (Y - %BAS%);
POL(R,'KORN','TAK')   = POL(R,'KORN','TAK')  * (1 + OMDISP(R)/100) ** (Y - %BAS%);
*
* ... arealtak hele landet
POL('NORGE','KORN','TAK') = SUM(R, POL(R,'KORN','TAK')) ;
*$offtext
*
* ... gulv sysselsetting regioner
POL('NORGE','ARB','GLV') =  0;
POL(SD,'ARB','GLV')   =  0;
POL(R,'ARB','GLV')     =  0;
*
* ... gulv omfang produksjoner regioner
POL('NORGE',PRDK,'PRDK_GLV')   = 0;
* Test
POL('NORGE','KORN','PRDK_GLV') = 0;
POL('NORGE','GROV','PRDK_GLV') = 0;
POL('NORGE','PLNT','PRDK_GLV') = 0;
POL(SD,PRDK,'PRDK_GLV')        = 0;
POL(F,PRDK,'PRDK_GLV')         = 0;
POL(R,PRDK,'PRDK_GLV')         = 0;
POL(R,'KORN','PRDK_GLV')       = 0;
POL(F,'KORN','PRDK_GLV')       = 0;
POL(F,'GROV','PRDK_GLV')       = 0;
POL(R,PRDK,'PRDK_GLV') = 0;
*
*POL(R,'MKYR','PRDK_GLV')                                                                =                   DATA(R,'MKYR','OMFG','BAS')        ;
*POL(R,'AKYR','PRDK_GLV')                                                                =                   DATA(R,'AKYR','OMFG','BAS')        ;
*POL(R,'GEIT','PRDK_GLV') $ (                  DATA(R,'GEIT','OMFG','BAS')        > .25) =                   DATA(R,'GEIT','OMFG','BAS')        ;
*POL(R,'SOEY','PRDK_GLV')                                                                =                   DATA(R,'SOEY','OMFG','BAS')        ;
*POL(R,'PURK','PRDK_GLV')                                                                =                   DATA(R,'PURK','OMFG','BAS')        ;
*POL(R,'HOEN','PRDK_GLV')                                                                =                   DATA(R,'HOEN','OMFG','BAS')        ;
*POL(R,'KYLS','PRDK_GLV')                                                                =                   DATA(R,'KYLS','OMFG','BAS')        ;
**
*POL(R,'KORN','PRDK_GLV') $ (SUM(KornOljePrdk, DATA(R,KornOljePRDK,'OMFG','BAS')) > .5)  = SUM(KornOljePrdk, DATA(R,KornOljePrdk,'OMFG','BAS')) ;
*POL(R,'POTE','PRDK_GLV') $ (                  DATA(R,'POTE','OMFG','BAS')        > .2)  =                   DATA(R,'POTE','OMFG','BAS')        ;
*POL(R,'GRNS','PRDK_GLV') $ (SUM(GRNS,         DATA(R,GRNS,'OMFG','BAS'))         > .1)  = SUM(GRNS,         DATA(R,GRNS,'OMFG','BAS'))         ;
*POL(R,'FRBA','PRDK_GLV') $ (SUM(FRBA,         DATA(R,FRBA,'OMFG','BAS'))         > .1)  = SUM(FRBA,         DATA(R,FRBA,'OMFG','BAS'))         ;
*
POL(R,PRDK,'PRDK_GLV')   =  POL(R,PRDK,'PRDK_GLV')   * .0  ;
POL(R,'KORN','PRDK_GLV') =  POL(R,'KORN','PRDK_GLV') * .0  ;
POL(R,'GRNS','PRDK_GLV') =  POL(R,'GRNS','PRDK_GLV') * .0  ;
POL(R,'FRBA','PRDK_GLV') =  POL(R,'FRBA','PRDK_GLV') * .0  ;
*
*... produskjonsgulv produksjonsregioner
POL(R,VARE,'VARE_GLV') = 0;
POL(SD,VARE,'VARE_GLV')      = 0;
*
* ... produskjonstak produksjonsregioner
POL('NORGE',VARE,'VARE_TAK') = +INF;
POL('NORGE','KORN','VARE_TAK') = +INF;
POL(R,VARE,'VARE_TAK') = +INF;
*
* Upper bound on particular primary production per region justified by crop rotation (max 25% of arable land) in simulation mode
*POL(R,'POTE','VARE_TAK') = ENHDATA(R,'POTE','POTE','BAS') * POL(R,'FULLJ','TAK')  * .25 * .001;
*POL(R,'EPLE','VARE_TAK') = ENHDATA(R,'EPLE','EPLE','BAS') * POL(R,'FULLJ','TAK')  * .25 * .001;
*POL(R,'AFRU','VARE_TAK') = ENHDATA(R,'AFRU','AFRU','BAS') * POL(R,'FULLJ','TAK')  * .25 * .001;
*POL(R,'GRNF','VARE_TAK') = ENHDATA(R,'GRNF','GRNF','BAS') * POL(R,'FULLJ','TAK')  * .25 * .001;
*POL(R,'GRNV','VARE_TAK') = ENHDATA(R,'GRNV','GRNV','BAS') * POL(R,'FULLJ','TAK')  * .25 * .001;
*POL(R,'BLOM','VARE_TAK') = ENHDATA(R,'BLOM','BLOM','BAS') * POL(R,'FULLJ','TAK')  * .25 * .001;
*
* ... produksjonsgulv nasjonalt
POL('NORGE',VARE,'VARE_GLV') = 0;
*
* ... fylkesvise melkekvoter includig some flexibility
POL(F,'KMLK','KVOTE') = SUM(R$R_TIL_F(F,R), DATA(R,'KMLK','MNGD','BAS')) * 1.05 ;
* Calibrate to avoid that quota constraints
POL('050000','KMLK','KVOTE') = POL('050000','KMLK','KVOTE') * 1.05 ;
POL('060000','KMLK','KVOTE') = POL('060000','KMLK','KVOTE') * 1.01 ;
POL('090000','KMLK','KVOTE') = POL('090000','KMLK','KVOTE') * 1.15 ;
*
POL(F,'GMLK','KVOTE') = SUM(R$R_TIL_F(F,R), DATA(R,'GMLK','MNGD','BAS')) * 1.05 ;
*
* slå sammen kvoter for geitmelk siden det ikke er definert geitebruk i alle regioner
POL('040000','GMLK','KVOTE') = POL('010000','GMLK','KVOTE') + POL('040000','GMLK','KVOTE');
POL('010000','GMLK','KVOTE') = 0;
POL('060000','GMLK','KVOTE') = POL('060000','GMLK','KVOTE') + POL('070000','GMLK','KVOTE');
POL('070000','GMLK','KVOTE') = 0;
POL('080000','GMLK','KVOTE') = POL('080000','GMLK','KVOTE') + POL('090000','GMLK','KVOTE');
POL('090000','GMLK','KVOTE') = 0;
POL('190000','GMLK','KVOTE') = POL('190000','GMLK','KVOTE') + POL('200000','GMLK','KVOTE');
POL('200000','GMLK','KVOTE') = 0;
*

PARAMETER KvoteTak(F,*) Tilgjengelig kvote per vare og region;
KvoteTak(F,'KMLK') = POL(F,'KMLK','KVOTE');
KvoteTak(F,'GMLK') = POL(F,'GMLK','KVOTE');

*
** ... No milk quotas under calibration of PMP-terms
$ifThenI.Pmp %PMP%==YES
POL(F,'KMLK','KVOTE') = +INF;
POL(F,'GMLK','KVOTE') = +INF;
$endif.Pmp

*
* Del av politikk: stoerrelse enkeltbruk
TABLE BRUKSTOR_E1(R,B) Maksimal bruksstoerrelse for bruk i region
        BPTE    BHGE    BKMK    BAKY    BGRI    BSAU    BGMK  BHOE      BKYL      BKRN    BFRK
011101   56.0    45.0    42.4    20.4    55.0    41.0     9.0  1300.0     98844.0  230.0   17.0
021101   56.0    45.0    38.0    21.4    54.3    41.0     9.0    27.5     98844.0  230.0   17.0
021103   56.0    45.0    40.4    22.7    54.3    41.0     9.0    35.0     98844.0  230.0   17.0
041101   56.0    45.0    42.9    27.2    91.4    41.0     9.0  7381.5     98844.0  230.0   17.0
041203   85.0     2.0    29.1    25.8    54.3    41.0    13.0    27.5     98844.0  181.0   24.0
04125A   85.0     2.0    29.2    19.6    54.3    68.0    13.0    27.5     98844.0  181.0   24.0
051103   56.0    45.0    38.8    26.4    64.2    54.0     9.0    55.5     98844.0  230.0   17.0
05125A   85.0     2.0    28.1    18.2    54.3    63.0    13.0    27.5     98844.0  181.0   24.0
061101   56.0    45.0    41.8    23.9    54.3    41.0     9.0    30.0     98844.0  230.0   17.0
06125A   85.0     2.0    27.7    16.0    54.3    56.0    13.0    27.5     98844.0  181.0   24.0
071101   56.0    45.0    44.5    29.1    64.0    41.0     9.0    50.0     98844.0  230.0   17.0
081103   56.0    45.0    41.6    21.7    86.2    41.0     9.0    27.5     98844.0  230.0   17.0
081203   85.0     2.0    33.0    17.5    67.0    41.0    13.0  5205.0     98844.0  181.0   24.0
08125A   85.0     2.0    23.1    14.3    54.3    41.0    13.0    27.5     98844.0  181.0   24.0
09225A   15.0     6.0    25.1    16.0    54.3    41.0     9.0    43.5    137644.0   75.0   10.0
10225A   15.0     6.0    26.5    16.3    54.3    41.0     9.0    27.5    137644.0   75.0   10.0
112102   47.0    27.0    44.3    17.7    66.9    59.0     9.0  7419.0    137902.0   80.0    8.0
112203   15.0     6.0    49.3    12.0    59.0    87.0     9.0  7375.0    137644.0   75.0   10.0
11215B   47.0    27.0    35.7    14.9    54.3    98.0     9.0    27.5    137902.0   80.0    8.0
11225B   15.0     6.0    27.6    15.0    54.3    52.0     9.0    29.0    137644.0   75.0   10.0
12325B   15.0     2.0    26.6    11.0    54.3    41.0     9.0    27.5     98844.0  105.0   15.0
14325B   15.0     2.0    24.1    11.9    54.3    41.0     9.0    27.5     98844.0  105.0   15.0
15325B   15.0     2.0    30.6    14.0    54.3    41.0     9.0    27.5     98844.0  105.0   15.0
164104   16.0    20.0    37.3    16.6    54.3    41.0     9.0   170.0    100292.0  175.0    9.0
164204   15.0    18.0    32.4    14.4    74.9    41.0     9.0    27.5     98844.0  175.0   12.0
16425A   15.0    18.0    30.1    18.4    54.3    79.0     9.0    27.5     98844.0  175.0   12.0
174104   16.0    20.0    39.4    22.9    71.6    41.0     9.0  7050.0    100292.0  175.0    9.0
17425A   15.0    18.0    38.8    21.0    82.6    43.5     9.0  7415.5     98844.0  175.0   12.0
185206   15.0     2.0    33.8    17.2    72.2    57.0    87.5    27.5     98844.0   61.0    3.0
195206   15.0     2.0    29.5    18.4    54.3    72.0    87.5    27.5     98844.0   61.0    3.0
195207   15.0     2.0    24.3    5.9     54.3    68.0    87.5    27.5     98844.0   61.0    3.0
205207   15.0     2.0    33.9    8.0     54.3    41.0    87.5    27.5     98844.0   61.0    3.0
;

* PT2024
TABLE BRUKSTOR_E2(R,B) Maksimal bruksstoerrelse for bruk i region
       BSAU      BKRN        BPTE      BFRK      BHGE      BKMK      BAKY      BGMK      BGRI      BHOE        BKYL
011101  30.1923   350.6310   73.053    35.7561   92.3810   42.3830   20.3750  45.500    37.7727   4558.4100   36374.5000
021101  31.9939   442.0420   11.211    26.4062   45.6071   37.9500   21.3511  45.500    31.1667   2428.5500   23536.6000
021103  43.4759   411.2880   163.657   60.6500   46.6000   40.3630   22.7357  32.000    60.7083   2253.8800   53085.5000
041101  52.7367   400.4640   122.527   45.1562   117.8950  42.8646   27.1608  32.000    65.3088   5191.8700   26536.3000
041203  28.4500   404.7560   239.739   31.8000   103.4290  29.0938   25.8491  32.000    64.1591   3232.5900   34654.4000
04125A  90.3040   215.3330   127.730   29.2000   1.5000    29.1617   19.6217  99.500    1.5000    2442.9000   19247.1000
051103  71.1358   242.1420   102.937   23.0588   226.7200  38.7599   26.3872  44.000    50.1250   3553.4600   42335.4000
05125A  77.7442   139.4750   36.027    11.8125   4.7000    28.1174   18.1669  119.000   57.1212   728.6130    5.6667
061101  59.8007   264.4120   73.444    62.8624   271.3490  41.7742   23.9340  147.250   39.1500   2728.4000   34270.5000
06125A  72.4331   171.9700   40.357    59.3750   2.0000    27.6667   15.9545  147.250   33.7143   1036.4300   14250.0000
071101  31.1170   320.3250   160.068   30.7067   200.8930  44.5104   29.1293  147.250   40.8611   3319.9100   18878.9000
081103  23.7143   163.6190   100.538   22.3000   127.0000  41.6364   21.6974  8.000     31.6000   52.1000     0.0000
081203  44.6304   222.4800   8.333     47.0968   3.5556    33.0000   17.4800  8.000     50.0500   4334.6100   0.0000
08125A  57.4430   232.3650   11.579    23.3793   54.0833   23.1102   14.3154  112.875   11.1250   1693.4100   6962.3800
09225A  50.3839   139.8670   84.926    20.0286   46.0370   25.0909   16.0265  25.000    23.0833   2175.5700   0.0000
10225A  44.6430   85.6250    42.538    20.8485   8.5625    26.4946   16.3116  25.000    38.2368   1010.8000   27014.0000
112102  76.0830   115.3890   78.709    14.3846   105.9540  44.2916   17.7152  98.000    57.5644   6722.4800   38360.4000
112203  98.7657   160.3330   87.973    10.6250   1.0000    35.7283   14.8715  98.000    38.9412   4735.9100   45454.4000
11215B  92.5000   0.0000     3.000     0.0000    0.0000    49.2500   12.0000  187.400   33.5000   0.0000      0.0000
11225B  70.0449   98.0000    11.267    18.4182   13.7333   27.5636   14.9908  197.200   56.4479   2559.8100   24950.3000
12325B  45.4161   63.3333    3.913     23.8091   1.8889    26.5670   11.0057  111.778   28.7500   1157.4800   9175.6700
14325B  53.0553   30.3333    19.400    19.2353   12.5143   24.0515   11.8519  127.932   20.3421   1037.9200   2.0000
15325B  46.0677   143.6810   27.386    18.2466   14.8056   30.6043   14.0491  163.423   15.9848   1124.7000   16404.1000
164104  53.8024   224.5820   11.961    17.1481   12.6429   37.2507   16.5830  15.000    23.8684   3380.2500   36482.3000
164204  14.0000   182.7840   8.250     5.0000    0.0000    32.4000   14.3529  15.000    38.5000   43.8333     116266.0000
16425A  100.4670  125.5620   35.556    1.0000    3.0000    30.0540   18.4294  22.000    28.7500   2530.0200   30472.4000
174104  66.7476   255.6280   138.148   19.5652   131.1780  39.4481   22.8952  6.000     55.4348   4673.1200   32289.3000
17425A  65.5362   260.7140   69.306    25.6500   43.6250   38.7705   21.0395  125.000   49.9756   6469.9600   31100.1000
185206  82.8656   159.3080   9.941     4.9167    7.5556    33.8438   17.2096  169.636   46.8049   1048.8300   7.5000
195206  96.6179   1.0000     49.164    5.0714    8.6316    29.4955   18.4015  152.139   24.2143   988.1150    17.5000
195207  81.6569   0.0000     2.857     2.0000    0.0000    24.3421   5.8750   187.444   0.0000    9.3333      0.0000
205207  71.9960   183.5000   4.333     2.0000    44.3333   33.8614   7.9773   187.444   2.2500    17.1667     5.0000
;
































































* Assure that egg farms do not get infeasible due to Bunnfradrag
BRUKSTOR_E1(R,'BHOE') = MAX(700, BRUKSTOR_E1(R,'BHOE'));
BRUKSTOR_E2(R,'BHOE') = MAX(700, BRUKSTOR_E2(R,'BHOE'));
*
* Poultry counted in 1000 heads
BRUKSTOR_E1(R,'BHOE') = BRUKSTOR_E1(R,'BHOE') / 1000;
BRUKSTOR_E1(R,'BKYL') = BRUKSTOR_E1(R,'BKYL') / 1000;
*
BRUKSTOR_E2(R,'BHOE') = BRUKSTOR_E2(R,'BHOE') / 1000;
BRUKSTOR_E2(R,'BKYL') = BRUKSTOR_E2(R,'BKYL') / 1000;

*
PARAMETER BRUKSTOR(R,B,*,*) Definisjon av brukstoerrelse paa regionnivaa  ;
BRUKSTOR(R,B,'MAKS','Y') = MAX(BRUKSTOR_E1(R,B), BRUKSTOR_E2(R,B));
*
BRUKSTOR(R,B,'MAKS','Y') = BRUKSTOR(R,B,'MAKS','Y')  * 1;
BRUKSTOR(R,B,'MIN','Y')  = BRUKSTOR(R,B,'MAKS','Y')  * .9;
*
* brukes til � vurdere enhetskostnader
SET SIZE /XS,S,M,L,XL,XXL/;
PARAMETER STORRELSE(R,B,SIZE);
STORRELSE(R,'BKRN','M') = BRUKSTOR(R,'BKRN','MAKS','Y');
STORRELSE(R,'BPTE','M') = BRUKSTOR(R,'BPTE','MAKS','Y');
STORRELSE(R,'BFRK','M') = BRUKSTOR(R,'BFRK','MAKS','Y');
STORRELSE(R,'BHGE','M') = BRUKSTOR(R,'BHGE','MAKS','Y');
STORRELSE(R,'BKMK','M') = BRUKSTOR(R,'BKMK','MAKS','Y');
STORRELSE(R,'BGMK','M') = BRUKSTOR(R,'BGMK','MAKS','Y');
STORRELSE(R,'BAKY','M') = BRUKSTOR(R,'BAKY','MAKS','Y');
STORRELSE(R,'BSAU','M') = BRUKSTOR(R,'BSAU','MAKS','Y');
STORRELSE(R,'BGRI','M') = BRUKSTOR(R,'BGRI','MAKS','Y');
STORRELSE(R,'BHOE','M') = BRUKSTOR(R,'BHOE','MAKS','Y');
STORRELSE(R,'BKYL','M') = BRUKSTOR(R,'BKYL','MAKS','Y');
*
STORRELSE(R,B,'XS')   = STORRELSE(R,B,'M') * .5;
STORRELSE(R,B,'S')    = STORRELSE(R,B,'M') * .75;
STORRELSE(R,B,'L')    = STORRELSE(R,B,'M') * 1.5;
STORRELSE(R,B,'XL')   = STORRELSE(R,B,'M') * 2;
STORRELSE(R,B,'XXL')  = STORRELSE(R,B,'M') * 3;
*
* Produksjonskvoter melk
PARAMETER VAREKVOT(R,VARE) Produksjonskvoter;
VAREKVOT(R,VARE) = + INF;
VAREKVOT(R,'KMLK') = ENHDATA(R,'KMLK','MKYR','BAS') * BRUKSTOR(R,'BKMK','MAKS','Y');

* Fee on feed concentrates
PARAMETER KFORAVG(R,VARE);
KFORAVG(R,MOELUTVARE) = 0;

* Fee on purchased nitrogen
KFORAVG(R,'NITG') = 0;

* Require non-negative profits in the agricultural sector
Scalar AGProfit;
AGProfit = 0;

**************************
* Folkehelse
**************************
* YES: include in object function
* NO: include not in object function
$setGlobal PubHealth NO


*Target dietary recommendation of food groups in gram per person per day;
POL('NORGE',FoodGrp,'MAAL') = INF;


**************************
* Ecosystem services
**************************
* YES: include in object function
* NO: include not in object function
$setGlobal EcoSys NO

**************************
* Land use change
**************************
$setGlobal LUC NO

* Pris for LUC utslipp i 1000 kr per t CO2-e
Scalar LUCAvg /0/;

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
*
* NITRAVRENN = 0 ingen endring
NITRAVRENN(R) = 0;
*
* Tak klimagassutslipp i GHG
POL('NORGE','GHG','TAK') =  +INF;
*
* klimaavgift
* angitt pr miljovare for norsk produksjon
PARAMETER CO2AVGXP(UTSLIPPAVG);
* 350 kr per t CO2-ekvivalent
CO2AVGXP(UTSLIPPAVG) = .350 * SUM(UTSLIPPGHG$UTSLIPPAVG_TIL_UTSLIPPGHG(UTSLIPPGHG,UTSLIPPAVG), GHGPOTENSIAL(UTSLIPPGHG)) ;
CO2AVGXP(UTSLIPPAVG) = 0;
*
* angitt pr miljovare for importert vare
PARAMETER CO2AVGXI(VARE);
CO2AVGXI(UTSLIPPAVG) = CO2AVGXP(UTSLIPPAVG);
*
* Skalering av tilskudd til klimatiltak
PARAMETER KltkScal(B);
KltkScal(B) = 1;
*
SCALAR MCPF Marginal cost of public funds Percent /0/;
*
* Krisemeny
* minste verdier pr cap og dag for energi fett og protein
POL('NORGE','ENER','GLV') = 0;
POL('NORGE','PROT','GLV') = 0;
POL('NORGE','FETT','GLV') = 0;

POL('NORGE',NSTOFF,'PROD') = 0;
POL('NORGE',NSTOFF,'KONS') = 0;


* Del av politikk: antall meierier
POL('OEST','MEIR','MIN') = 10;
POL('SOER','MEIR','MIN') = 6;
POL('VEST','MEIR','MIN') = 6;
POL('MIDT','MEIR','MIN') = 8;
POL('NORD','MEIR','MIN') = 4;
*
POL(M,'MEIR','MIN') = POL(M,'MEIR','MIN') * .9;
*
* Del av politikk: antall slakterier
POL('OEST','SSLK','gs_MIN') =  7;
POL('SOER','SSLK','gs_MIN') =  7;
POL('VEST','SSLK','gs_MIN') =  5;
POL('MIDT','SSLK','gs_MIN') =  7;
POL('NORD','SSLK','gs_MIN') =  7;
*
POL(M,'SSLK','gs_MIN')  = POL(M,'SSLK','gs_MIN') * .75;
POL(M,'SSLK','gs_MAKS') = POL(M,'SSLK','gs_MIN') / .75 * 2;
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

* Antall ganger slaktebil hos produsent pr aar
POL('BESOEK','KJOTT','ANTL') = 4;
*