************************************************************************
*
*   Jordmod
*
*   Ansvarlig: Klaus, Ruralis
*   Formaal: Trendforecast of world market prices
*   Kommentarer:
*   Status:
*
************************************************************************
* Assumption: Target producer price for cereals and feed concentrates increases with KPI
MaalPris(VARE) $ MOELINNVARE(VARE) = MaalPris(VARE) * (1 + KPI) ** (Y - %BAS%);
*
* jf verdensmarkedspriser.xlsx
PARAMETER OUTLOOK(VARE) /
HVEM    -1.544027001
FFKN    -0.410348048
FBLG    -0.211672293
ERTM    -1.064452495
STFK    0.816452588
SVNK    -0.051452792
SAUK    -0.183644073
OSTD    0.054219863
SKMP    -0.141178456
POTE    -0.740583878
SMOR    -0.109653081
FSOY    -0.981705544
/;
*
* Prisendring basert paa Outlook 2014
PI("HVEM") =  PI("HVEM") * (1 + OUTLOOK("HVEM")/100) ** (Y - %BAS%);
PI("HVEF") =  PI("HVEF") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
PI("RUGM") =  PI("RUGM") * (1 + OUTLOOK("HVEM")/100) ** (Y - %BAS%);
PI("RUGF") =  PI("RUGF") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
PI("BYGM") =  PI("BYGM") * (1 + OUTLOOK("HVEM")/100) ** (Y - %BAS%);
PI("BYGF") =  PI("BYGF") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
PI("HAVM") =  PI("HAVM") * (1 + OUTLOOK("HVEM")/100) ** (Y - %BAS%);
PI("HAVF") =  PI("HAVF") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
PI("AKRM") =  PI("AKRM") * (1 + OUTLOOK("HVEM")/100) ** (Y - %BAS%);
PI("AKRF") =  PI("AKRF") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
PI("FMKN") =  PI("FMKN") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
PI("FMKN") =  PI("FMKN") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
PI("FFKN") =  PI("FFKN") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
PI("FFKN") =  PI("FFKN") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
PI("RAPM") =  PI("RAPM") * (1 + OUTLOOK("ERTM")/100) ** (Y - %BAS%);
PI("RAPF") =  PI("RAPF") * (1 + OUTLOOK("FBLG")/100) ** (Y - %BAS%);
PI("ERTM") =  PI("ERTM") * (1 + OUTLOOK("ERTM")/100) ** (Y - %BAS%);
PI("ERTF") =  PI("ERTF") * (1 + OUTLOOK("FBLG")/100) ** (Y - %BAS%);
PI("POTE") =  PI("POTE") * (1 + OUTLOOK("POTE")/100) ** (Y - %BAS%);
PI("GRNV") =  PI("GRNV") * (1 + OUTLOOK("POTE")/100) ** (Y - %BAS%);
PI("GRNF") =  PI("GRNF") * (1 + OUTLOOK("POTE")/100) ** (Y - %BAS%);
PI("EPLE") =  PI("EPLE") * (1 + OUTLOOK("POTE")/100) ** (Y - %BAS%);
PI("AFRU") =  PI("AFRU") * (1 + OUTLOOK("POTE")/100) ** (Y - %BAS%);
PI("BLOM") =  PI("BLOM") * (1 + OUTLOOK("POTE")/100) ** (Y - %BAS%);
PI("FJRK") =  PI("FJRK") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%);
PI("KHEL") =  PI("KHEL") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%);
PI("KFIL") =  PI("KFIL") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%);
PI("KANT") =  PI("KANT") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%);
PI("EGGS") =  PI("EGGS") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%);
PI("KMLK") =  PI("KMLK") * (1 + OUTLOOK("SMOR")/100) ** (Y - %BAS%);
PI("MLKD") =  PI("MLKD") * (1 + OUTLOOK("SMOR")/100) ** (Y - %BAS%) ;
PI("MLKI") =  PI("MLKI") * (1 + OUTLOOK("SMOR")/100) ** (Y - %BAS%) ;
PI("MLKS") =  PI("MLKS") * (1 + OUTLOOK("SMOR")/100) ** (Y - %BAS%) ;
PI("YOGH") =  PI("YOGH") * (1 + OUTLOOK("SMOR")/100) ** (Y - %BAS%) ;
PI("OSTD") =  PI("OSTD") * (1 + OUTLOOK("OSTD")/100) ** (Y - %BAS%) ;
PI("OSTI") =  PI("OSTI") * (1 + OUTLOOK("OSTD")/100) ** (Y - %BAS%) ;
PI("OSTK") =  PI("OSTK") * (1 + OUTLOOK("OSTD")/100) ** (Y - %BAS%) ;
PI("OSTM") =  PI("OSTM") * (1 + OUTLOOK("OSTD")/100) ** (Y - %BAS%) ;
PI("OSTG") =  PI("OSTG") * (1 + OUTLOOK("OSTD")/100) ** (Y - %BAS%) ;
PI("OSTE") =  PI("OSTE") * (1 + OUTLOOK("OSTD")/100) ** (Y - %BAS%) ;
PI("OSTX") =  PI("OSTX") * (1 + OUTLOOK("OSTD")/100) ** (Y - %BAS%) ;
PI("SKMP") =  PI("SKMP") * (1 + OUTLOOK("SKMP")/100) ** (Y - %BAS%) ;
PI("FLOT") =  PI("FLOT") * (1 + OUTLOOK("SMOR")/100) ** (Y - %BAS%) ;
PI("SMOR") =  PI("SMOR") * (1 + OUTLOOK("SMOR")/100) ** (Y - %BAS%);
PI("STFK") =  PI("STFK") * (1 + OUTLOOK("STFK")/100) ** (Y - %BAS%);
PI("KLVK") =  PI("KLVK") * (1 + OUTLOOK("STFK")/100) ** (Y - %BAS%);
PI("SAUK") =  PI("SAUK") * (1 + OUTLOOK("SAUK")/100) ** (Y - %BAS%);
PI("SVNK") =  PI("SVNK") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%);
PI("PRIN") =  PI("PRIN") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%);
PI("KYST") =  PI("KYST") * (1 + OUTLOOK("STFK")/100) ** (Y - %BAS%)  ;
PI("KYSA") =  PI("KYSA") * (1 + OUTLOOK("SAUK")/100) ** (Y - %BAS%) ;
PI("KYSV") =  PI("KYSV") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%)  ;
PI("KBST") =  PI("KBST") * (1 + OUTLOOK("STFK")/100) ** (Y - %BAS%)  ;
PI("KBSA") =  PI("KBSA") * (1 + OUTLOOK("SAUK")/100) ** (Y - %BAS%) ;
PI("KBSV") =  PI("KBSV") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%)  ;
PI("KSST") =  PI("KSST") * (1 + OUTLOOK("STFK")/100) ** (Y - %BAS%)  ;
PI("KSSA") =  PI("KSSA") * (1 + OUTLOOK("SAUK")/100) ** (Y - %BAS%) ;
PI("KSSV") =  PI("KSSV") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%)  ;
PI("KDEI") =  PI("KDEI") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%) ;
PI("KPOL") =  PI("KPOL") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%) ;
PI("KPAL") =  PI("KPAL") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%) ;
PI("KSPP") =  PI("KSPP") * (1 + OUTLOOK("SAUK")/100) ** (Y - %BAS%) ;
PI("KSPV") =  PI("KSPV") * (1 + OUTLOOK("SAUK")/100) ** (Y - %BAS%) ;
PI("KDIV") =  PI("KDIV") * (1 + OUTLOOK("SVNK")/100) ** (Y - %BAS%) ;
PI("FSOY") =  PI("FSOY") * (1 + OUTLOOK("FSOY")/100) ** (Y - %BAS%);
PI("FBLG") =  PI("FBLG") * (1 + OUTLOOK("FBLG")/100) ** (Y - %BAS%);
PI("FANT") =  PI("FANT") * (1 + OUTLOOK("FFKN")/100) ** (Y - %BAS%);
*
* Nominell endring p� grunn av reelle prisendringer i Outlook
PI(VARE) = PI(VARE) * (1 + KPI) ** (Y - %BAS%);

*abort pi;


* Oppdatere prosenttoll for melk ost og kj�tt
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

* Ny prosenttoll melk og ost
TOLL('MLKS') = PROSENTTOLL('MLKS') * PI('MLKS') / 100;
TOLL('OSTK') = PROSENTTOLL('OSTK') * PI('OSTK') / 100;
TOLL('OSTM') = PROSENTTOLL('OSTM') * PI('OSTM') / 100;
TOLL('OSTG') = PROSENTTOLL('OSTG') * PI('OSTG') / 100;
*
TOLL('KBST') = PROSENTTOLL('KBST') * PI('KBST') / 100;
TOLL('SAUK') = PROSENTTOLL('SAUK') * PI('SAUK') / 100;
*
*
* Redo tariff calculations based on tariffs in reference run
* Update MFN
KVOTETOLL(VARE) =  TOLL(VARE) ;
KVOTETOLL(VARE) $ (POL('NORGE',VARE,'MFNIMPT')  > 0) = MAX(0, MIN(1/3 * TOLL(VARE), DATA('NORGE',VARE,'TOTP','BAS') - PI(VARE)));
* lavere toll pga storfe fra MUL
KVOTETOLL('STFK') $ (POL('NORGE','STFK','MFNIMPT')  > 0) = .1 * TOLL('STFK');
*
* Update administrative tariffs
POL('NORGE',VARE,'ADMIMPT') = 0;
* Administrativt import av korn
POL('NORGE',MOELINNVARE,'ADMIMPT') =  + INF;
* Korn til kraftfôr
POL('NORGE','FMKN','ADMIMPT') =  + INF;
POL('NORGE','FFKN','ADMIMPT') =  + INF;
POL('NORGE','FBLG','ADMIMPT') =  + INF;
POL('NORGE','FSOY','ADMIMPT') =  + INF;
POL('NORGE','FANT','ADMIMPT') =  + INF;
*
KVOTETOLLA(VARE) = TOLL(VARE) ;
KVOTETOLLA(VARE) $ (POL('NORGE',VARE,'ADMIMPT')  > 0) = MAX(0, DATA('NORGE',VARE,'TOTP','BAS') - PI(VARE));
KVOTETOLLA(MOELINNVARE)                               = MAX(0, MaalPris(MOELINNVARE)  - PRISNED(MOELINNVARE) - PI(MOELINNVARE));
KVOTETOLLA('FMKN') = KVOTETOLLA('HVEM');
KVOTETOLLA('FFKN') = KVOTETOLLA('BYGF');
KVOTETOLLA('FBLG') = KVOTETOLLA('RAPM');
KVOTETOLLA('FSOY') = 0.60;
KVOTETOLLA('FBLG') = 1.165;
KVOTETOLLA('FANT') = 0.0;
KVOTETOLLA('POTE') = MAX(0, MIN[TOLL('POTE'),DATA('NORGE','POTE','TOTP','BAS') - PI('POTE')]);
*
* Update bilateral tariffs
KVOTETOLLB(VARE) = TOLL(VARE) ;
POL('NORGE',VARE,'BILIMPT') = 0;
POL('NORGE','OSTD','BILIMPT') =  7.2;
KVOTETOLLB('OSTD') = 0.0;
*
* Update sensitive tariffs
KVOTETOLLS(VARE) = TOLL(VARE) ;
POL('NORGE',VARE,'SENIMPT') = 0;
*
* No change in subsidized exports