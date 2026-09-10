************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Ivar, SNF
*   Formaal: Meiermodell
*   Kommentarer:
*   Status:
*
************************************************************************
VARIABLES
         objmei                 Objektverdi
         pmei(VARE,M)           Engrospris
         xmei(VARE,M)           Innenlands konsumert mengde
         xemei(VARE,M)          Eksportert mengde
         qmei(M)                Antall meierier pr M
         xpmei(VARE,M)          Innenlands produsert mengde pr vare og region
         prodtotmei(VARE)       Innenlands produsert mengde pr vare og hele landet
         zpmei(M,VARE)          Produsert raamelk pr VARE og M
         zmei(M,VARE)           Foredlet raamelk pr VARE og M
         gmei(FP,M)             Stoerrelse PRDK i M
         cfmei(M)               Foredlingskostnader pr M
         ctmei(M)               Inntransportkostnader pr M
         uttrmei(VARE,M,MM)     Transport av produkt VARE fra region M til region MM
         inntrmei(VARE,M,MM)    Transport av produkt VARE til region M fra region MM

POSITIVE VARIABLES pmei,xmei,xemei,xpmei,zmei,zpmei,qmei,gmei,cfmei,ctmei,uttrmei,inntrmei;



EQUATIONS
         EQOBJMEI             Objektfunksjonen
         EQPR                 Profittbetingelse for meierier
         BALANSE(VARE,M,MM)
         VEKT(VARE,M)
         MELKVEKT(M,VARE)     Markedsbalanse for raamelk i region M
         ETTERSP(VARE,M)      Innenlands etterspoersel
         PRODUKEQ(VARE,M)     Innenlands produksjon av vare i region M
         PRODTOTEQ(VARE)      Produksjon av vare for hele landet
         INNSATSEQ(M,VARE)    Innveid raamelk i region M
         FOREDLMEIEQ(M)       Foredlingskostnader i region M
         TRANSEQ(M)           Transportkostnader i region M
;

* Objektfunksjon maksimerer velferd definert som produsentoverskudd (inntekter minus kostnader)
* og konsumentoverskudd

EQOBJmei..  OBJmei =E=
* Innenlandske markedsinntekter
                        SUM((MEIDVARE,M), pmei(MEIDVARE,M)* xmei(MEIDVARE,M))
* Eksportinntekter
                        + SUM((MEIXVARE,M), (pe(MEIXVARE) - TRKOSTEKS(MEIXVARE,M)) * xemei(MEIXVARE,M))
* Raavarekostnader
                        - SUM((M,VARE)$MEIINNVARE(VARE), SIMDATA(M,VARE,'TOTP','Y') * zpmei(M,VARE))
* Markedsregulering PU
                        + SUM((FP,M), PUSATS(FP) * gmei(FP,M))
                        + SUM((M,VARE)$MEIINNVARE(VARE), PUINNT(M) * zpmei(M,VARE))
                        + SUM((FP,M), PUDISB(FP,M) * gmei(FP,M))
* Markedsregulering Omsetningsavgift
                        - SUM((M,VARE)$MEIINNVARE(VARE), OMSET(VARE) * zpmei(M,VARE))
* Markedsregulering Eksportstoette
                        + SUM((MEIXVARE,M), EKSSUB(MEIXVARE) * xemei(MEIXVARE,M))
* Foredlingskostnader
                        - SUM(M, cfmei(M))
* Inntransportkostnader
                        - SUM(M, ctmei(M))
* Transportkostnader mellom markedsregioner
                        - SUM((MEIVARE,M,MM), uttrmei(MEIVARE,M,MM)*TRKOST(MEIVARE,M,MM))
* Konsumentoverskudd
*                        + 0.5 * SUM((MEIDVARE,M), xmei(MEIDVARE,M)**2/BETAmei(MEIDVARE,M));
                 + 0.5 * SUM((MEIDVARE,M)$BETAmei(MEIDVARE,M),
                             BETAmei(MEIDVARE,M)*xmei(MEIDVARE,M)**2)
;
*
* Profittbetingelse for meierier
EQPR..
* Innenlandske markedsinntekter
                        SUM((MEIDVARE,M), pmei(MEIDVARE,M)* xmei(MEIDVARE,M))
* Eksportinntekter
                        + SUM((MEIXVARE,M), pe(MEIXVARE) * xemei(MEIXVARE,M))
* Raavarekostnader
                        - SUM((M,VARE)$MEIINNVARE(VARE), SIMDATA(M,VARE,'TOTP','Y') * zpmei(M,VARE))
* Markedsregulering Omsetningsavgift
                        - SUM((M,VARE)$MEIINNVARE(VARE), OMSET(VARE) * zpmei(M,VARE))
* Markedsregulering Eksportstoette
                        + SUM((MEIXVARE,M), EKSSUB(MEIXVARE) * xemei(MEIXVARE,M))
* Foredlingskostnader
                        - SUM(M, cfmei(M))
* Inntransportkostnader
                        - SUM(M, ctmei(M))
* Transportkostnader mellom markedsregioner
                        - SUM((MEIVARE,M,MM), uttrmei(MEIVARE,M,MM)*TRKOST(MEIVARE,M,MM))
              =G= 0;
*
*
* Innenlands etterspoersel
ETTERSP(MEIDVARE,M)..   pmei(MEIDVARE,M) =E= ALFAmei(MEIDVARE,M) - (BETAmei(MEIDVARE,M) * xmei(MEIDVARE,M));
*
* Regionale foredlingskostnader
FOREDLMEIEQ(M)..        cfmei(M) =E= SUM(FP, AFmei(FP) * (MEIDATA('KMLK',FP) + MEIDATA('GMLK',FP)) * gmei(FP,M)) + BFmei * qmei(M);
*
* Regional produksjon av meierivarer
PRODUKEQ(MEIVARE,M)..   xpmei(MEIVARE,M) =E= SUM(FP, MEIDATA(MEIVARE,FP) * gmei(FP,M));
*
* Nasjonal produksjon av meierivarer
PRODTOTEQ(MEIVARE)..    prodtotmei(MEIVARE) =E= SUM(M, xpmei(MEIVARE,M));
*
* Inntransportkostnader
TRANSEQ(M)..            ctmei(M) =E= ATmei(M)*PROD_MEI(M) + BTmei(M)*(SUM(VARE$MEIINNVARE(VARE), zpmei(M,VARE))**2)*(1/qmei(M));
*
* Regional foredlet raamelk
INNSATSEQ(M,VARE) $ (SAMEAS('KMLK',VARE) OR SAMEAS('GMLK',VARE))
                     .. zmei(M,VARE) =E= SUM(FP, gmei(FP,M) * MEIDATA(VARE,FP));
*
* Balanse for transport av foredlede meierivarer mellom markedsregioner
BALANSE(VARE,M,MM) $ MEIVARE(VARE)
                     .. inntrmei(VARE,MM,M) =E= uttrmei(VARE,M,MM);
*
* Varebalanse for meieriprodukter innenfor en markedsregion
VEKT(MEIVARE,M)..       xmei(MEIVARE,M)  + xemei(MEIVARE,M) + SUM(MM, uttrmei(MEIVARE,M,MM))
                    =E= xpmei(MEIVARE,M)                    + SUM(MM, inntrmei(MEIVARE,M,MM));
*
* Varebalanse for raamelk innenfor en markedsregion
MELKVEKT(M,VARE) $ (SAMEAS('KMLK',VARE) OR SAMEAS('GMLK',VARE))
..                      zmei(M,VARE)  =E= zpmei(M,VARE);
*
MODEL MEIERIMODELL /
         EQOBJmei
         EQPR
         BALANSE
         VEKT
         MELKVEKT
         ETTERSP
         PRODUKEQ
         PRODTOTEQ
         INNSATSEQ
         FOREDLMEIEQ
         TRANSEQ
/;