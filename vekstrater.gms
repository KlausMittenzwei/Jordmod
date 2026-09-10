*************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Vekstrater for eksogen fremskriving av parametre
*   Kommentarer:
*   Enheter: Prosent
*   Status:
*
************************************************************************
* Konsumprisindeks
* Kilde: Government's inflation target
SCALAR KPI Konsumprisindeks /0.02/;
*
* Befolkningsvekst 2021-2035
* Kilde: SSB, middelalternativet (tables 07459, 14282)
SCALAR POP Aarlig befolkningsvekst /0.006220086/;
*
SCALAR INNSATVPRIS Prisvekt for innsatsvarer utover konsumpris / 0.005/;

PARAMETER VEKSTRATE(*) Aarlig produktivitetsvekst;
VEKSTRATE('ARBF') = .0015;
VEKSTRATE('KAPB') = .00025;
VEKSTRATE('KAPM') = .00025;
*
VEKSTRATE('ARBF') = .0;
VEKSTRATE('KAPB') = .0;
VEKSTRATE('KAPM') = .0;
*
* Generell
PARAMETER VEKSTRAT(VARE,PRDK) Aarlig produktivitetsvekst for kostnadssparende teknologisk utvikling;
*VEKSTRAT(VARE,PRDK) = 0.0015;
VEKSTRAT(VARE,PRDK) = 0.0;
*
* Vekstrate for nominell loennsvekst
* Kilde: https://www.ssb.no/nasjonalregnskap-og-konjunkturer/konjunkturer/statistikk/konjunkturtendensene fra 14. juni 2024
SCALAR LOENN Nominal wage increase / 0.03 /;
* Omregnes til reell loennsvekst
LOENN = LOENN - KPI;
*
* Source: Totalkalkylen
* Realrente paa kapital 
SCALAR RENTE Realrente / 0.0335/;
*
* generell vekstrate oppdateres her
ENHDATA(R,VARE,PRDK,'Y') $ VEKST(VARE,PRDK) = ENHDATA(R,VARE,PRDK,'Y') * (1 + VEKSTRAT(VARE,PRDK)) ** (Y - %BAS%) ;
* vekstrate for arbeid og gjoedsel oppdateres her
* vekstrate for famarbeid oppdateres paa kalibbrukxx.gms
* vekstrate for lonn slakteri oppdateres paa kalibslakterixx.gms
DATA(R,'ARBL','TOTP','Y') = DATA(R,'ARBL','TOTP','Y') * (1 + LOENN + KPI) ** (Y - %BAS%);
DATA(R,'KAPJ','TOTP','Y') = DATA(R,'KAPJ','TOTP','Y') * (1 + KPI) ** (Y - %BAS%);
DATA(R,'NITG','TOTP','Y') = DATA(R,'NITG','TOTP','Y') * (1 + KPI) ** (Y - %BAS%);
DATA(R,'FOSG','TOTP','Y') = DATA(R,'FOSG','TOTP','Y') * (1 + KPI) ** (Y - %BAS%);
DATA(R,'KALG','TOTP','Y') = DATA(R,'KALG','TOTP','Y') * (1 + KPI) ** (Y - %BAS%);
*
* prisen for kapital oppdateres her
DATA(R,INNKAP,'TOTP','Y') $ ((Y = %SIM%) AND (NOT SAMEAS('KAPJ',INNKAP))) = RENTE;
*
* Fremskriving for innsatsfaktorer med pris lik 1 unntatt arbeid
* oppdateres her
* Produktivitetsvekst for innsatsvarer
ENHDATA(R,INNSATV,PRDK,'Y') = ENHDATA(R,INNSATV,PRDK,'Y') * (1 - VEKSTRAT(INNSATV,PRDK)) ** (Y - %BAS%) ;
*
* Slaktevekt og f�ring
*ENHDATA(R,'STFK','MKYR','Y') = ENHDATA(R,'STFK','MKYR','Y') * (1.004 ** (Y - %BAS%)) ;
*ENHDATA(R,'STFK','AKYR','Y') = ENHDATA(R,'STFK','AKYR','Y') * (1.004 ** (Y - %BAS%)) ;
*ENHDATA(R,'STFK','OKSS','Y') = ENHDATA(R,'STFK','OKSS','Y') * (1.004 ** (Y - %BAS%)) ;
*ENHDATA(R,'STFK','KVGS','Y') = ENHDATA(R,'STFK','KVGS','Y') * (1.004 ** (Y - %BAS%)) ;
*ENHDATA(R,'KLVK','OKKS','Y') = ENHDATA(R,'KLVK','OKKS','Y') * (1.004 ** (Y - %BAS%)) ;
*ENHDATA(R,'KLVK','KVKS','Y') = ENHDATA(R,'KLVK','KVKS','Y') * (1.004 ** (Y - %BAS%)) ;
*ENHDATA(R,'SAUK','SOEY','Y') = ENHDATA(R,'SAUK','SOEY','Y') * (1.005 ** (Y - %BAS%)) ;
*ENHDATA(R,'SAUK','LAMS','Y') = ENHDATA(R,'SAUK','LAMS','Y') * (1.005 ** (Y - %BAS%)) ;
*ENHDATA(R,'SVNK','PURK','Y') = ENHDATA(R,'SVNK','PURK','Y') * (1.004 ** (Y - %BAS%)) ;
*ENHDATA(R,'SVNK','GRIS','Y') = ENHDATA(R,'SVNK','GRIS','Y') * (1.004 ** (Y - %BAS%)) ;
*ENHDATA(R,'FJRK','KYLS','Y') = ENHDATA(R,'FJRK','KYLS','Y') * (1.004 ** (Y - %BAS%)) ;
*ENHDATA(R,'EGGS','HOEN','Y') = ENHDATA(R,'EGGS','HOEN','Y') * (1.004 ** (Y - %BAS%)) ;
**
*ENHDATA(R,'FDRA','AKYR','Y') = ENHDATA(R,'FDRA','AKYR','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FDRA','OKSS','Y') = ENHDATA(R,'FDRA','OKSS','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FDRA','KVGS','Y') = ENHDATA(R,'FDRA','KVGS','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FDRA','OKKS','Y') = ENHDATA(R,'FDRA','OKKS','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FDRA','OKKO','Y') = ENHDATA(R,'FDRA','KVKS','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FDRA','OKKS','Y') = ENHDATA(R,'FDRA','OKKS','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FDRA','KVKO','Y') = ENHDATA(R,'FDRA','KVKS','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FDRM','SOEY','Y') = ENHDATA(R,'FDRM','SOEY','Y') * (1.005 ** (Y - %BAS%)) ;
*ENHDATA(R,'FDRA','LAMS','Y') = ENHDATA(R,'FDRA','LAMS','Y') * (1.005 ** (Y - %BAS%)) ;
*ENHDATA(R,'FSVN','PURK','Y') = ENHDATA(R,'FSVN','PURK','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FSVN','GRIS','Y') = ENHDATA(R,'FSVN','GRIS','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FKYL','KYLS','Y') = ENHDATA(R,'FKYL','KYLS','Y') * (1.007 ** (Y - %BAS%)) ;
*ENHDATA(R,'FEGG','HOEN','Y') = ENHDATA(R,'FEGG','HOEN','Y') * (1.007 ** (Y - %BAS%)) ;
*
* Fremskriving av kapitalverdi i kalibbrukxx.gms
* Fremskriving av kostnadsvekst for varer utenom DG
ENHDATA(R,INNSATV,PRDK,'Y') = ENHDATA(R,INNSATV,PRDK,'Y') * (1 + KPI + INNSATVPRIS) ** (Y - %BAS%) ;
* Fremskriving av kostnadsvekst for varer i DG skjer i kalibbruk21.gms
* Vekstrater for avlingsnivaa korn og grovfor
* oppdateres i kalibbrukxx.gms
SCALAR VEKSTKORN Vekstrate korn /0.05/;
*
SCALAR VEKSTGROV Vekstrate grovfor /0.05/;
*
* Vekstrate teknisk fremskritt melk i prosent
SCALAR TFMELK Vekstrate melk /0.25/;
*
* Økt melkeytelse i prosent per år
SCALAR VEKSTMELK Vekstrate melk /0.5/;
*
* Vekstrate endogen industri i prosent
SCALAR VEKSTIND Vekstrate industri /0.2/;
*
* Vekstrate eksogen industri i prosent
SCALAR VEKSTINDE Vekstrate industri /0.2/;
