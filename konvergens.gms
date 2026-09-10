************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Lagre og skrive ut data for konvergens av endogene variable
*   Kommentarer:
*   Enheter: Priser i kr / kg, dyr, daa etc
*            Mengder i 1000 kg
*            Verdier i 1000 kr
*            Omfang i  1000 dyr eller daa
*   Status:
*
************************************************************************
$iftheni.pmp %PMP%==NO
execute_unload 'RESULTATER\%SCEN%_KONV.GDX', konvergens, konvergenstest;
$endif.pmp

$iftheni.pmp %PMP%==YES
execute_unload 'RESULTATER\Calib_KONV.GDX', konvergens;
$endif.pmp

*
file KONVFIL/RESULTATER\%SCEN%_KONV.GMS/;
KONVFIL.pw=999;
put KONVFIL;
put "Systeminformasjon:" /;
put "Simulering:",  @15, put SYSTEM.DATE; put"   "; put SYSTEM.TIME /;
put "Scenario:" ,   @15, put LOOP(SCENNAVN, put SCENNAVN.tl); put /;
put "Iterasjoner:", @15, put CARD(STEP):2:0 ////;
*
* Konvergensindikator primaerjordbruk
put "Primaerjordbruk"/;
put "PROF (1000 kr)"/;
put @20, loop(STEP, put STEP.tl:10:0); put /;
loop((R,B), put R.tl:6:0, put".", put B.tl:4:0, @20, loop(STEP, put KONVERGENS(R,B,'PROF',STEP):10:3); put/);
put /"PRIS (kr pr kg)"/;
loop(R, put R.tl:6:0, put".KMLK", @20, loop(STEP, put KONVERGENS(R,'KMLK','TOTP',STEP):10:3); put/);
loop(R, put R.tl:6:0, put".STFK", @20, loop(STEP, put KONVERGENS(R,'STFK','TOTP',STEP):10:3); put/);
loop(R, put R.tl:6:0, put".SAUK", @20, loop(STEP, put KONVERGENS(R,'SAUK','TOTP',STEP):10:3); put/);
loop(R, put R.tl:6:0, put".SVNK", @20, loop(STEP, put KONVERGENS(R,'SVNK','TOTP',STEP):10:3); put/);
loop(R, put R.tl:6:0, put".HVET", @20, loop(STEP, put KONVERGENS(R,'HVET','TOTP',STEP):10:3); put/);
loop(R, put R.tl:6:0, put".RUGH", @20, loop(STEP, put KONVERGENS(R,'RUGH','TOTP',STEP):10:3); put/);
loop(R, put R.tl:6:0, put".BYGG", @20, loop(STEP, put KONVERGENS(R,'BYGG','TOTP',STEP):10:3); put/);
loop(R, put R.tl:6:0, put".HAVR", @20, loop(STEP, put KONVERGENS(R,'HAVR','TOTP',STEP):10:3); put/);
*
put /"Totalareal (1000 daa)"/;
loop(R, put R.tl:6:0, put".OMFG", @20, loop(STEP, put KONVERGENS(R,'AREA','OMFG',STEP):10:3); put/);
put /"Fulldyrket areal (1000 daa)"/;
loop(R, put R.tl:6:0, put".OMFG", @20, loop(STEP, put KONVERGENS(R,'FULL','OMFG',STEP):10:3); put/);
put /"Matkornareal (1000 daa)"/;
loop(R, put R.tl:6:0, put".OMFG", @20, loop(STEP, put KONVERGENS(R,'MATK','OMFG',STEP):10:3); put/);
*
* Konvergensindikator slakterier
put ///"Slakterier"/;
put @20, loop(STEP, put STEP.tl:6:0); put /;
put "PRIS (kr/kg): ", put /;
loop((M,FSLK), put M.tl:4:0, put".", put FSLK.tl:4:0, @20, loop(STEP, put KONVERGENS(M,FSLK,'PRIS',STEP):10:3); put/);
put /"PRIS (kr/kg): ", put /;
loop((M,SSLK), put M.tl:4:0, put".", put SSLK.tl:4:0, @20, loop(STEP, put KONVERGENS(M,SSLK,'PRIS',STEP):10:3); put/);
put /"MNGD (1000 kg): ", put /;
loop((M,SSLK), put M.tl:4:0, put".", put SSLK.tl:4:0, @20, loop(STEP, put KONVERGENS(M,'zs_',SSLK,STEP):10:3); put/);
put /"Antall (stk): ", put /;
loop(M,        put M.tl:4:0, put".gs",                @20, loop(STEP, put KONVERGENS(M,'gs','MNGD',STEP):10:3); put/);
put /"MNGD (1000 kg): ", put /;
loop(M,        put M.tl:4:0, put".zs",                @20, loop(STEP, put KONVERGENS(M,'zs','MNGD',STEP):10:3); put/);
put /"MNGD (1000 kg): ", put /;
loop((M,FSLKVARE), put M.tl:4:0, put".", put FSLKVARE.tl:4:0, @20, loop(STEP, put KONVERGENS(M,'zk_',FSLKVARE,STEP):10:3); put/);
put /"MNGD (1000 kg): ", put /;
loop(M,        put M.tl:4:0, put".zk",                @20, loop(STEP, put KONVERGENS(M,'zk','MNGD',STEP):10:3); put/);
put "TURANTALL (antall): ", put /;
loop(M,        put M.tl:4:0, put".",                  @20, loop(STEP, put KONVERGENS(M,'turantall','MNGD',STEP):10:3); put/);
put "TURLENGDE (km): ", put /;
loop(M,        put M.tl:4:0, put".",                  @20, loop(STEP, put KONVERGENS(M,'turlengde','MNGD',STEP):10:3); put/);
put "STOPP             : ", put /;
loop(M,        put M.tl:4:0, put".",                  @20, loop(STEP, put KONVERGENS(M,'stopp','MNGD',STEP):10:3); put/);
put "PRODUSENTER       : ", put /;
loop(M,        put M.tl:4:0, put".",                  @20, loop(STEP, put KONVERGENS(M,'produsent','SLK',STEP):10:3); put/);
*
* Konvergensindikator meierier
put ///"Meierier"/;
put "MNGD (1000 kg): ", put /;
put @20, loop(STEP, put STEP.tl:6:0); put /;
loop((M,MEIINNVARE)$SUM(STEP, KONVERGENS(M,MEIINNVARE,'MNGD',STEP)), put M.tl:4:0, put".", put MEIINNVARE.tl:4:0, @20, loop(STEP, put KONVERGENS(M,MEIINNVARE,'MNGD',STEP):10:3); put/);
put /"KONS (1000 kg): ", put /;
loop((M,MEIDVARE)$SUM(STEP, KONVERGENS(M,MEIDVARE,'KONS',STEP)), put M.tl:4:0, put".", put MEIDVARE.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,MEIDVARE,'KONS',STEP):10:3); put/);
put /"PROD (1000 kg): ", put /;
loop((M,MEIDVARE)$SUM(STEP, KONVERGENS(M,MEIDVARE,'PROD',STEP)), put M.tl:4:0, put".", put MEIDVARE.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,MEIDVARE,'PROD',STEP):10:3); put/);
put /"EXPT (1000 kg): ", put /;
loop((M,MEIXVARE)$SUM(STEP, KONVERGENS(M,MEIXVARE,'EXPT',STEP)), put M.tl:4:0, put".", put MEIXVARE.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,MEIXVARE,'EXPT',STEP):10:3); put/);
put /"PRIS (kr/kg): ", put /;
loop((M,MEIDVARE)$SUM(STEP, KONVERGENS(M,MEIDVARE,'PRIS',STEP)), put M.tl:4:0, put".", put MEIDVARE.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,MEIDVARE,'PRIS',STEP):10:3); put/);
put /"ANTALL (1000 stk): ", put /;
loop(M$SUM(STEP, KONVERGENS(M,'MEIR','ANTL',STEP)),          put M.tl:4:0,                            @20, loop(STEP, put KONVERGENS(M,'MEIR','ANTL',STEP):10:3); put/);
put /"PRIS (kr/kg): ", put /;
loop((M,MEIR)$SUM(STEP, KONVERGENS(M,MEIR,'PRIS',STEP)),     put M.tl:4:0, put".", put MEIR.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,MEIR,'PRIS',STEP):10:3); put/);
put /"APRS (kr/kg): ", put /;
loop((M,MEIR)$SUM(STEP, KONVERGENS(M,MEIR,'APRS',STEP)),     put M.tl:4:0, put".", put MEIR.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,MEIR,'APRS',STEP):10:3); put/);
put /"IPRS (kr/kg): ", put /;
loop((M,MEIR)$SUM(STEP, KONVERGENS(M,MEIR,'IPRS',STEP)),     put M.tl:4:0, put".", put MEIR.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,MEIR,'IPRS',STEP):10:3); put/);
put "PRODUSENTER       : ", put /;
loop(M,        put M.tl:4:0, put".",                  @20, loop(STEP, put KONVERGENS(M,'produsent','MEI',STEP):10:3); put/);

*
* Konvergens i markedsmodellen
put ///"KONS: ", put /;
loop((M,VARE)$SUM(STEP, KONVERGENS(M,VARE,'KONS',STEP)),     put M.tl:4:0, put".", put VARE.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,VARE,'KONS',STEP):10:3); put/);
put "PROD (1000 kg): ", put /;
loop((M,VARE)$SUM(STEP, KONVERGENS(M,VARE,'PROD',STEP)),     put M.tl:4:0, put".", put VARE.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,VARE,'PROD',STEP):10:3); put/);
put /"PRIS (kr/kg): ", put /;
loop((M,VARE)$SUM(STEP, KONVERGENS(M,VARE,'PRIS',STEP)),     put M.tl:4:0, put".", put VARE.tl:4:0,   @20, loop(STEP, put KONVERGENS(M,VARE,'PRIS',STEP):10:3); put/);
put /"Endogent pristilskudd (kr/kg): ", put /;
loop(VARE$SUM(STEP, KONVERGENS('NORGE','VARE_GLV',VARE,STEP)), put"NORGE.", put VARE.tl:4:0, @20, loop(STEP, put KONVERGENS('NORGE','VARE_GLV',VARE,STEP):10:3);   put/);
                                                               put"NORGE.KORN",              @20, loop(STEP, put KONVERGENS('NORGE','VARE_GLV','KORN',STEP):10:3); put/;
                                                               put"NORGE.STKK",              @20, loop(STEP, put KONVERGENS('NORGE','VARE_GLV','STKK',STEP):10:3); put/;
*
put /"Grunntilskudd (kr/kg): ", put /;
loop(VARE$(SUM(STEP, KONVERGENS('NORGE','TGRUN',VARE,STEP)) > 0),     put"NORGE.", put VARE.tl:4:0,   @20, loop(STEP, put KONVERGENS('NORGE','TGRUN',VARE,STEP):10:3); put/);

put /"BRUK (1000 stk): ", put /;
loop((B,R)$SUM(STEP, KONVERGENS(B,R,'BRUK',STEP)),           put B.tl:4:0, put".", put R.tl:6:0,   @20, loop(STEP, put KONVERGENS(B,R,'BRUK',STEP):10:3); put/);
put /"ANLEGG (1000 stk): ", put /;
loop(M$SUM(STEP, KONVERGENS(M,'MEIR','ANTL',STEP)),         put 'MEIR'  , put".", put M.tl:6:0,   @20, loop(STEP, put KONVERGENS(M,'MEIR','ANTL',STEP):10:3); put/);
loop((M,SSLK)$SUM(STEP, KONVERGENS(M,SSLK,'ANTL',STEP)),         put SSLK.tl:4:0, put".", put M.tl:6:0,   @20, loop(STEP, put KONVERGENS(M,SSLK,'ANTL',STEP):10:3); put/);
loop((M,FSLK)$SUM(STEP, KONVERGENS(M,FSLK,'ANTL',STEP)),         put FSLK.tl:4:0, put".", put M.tl:6:0,   @20, loop(STEP, put KONVERGENS(M,FSLK,'ANTL',STEP):10:3); put/);
*
* Konvergens i tilskuddsatser
put ///"TIL: ", put /;
loop((VARETIL,VARE)$SUM(STEP, KONVERGENS('NORGE',VARETIL,VARE,STEP)), put"NORGE.", put VARETIL.tl:5:0, put".", put VARE.tl:4:0,  @20, loop(STEP, put KONVERGENS('NORGE',VARETIL,VARE,STEP):10:3); put/);
loop((PRDKTIL,PRDK)$SUM(STEP, KONVERGENS('NORGE',PRDKTIL,PRDK,STEP)), put"NORGE.", put PRDKTIL.tl:5:0, put".", put PRDK.tl:4:0,  @20, loop(STEP, put KONVERGENS('NORGE',PRDKTIL,PRDK,STEP):10:3); put/);
loop((R,VARETIL,VARE)$SUM(STEP, KONVERGENS(R,VARETIL,VARE,STEP)), put R.tl:6:0, put".", put VARETIL.tl:5:0, put".", put VARE.tl:4:0,  @20, loop(STEP, put KONVERGENS(R,VARETIL,VARE,STEP):10:3); put/);
loop((R,PRDKTIL,PRDK)$SUM(STEP, KONVERGENS(R,PRDKTIL,PRDK,STEP)), put R.tl:6:0, put".", put PRDKTIL.tl:5:0, put".", put PRDK.tl:4:0,  @20, loop(STEP, put KONVERGENS(R,PRDKTIL,PRDK,STEP):10:3); put/);
loop(R$SUM(STEP, KONVERGENS(R,'TARBF','TARBF',STEP)), put R.tl:6:0, put".TARBF", @20, loop(STEP, put KONVERGENS(R,'TARBF','TARBF',STEP):10:3); put/);

* Konvergens i nasjonal omfang produksjoner
put ///"OMFG: ", put /;
loop(PRDK$SUM(STEP, KONVERGENS('NORGE','OMFG',PRDK,STEP)), put"NORGE.OMFG.", put PRDK.tl:4:0,  @20, loop(STEP, put KONVERGENS('NORGE','OMFG',PRDK,STEP):10:3); put/);

* Konvergens i nasjonal produksjon
put ///"OMFG: ", put /;
loop(PRDK$SUM(STEP, KONVERGENS('NORGE','OMFG',PRDK,STEP)), put"NORGE.OMFG.", put PRDK.tl:4:0,  @20, loop(STEP, put KONVERGENS('NORGE','OMFG',PRDK,STEP):10:3); put/);

* Konvergens i endogene arealpriser
put ///"PRIS: ", put /;
loop((R,PLANTE)$SUM(STEP, KONVERGENS(R,'KAPJ',PLANTE,STEP)), put R.tl:6:0, put PLANTE.tl:4:0,  @20, loop(STEP, put KONVERGENS(R,'KAPJ',PLANTE,STEP):10:3); put/);










