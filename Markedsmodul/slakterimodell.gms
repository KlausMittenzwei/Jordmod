*********************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Klaus, NILF
*   Formaal: Slakterimodeller for slakting_skjaering og foredling
*   Kommentarer: Modellen minimerer foredlingskostnader for gitte priser og mengder
*   Status:
*
**********************************************************************************
VARIABLES
         objslk              Objektverdien for kjoettbransjen
         rkslk(M)            Raavarekostnader
         cfslk(M)            Foredlingskostnader
         ctslk(M)            Inntransportkostnader
         transsslk(M)        Transportkostnader mellom slakting_skjaering og foredling i annen markedsregion
         transfslk(M)        Transportkostnader mellom foredling og annen markedsregion
         zs_(M,SSLK)         Innveid raavare pr slakte-skjaereaktivitet i M
         zs(M)               Innveid raavare slakte- og skjaerebedrift
         zk_(M,VARE)         Produsert mengde ulik ferdigvare i M
         zk(M)               Produsert mengde total ferdigvare i M
         gs(M)               Antall slakte- og skjaerebedrifter
         uttrslk(VARE,M,MM)  Transport av VARE fra M til MM
         inntrslk(VARE,M,MM) Transport av VARE til M fra MM
         turlengde(M)        Lengde for slaktebil pr tur og M i km
         stopp(M)            Antall produsentbesoek pr tur i M
         turantall(M)        Antall turer for aa hente all raavare i M

POSITIVE VARIABLES zs_,zs,zk_,zk,gs,cfslk,ctslk,uttrslk,inntrslk,turlengde,stopp,turantall,transsslk,transfslk;
*
EQUATIONS
         EQOBJSLK               Objektfunksjonen
         RAAVAREEQ(M)           Raavarekostnader i M
         FOREDLSLKEQ(M)         Foredlingskostnader i M
         TRANSINNEQ(M)          Inntransportkostnader i M
         STKKVEKT(M)            Varebalanse for storfe og kalv innenfor M
         SAGKVEKT(M)            Varebalanse for sau lam geit kje innenfor M
         SVNKVEKT(M)            Varebalanse for svin innenfor M
         SSLKSTOR(M)            Stoerrelse av en slakting-skjaeringsbedrift innenfor M
         HLVFVEKT(VARE,M)       Varebalanse for halvfabrikata innenfor M
         FSLKSTOR(M)            Stoerrelse av foredlingsbedrift innenfor M
         SLKVVEKT(VARE,M)       Varebalanse for sluttprodukter innenfor M
         SLKVBALS(VARE,M,MM)    Varebalanse for transport av kjoettvarer mellom markedsregioner
         TRANSSSLKEQ(M)         Transportkostnader mellom slakting_skjaering og foredling i annen markedsregion
         TRANSFSLKEQ(M)         Transportkostnader mellom foredling og annen markedsregioner
         TRANSTIDEQ(M)          Ligning for maksimal transporttid for levende dyr
         TURLENGDEEQ(M)         Lengde for slaktebil pr tur og i km
         TURANTALLEQ(M)         Antall turer for aa hente raavare
         TRBILEQ(M)             Utnyttelse av lastebilen
;
*
* Objektfunksjon minimerer foredlingskostnadene
EQOBJSLK..  objslk =E=
* Raavarekostnader
                        SUM(M, rkslk(M))
* Foredlingskostnader
                      + SUM(M, cfslk(M))
* Inntransportkostnader
                      + SUM(M, ctslk(M))
* Innfrakttilskudd
                      - SUM((M,SLKINNVARE), SIMDATA(M,SLKINNVARE,'MNGD','Y') * SUM(R$R_TIL_M(M,R), INNFRAKTTIL(R,SLKINNVARE)))
* Transportkostnader fra slakting_skjaeringanlegg til foredlingsanlegg mellom markedsregioner
                      + SUM(M, transsslk(M))
* Transportkostnader fra foredlingsanlegg til markedsregioner
                      + SUM(M, transfslk(M))
* Intern utjevning PRIN
*                      + SUM((M,IUVARE)$(NOT SAMEAS('FJRK',IUVARE)), IU(IUVARE) * SIMDATA(M,IUVARE,'MNGD','Y'))
;
*
* Regionale raavarekostnader
RAAVAREEQ(M)..  rkslk(M) =E= SUM(SLKINNVARE, SIMDATA(M,SLKINNVARE,'TOTP','Y') * SIMDATA(M,SLKINNVARE,'MNGD','Y'));
*
* Regionale foredlingskostnader
FOREDLSLKEQ(M)..  cfslk(M) =E=
* Anleggskostnader i slakting og skjaering
                         SLKDATA('AVAR','SLST') * zs_(M,'SLST') * gs(M)
                       + SLKDATA('AVAR','SLSA') * zs_(M,'SLSA') * gs(M)
                       + SLKDATA('AVAR','SLSV') * zs_(M,'SLSV') * gs(M)
                       + (CFAS + CFBS/zs(M)) * zs(M) * gs(M)

* Anleggskostnader i foredling
                       + SUM((FSLK,FSLKVARE)$FP_TIL_SLTVARE(FSLKVARE,FSLK), SLKDATA('AVAR',FSLK) * zk_(M,FSLKVARE))
                       + (CFAK + CFBK/zk(M)) * zk(M) ;
*
* Sikrer at all raavare hentes
TURANTALLEQ(M)..   turantall(M) * stopp(M) =E= PROD_SLK(M) * BESOEK ;
*
* Utnyttelse av lastebilen
TRBILEQ(M)..    stopp(M) * KJRAAVARE(M) * 1000000 / (PROD_SLK(M) * BESOEK) =L= TRBILSTOR('OKYR');
*
* Regional lengde av tur for slaktebilen i km
TURLENGDEEQ(M)..      turlengde(M) =E=
                                 (SQRT(AREAL(M)/(gs(M)*3.14159))
          + (stopp(M) * 3.14159 * SQRT(AREAL(M)/(gs(M)*3.14159)) / PROD_SLK(M))) * CTKALIB(M)  ;
*
* Maksimal grense for inntransport av livdyr i timer
* unntatt NordNorge
TRANSTIDEQ(M)$(NOT SAMEAS('NORD',M))..     MAKSTRTID =G=  (   TRVEIANDEL(M)  * turlengde(M) /60
                                                         + (1-TRVEIANDEL(M)) * turlengde(M) /30)
                                                         +  stopp(M) * 45/60 ;
*
* Regionale inntransportkostnader
TRANSINNEQ(M)..            ctslk(M) =E=  turantall(M) / 1000000 *

* Avstandsavhengig kostnad
                           ( (  turlengde(M) * TRAVSKOST('OKYR'))
* Tidsavhengig kostnad
                           +(((   TRVEIANDEL(M)  * turlengde(M) /60)
                           + ((1-TRVEIANDEL(M)) * turlengde(M) /30)) * 60 * TRTIDKOST('OKYR'))
* Lasting og lossing
                           +( (1+stopp(M))   * TRSTPKOST('OKYR')))  ;
*
* Transportkostnader fra slakting_skjaering til foredling mellom markedsregioner
TRANSSSLKEQ(M)..        transsslk(M) =E= SUM((VARE,MM)$(SSLKVARE(VARE) AND FSLKVARE(VARE) AND NOT SAMEAS(M,MM)), uttrslk(VARE,M,MM) * TRKOST(VARE,M,MM));
*
* Transportkostnader foredling mellom markedsregioner
TRANSFSLKEQ(M)..        transfslk(M) =E= SUM((VARE,MM)$(SLKVARE(VARE) AND SLTVARE(VARE)  AND NOT SAMEAS(M,MM)),  uttrslk(VARE,M,MM) * TRKOST(VARE,M,MM));

* Varebalanse for storfe og kalv innenfor en markedsregion
STKKVEKT(M)..            SIMDATA(M,'STFK','MNGD','Y') + SIMDATA(M,'KLVK','MNGD','Y')
                    =E=  zs_(M,'SLST') * gs(M) * SLKDATA('STKK','SLST') ;
*
* Varebalanse for sau lam geit og kje innenfor en markedsregion
SAGKVEKT(M)..            SIMDATA(M,'SAUK','MNGD','Y') + SIMDATA(M,'GETK','MNGD','Y')
                    =E=  zs_(M,'SLSA') * gs(M) * SLKDATA('SAGK','SLSA');
*
* Varebalanse for gris innenfor en markedsregion
SVNKVEKT(M)..            SIMDATA(M,'SVNK','MNGD','Y')
                    =E=  zs_(M,'SLSV') * gs(M) * SLKDATA('SVNK','SLSV');
*
* Stoerrelse av en slakting-skjaeringsbedrift
SSLKSTOR(M)..            zs_(M,'SLST') + zs_(M,'SLSA') + zs_(M,'SLSV')
                     =E= zs(M);
*
* Varebalanse for produksjonskjoett og innmat innenfor en markedsregion
HLVFVEKT('PRIN',M)..
                zs_(M,'SLST') * gs(M) * SLKDATA('PRIN','SLST')
              + zs_(M,'SLSA') * gs(M) * SLKDATA('PRIN','SLSA')
              + zs_(M,'SLSV') * gs(M) * SLKDATA('PRIN','SLSV')
              + SUM(MM$(NOT SAMEAS(M,MM)), inntrslk('PRIN',M,MM))
           =G=  SUM(FSLK, zk_(M,'PRIN') * SLKDATA('PRIN',FSLK))
              + SUM(MM$(NOT SAMEAS(M,MM)),  uttrslk('PRIN',M,MM));
*
* Stoerrelse av foredlingsbedrift
FSLKSTOR(M)..            SUM(FSLKVARE$(NOT SAMEAS('PRIN',FSLKVARE)), zk_(M,FSLKVARE)) =E= zk(M);
*
* Varebalanse for sluttprodukter innenfor en markedsregion
SLKVVEKT(VARE,M)$(SLTVARE(VARE) AND SLKVARE(VARE))..
            SUM(FSLK, zk_(M,VARE) *         SLKDATA(VARE,FSLK))
          + SUM(SSLK, zs_(M,SSLK) * gs(M) * SLKDATA(VARE,SSLK))
          + SUM(MM$(NOT SAMEAS(M,MM)), inntrslk(VARE,M,MM))
     =G=  SIMDATA(M,VARE,'MNGD','Y') + SUM(MM$(NOT SAMEAS(M,MM)),  uttrslk(VARE,M,MM));
*
* Varebalanse for transport av kjoettvarer mellom markedsregioner
SLKVBALS(VARE,M,MM)$((SLKVARE(VARE) OR SAMEAS('STFK',VARE) OR SAMEAS('KLVK',VARE)
                                    OR SAMEAS('SAUK',VARE) OR SAMEAS('GETK',VARE)) AND NOT SAMEAS(M,MM))..
                    inntrslk(VARE,MM,M) =E= uttrslk(VARE,M,MM);

MODEL SLAKTERIMODELL  /
EQOBJSLK
RAAVAREEQ
FOREDLSLKEQ
TURANTALLEQ
TRBILEQ
TURLENGDEEQ
TRANSINNEQ
TRANSSSLKEQ
TRANSFSLKEQ
TRANSTIDEQ
STKKVEKT
SAGKVEKT
SVNKVEKT
SSLKSTOR
HLVFVEKT
FSLKSTOR
SLKVVEKT
SLKVBALS
/;