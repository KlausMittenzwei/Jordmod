************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Innlesing av koeffisienter for aktivitetene i kjoettbransjen
*   Kommentarer:
*   Enheter: Priser i kr pr kg
*            Mengder i mill kg
*            Verdier i mill kr
*   Status:
*
************************************************************************
PARAMETER SLKINFES(STEP) Antall infeasibilities i slakterimodellen;
*
TABLE SLKDATA(VARE,PRDK)
          SLST      SLSA      SLSV
STKK      1.00000
SAGK                1.00000
SVNK                          1.00000
LONN      5.070     7.370     4.280
ANNT      6.065     8.335     4.905
*
KYST      0.033
KYSA                0.600
KYSV                          0.393
KBST      0.147
KBSA                0.006
KBSV                          0.030
KSST      0.005
KSSA                0.058
KSSV                          0.087
PRIN      0.596     0.191     0.3903
*
+         KDEI    KPOL    KPAL     KSPP     KSPV     KDIV
PRIN      0.990   0.7560  0.9440   1.2800   1.5700   0.756
LONN      1.928   4.978   6.313    13.062   20.253   4.380
AVAR      1.811   6.444   7.214    7.632    6.651    2.783
ANNT      17.24   17.170  29.950   47.610   49.390   19.28
KDEI      1.00000
KPOL              1.00000
KPAL                      1.00000
KSPP                               1.00000
KSPV                                        1.00000
KDIV                                                 1.00000
*
;

* Calibration
SLKDATA('PRIN',SSLK) = SLKDATA('PRIN',SSLK) * 1.06;

* Projection from 2021 to 2023
* Source: StatTab 09170: Lonn: Lønnskostnader, Annt: Produktinnsats  
SLKDATA('LONN','SLST') = SLKDATA('LONN','SLST') * 32803/29805;
SLKDATA('ANNT','SLST') = SLKDATA('ANNT','SLST') * 288181/230677;
*
SLKDATA('LONN','SLSA') = SLKDATA('LONN','SLSA') * 32803/29805;
SLKDATA('ANNT','SLSA') = SLKDATA('ANNT','SLSA') * 288181/230677;
*
SLKDATA('LONN',FSLK) = SLKDATA('LONN',FSLK) * 32803/29805;
SLKDATA('ANNT',FSLK) = SLKDATA('ANNT',FSLK) * 288181/230677;
*
SLKDATA('AVAR',FSLK) = SLKDATA('AVAR',FSLK) * 288181/230677;
*
* Projection from 2023 to 2024 
* Source: StatTab 14709 CPI (2025=100) 
SLKDATA('LONN','SLST') = SLKDATA('LONN','SLST') * 97.1/94.1;
SLKDATA('ANNT','SLST') = SLKDATA('ANNT','SLST') * 97.1/94.1;
SLKDATA('LONN','SLSA') = SLKDATA('LONN','SLSA') * 97.1/94.1;
SLKDATA('ANNT','SLSA') = SLKDATA('ANNT','SLSA') * 97.1/94.1;
SLKDATA('LONN',FSLK) = SLKDATA('LONN',FSLK)     * 97.1/94.1;
SLKDATA('ANNT',FSLK) = SLKDATA('ANNT',FSLK)     * 97.1/94.1;
SLKDATA('AVAR',FSLK) = SLKDATA('AVAR',FSLK)     * 97.1/94.1;
*
*
PARAMETER PRINANDEL(SSLK) Maksimal andel kjøttråvare i foredlede kjøttvarer;
PRINANDEL(SSLK) = 1;
PRINANDEL('SLSA') = .075;

* Projection of LONN ANNT og AVAR to simulation year
SLKDATA('LONN',PRDK) = SLKDATA('LONN',PRDK) * (1 + KPI + LOENN - VEKSTIND/100) ** (Y - %BAS%);
SLKDATA('ANNT',PRDK) = SLKDATA('ANNT',PRDK) * (1 + KPI         - VEKSTIND/100) ** (Y - %BAS%);
SLKDATA('AVAR',PRDK) = SLKDATA('AVAR',PRDK) * (1 + KPI         - VEKSTIND/100) ** (Y - %BAS%);
*
* Source: taken from calib.gdx
PARAMETER PROD_SLK(M) Antall kjoettprodusenter
/
OEST    7024
SOER    7191
VEST    4613
MIDT    6930
NORD    2657
/;

KonvergensTest(M,'Prod_SLK','','','0') = PROD_SLK(M);
*
* Landareal uendret av antall produsenter
AREALKNST('OEST') = AREAL('OEST') * .25;
AREALKNST('SOER') = AREAL('SOER') * .5;
AREALKNST('VEST') = AREAL('VEST') * .75;
AREALKNST('MIDT') = AREAL('MIDT') * .5;
AREALKNST('NORD') = AREAL('NORD') * .9;
*
* Initialisering av effektiv landareal
AREALPROD(M) = (AREAL(M) - AREALKNST(M)) / PROD_SLK(M);
*
* # slaughterhouses in 2024
* Source: slakterier.xlsx
PARAMETER ANTL_SLK(M) Antall slakterier
/ OEST       5
  SOER       8
  VEST       4
  MIDT       4
  NORD       6
/;
*
SCALAR FKOSTSSLKBAS Gjennomsnittlige foredlingskostnader SSLK i basisaaret;
FKOSTSSLKBAS =
    SUM(M,
   (SIMDATA(M,'STFK','MNGD','Y') + SIMDATA(M,'STFK','MNGD','Y')) * (SLKDATA('LONN','SLST') + SLKDATA('ANNT','SLST'))
 + (SIMDATA(M,'SAUK','MNGD','Y') + SIMDATA(M,'GETK','MNGD','Y')) * (SLKDATA('LONN','SLSA') + SLKDATA('ANNT','SLSA'))
 +  SIMDATA(M,'SVNK','MNGD','Y')                                   * (SLKDATA('LONN','SLSV') + SLKDATA('ANNT','SLSV')))
 /    SUM((M,SLKINNVARE), SIMDATA(M,SLKINNVARE,'MNGD','Y'));
*
*
SCALAR FKOSTFSLKBAS Gjennomsnittlige foredlingskostnader FSLK i basisaaret;
FKOSTFSLKBAS =
    SUM((M,FSLK,FSLKVARE)$FP_TIL_SLTVARE(FSLKVARE,FSLK),
    SIMDATA(M,FSLKVARE,'MNGD','Y') * (SLKDATA('LONN',FSLK) + SLKDATA('ANNT',FSLK)))
 /  SUM((M,FSLKVARE), SIMDATA(M,FSLKVARE,'MNGD','Y'));
*
*
SCALAR BESOEK Besoek pr produsent pr aar;
BESOEK = POL('BESOEK','KJOTT','ANTL');
*
SCALAR MAKSTRTID Maksimal transporttid for levende dyr i timer /8/ ;
*
* Forutsetninger stordriftsfordeler
SCALARS DM Mengdeendring /2/
        DCS Kostnadsnivaa slakting og skjaering ved mengdeendring /0.75/
        DCF Kostnadsnivaa foredling ved mengdeendring /0.9/;

SCALAR  ZS_BAS Anleggstoerrelse i basisaaret
        ZK_BAS Volum i basisaaret;




ZS_BAS = SUM((M,SLKINNVARE),  SIMDATA(M,SLKINNVARE,'MNGD','Y')) / SUM(M, ANTL_SLK(M));
ZK_BAS = SUM((M,FSLK),        SIMDATA(M,FSLK,'MNGD','Y'))  / 9;


SCALAR  CF_BAS Anleggskostnader slakting og skjaering i basisaaret;
CF_BAS = SUM(M, ((SLKDATA('LONN','SLST') + SLKDATA('ANNT','SLST')) * (SIMDATA(M,'STFK','MNGD','Y') + SIMDATA(M,'KLVK','MNGD','Y'))
               + (SLKDATA('LONN','SLSA') + SLKDATA('ANNT','SLSA')) * (SIMDATA(M,'SAUK','MNGD','Y') + SIMDATA(M,'GETK','MNGD','Y'))
               + (SLKDATA('LONN','SLSV') + SLKDATA('ANNT','SLSV')) *  SIMDATA(M,'SVNK','MNGD','Y'))) /
         SUM(M,  KJRAAVARE(M));

*
PARAMETER CK_BAS Anleggskostnader foredling i basisaaret;
CK_BAS = SUM((M,FSLK), (SLKDATA('LONN',FSLK) + SLKDATA('ANNT',FSLK)) * SIMDATA(M,FSLK,'MNGD','Y')) / SUM((M,FSLK), SIMDATA(M,FSLK,'MNGD','Y'));
*
SCALARS CFAS, CFBS;
CFBS = (DCS-1)*DM*CF_BAS*ZS_BAS/(1-DM);
CFAS = CF_BAS - CFBS/ZS_BAS;

*abort dcs, dm, cf_bas, zs_bas;


SCALARS CFAK, CFBK;
CFBK = (DCF-1)*DM*CK_BAS*ZK_BAS/(1-DM);
CFAK = CK_BAS - CFBK/ZK_BAS;
*
PARAMETER CTKALIB(M) Kalibrering av regional kjoerelengde;
CTKALIB('OEST') = 1;
CTKALIB('SOER') = 1;
CTKALIB('VEST') = 2;
CTKALIB('MIDT') = 1;
CTKALIB('NORD') = 2;
*
* Market regulation fee except regulation costs
* Source: slakterier.xlsx
OMSET('STFK') = 1.3148;
OMSET('KLVK') = 1.3148;
OMSET('SAUK') = 0.8741;
OMSET('GETK') = 0.8741;
OMSET('SVNK') = 0.9178;
*
* Projection market regulation fee to simulation year
OMSET(SLKINNVARE) = OMSET(SLKINNVARE) * (1 + KPI) ** (Y - %BAS%);
*
* Innfrakttilskudd
* Source: slakterier.xlsx
PARAMETER INNFRAKTTILKJOETT(R,VARE);
INNFRAKTTILKJOETT(R,'STFK')$R_TIL_M('OEST',R) = 0.4050;
INNFRAKTTILKJOETT(R,'STFK')$R_TIL_M('SOER',R) = 0.4007;
INNFRAKTTILKJOETT(R,'STFK')$R_TIL_M('VEST',R) = 1.2812;
INNFRAKTTILKJOETT(R,'STFK')$R_TIL_M('MIDT',R) = 1.3167;
INNFRAKTTILKJOETT(R,'STFK')$R_TIL_M('NORD',R) = 1.5543;

INNFRAKTTILKJOETT(R,'KLVK') = INNFRAKTTILKJOETT(R,'STFK');

INNFRAKTTILKJOETT(R,'SVNK')$R_TIL_M('OEST',R) = 0.1962;
INNFRAKTTILKJOETT(R,'SVNK')$R_TIL_M('SOER',R) = 0.2302;
INNFRAKTTILKJOETT(R,'SVNK')$R_TIL_M('VEST',R) = 0.6456;
INNFRAKTTILKJOETT(R,'SVNK')$R_TIL_M('MIDT',R) = 0.8677;
INNFRAKTTILKJOETT(R,'SVNK')$R_TIL_M('NORD',R) = 2.0452;

INNFRAKTTILKJOETT(R,'SAUK')$R_TIL_M('OEST',R) = 0.4440;
INNFRAKTTILKJOETT(R,'SAUK')$R_TIL_M('SOER',R) = 0.4273;
INNFRAKTTILKJOETT(R,'SAUK')$R_TIL_M('VEST',R) = 0.9572;
INNFRAKTTILKJOETT(R,'SAUK')$R_TIL_M('MIDT',R) = 0.6983;
INNFRAKTTILKJOETT(R,'SAUK')$R_TIL_M('NORD',R) = 0.8905;

INNFRAKTTILKJOETT(R,'GETK') = INNFRAKTTILKJOETT(R,'SAUK');
*
*
PARAMETER IU(FP);
IU('SLST') = 5 * (1 + KPI) ** (Y - %BAS%);
IU('SLSA') = 5 * (1 + KPI) ** (Y - %BAS%);
IU('SLSV') = -15 * (1 + KPI) ** (Y - %BAS%);

IU('SLST') = 0 * (1 + KPI) ** (Y - %BAS%);
IU('SLSA') = 0 * (1 + KPI) ** (Y - %BAS%);
IU('SLSV') = 0 * (1 + KPI) ** (Y - %BAS%);


