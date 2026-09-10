************************************************************************
*
*   Jordmod og klima: Del av C-scape 20010-2014
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Parametre for ernaering
*   Kommentarer: Basert paa Paal og Klaus, 3 mar 11, KMi
*   Status:
************************************************************************
*
TABLE MATINNHOLD(VARE,NAERSTOFF)  Innhold naeringsstoffer i matvarer i kcal eller g pr kg
           ENER            PROT          FETT
HVET        2920.000        88.668        15.668
BYGG        2288.983        37.119        0.000
RUGH        2683.824        69.779        10.735
AKRN        2683.824        69.779        10.735
HAVR        1921.053        76.842        38.421
ERTE        3361.842        211.316       19.211
RAPS        3650.000        243.333       243.333
POTE        672.110         16.190        0.981
*GRNV        205.313         9.125         2.281
*GRNF        275.698         12.586        2.397
*EPLE        348.351         4.098         1.793
*AFRU        441.532         5.887         4.415
STFK        1032.683        129.976       51.634
SAUK        2346.429        123.839       202.054
SVNK        3602.597        96.385        353.939
FJRK        1249.329        149.430       68.591
EGGS        1432.710        115.981       98.925
MLKD        470.407         32.672        14.830
MLKI        470.407         32.672        14.830
MLKS        613.120         32.656        14.328
YOGH        1024.326        38.196        34.284
OSTD        3510.000        270.000       270.000
OSTI        3510.000        270.000       270.000
OSTK        2880.000        60.000        280.000
OSTM        3842.335        215.075       271.772
OSTG        4430.000        120.000       270.000
OSTE        3510.000        270.000       270.000
OSTX        3510.000        270.000       270.000
SKMP        3096.900        309.690       820.000
FLOT        3203.673        22.571        332.171
SMOR        7453.904        10.000        819.323
;

* Deriverte produkter
MATINNHOLD(VARE,'KMLK') = MATINNHOLD(VARE,'MLKD');
MATINNHOLD(VARE,'GMLK') = MATINNHOLD(VARE,'MLKD');
MATINNHOLD(VARE,'KLVK') = MATINNHOLD(VARE,'STFK');
MATINNHOLD(VARE,'GETK') = MATINNHOLD(VARE,'SAUK');
MATINNHOLD(VARE,'STKK') = MATINNHOLD(VARE,'STFK');
MATINNHOLD(VARE,'SAGK') = MATINNHOLD(VARE,'SAUK');

MATINNHOLD(VARE,'KYST') = MATINNHOLD(VARE,'STFK');
MATINNHOLD(VARE,'KYSA') = MATINNHOLD(VARE,'SAUK');
MATINNHOLD(VARE,'KYSV') = MATINNHOLD(VARE,'SVNK');
MATINNHOLD(VARE,'KBST') = MATINNHOLD(VARE,'STFK');
MATINNHOLD(VARE,'KBSA') = MATINNHOLD(VARE,'SAUK');
MATINNHOLD(VARE,'KBSV') = MATINNHOLD(VARE,'SVNK');
MATINNHOLD(VARE,'KSST') = MATINNHOLD(VARE,'STFK');
MATINNHOLD(VARE,'KSSA') = MATINNHOLD(VARE,'SAUK');
MATINNHOLD(VARE,'KSSV') = MATINNHOLD(VARE,'SVNK');

MATINNHOLD(VARE,'PRIN') = .5 * MATINNHOLD(VARE,'STFK') + .5 * MATINNHOLD(VARE,'SVNK');
MATINNHOLD(VARE,'KDEI') = .5 * MATINNHOLD(VARE,'STFK') + .5 * MATINNHOLD(VARE,'SVNK');
MATINNHOLD(VARE,'KPOL') = .5 * MATINNHOLD(VARE,'STFK') + .5 * MATINNHOLD(VARE,'SVNK');
MATINNHOLD(VARE,'KPAL') = .5 * MATINNHOLD(VARE,'STFK') + .5 * MATINNHOLD(VARE,'SVNK');
MATINNHOLD(VARE,'KSPP') =  MATINNHOLD(VARE,'STFK');
MATINNHOLD(VARE,'KSPV') =  MATINNHOLD(VARE,'SAUK');

MATINNHOLD(VARE,'MMEL') =  MATINNHOLD(VARE,'HVET');
MATINNHOLD(VARE,'MKRN') =  MATINNHOLD(VARE,'HVET');
MATINNHOLD(VARE,'FFKN') =  MATINNHOLD(VARE,'BYGG');
HOLD(VARE,'HVET');
MATINNHOLD(VARE,'FFKN') =  MATINNHOLD(VARE,'BYGG');


HOLD(VARE,'HVET');
MATINNHOLD(VARE,'FFKN') =  MATINNHOLD(VARE,'BYGG');

