************************************************************************
*
*   Jordmod og klima: Del av C-scape 20010-2014
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Parametre for klimagassutslipp og miljoindikatorer
*   Kommentarer: Basert paa IG, 26 jan 11, KMi
*   Status:
************************************************************************
*
*
** CH4 (enteric fermentation)
* Melkekyr: egen funksjon i tilbudsmodellen med parametre avhengig av ytelse og grovforandel
PARAMETER CH4EN(PRDK)  Metan kg per dyr per aar enteric fermentation
* Dokumentasjon av utslippsberegning
* Utslipp fra ungpurke/r�ne legges til purke
/
*AKYR    109.96
* endret iflg samtale med PAS
AKYR    86
OKSS    54.72
KVGS    54.72
KVGO    54.72
OKKS    54.72
KVKS    54.72
KVKO    54.72
GRIS    1.5
PURK    1.81
SOEY    14.075
LAMS    4.471
GEIT    13
* Fjoerfe angitt i 1000 dyr
HOEN    20
KYLS    3.6
/;
*
* Korrige for levealder storfe og lam
CH4EN('OKSS') = CH4EN('OKSS') * 18.1/12;
CH4EN('KVGS') = CH4EN('KVGS') * 22.8/12;
CH4EN('OKKS') = CH4EN('OKKS') * 7.52/12;
CH4EN('KVKS') = CH4EN('KVKS') * 8.18/12;
CH4EN('LAMS') = CH4EN('LAMS') * 143/365;
*
* Omregne fra griseplass til slaktegris
CH4EN('GRIS') = CH4EN('GRIS') * .495;
CH4EN('KYLS') = CH4EN('KYLS') * .185;
*
* Source: NIR 2025
Table ScaleCH4EN(PRDK,*)
        upp   val   low  zer
AKYR    1.2   1     .8   1
OKSS    1.25  1     .75  1
KVGS    1.25  1     .75  1
KVGO    1.25  1     .75  1
OKKS    1.25  1     .75  1
KVKS    1.25  1     .75  1
KVKO    1.25  1     .75  1
GRIS    1.4   1     .6   1
PURK    1.4   1     .6   1
SOEY    1.25  1     .75  1
LAMS    1.25  1     .75  1
GEIT    1.4   1     .6   1
HOEN    1.4   1     .6   1
KYLS    1.4   1     .6   1
;

* Uncertainty of emission factor
$if %SCEN%==PHuppESupp CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'upp') ;
$if %SCEN%==PHuppESval CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==PHuppESlow CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'low') ;
$if %SCEN%==PHuppES0   CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'zer') ;
$if %SCEN%==PHvalESupp CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'upp') ;
$if %SCEN%==PHvalESval CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==PHvalESlow CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'low') ;
$if %SCEN%==PHvalES0   CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'zer') ;
$if %SCEN%==PHlowESupp CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'upp') ;
$if %SCEN%==PHlowESval CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==PHlowESlow CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'low') ;
$if %SCEN%==PHlowES0   CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'zer') ;
$if %SCEN%==PH0ESupp   CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'upp') ;
$if %SCEN%==PH0ESval   CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==PH0ESlow   CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'low') ;
$if %SCEN%==PH0ES0     CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'zer') ;
$if %SCEN%==PH0ES0H     CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'upp') ;
$if %SCEN%==PH0ES0L     CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'low') ;
*
$if %SCEN%==SensESS CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensVSL CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensDUp CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensDLo CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensLUC CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensCPUp CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensCPLo CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;

$if %SCEN%==SensEXT CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensPay CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensPD  CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensFS  CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;
$if %SCEN%==SensZP  CH4EN(PRDK) = CH4EN(PRDK) * ScaleCH4EN(PRDK,'val') ;

PARAMETER CH4MM(PRDK)  Metan kg per dyr per aar manure management
* Dokumentasjon av utslippsberegning
* Utslipp fra ungpurke/r�ne legges til purke
* Storfe: CFR 2014, table 3Ba
* Rest: Sandmo et al. 2016 Table 6.14 & 6.15
/
AKYR   7.63242885349284
OKSS   4.10735805597398
KVGS   4.10735805597398
KVGO   4.10735805597398
OKKS   4.10735805597398
KVKS   4.10735805597398
SOEY   0.1899999999708
LAMS   0.1899999999708
GEIT   0.13
GRIS   3.5
PURK   11.63
* Fjoerfe angitt i 1000 dyr
HOEN   46
KYLS   13
/;
* Korrige for levealder storfe og lam
CH4MM('OKSS') = CH4MM('OKSS') * 18.1/12;
CH4MM('KVGS') = CH4MM('KVGS') * 22.8/12;
CH4MM('OKKS') = CH4MM('OKKS') * 7.52/12;
CH4MM('KVKS') = CH4MM('KVKS') * 8.18/12;
CH4MM('LAMS') = CH4MM('LAMS') * 143/365;
*
* Omregne fra griseplass til slaktegris
CH4MM('GRIS') = CH4MM('GRIS') * .495;
CH4MM('KYLS') = CH4MM('KYLS') * .185;

* Source: NIR 2025
Parameter ScaleCH4MM(PRDK,*);
ScaleCH4MM(PRDK,'upp') = CH4MM(PRDK) * 1.2;
ScaleCH4MM(PRDK,'val') = CH4MM(PRDK) * 1;
ScaleCH4MM(PRDK,'low') = CH4MM(PRDK) * 0.8;
ScaleCH4MM(PRDK,'zer') = CH4MM(PRDK) * 1;
*
* Uncertainty of emission factor
$if %SCEN%==PHuppESupp CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'upp') ;
$if %SCEN%==PHuppESval CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==PHuppESlow CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'low') ;
$if %SCEN%==PHuppES0   CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'zer') ;
$if %SCEN%==PHvalESupp CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'upp') ;
$if %SCEN%==PHvalESval CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==PHvalESlow CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'low') ;
$if %SCEN%==PHvalES0   CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'zer') ;
$if %SCEN%==PHlowESupp CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'upp') ;
$if %SCEN%==PHlowESval CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==PHlowESlow CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'low') ;
$if %SCEN%==PHlowES0   CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'zer') ;
$if %SCEN%==PH0ESupp   CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'upp') ;
$if %SCEN%==PH0ESval   CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==PH0ESlow   CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'low') ;
$if %SCEN%==PH0ES0     CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'zer') ;
$if %SCEN%==PH0ES0H     CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'upp') ;
$if %SCEN%==PH0ES0L     CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'low') ;
*
$if %SCEN%==SensESS CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensVSL CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensDUp CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensDLo CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensLUC CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensCPUp CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensCPLo CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;

$if %SCEN%==SensEXT CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensPay CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensPD  CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensFS  CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;
$if %SCEN%==SensZP  CH4MM(PRDK) = CH4MM(PRDK) * ScaleCH4MM(PRDK,'val') ;



* Uncertainty in emission factor enteric fermentation for dairy cows applied in the supply model
* Source: NIR 2025
Scalar EFCH4ENDairy;
Parameter ScaleCH4ENDairy(*);
ScaleCH4ENDairy('upp') = 1.28;
ScaleCH4ENDairy('val') = 1;
ScaleCH4ENDairy('low') = 0.72;
ScaleCH4ENDairy('zer') = 1;
*
EFCH4ENDairy = ScaleCH4ENDairy('val') ;


* Uncertainty of emission factor
$if %SCEN%==PHuppESupp EFCH4ENDairy = ScaleCH4ENDairy('upp') ;
$if %SCEN%==PHuppESval EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==PHuppESlow EFCH4ENDairy = ScaleCH4ENDairy('low') ;
$if %SCEN%==PHuppES0   EFCH4ENDairy = ScaleCH4ENDairy('zer') ;
$if %SCEN%==PHvalESupp EFCH4ENDairy = ScaleCH4ENDairy('upp') ;
$if %SCEN%==PHvalESval EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==PHvalESlow EFCH4ENDairy = ScaleCH4ENDairy('low') ;
$if %SCEN%==PHvalES0   EFCH4ENDairy = ScaleCH4ENDairy('zer') ;
$if %SCEN%==PHlowESupp EFCH4ENDairy = ScaleCH4ENDairy('upp') ;
$if %SCEN%==PHlowESval EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==PHlowESlow EFCH4ENDairy = ScaleCH4ENDairy('low') ;
$if %SCEN%==PHlowES0   EFCH4ENDairy = ScaleCH4ENDairy('zer') ;
$if %SCEN%==PH0ESupp   EFCH4ENDairy = ScaleCH4ENDairy('upp') ;
$if %SCEN%==PH0ESval   EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==PH0ESlow   EFCH4ENDairy = ScaleCH4ENDairy('low') ;
$if %SCEN%==PH0ES0     EFCH4ENDairy = ScaleCH4ENDairy('zer') ;
$if %SCEN%==PH0ES0H     EFCH4ENDairy = ScaleCH4ENDairy('upp') ;
$if %SCEN%==PH0ES0L     EFCH4ENDairy = ScaleCH4ENDairy('low') ;
*
$if %SCEN%==SensESS EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensVSL EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensDUp EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensDLo EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensLUC EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensCPUp EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensCPLo EFCH4ENDairy = ScaleCH4ENDairy('val') ;

$if %SCEN%==SensEXT EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensPay EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensPD  EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensFS  EFCH4ENDairy = ScaleCH4ENDairy('val') ;
$if %SCEN%==SensZP  EFCH4ENDairy = ScaleCH4ENDairy('val') ;

* Dette er innsatsfaktorer som ikke har kostnader derfor null pris
DATA(R,'ch4e','TOTP','BAS')   = 0;
DATA(R,'ch4m','TOTP','BAS')   = 0;
DATA(R,'ch4b','TOTP','BAS')   = 0;
DATA(R,'n2omm','TOTP','BAS')  = 0;
DATA(R,'n2oar','TOTP','BAS')  = 0;
DATA(R,'nh3','TOTP','BAS')    = 0;
DATA(R,'ge','TOTP','BAS')     = 0;
DATA(R,'ym','TOTP','BAS')     = 0;
DATA(R,'VSdm','TOTP','BAS')   = 0;
DATA(R,'SM','TOTP','BAS')     = 0;

*  Kilde for sau, gris og fj�rfe: Karlengen et al 2012 Husdyrgj�dsel normer for mengde gj�dsel og utskillelse av nitrogen fosfor og kalium
*  Kilde for storfe og geit: UNFCCC 2017 tabell 3.F
TABLE BRUTTODYRGJOEDSEL(PRDK,VARE) Brutto husdyrgjoedsel i kg naeringsstoff pr dyr og aar
         NITH   FOSH    KALH
MKYR     126.61 14.1    99.5
AKYR     64.52  7.8     89.6
OKSS     42.50  7.2     59.3
KVGS     42.50  10.3    85.0
KVGO     42.50  10.3    85.0
OKKS     42.50
KVKS     42.50
GRIS     3.2    0.51
PURK     34.29  4.47
SOEY     11.6   2
LAMS     7.7
GEIT     13.47  2
* Fjoerfe angitt i 1000 dyr
HOEN     669.8  157.2
KYLS     29.7   6.3
;
* Korrige for levealder storfe
BRUTTODYRGJOEDSEL('OKSS',VARE) = BRUTTODYRGJOEDSEL('OKSS',VARE) * 18.1/12;
BRUTTODYRGJOEDSEL('KVGS',VARE) = BRUTTODYRGJOEDSEL('KVGS',VARE) * 22.8/12;
BRUTTODYRGJOEDSEL('OKKS',VARE) = BRUTTODYRGJOEDSEL('OKKS',VARE) * 7.52/12;
BRUTTODYRGJOEDSEL('KVKS',VARE) = BRUTTODYRGJOEDSEL('KVKS',VARE) * 8.18/12;
*
PARAMETER B0,MCP,virksomtNprVS,virksomtPprVS,virksomtKprVS;
* Kilde: NI 2016, s. 173 table 6.8
B0  =  0.23;
* Kilde: Modelldokumentasjon, implisitt beregnet
MCP =  0.0002564 ;
* Kilde: VSDM fra NI 2016, s. 173 table 6.8
virksomtNprVS    =  BRUTTODYRGJOEDSEL('MKYR','NITH')/1522;
virksomtPprVS    =  BRUTTODYRGJOEDSEL('MKYR','FOSH')/1522;
virksomtKprVS    =  BRUTTODYRGJOEDSEL('MKYR','KALH')/1522;

* Uncertainty in emission factor manure management for dairy cows applied to BO
* Source: NIR 2025
Parameter ScaleB0(*);
ScaleB0('upp') = 1.28;
ScaleB0('val') = 1;
ScaleB0('low') = 0.72;
ScaleB0('zer') = 1;
*
* Uncertainty of emission factor
$if %SCEN%==PHuppESupp B0 = B0 * ScaleB0('upp') ;
$if %SCEN%==PHuppESval B0 = B0 * ScaleB0('val') ;
$if %SCEN%==PHuppESlow B0 = B0 * ScaleB0('low') ;
$if %SCEN%==PHuppES0   B0 = B0 * ScaleB0('zer') ;
$if %SCEN%==PHvalESupp B0 = B0 * ScaleB0('upp') ;
$if %SCEN%==PHvalESval B0 = B0 * ScaleB0('val') ;
$if %SCEN%==PHvalESlow B0 = B0 * ScaleB0('low') ;
$if %SCEN%==PHvalES0   B0 = B0 * ScaleB0('zer') ;
$if %SCEN%==PHlowESupp B0 = B0 * ScaleB0('upp') ;
$if %SCEN%==PHlowESval B0 = B0 * ScaleB0('val') ;
$if %SCEN%==PHlowESlow B0 = B0 * ScaleB0('low') ;
$if %SCEN%==PHlowES0   B0 = B0 * ScaleB0('zer') ;
$if %SCEN%==PH0ESupp   B0 = B0 * ScaleB0('upp') ;
$if %SCEN%==PH0ESval   B0 = B0 * ScaleB0('val') ;
$if %SCEN%==PH0ESlow   B0 = B0 * ScaleB0('low') ;
$if %SCEN%==PH0ES0     B0 = B0 * ScaleB0('val') ;
$if %SCEN%==PH0ES0H     B0 = B0 * ScaleB0('upp') ;
$if %SCEN%==PH0ES0L     B0 = B0 * ScaleB0('low') ;
*
$if %SCEN%==SensESS B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensVSL B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensDUp B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensDLo B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensLUC B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensCPUp B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensCPLo B0 = B0 * ScaleB0('val') ;

$if %SCEN%==SensEXT B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensPay B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensPD  B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensFS  B0 = B0 * ScaleB0('val') ;
$if %SCEN%==SensZP  B0 = B0 * ScaleB0('val') ;
*
* Binding av CO2 (kg CO2-ekv. per daa)
* Kilde: Mittenzwei og Prestvik, fulldyrket og overflatedyrket
PARAMETER SINK(PLANTE) /
GFFS    24.1612
GFFB    24.1612
GFOS    24.1612
GFOB    24.1612
GFIB    24.1612
EPLE    24.1612
/;
*
* Utslipp av CO2 (kg CO2-ekv. per daa)
* Kilde: Mittenzwei og Prestvik, fulldyrket og overflatedyrket
PARAMETER SOURCE(PLANTE) /
HVEM   207.294
HVEF   207.294
RUGM   207.294
RUGF   207.294
BYGM   207.294
BYGF   207.294
HAVM   207.294
HAVF   207.294
AKRM   207.294
AKRF   207.294
RAPM   207.294
RAPF   207.294
ERTM   207.294
ERTF   207.294
POTE   207.294
GRNV   207.294
GRNF   207.294
AFRU   207.294
/;

*
* Settes til null her siden det er brukt annen klimaavgift
SINK(PLANTE) = 0;
SOURCE(PLANTE) = 0;
*
* Skalering til observerte verdier
ENHDATA(R,'CO2SINK',PLANTE,'BAS')   = SINK(PLANTE)   * .275;
ENHDATA(R,'CO2SOUR',PLANTE,'BAS')   = SOURCE(PLANTE) * .275;
ENHDATA(R,'CO2SINK',PLANTE,'Y')     = ENHDATA(R,'CO2SINK',PLANTE,'BAS');
ENHDATA(R,'CO2SOUR',PLANTE,'Y')     = ENHDATA(R,'CO2SOUR',PLANTE,'BAS');
*
*Kilde: Klimagasskalkulator versjon 16. august 2017 koeffisienter! b177:b178
*TABLE EFn2omm(*,PRDK)
*        MKYR AKYR OKSS KVGS KVGO GEIT SOEY LAMS
*BEITE    .02  .02  .02  .02  .02  .01  .01  .01
*;
* Kilde: Implisitt fra Table 3B(b)
PARAMETER EFN2OMM(PRDK) kg N2O per kg N
/
MKYR 0.006497046
AKYR 0.010419843
OKSS 0.007449334
KVGS 0.007449334
KVGO 0.007449334
OKKS 0.007449334
KVKS 0.007449334
SOEY 0.007467175
PURK 0.006851666
GRIS 0.006851666
GEIT 0.016602815
HOEN 0.001571429
KYLS 0.001571429
/;
* Korrige for levealder storfe
EFN2OMM('OKSS') = EFN2OMM('OKSS') * 18.1/12;
EFN2OMM('KVGS') = EFN2OMM('KVGS') * 22.8/12;
EFN2OMM('OKKS') = EFN2OMM('OKKS') * 7.52/12;
EFN2OMM('KVKS') = EFN2OMM('KVKS') * 8.18/12;
EFN2OMM('LAMS') = EFN2OMM('LAMS') * 143/365;
*
* Omregne fra griseplass til slaktegris
EFN2OMM('GRIS') = EFN2OMM('GRIS') * .495;
EFN2OMM('KYLS') = EFN2OMM('KYLS') * .185;
*
* Uncertainty in emission factor
* Source: NIR 2025
Parameter ScaleEFN2OMM(*);
ScaleEFN2OMM('upp') = 2;
ScaleEFN2OMM('val') = 1;
ScaleEFN2OMM('low') = 0.5;
ScaleEFN2OMM('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('upp') ;
$if %SCEN%==PHuppESval EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==PHuppESlow EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('low') ;
$if %SCEN%==PHuppES0   EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('zer') ;
$if %SCEN%==PHvalESupp EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('upp') ;
$if %SCEN%==PHvalESval EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==PHvalESlow EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('low') ;
$if %SCEN%==PHvalES0   EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('zer') ;
$if %SCEN%==PHlowESupp EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('upp') ;
$if %SCEN%==PHlowESval EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==PHlowESlow EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('low') ;
$if %SCEN%==PHlowES0   EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('zer') ;
$if %SCEN%==PH0ESupp   EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('upp') ;
$if %SCEN%==PH0ESval   EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==PH0ESlow   EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('low') ;
$if %SCEN%==PH0ES0     EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('zer') ;
$if %SCEN%==PH0ES0H     EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('upp') ;
$if %SCEN%==PH0ES0L     EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('low') ;
*
$if %SCEN%==SensESS EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensVSL EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensDUp EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensDLo EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensLUC EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensCPUp EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensCPLo EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;

$if %SCEN%==SensEXT EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensPay EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensPD  EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensFS  EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;
$if %SCEN%==SensZP  EFN2OMM(PRDK) = EFN2OMM(PRDK) * ScaleEFN2OMM('val') ;



PARAMETER ANDELMYR(R) Andel myr til beregning av lystgass fra myr
/
011101     0.01
021101     0.01
021103     0.01
041203     0.01
041101     0.01
04125A     0.01
051103     0.02
05125A     0.02
061101     0.02
06125A     0.02
071101     0.02
081103     0.02
08125A     0.02
081203     0.02
09225A     0.02
10225A     0.02
11225B     0.02
112102     0.02
112203     0.02
11215B     0.02
12325B     0.03
14325B     0.18
15325B     0.18
164104     0.18
16425A     0.18
164204     0.18
174104     0.17
17425A     0.17
185206     0.12
195206     0.05
195207     0.05
205207     0.05
/;


* Enhet: Andel N2O-N av total N
* Kilde: CRF Norway tabell 3D
SCALAR EFN2OM Husdyrgj�dsel tilf�rt �ker og eng i kg N2O-N per kg N /0.01000000018203/
       EFN2OS Handelsgj�dsel tilf�rt jord i kg N2O-N per kg N /0.01000568266788/
       EFN2OB Husdyrgj�dsel tilf�rt beite i kg N2O-N per kg N /0.01603854876018/
       EFN2ONH3NED Indirekte utslipp nedfall ammoniak spredning gj�dsel i kg N2O-N per kg N /0.00999985312346/
       EFN2ONH3AVR Indirekte utslipp avrenning spredning dyrgj�dsel i kg N2O-N per kg N /0.00749999981843/
       FRACGASM  Andel husdyrgj�dsel som volaterer til NH3   /0.208770321952/
       FRACAVR   Andel N tapt til avrenning                 /0.22/
       FRACGASF  Andel handelsgj�dsel som volaterer til NH3  / 0.02743493439272 /

* Kilde: CRF Norway tabell 3B(b)
       EFN2ONH3MMNED  Indirekte utslipp nedfall gj�dselh�ndtering i kg N2O-N per kg N   /0.01571428600808/
       EFN2ONH3MMAVR  Indirekte utslipp avrenning gj�dselh�ndtering i kg N2O-N per kg N /0.01178571398682/
       FRACMMNED Andel husdyrgj�dsel som volaterer til NH3 ved gj�dselh�ndtering /0.06089667 /
       FRACMMAVR Andel husdyrgj�dsel som avrenner ved gj�dselh�ndtering /0.035660571 /

       EFCO2KALK  Utslipp kalking i t CO2-C per t C  / 0.12 /

* Kilde: klimagassutslipp utslippsregnskap.xlsx ark! N2O_Restavling
       EFN2OAVL Direkte utslipp fra restavling i kg N20-N per kg N                    /0.01000000017937/
       FRACAVL Andel N i restavling                                                   / 0.078264673 /
* Kilde: CRF Norway 2014 Table 3.F Field burning of agricultural residue
       DRMCERE  Dry matter fraction of residue                                        / 0.85/
       FRACCEREBRN  Fraction burned in fields                                         / 0.04 /
       EFCH4BRN Utslipp av metan ved brenning av restavling i kg per kt dm            /0.0027/
       EFN2OBRN Utslipp av lystgass ved brenning av restavling i kg per kt dm         /0.00006999999949897/
       EFN2OMYR Utslipp av lystgass fra myr i kg N2O-N per daa                        /1.28156894684077/
;

* Uncertainty in emission factor
* Source: NIR 2025
Parameter ScaleEFN2OM(*);
ScaleEFN2OM('upp') = 1.3;
ScaleEFN2OM('val') = 1;
ScaleEFN2OM('low') = 0.7;
ScaleEFN2OM('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2OM = EFN2OM * ScaleEFN2OM('upp') ;
$if %SCEN%==PHuppESval EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==PHuppESlow EFN2OM = EFN2OM * ScaleEFN2OM('low') ;
$if %SCEN%==PHuppES0   EFN2OM = EFN2OM * ScaleEFN2OM('zer') ;
$if %SCEN%==PHvalESupp EFN2OM = EFN2OM * ScaleEFN2OM('upp') ;
$if %SCEN%==PHvalESval EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==PHvalESlow EFN2OM = EFN2OM * ScaleEFN2OM('low') ;
$if %SCEN%==PHvalES0   EFN2OM = EFN2OM * ScaleEFN2OM('zer') ;
$if %SCEN%==PHlowESupp EFN2OM = EFN2OM * ScaleEFN2OM('upp') ;
$if %SCEN%==PHlowESval EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==PHlowESlow EFN2OM = EFN2OM * ScaleEFN2OM('low') ;
$if %SCEN%==PHlowES0   EFN2OM = EFN2OM * ScaleEFN2OM('zer') ;
$if %SCEN%==PH0ESupp   EFN2OM = EFN2OM * ScaleEFN2OM('upp') ;
$if %SCEN%==PH0ESval   EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==PH0ESlow   EFN2OM = EFN2OM * ScaleEFN2OM('low') ;
$if %SCEN%==PH0ES0     EFN2OM = EFN2OM * ScaleEFN2OM('zer') ;
$if %SCEN%==PH0ES0H     EFN2OM = EFN2OM * ScaleEFN2OM('upp') ;
$if %SCEN%==PH0ES0L     EFN2OM = EFN2OM * ScaleEFN2OM('low') ;
*
$if %SCEN%==SensESS EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensVSL EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensDUp EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensDLo EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensLUC EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensCPUp EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensCPLo EFN2OM = EFN2OM * ScaleEFN2OM('val') ;

$if %SCEN%==SensEXT EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensPay EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensPD  EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensFS  EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
$if %SCEN%==SensZP  EFN2OM = EFN2OM * ScaleEFN2OM('val') ;
                        


* Uncertainty in emission factor
* Source: NIR 2025
Parameter ScaleEFN2OS(*);
ScaleEFN2OS('upp') = 1.2;
ScaleEFN2OS('val') = 1;
ScaleEFN2OS('low') = 0.8;
ScaleEFN2OS('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2OS = EFN2OS * ScaleEFN2OS('upp') ;
$if %SCEN%==PHuppESval EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==PHuppESlow EFN2OS = EFN2OS * ScaleEFN2OS('low') ;
$if %SCEN%==PHuppES0   EFN2OS = EFN2OS * ScaleEFN2OS('zer') ;
$if %SCEN%==PHvalESupp EFN2OS = EFN2OS * ScaleEFN2OS('upp') ;
$if %SCEN%==PHvalESval EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==PHvalESlow EFN2OS = EFN2OS * ScaleEFN2OS('low') ;
$if %SCEN%==PHvalES0   EFN2OS = EFN2OS * ScaleEFN2OS('zer') ;
$if %SCEN%==PHlowESupp EFN2OS = EFN2OS * ScaleEFN2OS('upp') ;
$if %SCEN%==PHlowESval EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==PHlowESlow EFN2OS = EFN2OS * ScaleEFN2OS('low') ;
$if %SCEN%==PHlowES0   EFN2OS = EFN2OS * ScaleEFN2OS('zer') ;
$if %SCEN%==PH0ESupp   EFN2OS = EFN2OS * ScaleEFN2OS('upp') ;
$if %SCEN%==PH0ESval   EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==PH0ESlow   EFN2OS = EFN2OS * ScaleEFN2OS('low') ;
$if %SCEN%==PH0ES0     EFN2OS = EFN2OS * ScaleEFN2OS('zer') ;
$if %SCEN%==PH0ES0H     EFN2OS = EFN2OS * ScaleEFN2OS('upp') ;
$if %SCEN%==PH0ES0L     EFN2OS = EFN2OS * ScaleEFN2OS('low') ;
*
$if %SCEN%==SensESS EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensVSL EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensDUp EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensDLo EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensLUC EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensCPUp EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensCPLo EFN2OS = EFN2OS * ScaleEFN2OS('val') ;

$if %SCEN%==SensEXT EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensPay EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensPD  EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensFS  EFN2OS = EFN2OS * ScaleEFN2OS('val') ;
$if %SCEN%==SensZP  EFN2OS = EFN2OS * ScaleEFN2OS('val') ;

* Uncertainty in emission factor
* Source: NIR 2025
Parameter ScaleEFN2OB(*);
ScaleEFN2OB('upp') = 1.3;
ScaleEFN2OB('val') = 1;
ScaleEFN2OB('low') = 0.7;
ScaleEFN2OB('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2OB = EFN2OB * ScaleEFN2OB('upp') ;
$if %SCEN%==PHuppESval EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==PHuppESlow EFN2OB = EFN2OB * ScaleEFN2OB('low') ;
$if %SCEN%==PHuppES0   EFN2OB = EFN2OB * ScaleEFN2OB('zer') ;
$if %SCEN%==PHvalESupp EFN2OB = EFN2OB * ScaleEFN2OB('upp') ;
$if %SCEN%==PHvalESval EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==PHvalESlow EFN2OB = EFN2OB * ScaleEFN2OB('low') ;
$if %SCEN%==PHvalES0   EFN2OB = EFN2OB * ScaleEFN2OB('zer') ;
$if %SCEN%==PHlowESupp EFN2OB = EFN2OB * ScaleEFN2OB('upp') ;
$if %SCEN%==PHlowESval EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==PHlowESlow EFN2OB = EFN2OB * ScaleEFN2OB('low') ;
$if %SCEN%==PHlowES0   EFN2OB = EFN2OB * ScaleEFN2OB('zer') ;
$if %SCEN%==PH0ESupp   EFN2OB = EFN2OB * ScaleEFN2OB('upp') ;
$if %SCEN%==PH0ESval   EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==PH0ESlow   EFN2OB = EFN2OB * ScaleEFN2OB('low') ;
$if %SCEN%==PH0ES0     EFN2OB = EFN2OB * ScaleEFN2OB('zer') ;
$if %SCEN%==PH0ES0H     EFN2OB = EFN2OB * ScaleEFN2OB('upp') ;
$if %SCEN%==PH0ES0L     EFN2OB = EFN2OB * ScaleEFN2OB('low') ;
*
$if %SCEN%==SensESS EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensVSL EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensDUp EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensDLo EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensLUC EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensCPUp EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensCPLo EFN2OB = EFN2OB * ScaleEFN2OB('val') ;

$if %SCEN%==SensEXT EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensPay EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensPD  EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensFS  EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
$if %SCEN%==SensZP  EFN2OB = EFN2OB * ScaleEFN2OB('val') ;
            
 
* Uncertainty in emission factor
* Source: NIR 2025
Parameter ScaleEFN2ONH3NED(*);
ScaleEFN2ONH3NED('upp') = 1.2;
ScaleEFN2ONH3NED('val') = 1;
ScaleEFN2ONH3NED('low') = 0.8;
ScaleEFN2ONH3NED('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('upp') ;
$if %SCEN%==PHuppESval EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==PHuppESlow EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('low') ;
$if %SCEN%==PHuppES0   EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('zer') ;
$if %SCEN%==PHvalESupp EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('upp') ;
$if %SCEN%==PHvalESval EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==PHvalESlow EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('low') ;
$if %SCEN%==PHvalES0   EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('zer') ;
$if %SCEN%==PHlowESupp EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('upp') ;
$if %SCEN%==PHlowESval EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==PHlowESlow EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('low') ;
$if %SCEN%==PHlowES0   EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('zer') ;
$if %SCEN%==PH0ESupp   EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('upp') ;
$if %SCEN%==PH0ESval   EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==PH0ESlow   EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('low') ;
$if %SCEN%==PH0ES0     EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('zer') ;
$if %SCEN%==PH0ES0H     EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('upp') ;
$if %SCEN%==PH0ES0L     EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('low') ;
*
$if %SCEN%==SensESS EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==SensVSL EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==SensDUp EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==SensDLo EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==SensLUC EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;

$if %SCEN%==SensEXT EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==SensPay EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==SensPD  EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==SensFS  EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;
$if %SCEN%==SensZP  EFN2ONH3NED = EFN2ONH3NED * ScaleEFN2ONH3NED('val') ;





* Uncertainty in emission factor
* Source: NIR 2025
Parameter ScaleEFN2ONH3MMNED(*);
ScaleEFN2ONH3MMNED('upp') = 1.2;
ScaleEFN2ONH3MMNED('val') = 1;
ScaleEFN2ONH3MMNED('low') = 0.8;
ScaleEFN2ONH3MMNED('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('upp') ;
$if %SCEN%==PHuppESval EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==PHuppESlow EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('low') ;
$if %SCEN%==PHuppES0   EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('zer') ;
$if %SCEN%==PHvalESupp EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('upp') ;
$if %SCEN%==PHvalESval EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==PHvalESlow EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('low') ;
$if %SCEN%==PHvalES0   EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('zer') ;
$if %SCEN%==PHlowESupp EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('upp') ;
$if %SCEN%==PHlowESval EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==PHlowESlow EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('low') ;
$if %SCEN%==PHlowES0   EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('zer') ;
$if %SCEN%==PH0ESupp   EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('upp') ;
$if %SCEN%==PH0ESval   EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==PH0ESlow   EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('low') ;
$if %SCEN%==PH0ES0     EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('zer') ;
$if %SCEN%==PH0ES0H     EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('upp') ;
$if %SCEN%==PH0ES0L     EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('low') ;
*
$if %SCEN%==SensESS EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensVSL EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensDUp EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensDLo EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensLUC EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensCPUp EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensCPLo EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;

$if %SCEN%==SensEXT EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensPay EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensPD  EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensFS  EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;
$if %SCEN%==SensZP  EFN2ONH3MMNED = EFN2ONH3MMNED * ScaleEFN2ONH3MMNED('val') ;


* Uncertainty in emission factor
* Source: NIR 2025
Parameter ScaleEFN2ONH3AVR(*);
ScaleEFN2ONH3AVR('upp') = 1.3;
ScaleEFN2ONH3AVR('val') = 1;
ScaleEFN2ONH3AVR('low') = 0.7;
ScaleEFN2ONH3AVR('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('upp') ;
$if %SCEN%==PHuppESval EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==PHuppESlow EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('low') ;
$if %SCEN%==PHuppES0   EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('zer') ;
$if %SCEN%==PHvalESupp EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('upp') ;
$if %SCEN%==PHvalESval EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==PHvalESlow EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('low') ;
$if %SCEN%==PHvalES0   EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('zer') ;
$if %SCEN%==PHlowESupp EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('upp') ;
$if %SCEN%==PHlowESval EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==PHlowESlow EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('low') ;
$if %SCEN%==PHlowES0   EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('zer') ;
$if %SCEN%==PH0ESupp   EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('upp') ;
$if %SCEN%==PH0ESval   EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==PH0ESlow   EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('low') ;
$if %SCEN%==PH0ES0     EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('zer') ;
$if %SCEN%==PH0ES0H     EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('upp') ;
$if %SCEN%==PH0ES0L     EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('low') ;
*
$if %SCEN%==SensESS EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensVSL EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensDUp EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensDLo EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensLUC EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensCPUp EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensCPLo EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;

$if %SCEN%==SensEXT EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensPay EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensPD  EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensFS  EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;
$if %SCEN%==SensZP  EFN2ONH3AVR = EFN2ONH3AVR * ScaleEFN2ONH3AVR('val') ;


* Uncertainty in emission factor
* Source: NIR 2025
Parameter ScaleEFN2ONH3MMAVR(*);
ScaleEFN2ONH3MMAVR('upp') = 1.3;
ScaleEFN2ONH3MMAVR('val') = 1;
ScaleEFN2ONH3MMAVR('low') = 0.7;
ScaleEFN2ONH3MMAVR('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('upp') ;
$if %SCEN%==PHuppESval EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==PHuppESlow EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('low') ;
$if %SCEN%==PHuppES0   EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('zer') ;
$if %SCEN%==PHvalESupp EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('upp') ;
$if %SCEN%==PHvalESval EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==PHvalESlow EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('low') ;
$if %SCEN%==PHvalES0   EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('zer') ;
$if %SCEN%==PHlowESupp EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('upp') ;
$if %SCEN%==PHlowESval EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==PHlowESlow EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('low') ;
$if %SCEN%==PHlowES0   EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('zer') ;
$if %SCEN%==PH0ESupp   EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('upp') ;
$if %SCEN%==PH0ESval   EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==PH0ESlow   EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('low') ;
$if %SCEN%==PH0ES0     EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('zer') ;
$if %SCEN%==PH0ES0H     EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('upp') ;
$if %SCEN%==PH0ES0L     EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('low') ;
*
$if %SCEN%==SensESS EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensVSL EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensDUp EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensDLo EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensLUC EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensCPUp EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensCPLo EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;

$if %SCEN%==SensEXT EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensPay EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensPD  EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensFS  EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;
$if %SCEN%==SensZP  EFN2ONH3MMAVR = EFN2ONH3MMAVR * ScaleEFN2ONH3MMAVR('val') ;


* Uncertainty in emission factor
* Source: NIR 2025, IPCC Source category 3F1
Parameter ScaleEFCH4BRN(*);
ScaleEFCH4BRN('upp') = 1.2;
ScaleEFCH4BRN('val') = 1;
ScaleEFCH4BRN('low') = 0.8;
ScaleEFCH4BRN('zer') = 1;
*
$if %SCEN%==PHuppESupp EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('upp') ;
$if %SCEN%==PHuppESval EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==PHuppESlow EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('low') ;
$if %SCEN%==PHuppES0   EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('zer') ;
$if %SCEN%==PHvalESupp EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('upp') ;
$if %SCEN%==PHvalESval EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==PHvalESlow EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('low') ;
$if %SCEN%==PHvalES0   EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('zer') ;
$if %SCEN%==PHlowESupp EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('upp') ;
$if %SCEN%==PHlowESval EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==PHlowESlow EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('low') ;
$if %SCEN%==PHlowES0   EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('zer') ;
$if %SCEN%==PH0ESupp   EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('upp') ;
$if %SCEN%==PH0ESval   EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==PH0ESlow   EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('low') ;
$if %SCEN%==PH0ES0     EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('zer') ;
$if %SCEN%==PH0ES0H     EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('upp') ;
$if %SCEN%==PH0ES0L     EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('low') ;
*
$if %SCEN%==SensESS EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensVSL EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensDUp EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensDLo EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensLUC EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensCPUp EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensCPLo EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;

$if %SCEN%==SensEXT EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensPay EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensPD  EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensFS  EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;
$if %SCEN%==SensZP  EFCH4BRN = EFCH4BRN * ScaleEFCH4BRN('val') ;



* Uncertainty in emission factor
* Source: NIR 2025, IPCC Source category 3F1
Parameter ScaleEFN2OBRN(*);
ScaleEFN2OBRN('upp') = 1.3;
ScaleEFN2OBRN('val') = 1;
ScaleEFN2OBRN('low') = 0.7;
ScaleEFN2OBRN('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('upp') ;
$if %SCEN%==PHuppESval EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==PHuppESlow EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('low') ;
$if %SCEN%==PHuppES0   EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('zer') ;
$if %SCEN%==PHvalESupp EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('upp') ;
$if %SCEN%==PHvalESval EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==PHvalESlow EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('low') ;
$if %SCEN%==PHvalES0   EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('zer') ;
$if %SCEN%==PHlowESupp EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('upp') ;
$if %SCEN%==PHlowESval EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==PHlowESlow EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('low') ;
$if %SCEN%==PHlowES0   EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('zer') ;
$if %SCEN%==PH0ESupp   EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('upp') ;
$if %SCEN%==PH0ESval   EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==PH0ESlow   EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('low') ;
$if %SCEN%==PH0ES0     EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('zer') ;
$if %SCEN%==PH0ES0H     EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('upp') ;
$if %SCEN%==PH0ES0L     EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('low') ;
*
$if %SCEN%==SensESS EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensVSL EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensDUp EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensDLo EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensLUC EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensCPUp EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensCPLo EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;

$if %SCEN%==SensEXT EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensPay EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensPD  EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensFS  EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;
$if %SCEN%==SensZP  EFN2OBRN = EFN2OBRN * ScaleEFN2OBRN('val') ;



* Uncertainty in emission factor
* Source: NIR 2025, 
Parameter ScaleEFN2OAVL(*);
ScaleEFN2OAVL('upp') = 2;
ScaleEFN2OAVL('val') = 1;
ScaleEFN2OAVL('low') = 0.5;
ScaleEFN2OAVL('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('upp') ;
$if %SCEN%==PHuppESval EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==PHuppESlow EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('low') ;
$if %SCEN%==PHuppES0   EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('zer') ;
$if %SCEN%==PHvalESupp EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('upp') ;
$if %SCEN%==PHvalESval EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==PHvalESlow EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('low') ;
$if %SCEN%==PHvalES0   EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('zer') ;
$if %SCEN%==PHlowESupp EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('upp') ;
$if %SCEN%==PHlowESval EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==PHlowESlow EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('low') ;
$if %SCEN%==PHlowES0   EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('zer') ;
$if %SCEN%==PH0ESupp   EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('upp') ;
$if %SCEN%==PH0ESval   EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==PH0ESlow   EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('low') ;
$if %SCEN%==PH0ES0     EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('zer') ;
$if %SCEN%==PH0ES0H     EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('upp') ;
$if %SCEN%==PH0ES0L     EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('low') ;
*
$if %SCEN%==SensESS EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensVSL EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensDUp EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensDLo EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensLUC EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensCPUp EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensCPLo EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;

$if %SCEN%==SensEXT EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensPay EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensPD  EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensFS  EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;
$if %SCEN%==SensZP  EFN2OAVL = EFN2OAVL * ScaleEFN2OAVL('val') ;



* Uncertainty in emission factor
* Source: NIR 2025, 3Da6
Parameter ScaleEFN2OMYR(*);
ScaleEFN2OMYR('upp') = 1.37;
ScaleEFN2OMYR('val') = 1;
ScaleEFN2OMYR('low') = 0.63;
ScaleEFN2OMYR('zer') = 1;
*
$if %SCEN%==PHuppESupp EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('upp') ;
$if %SCEN%==PHuppESval EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==PHuppESlow EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('low') ;
$if %SCEN%==PHuppES0   EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('zer') ;
$if %SCEN%==PHvalESupp EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('upp') ;
$if %SCEN%==PHvalESval EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==PHvalESlow EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('low') ;
$if %SCEN%==PHvalES0   EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('zer') ;
$if %SCEN%==PHlowESupp EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('upp') ;
$if %SCEN%==PHlowESval EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==PHlowESlow EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('low') ;
$if %SCEN%==PHlowES0   EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('zer') ;
$if %SCEN%==PH0ESupp   EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('upp') ;
$if %SCEN%==PH0ESval   EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==PH0ESlow   EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('low') ;
$if %SCEN%==PH0ES0     EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('zer') ;
$if %SCEN%==PH0ES0H     EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('upp') ;
$if %SCEN%==PH0ES0L     EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('low') ;
*
$if %SCEN%==SensESS EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensVSL EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensDUp EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensDLo EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensLUC EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensCPUp EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensCPLo EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;

$if %SCEN%==SensEXT EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensPay EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensPD  EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensFS  EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;
$if %SCEN%==SensZP  EFN2OMYR = EFN2OMYR * ScaleEFN2OMYR('val') ;


* Uncertainty in emission factor
* Source: NIR 2025, IPCC Source category 3G
Parameter ScaleEFCO2KALK(*);
ScaleEFCO2KALK('upp') = 1.1;
ScaleEFCO2KALK('val') = 1;
ScaleEFCO2KALK('low') = 0.9;
ScaleEFCO2KALK('zer') = 1;
*
$if %SCEN%==PHuppESupp EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('upp') ;
$if %SCEN%==PHuppESval EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==PHuppESlow EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('low') ;
$if %SCEN%==PHuppES0   EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('zer') ;
$if %SCEN%==PHvalESupp EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('upp') ;
$if %SCEN%==PHvalESval EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==PHvalESlow EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('low') ;
$if %SCEN%==PHvalES0   EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('zer') ;
$if %SCEN%==PHlowESupp EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('upp') ;
$if %SCEN%==PHlowESval EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==PHlowESlow EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('low') ;
$if %SCEN%==PHlowES0   EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('zer') ;
$if %SCEN%==PH0ESupp   EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('upp') ;
$if %SCEN%==PH0ESval   EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==PH0ESlow   EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('low') ;
$if %SCEN%==PH0ES0     EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('zer') ;
$if %SCEN%==PH0ES0H     EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('upp') ;
$if %SCEN%==PH0ES0L     EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('low') ;
*
$if %SCEN%==SensESS EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensVSL EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensDUp EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensDLo EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensLUC EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensCPUp EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensCPLo EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;

$if %SCEN%==SensEXT EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensPay EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensPD  EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensFS  EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;
$if %SCEN%==SensZP  EFCO2KALK = EFCO2KALK * ScaleEFCO2KALK('val') ;

* Utslipp klimagass for soya i kg utslipp pr kg soya
PARAMETER GHGMOELUTVARE(VARE)
/
CH4  -0.00002
N2O  0.0049
CO2  0.0631
/;
*
* Utslipp handelsgjoedsel kg utslipp pr kg naerstoff
TABLE GHGHGJOD(VARE,UTSLIPPGHG)
      CH4    N2O   CO2
NITG  0      .005  3
FOSG  0      0     0
KALG  0      0     0
;
*
* GHG potential av kemiske forbindelser i CO2-ekvivalenter
* Source: AR6 https://ghgprotocol.org/sites/default/files/2024-08/Global-Warming-Potential-Values%20%28August%202024%29.pdf
PARAMETER GHGPOTENSIAL(VARE)
/
CH4     27
N2O    273
CO2      1
/;

$if %GWP%==GWPStar GHGPOTENSIAL('CH4') = .25 * GHGPOTENSIAL('CH4');

* Utslipp av importert vare
* kg CO2 eqv pr kg vare
* Kilde: L082\...\Dokumentasjon\kalibrering.xls
* Forutsetning om klimagassutslipp gitt av oppdragsgiver
PARAMETER GHGXIPOT(VARE)
/
HVEM   0.485
HVEF   0.485
RUGM   0.485
RUGF   0.485
BYGM   0.485
BYGF   0.485
HAVM   0.485
HAVF   0.485
AKRM   0.485
AKRF   0.485
RAPM   0.485
RAPF   0.485
ERTM   0.485
ERTF   0.485
POTE   0.043
GRNV   0.019
GRNF   0.043
EPLE   0.023
AFRU   0.039
BLOM   0.020
KMLK   1.170
GMLK   1.170
STFK  14.789
KLVK  14.789
SVNK   3.059
SAUK  28.709
FJRK   2.279
KHEL   2.279
KFIL   2.279
KANT   2.279
EGGS   0.927
/;

*
* GHG potential for foredlede importerte varer leses inn under de respektive filen
PARAMETER A0(R,PRDK);
PARAMETER A1(R,PRDK);
PARAMETER A2(R,PRDK);
PARAMETER A3(R,PRDK);


A0(R,PRDK) $ (SOROST(R) AND P_TIL_PA('KORNAREAL',PRDK))= 2.8;
A1(R,PRDK) $ (SOROST(R) AND P_TIL_PA('KORNAREAL',PRDK))= -0.1029;
A2(R,PRDK) $ (SOROST(R) AND P_TIL_PA('KORNAREAL',PRDK))= 0.01263;
A3(R,PRDK) $ (SOROST(R) AND P_TIL_PA('KORNAREAL',PRDK))= -0.000002;

A0(R,PRDK) $ (SOROST(R) AND P_TIL_PA('ENGAREAL',PRDK)) = 2.12;
A1(R,PRDK) $ (SOROST(R) AND P_TIL_PA('ENGAREAL',PRDK)) = 0.0644;
A2(R,PRDK) $ (SOROST(R) AND P_TIL_PA('ENGAREAL',PRDK)) = -0.00289;
A3(R,PRDK) $ (SOROST(R) AND P_TIL_PA('ENGAREAL',PRDK)) = 0.000157;

A0(R,PRDK) $ ((NOT SOROST(R)) AND P_TIL_PA('KORNAREAL',PRDK)) = 3.02;
A1(R,PRDK) $ ((NOT SOROST(R)) AND P_TIL_PA('KORNAREAL',PRDK)) = -0.0759;
A2(R,PRDK) $ ((NOT SOROST(R)) AND P_TIL_PA('KORNAREAL',PRDK)) = 0.01005;
A3(R,PRDK) $ ((NOT SOROST(R)) AND P_TIL_PA('KORNAREAL',PRDK)) = -0.000094;

A0(R,PRDK) $ ((NOT SOROST(R)) AND P_TIL_PA('ENGAREAL',PRDK)) = 1.59;
A1(R,PRDK) $ ((NOT SOROST(R)) AND P_TIL_PA('ENGAREAL',PRDK)) = 0.1441;
A2(R,PRDK) $ ((NOT SOROST(R)) AND P_TIL_PA('ENGAREAL',PRDK)) = -0.01468;
A3(R,PRDK) $ ((NOT SOROST(R)) AND P_TIL_PA('ENGAREAL',PRDK)) = 0.000565;
