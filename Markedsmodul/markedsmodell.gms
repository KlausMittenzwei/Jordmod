************************************************************************
*
*   Jordmod-prosjekt 2005-2007
*
*   Ansvarlig: Arve og Klaus, NILF
*   Formaal: Definisjon av markedsmodellen
*   Kommentarer:
*   Priser i kr pr kg
*   Mengder i mill kg
*   Verdier i mill kr
*   Omfang i 1000 daa eller dyr
*   Unntak: HOEN og KYLS i mill. dyr
*   Prosesser g og h i 1000 bedrifter
*
*   Status:
*
************************************************************************

VARIABLES

        obj             Samfunns�konomisk overskudd i jordbruket i mill kr
*
* Vareopprinnelse og vareanvendelse
*
        x(VARE,C,*)     Domestic quantiry at food chain level in kr pr kg
        xi(VARE,*)      Import til ordinaer toll i mill kg

        xq(VARE,*)      Import til MFN-kvoter i mill kg
        xqa(VARE,*)     Import til administrative kvoter i mill kg
        xqb(VARE,*)     Import til bilaterale kvoter i mill kg
        xqs(VARE,*)     Import av sensitive produkter i mill kg

        xe(VARE,*)      Eksport i mill kg
*
* Likevektspris for varer i markedsregion
*
        p(VARE,C,M)    Domestic price at food chain level in market region in kr pr kg
*
* Gaardsbruk
*
        g(B,R)           Antall gardsbruk i region i 1000
*
* Foredlingsprosesser
*
        h(FP,M)           Antall foredlingsprosesser i markedsregion
*
* Bruk av innsatsfaktorer
*
        z(VARE,*)    Faktorbruk mengde ulike regionale nivaaer
*
* Transport av varer mellom markedsregioner
*
        inntr(VARE,M,MM) Inntransport fra MM til M i mill kg
        uttr(VARE,M,MM)  Uttransport fra M til MM i mill kg
*
*  Klimautslipp og miljoindikatorer
*
        husdyrgjodsel(R)
        kunstgjodsel(R)
        nh3m
        n2onh3m
        nh3s
        n2onh3s
        n2om
        n2os

        ghgavgift
        ghgxp
        ghgxi

        sfor(NSTOFF)
        forbal

        v_spred(R) Residual spredareal på regionsviå
        hnfitot
        hnfikrnshr(FULLDYRK)
        hnfikrnshn
        hnfikrnnsp
        hnfigrvrum
        hnfigrvnsp
        hnfiaplnsp

*
* Ecosystemservices
*
        landest(R)  landscape estethics - all ag area
        biodiv(R)   biodiversity - all ag area
        culther(R)  cultural heritage - all grass incl outlying
        recreat(R)  rekreation - all ag area
        landestobs(R)  theoretical landscape estethics - all ag area
        biodivobs(R)   theoretical biodiversity - all ag area
        cultherobs(R)  theoretical cultural heritage - all grass incl outlying
        recreatobs(R)  theoretical rekreation - all ag area
        emis_n
        LUCObs(R,CropTypeObj)
*
* Helseeffekter og kosthold
*
        helse(KostGrp)    Helseeffekt per varegruppe i objektfunksjonen
        helseobs(KostGrp) Helseeffekter uten maks grense
        kosthold(FoodGrp) Dietary recommendations

Positive variables

                    x(VARE,C,*), p(VARE,C,M), g(B,R), h(FP,M), xi(VARE,*), xq(VARE,*), xqa(VARE,*), xqb(VARE,*),
                    xqs(VARE,*), xe(VARE,*), z(VARE,*), inntr(VARE,M,MM), uttr(VARE,M,MM), hnfikrnshr(FULLDYRK),
                    LUCInn(R,CropTypeObj), LUCOut(R,CropTypeObj)
*                    toll(VARE), kvotetoll(VARE), kvotetolla(VARE), kvotetollb(VARE), kvotetolls(VARE)
;
*
*
EQUATIONS
        EQOBJEKT                 Objektfunksjon
*
* Vareopprinnelse og vareanvendelse
*
        EQXPM(VARE,M)         Innenlands produksjon gaardsbruk i markedsregion
        EQXPR(VARE,R)         Innenlands produksjon gaardsbruk i produksjonsregion
        EQXPSSLKM(VARE,M)     Innenlands produksjon slakting og skjaering
        EQXPFSLKM(VARE,M)     Innenlands produksjon foredling kjoett
        EQXPMEIM(VARE,M)      Innenlands produksjon meierivarer
        EQXPKYLM(VARE,M)      Innenlands produksjon kylling
        EQXPMOEL(VARE,R)      Innenlandds produksjon av moellevarer
        EQXPOPRD(VARE,M)      Domestic production of non-processed products for final consumption
        EQXWHLS(VARE)         Domestic production for final consumption Norway
        EQXPRIM(VARE)         Domestic production from primary agriculture Norway
*
        EQXKM(VARE,M)         Innenlands konsum i markedsregion
        EQXK(VARE)            Innenlands konsum hele landet
*
        EQNITR                Balanse for nitrogen paa landsbasis
        EQFOSF                Balanse for fosfor paa landsbasis
        EQKALI                Balanse for kali paa landsbasis

        EQSTKKBAL(M)          Balanse for STKK i markedsregion
        EQSAGKBAL(M)          Balanse for SAGK i markedsregion
        EQSVNKBAL(M)          Balanse for SVNK i markedsregion
        EQMELKBAL(VARE,M)     Balanse for KMLK og GMLK i markedsregion
        EQFJRKBAL(M)          Balanse for FJRK i markedsregion
        EQPRINBAL(M)          Balanse for PRIN i markedsregion
        EQPRINANDEL(VARE)     Andel råvare i PRIN 
        EQMOELINBAL(VARE,M)   Balanse for moellevarer inn i moeller i markedsregion
        EQMOELUTBAL(VARE,M)   Balanse for moellevarer ut av moeller i markedsregion
        EQGFORBAL(M)          Balanse for FGRV for markedsregioner
*
* Budsjettstoette primaerjordbruk
*
        EQRTILBRK(VARE,R)    Budsjettstoette primaerjordbruk produksjonsregion
        EQMTILBRK(VARE,M)    Budsjettstoette primaerjordbruk markedsregion
        EQTILBRK(VARE)       Budsjettstoette primaerjordbruk hele landet
*
* Kostnader primaerjordbruk
*
        EQRKOSTBRK(VARE,R)    Kostnader primaerjordbruk produksjonsregion
        EQMKOSTBRK(VARE,M)    Kostnader primaerjordbruk markedsregion
        EQKOSTBRK(VARE)       Kostnader primaerjordbruk hele landet
*
* Non-negative profits in the food sector
        EQFOODSECTORPROFIT    Food sector profit
*
* Faktorbruk
*
        EQRFAKTOR(VARE,R)    Innsatsfaktor mengde i produksjonsregion
        EQMFAKTOR(VARE,M)    Innsatsfaktor mengde i markedsregion
        EQFAKTOR(VARE)       Innsatsfaktor mengde hele landet
        EQAREAL              Areal hele landet
        EQAREALTOTTAK        Tak areal hele landet
*
* herunder naturlige forhold
        EQRRTAKAREAL(R)      Tak for alt areal i produksjonsregion
        EQRRTAKFULLJ(R)      Tak for fulldyrket jord i produksjonsregion
        EQRRTAKGROV(R)       Tak for grasareal i produksjonsregion
        EQRRTAKMTKRN(R)      Tak for matkornareal i produksjonsregion
        EQTAKKORN            Tak for kornareal hele landet
        EQRRTAKKORN(R)       Tak for kornareal i produksjonsregion
        EQRRTAKGFUB(R)       Tak for utmarksbeite i produksjonsregion
*
* Etterspoersel
*
        EQVAREBALANSE(VARE,M)         Likevekt for varemarkeder i markedsregion
*
* Transport
        EQTRNSBALANSE(VARE,M,MM) Transport mellom markedsregioner
*
* Romlig likevekt 
EQTRANSPORTLAV(VARE,M,MM)
* Romlig likevekt 
EQTRANSPORTHOY(VARE,M,MM)

* Handel
*
        EQIMPORT(VARE)       Import ordinaer
        EQQIMPORT(VARE)      Import kvote
        EQQAIMPORT(VARE)     Import administrative kvoter
        EQQBIMPORT(VARE)     Import bilateralte kvoter
        EQQSIMPORT(VARE)     Import sensitive produkter

        EQEKSPORT(VARE)      Eksport ordinaer
*
* Ligninger for politikk

        EQBEITE              Gulv beite
        EQRRGLVAREAL(R)      Arealgulv regioner
        EQSENGLVAREAL        Arealgulv sentrale stroek
        EQDISGLVAREAL        Arealgulv distrikter
        EQDGGLVAREAL(DG)     Arealgulv DG-regioner
        EQARBEID             Sysselsettingsgulv hele landet
        EQRARBEID(R)         Sysselsettingsgulv i produksjonsregion
        EQMARBEID(M)         Sysselsettingsgulv i markedsregion
        EQSDARBEID(SD)       Sysselsettingsgulv i sentrale stroek og distrikter
        EQPRDKGLV(PRDK)      Gulv omfang produksjoner hele landet
        EQKORNGLV            Gulv omfang kornareal hele landet
        EQGROVGLV            Gulv omfang grovforareal hele landet
        EQFULLGLV(FULLDYRK)  Gulv omfang fulldyrket areal hele landet
        EQOVERGLV(F)         Gulv omfang total overflatedyrket areal fylker
        EQAREAGLV            Gulv omfang planeproduksjoner hele landet
        EQAREAMGLV(M)        Gulv omfang planeproduksjoner markedsregioner
        EQNOKFOR             Norskprodusert andel av kraftfor til droevtyggere

        EQPRDKSDGLV(PRDK,SD) Gulv omfang produksjoner i sentrale stroek og distrikter
        EQPRDKFGLV(PRDK,F)   Gulv omfang produksjoner i fylker
        EQFKORNGLV(F)        Gulv omfang kornareal i fylker
        EQMKORNGLV(M)        Gulv omfang kornareal i markedsregioner
        EQFGROVGLV(F)        Gulv omfang grovforareal i fylker
        EQPRDKMGLV(PRDK,M)   Gulv omfang produksjoner i markedsregioner
        EQPRDKRGLV(PRDK,R)   Gulv omfang produksjoner i regioner
        EQKORNRGLV(R)        Gulv omfang aggregerte produksjoner i regioner
        EQGRNSRGLV(R)        Gulv omfang aggregerte produksjoner i regioner
        EQFRBARGLV(R)        Gulv omfang aggregerte produksjoner i regioner
        EQXPTAK(VARE)        Produksjonstak hele landet
        EQXPKORNTAK          Produksjonstak korn hele landet
        EQXPRTAK(VARE,R)     Produksjonstak regionalt
        EQXPGLV(VARE)        Produksjonsgulv hele landet
        EQXPKORNGLV          Produksjonsgulv korn hele landet
        EQXPSTKKGLV          Produksjonsgulv storfe og kalv hele landet
        EQXPFGLV(VARE,F)     Produksjonsgulv fylker
        EQXPFKORNGLV(F)      Produksjonsgulv korn fylker
        EQXPRGLV(VARE,R)     Produksjonsgulv regioner
        EQXPRKORNGLV(R)      Produksjonsgulv korn regioner
        EQXPMGLV(VARE,M)     Produksjonsgulv regioner
        EQXPMKORNGLV(M)      Produksjonsgulv korn markedsregioner
        EQXPSDGLV(VARE,SD)   Produksjonsgulv sluttprodukter sentralte stroek og distrikter

        EQXQTAK(VARE)        Tak kvoteimport hele landet
        EQAXQTAK(VARE)       Tak kvoteimport MFN-kvoter hele landet
        EQBXQTAK(VARE)       Tak kvoteimport bilaterale kvoter hele landet
        EQSXQTAK(VARE)       Tak kvoteimport sensitive produkter hele landet
        EQXETAK(VARE)        Tak eksport hele landet
        EQXPKMLKTAK(F)       Fylkesvise tak melkekvoter kumelk
        EQXPGMLKTAK(F)       Fylkesvise tak melkekvoter geitmelk
        EQSPRED(R)           Begrensning av spredareal i produksjonsregion

        EQSFOR(NSTOFF)       Selvforsyningsgrad for naeringsstoffer
        EQFORBAL             Forbalanse
        EQHELSE(KostGrp)     Helseeffekt av kosthold per vare
        EQHELSEOBS(KostGrp)     Teoretisk helseeffekt av kosthold per vare
        
        EQTargetFoodConsMax(FoodGrp) Maximum dietary recommended target consumption of food groups
        EQTargetFoodConsMin(FoodGrp) Minimum dietary recommended target consumption of food groups

        EQLANDEST            Landskapsestestikk
        EQBIODIV             Biomangfold
        EQCULTHER            Cultural hertiage
        EQRECREAT            Recration
        EQLANDESTObs         Landskapsestestikk
        EQBIODIVObs          Biomangfold
        EQCULTHERObs         Cultural hertiage
        EQRECREATObs         Recration
        EQTotEMIS_N          Emission nitrogen

        EQLUC1(R,CropTypeObj) Land use change
        EQLUC2(R,CropTypeObj) Land use change
        EQLUCObs(R,CropType) Theoretical costs of CO2e emissions of land use change per crop type and region of non-ag area into ag area

        EQDIETT(NSTOFF)      Norskprodusert mat per person og dag
        EQPRODSFOR(NSTOFF)   Norsk produksjon maalt i naeringsstoff
        EQKONSSFOR(NSTOFF)   Norsk forbruk maalt i naeringsstoff
        EQHNFITOT            High Nature Value Farm Total Index
        EQHNFIKRNSHR(FULLDYRK)         High Nature Value Farm Korn Delindex Shannon crop share
        EQHNFIKRNSHN         High Nature Value Farm Korn Delindex Shannon
        EQHNFIKRNNSP         High Nature Value Farm Korn Delindex N-runoff
        EQHNFIGRVRUM         High Nature Value Farm Gras Delindex Ruminant stocking density
        EQHNFIGRVNSP         High Nature Value Farm Gras Delindex N-runoff
        EQHNFIAPLNSP         High Nature Value Farm Annen plante delindex N-runoff


*
* Ligninger for utslipp og miljoindikatorer
*
        EQHUSDYRGJODSEL(R)
        EQGJODSELBAL(R)

        EQRNH3M
        EQRN2ONH3M
        EQRN2OM
        EQRNH3S
        EQRN2ONH3S
        EQRN2OS

        EQCO2AVGIFT
        EQGHGXP
        EQGHGXI
        EQGHGTAK

        EQAREALUBENG
        EQAREALTOTTAK
;
*
*
EQOBJEKT.. OBJ =E=
* Innenlandske salgsinntekter (inkludert importert vare)
                  SUM((VARE,M)$SLTVARE(VARE), p(VARE,'CONS',M)*x(VARE,'CONS',M))
* Eksportinntekter
                + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE)), (PE(VARE)-TRKOSTEKS(VARE,M))*xe(VARE,M))

* Utgifter for import
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi(VARE,M))
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq(VARE,M))
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa(VARE,M))
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb(VARE,M))
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs(VARE,M))
* theoretical import of gras protein to higher price than domestically produced
                - SUM(M, DATA('011101','FGRP','TOTP','Y') * xqs('FGRP',M))
*
* Budsjettstoette
                + SUM((VARE,R) $ TILSKUDD(VARE), (1-MCPF/100) * x(VARE,'PRIM',R))
* Kostnader primaerjordbruk uten kraftfor
                - SUM((VARE,R) $ INNSATSUKFOR(VARE), x(VARE,'PRIM',R))
* Foredlingskostnader slakterier
                - SUM((SLK,M),  SIMDATA(M,SLK,'PRIS','Y') * h(SLK,M))
* Foredlingskostnader meierier
                - SUM((MEIR,M), SIMDATA(M,MEIR,'PRIS','Y') * h(MEIR,M))
* Foredlingskostnader moeller
                - SUM((M,MOEL), SIMDATA(M,MOEL,'PRIS','Y') * h(MOEL,M))
* Foredlingskostnader kylling
                - SUM((KSLK,M), SIMDATA(M,KSLK,'PRIS','Y') * h(KSLK,M))
* Foredlingskostnader utenom meierier slakterier og moeller at wholesale level
                - SUM((VARE,M)$SLTVARE(VARE), FK(VARE,M) * x(VARE,'WHLS',M))
* Raavarer helimporterte kraftforprodukter
                - SUM((M,MOEL), MOLDATA('FSOY',MOEL) * (PI('FSOY')+KVOTETOLLA('FSOY')) * h(MOEL,M))
                - SUM((M,MOEL), MOLDATA('FANT',MOEL) * (PI('FANT')+KVOTETOLLA('FANT')) * h(MOEL,M))
* Margins at wholesale (WHLS) and retail (RETL) level
                - SUM((VARE,M)$SLTVARE(VARE), (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x(VARE,'CONS',M))
                - SUM((VARE,M)$SLTVARE(VARE), (MARGIN(VARE,M,'WHLS')                      ) * xe(VARE,M))
* Markedsordning melk PU - ikke utbetalt til eksportprodukter
                + SUM((MEIR,M),                  PUSATS(MEIR)   * h(MEIR,M))
                + SUM((M,VARE)$MEIINNVARE(VARE), PUINNT(M)      * x(VARE,'PRIM',M))
                + SUM((MEIR,M),                  PUDISB(MEIR,M) * h(MEIR,M))
                + SUM((M,MEIR,VARE)$MEIINNVARE(VARE), MEIDATA(VARE,MEIR) * PUSATS(MEIR) * xe(VARE,M))
                + SUM((MEIR,VARE,M),             PUBISATS(VARE) * h(MEIR,M) * MEIDATA(VARE,MEIR))
* Markedsregulering Eksportstoette
                + SUM((VARE,M), (1+MCPF/100) * EKSSUB(VARE) * xe(VARE,M))
* Intern utjevning meierivarer
                + SUM((M,MEIR), IUMEIR(MEIR) * h(MEIR,M))
* Intern utjevning kjoett
                + SUM((M,SSLK), IU(SSLK) * h(SSLK,M))
* Innfrakttilskudd jordbruksvarer unntatt kraftfôr
                + SUM((R,VARE)$ (PRODUKT(VARE) AND MEIINNVARE(VARE)) , (1-MCPF/100) * x(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ (PRODUKT(VARE) AND SLKINNVARE(VARE)) , (1-MCPF/100) * x(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ (PRODUKT(VARE) AND AINDVARE(VARE))   , (1-MCPF/100) * x(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ (PRODUKT(VARE) AND MOELINNVARE(VARE) AND MOELUTVARE(VARE)), (1-MCPF/100) * x(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ MOELUTKVARE(VARE)  , z(VARE,R)   *    (1-MCPF/100) * INNFRAKTTIL(R,VARE)) 
* Innfrakttilskudd kraftfôr defined as compensating transport costs
                + SUM((MM,VARE)$SUM(VAREVARE, MOELFLYT(VARE,VAREVARE)), (1-MCPF/100) * uttr(VARE,'OEST',MM) * TRKOST(VARE,'OEST',MM))
* Nedskriving korn
                + SUM((M,VARE), (1-MCPF/100) * x(VARE,'PRIM',M) * PRISNED(VARE))
* Miljoeavgift
                - ghgavgift
* Avgift på kraftfôr
                -  SUM((MOELUTVARE,R), (1+MCPF/100) * z(MOELUTVARE,R) * KFORAVG(R,MOELUTVARE))
* Avgift på nitrogen
                -  SUM(R, (1+MCPF/100) * z('NITG',R)  * KFORAVG(R,'NITG')) 
* Omsetningsavgift
                - SUM(VARE, OMSET(VARE) * x(VARE,'PRIM','NORGE'))
* Transportkostnader mellom markedsregioner
                - SUM((VARE,M,MM), uttr(VARE,M,MM)*TRKOST(VARE,M,MM))
*
$ifthenI.Ecosys %Ecosys%==YES
* Landscape estethics
                + SUM(R, landest(R) * WTPLandest(R))
* Biodiversity                                     
                + SUM(R, biodiv(R)  * WTPBiodiv(R))
* Cultural heritage                                
                + SUM(R, culther(R) * WTPCulther(R))
* Recreation                                       
                + SUM(R, recreat(R) * WTPRecreat(R))
* Avgift av emissions of nitrogen
                - emis_n
$endIf.Ecosys
*
$ifthenI.LUC %LUC%==YES
* Land use change
                - SUM((R,CropTypeObj), LUCInn(R,CropTypeObj) * LUCCoeff(R,'OTHER',CropTypeObj) * LUCAvg) 
                - SUM((R,CropTypeObj), LUCOut(R,CropTypeObj) * LUCCoeff(R,CropTypeObj,'OTHER') * LUCAvg) 
$endIf.LUC
*
* Consumer welfare including utility from food loss and waste
                + 0.5*SUM((VARE,SVARE,M), x(VARE,'CONS',M)*invBeta(VARE,SVARE,M)*x(SVARE,'CONS',M))
*
$ifThenI.PubHealth %PubHealth%==YES
* Health effects
                + SUM(KostGrp, helse(KostGrp))
$endIf.PubHealth
*
* PMP Allocation
                + SUM((B,R),      PmpProdCnst(R,B) *  g(B,R))
                + SUM((B,R), .5 * PmpProdQuad(R,B) * (g(B,R)**2) $ (PmpProdQuad(R,B) < 0))
                - SUM((B,R), .5 * PmpProdQuad(R,B) * (g(B,R)**2) $ (PmpProdQuad(R,B) > 0))
;
*                    
* Ligninger for produksjon
* Production primary agriculture in production region
EQXPR(VARE,R)$PRODUKT(VARE)..
               x(VARE,'PRIM',R) =E=  SUM(B, SIMDATA(R,B,'MNGD',VARE) * g(B,R));
*
* Production primary agriculture of cereal products in production region
EQXPMOEL(VARE,R)$(SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE) OR SAMEAS('FBLG',VARE))..
               x(VARE,'PRIM',R) =E=  SUM((B,VAREVARE)$MOELFLYT(VARE,VAREVARE), SIMDATA(R,B,'MNGD',VAREVARE) * g(B,R));
*
* Production primary agriculture all products in market region
EQXPM(VARE,M)$(PRODUKT(VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE) OR SAMEAS('FBLG',VARE))..
               x(VARE,'PRIM',M) =E= SUM(R$R_TIL_M(M,R), x(VARE,'PRIM',R));
*
* Production and trade of pure meat products for final consumption in market region
EQXPSSLKM(VARE,M)$(SSLKVARE(VARE) AND SLTVARE(VARE))..
               x(VARE,'WHLS',M) + xe(VARE,M)  =E= SUM(SSLK, SLKDATA(VARE,SSLK) * h(SSLK,M)) + xi(VARE,M) + xq(VARE,M) + xqa(VARE,M) + xqb(VARE,M)  + xqs(VARE,M);
*
* Production and trade of processed meat products for final consumption in market region
EQXPFSLKM(VARE,M)$(FSLKVARE(VARE) AND SLTVARE(VARE))..
               x(VARE,'WHLS',M) + xe(VARE,M)  =E= SUM(FSLK, SLKDATA(VARE,FSLK) * h(FSLK,M)) + xi(VARE,M) + xq(VARE,M) + xqa(VARE,M) + xqb(VARE,M)  + xqs(VARE,M);
*
* Production and trade of dairy products for final consumption in market region
EQXPMEIM(VARE,M)$(MEIVARE(VARE) AND SLTVARE(VARE))..
               x(VARE,'WHLS',M) + xe(VARE,M)  =E= SUM(MEIR, MEIDATA(VARE,MEIR) * h(MEIR,M)) + xi(VARE,M) + xq(VARE,M) + xqa(VARE,M) + xqb(VARE,M)  + xqs(VARE,M);
*
* Production and trade of poultry products for final consumption in market region
EQXPKYLM(VARE,M)$(FJRKMKVARE(VARE) AND SLTVARE(VARE))..
               x(VARE,'WHLS',M) + xe(VARE,M)  =E= SUM(KSLK, KYLDATA(VARE,KSLK) * h(KSLK,M)) + xi(VARE,M) + xq(VARE,M) + xqa(VARE,M) + xqb(VARE,M)  + xqs(VARE,M);
*
* Domestic processing of non-processed products for final consumption in Norway 
EQXPOPRD(VARE,M)$(SLTVARE(VARE) AND EFKVARE(VARE))..
               x(VARE,'WHLS',M) + xe(VARE,M)  =E= x(VARE,'PRIM',M) + xi(VARE,M) + xq(VARE,M) + xqa(VARE,M) + xqb(VARE,M)  + xqs(VARE,M);
*
* Production products for final consumption in Norway 
EQXWHLS(VARE)$SLTVARE(VARE)..
               x(VARE,'WHLS','NORGE') =E= SUM(M, x(VARE,'WHLS',M));
*
* Production products from primary agriculture in Norway 
EQXPRIM(VARE)$PRODUKT(VARE)..
               x(VARE,'PRIM','NORGE') =E= SUM(M, x(VARE,'PRIM',M));
*
* Ligninger for ettersporsel
EQXKM(VARE,M)$(SLTVARE(VARE) AND SUM(VAREVARE, BETA(VARE,VAREVARE,M)))..
         x(VARE,'CONS',M) =E= ALFA(VARE,M) - SUM(VAREVARE, p(VAREVARE,'CONS',M) * BETA(VARE,VAREVARE,M));
*
* Etterspoersel hele landet
EQXK(VARE)$SLTVARE(VARE)..
         x(VARE,'CONS','NORGE')    =E= SUM(M, x(VARE,'CONS',M));
*
* Varebalanse for sluttprodukter i markedsregion
EQVAREBALANSE(VARE,M)$SLTVARE(VARE)..    
             x(VARE,'CONS',M)                                                  + SUM(MM,  uttr(VARE,M,MM))
        =E=  x(VARE,'WHLS',M) * (1-sum(CProc, FoodLossWaste(VARE,CProc))/100)  + SUM(MM, inntr(VARE,M,MM));

*
* Romlig likevekt 
EQTRANSPORTLAV(VARE,M,MM)$SLTVARE(VARE)..
               p(VARE,'CONS',M) =L= p(VARE,'CONS',MM) + TRKOST(VARE,M,MM);
*
* Romlig likevekt 
EQTRANSPORTHOY(VARE,M,MM)$SLTVARE(VARE)..
               p(VARE,'CONS',M) =G= p(VARE,'CONS',MM) - TRKOST(VARE,M,MM);

*
*
* Varebalanser for mellomprodukter
* Gjoedselbalanse aapner for overskudd
* Balanse nitrogen paa landsbasis
EQNITR.. SUM((R,B), SIMDATA(R,B,'MNGD','NITR') * g(B,R)) =L= SUM((R,B), SIMDATA(R,B,'MNGD','NITH') * g(B,R)) + SUM((R,B), SIMDATA(R,B,'MNGD','NITG') * g(B,R));
*
* Balanse fosfor paa landsbasis
EQFOSF.. SUM((R,B), SIMDATA(R,B,'MNGD','FOSF') * g(B,R)) =L= SUM((R,B), SIMDATA(R,B,'MNGD','FOSH') * g(B,R)) + SUM((R,B), SIMDATA(R,B,'MNGD','FOSG') * g(B,R));
*
* Balanse kali paa landsbasis
EQKALI.. SUM((R,B), SIMDATA(R,B,'MNGD','KALI') * g(B,R)) =L= SUM((R,B), SIMDATA(R,B,'MNGD','KALH') * g(B,R)) + SUM((R,B), SIMDATA(R,B,'MNGD','KALG') * g(B,R));
*
* Ingen transport av raavarer til foredling mellom markedsregioner med unntak for PRIN og kraftfor
EQSTKKBAL(M)..
         SUM(SSLK, SLKDATA('STKK',SSLK) * h(SSLK,M)) + xe('STFK',M) + xe('KLVK',M)
   =E=   x('STFK','PRIM',M) + x('KLVK','PRIM',M) + xi('STFK',M) + xi('KLVK',M) + xq('STFK',M) + xq('KLVK',M)
       + xqa('STFK',M) + xqa('KLVK',M) + xqb('STFK',M) + xqb('KLVK',M) + xqs('STFK',M) + xqs('KLVK',M) ;
*
EQSAGKBAL(M)..
         SUM(SSLK, SLKDATA('SAGK',SSLK) * h(SSLK,M)) + xe('SAUK',M)
   =E=   x('SAUK','PRIM',M) + x('GETK','PRIM',M) + xi('SAUK',M) + xq('SAUK',M) + xqa('SAUK',M) + xqb('SAUK',M) + xqs('SAUK',M) ;
*
EQSVNKBAL(M)..
         SUM(SSLK, SLKDATA('SVNK',SSLK) * h(SSLK,M)) + xe('SVNK',M)
   =E=   x('SVNK','PRIM',M) + xi('SVNK',M) + xq('SVNK',M) + xqa('SVNK',M) + xqb('SVNK',M) + xqs('SVNK',M);
*
EQMELKBAL(VARE,M)$(SAMEAS('KMLK',VARE) OR SAMEAS('GMLK',VARE))..
         SUM(MEIR, MEIDATA(VARE,MEIR) * h(MEIR,M)) + xe(VARE,M)
   =E=   x(VARE,'PRIM',M) + xi(VARE,M) + xq(VARE,M) + xqa(VARE,M) + xqb(VARE,M) + xqs(VARE,M);
*
EQFJRKBAL(M)..
         SUM(KSLK, KYLDATA('FJRK',KSLK) * h(KSLK,M)) + xe('FJRK',M)
   =E=   x('FJRK','PRIM',M) + xi('FJRK',M) + xq('FJRK',M) + xqa('FJRK',M) + xqb('FJRK',M) + xqs('FJRK',M);
*
EQPRINBAL(M)..
         SUM(FSLK, SLKDATA('PRIN',FSLK) * h(FSLK,M) ) + SUM(MM,  uttr('PRIN',M,MM))
   =E=   SUM(SSLK, SLKDATA('PRIN',SSLK) * h(SSLK,M) ) + SUM(MM, inntr('PRIN',M,MM));

EQPRINANDEL('SAGK')..
         SUM(M,         SLKDATA('PRIN','SLSA') * h('SLSA',M))
   =L=   SUM((M,SSLK),  SLKDATA('PRIN',SSLK)   * h(SSLK,M) ) * PRINANDEL('SLSA') ;

* LHS: Produksjon og import av korn og oljevekster, RHS: Forbruk av korn og oljevekster i moeller
EQMOELINBAL(VARE,M)$SUM(VAREVARE, MOELFLYT(VARE,VAREVARE))..
        SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), x(VAREVARE,'PRIM',M))
         + xi(VARE,M) + xq(VARE,M) + xqa(VARE,M) + xqb(VARE,M) + xqs(VARE,M) + SUM(MM, inntr(VARE,M,MM))
   =E=   SUM(MOEL $ MOLDATA(VARE,MOEL), MOLDATA(VARE,MOEL) * h(MOEL,M))
        + SUM(VAREVARE$MOELFLYT(VARE,VAREVARE), xe(VAREVARE,M)) + SUM(MM, uttr(VARE,M,MM));
        
* LHS: Forbruk av kraftforråvarer og matmel, RHS: Produksjon av kraftfôr (z(VARE) og matmel (x(VARE))
EQMOELUTBAL(VARE,M)$MOELUTVARE(VARE)..
           SUM(MOEL$(MOLDATA(VARE,MOEL) AND MOELUTKVARE(VARE)),   MOLDATA(VARE,MOEL) * h(MOEL,M))
        +  SUM(MOEL$(MOLUTDATA(VARE,MOEL) AND SLTVARE(VARE)),     MOLUTDATA(VARE,MOEL) * h(MOEL,M))
   =E=     z(VARE,M) $ MOELUTKVARE(VARE)
         + x(VARE,'WHLS',M) $ SLTVARE(VARE) ;

* Krav til norskprodusert kraftfor for storfe
EQNOKFOR..
         x('BYGF','PRIM','NORGE')+x('HAVF','PRIM','NORGE')+x('RAPF','PRIM','NORGE')
   =G=   SUM((M,VARE)$(SAMEAS('FDRM',VARE) OR SAMEAS('FDRA',VARE)), z(VARE,M)) * POL('NORGE','KFOR','MNGD');
*
EQGFORBAL(M)..
         SUM((R,B,VARE)$(R_TIL_M(M,R) AND (SAMEAS('GFFS',VARE) OR SAMEAS('GFFB',VARE)
         OR SAMEAS('GFOS',VARE) OR SAMEAS('GFOB',VARE) OR SAMEAS('GFIB',VARE) OR SAMEAS('GFUB',VARE))),
         SIMDATA(R,B,'MNGD',VARE) * g(B,R))
   =G=   SUM((R,B)$R_TIL_M(M,R), SIMDATA(R,B,'MNGD','FGRV') * g(B,R));
*
* Transportbalanse for varer mellom markedsregioner
EQTRNSBALANSE(VARE,M,MM)$(SLTVARE(VARE) OR SAMEAS('PRIN',VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE) OR SAMEAS('FBLG',VARE)
                                        OR SAMEAS('FDRM',VARE) OR SAMEAS('FDRA',VARE) OR SAMEAS('FSVN',VARE) OR SAMEAS('FKYL',VARE)  OR SAMEAS('FEGG',VARE))
        .. inntr(VARE,MM,M) =E= uttr(VARE,M,MM);
*EQTRNSBALANSE(VARE,M,MM).. inntr(VARE,MM,M) =E= uttr(VARE,M,MM);
*
* Budsjettstoette ...
* ... produksjonsregion
EQRTILBRK(VARE,R)$TILSKUDD(VARE).. x(VARE,'PRIM',R) =E= SUM(B, SIMDATA(R,B,'VERD',VARE) * g(B,R)) ;
* ... markedsregion
EQMTILBRK(VARE,M)$TILSKUDD(VARE).. x(VARE,'PRIM',M) =E= SUM((R,B)$R_TIL_M(M,R), SIMDATA(R,B,'VERD',VARE) * g(B,R));
* ... hele landet
EQTILBRK(VARE)$TILSKUDD(VARE)..    x(VARE,'PRIM','NORGE')    =E= SUM((R,B), SIMDATA(R,B,'VERD',VARE) * g(B,R));
*
* Faktorbruk ...
* ... produksjonsregion
EQRFAKTOR(VARE,R)$INNSATS(VARE).. z(VARE,R) =E= SUM(B, SIMDATA(R,B,'MNGD',VARE) * g(B,R));
* ... markedsregion
EQMFAKTOR(VARE,M)$INNSATS(VARE).. z(VARE,M) =E= SUM(R$R_TIL_M(M,R), z(VARE,R));
* ... hele landet
EQFAKTOR(VARE)$INNSATS(VARE)..    z(VARE,'NORGE')    =E= SUM(R, z(VARE,R));
*
* Kostnader ...
* ... produksjonsregion
EQRKOSTBRK(VARE,R)$(INNSATS(VARE)$( SUM(B, SIMDATA(R,B,'VERD',VARE)) $ ((NOT SAMEAS('FMKN',VARE))$(NOT SAMEAS('FFKN',VARE))$(NOT SAMEAS('FBLG',VARE))))).. x(VARE,'PRIM',R) =E= SUM(B, SIMDATA(R,B,'VERD',VARE)*g(B,R)) ;
* ... markedsregion
EQMKOSTBRK(VARE,M)$(INNSATS(VARE)$((NOT SAMEAS('FMKN',VARE)) AND (NOT SAMEAS('FFKN',VARE)) AND (NOT SAMEAS('FBLG',VARE)))).. x(VARE,'PRIM',M) =E= SUM(R$R_TIL_M(M,R), x(VARE,'PRIM',R));
* ... hele landet
EQKOSTBRK(VARE)$(INNSATS(VARE)$((NOT SAMEAS('FMKN',VARE)) AND (NOT SAMEAS('FFKN',VARE)) AND (NOT SAMEAS('FBLG',VARE))))..    x(VARE,'PRIM','NORGE')  =E= SUM(R, x(VARE,'PRIM',R));
*
*
* Non-negative profit in the agricultural sector
EQFOODSECTORPROFIT..     AGProfit  =L= 
* Innenlandske salgsinntekter (inkludert importert vare)
                  SUM((VARE,M)$SLTVARE(VARE), p(VARE,'CONS',M)*x(VARE,'CONS',M))
* Eksportinntekter
                + SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE)), (PE(VARE)-TRKOSTEKS(VARE,M))*xe(VARE,M))
* Utgifter for import
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+TOLL(VARE)      +TRKOSTIMP(VARE,M))*xi(VARE,M))
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLL(VARE) +TRKOSTIMP(VARE,M))*xq(VARE,M))
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLLA(VARE)+TRKOSTIMP(VARE,M))*xqa(VARE,M))
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLLB(VARE)+TRKOSTIMP(VARE,M))*xqb(VARE,M))
                - SUM((VARE,M)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE)), (PI(VARE)+KVOTETOLLS(VARE)+TRKOSTIMP(VARE,M))*xqs(VARE,M))
* theoretical import of gras protein to higher price than domestically produced
                - SUM(M, DATA('011101','FGRP','TOTP','Y') * xqs('FGRP',M))
* Budsjettstoette
                + SUM((VARE,R) $ TILSKUDD(VARE), (1-MCPF/100) * x(VARE,'PRIM',R))
* Kostnader primaerjordbruk uten kraftfor
                - SUM((VARE,R) $ INNSATSUKFOR(VARE), x(VARE,'PRIM',R))
* Foredlingskostnader slakterier
                - SUM((SLK,M),  SIMDATA(M,SLK,'PRIS','Y') * h(SLK,M))
* Foredlingskostnader meierier
                - SUM((MEIR,M), SIMDATA(M,MEIR,'PRIS','Y') * h(MEIR,M))
* Foredlingskostnader moeller
                - SUM((M,MOEL), SIMDATA(M,MOEL,'PRIS','Y') * h(MOEL,M))
* Foredlingskostnader kylling
                - SUM((KSLK,M), SIMDATA(M,KSLK,'PRIS','Y') * h(KSLK,M))
* Foredlingskostnader utenom meierier slakterier og moeller at wholesale level
                - SUM((VARE,M)$SLTVARE(VARE), FK(VARE,M) * x(VARE,'WHLS',M))
* Raavarer helimporterte kraftforprodukter
                - SUM((M,MOEL), MOLDATA('FSOY',MOEL) * (PI('FSOY')+KVOTETOLLA('FSOY')) * h(MOEL,M))
                - SUM((M,MOEL), MOLDATA('FANT',MOEL) * (PI('FANT')+KVOTETOLLA('FANT')) * h(MOEL,M))
* Margins at wholesale (WHLS) and retail (RETL) level
                - SUM((VARE,M)$SLTVARE(VARE), (MARGIN(VARE,M,'WHLS')+MARGIN(VARE,M,'RETL')) * x(VARE,'CONS',M))
                - SUM((VARE,M)$SLTVARE(VARE), (MARGIN(VARE,M,'WHLS')                      ) * xe(VARE,M))
* Markedsordning melk PU - ikke utbetalt til eksportprodukter
                + SUM((MEIR,M),                  PUSATS(MEIR)   * h(MEIR,M))
                + SUM((M,VARE)$MEIINNVARE(VARE), PUINNT(M)      * x(VARE,'PRIM',M))
                + SUM((MEIR,M),                  PUDISB(MEIR,M) * h(MEIR,M))
                + SUM((M,MEIR,VARE)$MEIINNVARE(VARE), MEIDATA(VARE,MEIR) * PUSATS(MEIR) * xe(VARE,M))
* Markedsregulering Eksportstoette
                + SUM((VARE,M), (1+MCPF/100) * EKSSUB(VARE) * xe(VARE,M))
* Intern utjevning meierivarer
                + SUM((M,MEIR), IUMEIR(MEIR) * h(MEIR,M))
* Intern utjevning kjoett
                + SUM((M,SSLK), IU(SSLK) * h(SSLK,M))
* Innfrakttilskudd jordbruksvarer unntatt kraftfôr
                + SUM((R,VARE)$ (PRODUKT(VARE) AND MEIINNVARE(VARE)) , (1-MCPF/100) * x(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ (PRODUKT(VARE) AND SLKINNVARE(VARE)) , (1-MCPF/100) * x(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ (PRODUKT(VARE) AND AINDVARE(VARE))   , (1-MCPF/100) * x(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ (PRODUKT(VARE) AND MOELINNVARE(VARE) AND MOELUTVARE(VARE)), (1-MCPF/100) * x(VARE,'PRIM',R) * INNFRAKTTIL(R,VARE)) 
                + SUM((R,VARE)$ MOELUTKVARE(VARE)  , z(VARE,R)   *    (1-MCPF/100) * INNFRAKTTIL(R,VARE)) 
* Innfrakttilskudd kraftfôr defined as compensating transport costs
                + SUM((MM,VARE)$SUM(VAREVARE, MOELFLYT(VARE,VAREVARE)), (1-MCPF/100) * uttr(VARE,'OEST',MM) * TRKOST(VARE,'OEST',MM))
* Nedskriving korn
                + SUM((M,VARE), (1-MCPF/100) * x(VARE,'PRIM',M) * PRISNED(VARE))
* Avgift på kraftfôr
                -  SUM((MOELUTVARE,R), (1+MCPF/100) * z(MOELUTVARE,R) * KFORAVG(R,MOELUTVARE))
* Avgift på nitrogen
                -  SUM(R, (1+MCPF/100) * z('NITG',R)  * KFORAVG(R,'NITG')) 
* Omsetningsavgift
                - SUM(VARE, OMSET(VARE) * x(VARE,'PRIM','NORGE'))
* Transportkostnader mellom markedsregioner
                - SUM((VARE,M,MM), uttr(VARE,M,MM)*TRKOST(VARE,M,MM))
* Miljoeavgift
                - ghgavgift
                
$ifthenI.Ecosys %Ecosys%==YES
* Avgift av emissions of nitrogen
                - emis_n
$endIf.Ecosys
* PMP Allocation
                + SUM((B,R),      PmpProdCnst(R,B) *  g(B,R))
                + SUM((B,R), .5 * PmpProdQuad(R,B) * (g(B,R)**2) $ (PmpProdQuad(R,B) < 0))
                - SUM((B,R), .5 * PmpProdQuad(R,B) * (g(B,R)**2) $ (PmpProdQuad(R,B) > 0))
;
*
* Begresning gjennom naturlige forhold...
* ... men med viss fleksibilitet
* ... arealtak hele landet
EQAREALTOTTAK.. SUM((B,PLANTE,R)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE)*g(B,R)) =L= POL('NORGE','TRADAR','TAK');
*
* ... arealtak i produksjonsregion
EQRRTAKAREAL(R).. SUM((B,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE) * g(B,R)) =L= POL(R,'AREAL','TAK');
*
* ... grasareal i produksjonsregion
EQRRTAKGROV(R).. SUM((B,GROV), SIMDATA(R,B,'OMFG',GROV) * g(B,R)) + SUM(B, SIMDATA(R,B,'OMFG','GFUB') * g(B,R)) =L= POL(R,'GRAS','TAK');
*
* ... tak paa fulldykret jord i produksjonsregioner
EQRRTAKFULLJ(R).. SUM((B,FULLDYRK), SIMDATA(R,B,'OMFG',FULLDYRK) * g(B,R)) =L= POL(R,'FULLJ','TAK');
*
* ... tak paa matkornareal i produksjonsregioner
EQRRTAKMTKRN(R).. SUM((B,FULLDYRKMAT), SIMDATA(R,B,'OMFG',FULLDYRKMAT) * g(B,R)) =L= POL(R,'MATKN','TAK');
*
* ... tak paa kornareal i Norge
EQTAKKORN.. SUM((R,B,KORN), SIMDATA(R,B,'OMFG',KORN) * g(B,R)) =L= POL('NORGE','KORN','TAK');
*
* ... tak paa kornareal i produksjonsregioner
EQRRTAKKORN(R).. SUM((B,KORN), SIMDATA(R,B,'OMFG',KORN) * g(B,R)) =L= POL(R,'KORN','TAK');
*
* ... tak paa utmarksbeite i produksjonsregioner
EQRRTAKGFUB(R).. SUM(B, SIMDATA(R,B,'OMFG','GFUB') * g(B,R)) =L= POL(R,'GFUB','TAK');
*
*Likninger for ordinaer import kvoteimport og eksport av produkter
*
* Ordinaer import
EQIMPORT(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE))
              ..  xi(VARE,'NORGE') =E= SUM(M, xi(VARE,M));
*
* Kvoteimport
* MFN-kvoter
EQQIMPORT(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE))
              .. xq(VARE,'NORGE') =E= SUM(M, xq(VARE,M));
* Administrative kvoter
EQQAIMPORT(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE))
              .. xqa(VARE,'NORGE') =E= SUM(M, xqa(VARE,M));
* Bilaterale kvoter
EQQBIMPORT(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE))
              .. xqb(VARE,'NORGE') =E= SUM(M, xqb(VARE,M));
* Sensitive produkter
EQQSIMPORT(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE))
              .. xqs(VARE,'NORGE') =E= SUM(M, xqs(VARE,M));
* Eksport
EQEKSPORT(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR MOELVARE(VARE))
              .. xe(VARE,'NORGE') =E= SUM(M, xe(VARE,M));
*
*
* Politiske rammebetingelser modellert som restriksjoner for ...
*
* ... areal hele landet
EQAREAL..  SUM((R,B,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)),SIMDATA(R,B,'OMFG',PLANTE)*g(B,R)) =G= POL('NORGE','AREAL','GLV');
*
* ... tradisjonelt areal hele landet
EQAREALUBENG..  SUM((B,PLANTE,R)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE)*g(B,R)) =G= POL('NORGE','TRADAR','GLV');
*
* ... beite hele landet
EQBEITE..  SUM((B,R,BEIT), SIMDATA(R,B,'OMFG',BEIT)*g(B,R)) =G= POL('NORGE','BEITE','GLV');
*
* ... arealgulv i produksjonsregion
EQRRGLVAREAL(R).. SUM((B,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)),SIMDATA(R,B,'OMFG',PLANTE)*G(B,R)) =G= POL(R,'AREAL','GLV');

* ... arealgulv i sentrale stroek
EQSENGLVAREAL..   SUM((B,PLANTE,R)$(R_TIL_SD('000100',R) AND (NOT SAMEAS('GFUB',PLANTE))),SIMDATA(R,B,'OMFG',PLANTE)*G(B,R)) =G= POL('000100','AREAL','GLV');

* ... arealgulv i distrikter
EQDISGLVAREAL..   SUM((B,PLANTE,R)$R_TIL_SD('000200',R), SIMDATA(R,B,'OMFG',PLANTE)*G(B,R)) =G= POL('000200','AREAL','GLV');
*
* ... arealgulv i DG-regioner
EQDGGLVAREAL(DG)..  SUM((B,PLANTE,R)$R_TIL_DG(DG,R), SIMDATA(R,B,'OMFG',PLANTE)*G(B,R)) =G= POL(DG,'AREAL','GLV');
*
* ... sysselsettingsgulv hele landet
EQARBEID..        SUM((R,B), SIMDATA(R,B,'MNGD','ARBF') * g(B,R)) =G= POL('NORGE','ARB','GLV');
*
* ... sysselsettingsgulv i markedsregion
EQMARBEID(M)..    SUM((R,B)$R_TIL_M(M,R), SIMDATA(R,B,'MNGD','ARBF') * g(B,R)) =G= POL(M,'ARB','GLV');
*
* ... sysselsettingsgulv i produksjonsregion
EQRARBEID(R)..    SUM(B, SIMDATA(R,B,'MNGD','ARBF') * g(B,R)) =G= POL(R,'ARB','GLV');
*
* ... sysselsettingsgulv i sentrale stroek og distrikter
EQSDARBEID(SD)..  SUM((R,B)$R_TIL_SD(SD,R), SIMDATA(R,B,'MNGD','ARBF') * g(B,R)) =G= POL(SD,'ARB','GLV');
*
* ... gulv omfang produksjoner hele landet
EQPRDKGLV(PRDK).. SUM((R,B),        SIMDATA(R,B,'OMFG',PRDK) * g(B,R))     =G= POL('NORGE',PRDK,'PRDK_GLV');
EQPRDKMGLV(PRDK,M).. SUM((R,B)$R_TIL_M(M,R),  SIMDATA(R,B,'OMFG',PRDK) * g(B,R)) =G= POL(M,PRDK,'PRDK_GLV');
EQKORNGLV..       SUM((R,B,KORN),   SIMDATA(R,B,'OMFG',KORN) * g(B,R))     =G= POL('NORGE','KORN','PRDK_GLV');
EQMKORNGLV(M)..   SUM((R,B,KORN)$R_TIL_M(M,R),   SIMDATA(R,B,'OMFG',KORN) * g(B,R))     =G= POL(M,'KORN','PRDK_GLV');
EQGROVGLV..       SUM((R,B,GROV),   SIMDATA(R,B,'OMFG',GROV) * g(B,R))     =G= POL('NORGE','GROV','PRDK_GLV');
EQAREAGLV..       SUM((R,B,PLANTE), SIMDATA(R,B,'OMFG',PLANTE) * g(B,R))   =G= POL('NORGE','PLNT','PRDK_GLV');
EQAREAMGLV(M)..     SUM((R,B,PLANTE)$(R_TIL_M(M,R) AND (NOT SAMEAS('GFUB',PLANTE))), SIMDATA(R,B,'OMFG',PLANTE) * g(B,R))   =G= POL(M,'AREAL','GLV');
EQFULLGLV(FULLDYRK)..       SUM((R,B), SIMDATA(R,B,'OMFG',FULLDYRK) * g(B,R)) =G= POL('NORGE',FULLDYRK,'PRDK_GLV');
EQOVERGLV(F)..    SUM((R,B,OVERDYRK)$R_TIL_F(F,R), SIMDATA(R,B,'OMFG',OVERDYRK) * g(B,R)) =G= POL(F,'OVERDYRK','PRDK_GLV');
*
EQPRDKRGLV(PRDK,R) $ (POL(R,PRDK,'PRDK_GLV') > 0).. SUM(B, SIMDATA(R,B,'OMFG',PRDK) * g(B,R))   =E= POL(R,PRDK,'PRDK_GLV') ;
EQKORNRGLV(R) $ (POL(R,'Korn','PRDK_GLV') > 0).. Sum((B,KornOljePrdk), SIMDATA(R,B,'OMFG',KornOljePrdk) * g(B,R)) =E= POL(R,'Korn','PRDK_GLV');
EQGRNSRGLV(R) $ (POL(R,'GRNS','PRDK_GLV') > 0).. Sum((B,GRNS),         SIMDATA(R,B,'OMFG',GRNS)         * g(B,R)) =E= POL(R,'GRNS','PRDK_GLV');
EQFRBARGLV(R) $ (POL(R,'FRBA','PRDK_GLV') > 0).. Sum((B,FRBA),         SIMDATA(R,B,'OMFG',FRBA)         * g(B,R)) =E= POL(R,'FRBA','PRDK_GLV');
*
* ... gulv omfang produksjoner i sentrale stroek og distrikter
EQPRDKSDGLV(PRDK,SD).. SUM((R,B)$R_TIL_SD(SD,R), SIMDATA(R,B,'OMFG',PRDK) * g(B,R)) =G= POL(SD,PRDK,'PRDK_GLV');
*
* ... gulv omfang produksjoner i fylker
EQPRDKFGLV(PRDK,F)$(NOT FP(PRDK))..  SUM((R,B)     $R_TIL_F(F,R), SIMDATA(R,B,'OMFG',PRDK) * g(B,R)) =G= POL(F,PRDK,'PRDK_GLV');
EQFKORNGLV(F)..                      SUM((R,B,KORN)$R_TIL_F(F,R), SIMDATA(R,B,'OMFG',KORN) * g(B,R)) =G= POL(F,'KORN','PRDK_GLV');
EQFGROVGLV(F)..                      SUM((R,B,GROV)$R_TIL_F(F,R), SIMDATA(R,B,'OMFG',GROV) * g(B,R)) =G= POL(F,'GROV','PRDK_GLV');
*
* ... produksjonstak hele landet
EQXPTAK(VARE)$PRODUKT(VARE)..   x(VARE,'PRIM','NORGE') =L= POL('NORGE',VARE,'VARE_TAK');
EQXPKORNTAK..   SUM((R,VARE)$((MOELINNVARE(VARE) AND PRODUKT(VARE))), x(VARE,'PRIM',R)) =L= POL('NORGE','KORN','VARE_TAK');
* ... produksjonstak regionalt
EQXPRTAK(PRODUKT,R)..   x(PRODUKT,'PRIM',R) =L= POL(R,PRODUKT,'VARE_TAK');
*
* ... produksjonsgulv regionalt
EQXPRGLV(VARE,R)$PRODUKT(VARE)..   x(VARE,'PRIM',R) =G= POL(R,VARE,'VARE_GLV');
EQXPRKORNGLV(R)..    SUM(VARE$((MOELINNVARE(VARE) AND PRODUKT(VARE))), x(VARE,'PRIM',R)) =G= POL(R,'KORN','VARE_GLV');
EQXPMGLV(VARE,M)$PRODUKT(VARE)..   SUM(R$R_TIL_M(M,R), x(VARE,'PRIM',R)) =G= POL(M,VARE,'VARE_GLV');
EQXPMKORNGLV(M)..    SUM((VARE,R)$(R_TIL_M(M,R) AND (MOELINNVARE(VARE) AND PRODUKT(VARE))), x(VARE,'PRIM',R)) =G= POL(M,'KORN','VARE_GLV');
EQXPFGLV(VARE,F)$PRODUKT(VARE)..   SUM(R$R_TIL_F(F,R), x(VARE,'PRIM',R)) =G= POL(F,VARE,'VARE_GLV');
EQXPFKORNGLV(F)..    SUM((R,VARE)$(R_TIL_F(F,R) AND MOELINNVARE(VARE) AND PRODUKT(VARE)), x(VARE,'PRIM',R)) =G= POL(F,'KORN','VARE_GLV');
*
* ... produksjonsgulv hele landet
EQXPGLV(VARE)$PRODUKT(VARE)..   x(VARE,'PRIM','NORGE') =G= POL('NORGE',VARE,'VARE_GLV');
EQXPKORNGLV..    SUM((R,VARE)$(MOELINNVARE(VARE) AND PRODUKT(VARE)), x(VARE,'PRIM',R)) =G= POL('NORGE','KORN','VARE_GLV');
EQXPSTKKGLV..    x('STFK','PRIM','NORGE') + x('KLVK','PRIM','NORGE') =G= POL('NORGE','STKK','VARE_GLV');

* ... produksjonsgulv sentrale stroek og distrikter
EQXPSDGLV(VARE,SD)$ PRODUKT(VARE)..   SUM(R$R_TIL_SD(SD,R), x(VARE,'PRIM',R)) =G= POL(SD,VARE,'VARE_GLV');
*
* ... tak kvoteimport hele landet
EQXQTAK(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('PRIN',VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE))..
         xq(VARE,'NORGE') =L= POL('NORGE',VARE,'MFNIMPT');
EQAXQTAK(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('PRIN',VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE))..
         xqa(VARE,'NORGE') =L= POL('NORGE',VARE,'ADMIMPT');
EQBXQTAK(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('PRIN',VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE))..
         xqb(VARE,'NORGE') =L= POL('NORGE',VARE,'BILIMPT');
EQSXQTAK(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('PRIN',VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE))..
         xqs(VARE,'NORGE') =L= POL('NORGE',VARE,'SENIMPT');
*
* ... tak kvoteeksport hele landet
EQXETAK(VARE)$(PRODUKT(VARE) OR SLTVARE(VARE) OR SAMEAS('PRIN',VARE) OR SAMEAS('FMKN',VARE) OR SAMEAS('FFKN',VARE))..
         xe(VARE,'NORGE') =L= POL('NORGE',VARE,'KVTEXPT');
*
* ... regionale melkekvoter
EQXPKMLKTAK(F)..   SUM(R$R_TIL_F(F,R), x('KMLK','PRIM',R)) =L= POL(F,'KMLK','KVOTE');
EQXPGMLKTAK(F)..   SUM(R$R_TIL_F(F,R), x('GMLK','PRIM',R)) =L= POL(F,'GMLK','KVOTE');
*
* ... begrensning av spredareal i produksjonsregion
EQSPRED(R)..  SUM(B, SIMDATA(R,B,'OMFG','SPRE') * g(B,R)) =E= v_spred(R);
*
*
* Klimautslipp og miljoeindikatorer
*
EQHUSDYRGJODSEL(R)..  husdyrgjodsel(R)* g('BKRN',R) =E=
                      SUM(B$(SAMEAS(B,'BGRI') OR SAMEAS(B,'BHOE') OR SAMEAS(B,'BKYL')), SIMDATA(R,B,'MNGD','NITH') * g(B,R));

EQGJODSELBAL(R).. SIMDATA(R,'BKRN','MNGD','NITR') =E= husdyrgjodsel(R) + kunstgjodsel(R);


EQRN2OM..     n2om    =E= SUM((R,B)$(SAMEAS(B,'BGRI') OR SAMEAS(B,'BHOE') OR SAMEAS(B,'BKYL')), SIMDATA(R,B,'MNGD','N2OM')    * g(B,R));
EQRNH3M..     nh3m    =E= SUM((R,B)$(SAMEAS(B,'BGRI') OR SAMEAS(B,'BHOE') OR SAMEAS(B,'BKYL')), SIMDATA(R,B,'MNGD','NH3M')    * g(B,R));
EQRN2ONH3M..  n2onh3m =E= SUM((R,B)$(SAMEAS(B,'BGRI') OR SAMEAS(B,'BHOE') OR SAMEAS(B,'BKYL')), SIMDATA(R,B,'MNGD','N2ONH3M') * g(B,R));


EQRN2OS..    n2os    =E= SUM(R$SIMDATA(R,'BKRN','MNGD','NITR'), SIMDATA(R,'BKRN','MNGD','N2OS')    * (SIMDATA(R,'BKRN','MNGD','NITG')/SIMDATA(R,'BKRN','MNGD','NITR')) * g('BKRN',R));
EQRNH3S..    nh3s    =E= SUM(R$SIMDATA(R,'BKRN','MNGD','NITR'), SIMDATA(R,'BKRN','MNGD','NH3S')    * (SIMDATA(R,'BKRN','MNGD','NITG')/SIMDATA(R,'BKRN','MNGD','NITR')) * g('BKRN',R));
EQRN2ONH3S.. n2onh3s =E= SUM(R$SIMDATA(R,'BKRN','MNGD','NITR'), SIMDATA(R,'BKRN','MNGD','N2ONH3S') * (SIMDATA(R,'BKRN','MNGD','NITG')/SIMDATA(R,'BKRN','MNGD','NITR')) * g('BKRN',R));

EQCO2AVGIFT.. ghgavgift =E= SUM((R,B,UTSLIPPAVG), SIMDATA(R,B,'MNGD',UTSLIPPAVG) * g(B,R) * CO2AVGXP(UTSLIPPAVG) )
                          + SUM((M,VARE), (xi(VARE,M)+xq(VARE,M)+xqa(VARE,M)+xqb(VARE,M)+xqs(VARE,M)) * GHGXIPOT(VARE) * CO2AVGXI('CO2'));

$ifthenI.Ecosys %Ecosys%==YES
EQTotEMIS_N.. emis_n =E=   SUM((R,B), SIMDATA(R,B,'VERD','EMIS_N') * g(B,R));
$endIf.Ecosys

EQGHGXP.. ghgxp =E=   SUM((R,B,UTSLIPPGHG), SIMDATA(R,B,'MNGD',UTSLIPPGHG) * g(B,R) * GHGPOTENSIAL(UTSLIPPGHG)  )
                    + SUM((M,UTSLIPPGHG,KMOEL), h(KMOEL,M) * .15 * GHGMOELUTVARE(UTSLIPPGHG) * GHGPOTENSIAL(UTSLIPPGHG))
                    + SUM((R,B,HGJOD,UTSLIPPGHG), SIMDATA(R,B,UTSLIPPGHG,HGJOD) * GHGPOTENSIAL(UTSLIPPGHG)  * g(B,R));
EQGHGXI.. ghgxi =E=   SUM((M,VARE), (xi(VARE,M)+xq(VARE,M)+xqa(VARE,M)+xqb(VARE,M)+xqs(VARE,M)) * GHGXIPOT(VARE));


EQGHGTAK.. SUM((R,B,UTSLIPPGHG), SIMDATA(R,B,'MNGD',UTSLIPPGHG) * g(B,R) * GHGPOTENSIAL(UTSLIPPGHG)  ) =L= POL('NORGE','GHG','TAK');


*
* Ecosystem services
*
EQLANDEST(R)..  landest(R)  =L= landestobs(R)  ;
EQBIODIV(R) ..   biodiv(R)  =L= biodivobs(R)   ;
EQCULTHER(R)..  culther(R)  =L= cultherobs(R)  ;
EQRECREAT(R)..  recreat(R)  =L= recreatobs(R)  ;
                                 
*
* mill NOK: [daa/farm x 1000 farms - 1000 daa] x 1000 NOK/daa 
* negative number if land goes out of production
* positive number if land comes into production
EQLANDESTobs(R)..  landestobs(R)  =E=  SUM((PRDK,B) $ (PLANTE(PRDK) $ (NOT SAMEAS('GFUB',PRDK))), SIMDATA(R,B,'OMFG',PRDK) * g(B,R)) - Ref_landest(R) ;
EQBIODIVobs(R) ..   biodivobs(R)  =E=   (SUM((GROV,B),  SIMDATA(R,B,'OMFG',GROV)   * g(B,R))                  
                                       + SUM(B,         SIMDATA(R,B,'OMFG','GFUB') * g(B,R))) - Ref_biodiv(R);              ;
EQCULTHERobs(R)..  cultherobs(R)  =E=  SUM((PLANTE,B), SIMDATA(R,B,'OMFG',PLANTE) * g(B,R)) - Ref_culther(R) ;
EQRECREATobs(R)..  recreatobs(R)  =E=  SUM((PLANTE,B), SIMDATA(R,B,'OMFG',PLANTE) * g(B,R)) - Ref_recreat(R) ;
*
* LUC land use change
EQLUC1(R,CropTypeObj)..       LUCObs(R,CropTypeObj) - LUCInn(R,CropTypeObj) + LUCOut(R,CropTypeObj) =E= 0;
EQLUC2(R,CropTypeObj)..   2 * LUCInn(R,CropTypeObj) =E= LUCObs(R,CropTypeObj) + LUCInn(R,CropTypeObj) + LUCOut(R,CropTypeObj);
*
EQLUCObs(R,CropTypeObj)..  LUCObs(R,CropTypeObj)  =E= SUM((B,PRDK)$CropTypeObj_to_PRDK(CropTypeObj,PRDK), SIMDATA(R,B,'OMFG',PRDK) * g(B,R)) - Ref_LUC(R,CropTypeObj) ;
*
*
* Selvforsyning og beredskap
*
EQSFOR(NSTOFF)$(NOT SAMEAS('FFEM',NSTOFF)).. sfor(NSTOFF) =G=    SUM(SLTVARE, x(SLTVARE,'PRIM','NORGE') * NAERING(SLTVARE,NSTOFF))  /
                                                                (SUM(SLTVARE, x(SLTVARE,'CONS','NORGE') * NAERING(SLTVARE,NSTOFF)) +
                                                                 SUM(SLTVARE, xe(SLTVARE,'NORGE') * NAERING(SLTVARE,NSTOFF)));

EQPRODSFOR(NSTOFF)$(NOT SAMEAS('FFEM',NSTOFF)).. SUM(PRODUKT$((NOT SAMEAS('BYGG',PRODUKT)) AND (NOT SAMEAS('HAVR',PRODUKT))), x(PRODUKT,'PRIM','NORGE') * NAERING(PRODUKT,NSTOFF)) / 1000 / .239  =G= POL('NORGE',NSTOFF,'PROD');
EQKONSSFOR(NSTOFF)$(NOT SAMEAS('FFEM',NSTOFF)).. SUM(SLTVARE,                                                                 x(SLTVARE,'CONS','NORGE') * NAERING(SLTVARE,NSTOFF)) / 1000 / .239  =G= POL('NORGE',NSTOFF,'KONS');

*
* Konsum i mill kg og befolkning i mill omregnes i g per dag
* TMREL:g per dag
* DALYCHG: DALY per g per dag
* VSL: mill kr per DALY
* corrected for food waste and loss at all food chain stages
* measured against TMREL
* enters objektive function positive
EQHelse(KostGrp).. helse(KostGrp) =L= helseobs(KostGrp);  
*
EQHelseobs(KostGrp).. helseobs(KostGrp) =E=  
   ((( SUM(Vare$KostVare(KostGrp,Vare), x(Vare,'CONS','NORGE') * EatCorr(KostGrp) * (1 - Sum(CCons, FoodLossWaste(VARE,CCons))/100)) * 1000 / (POPBAS * (1+POP)**(Y-%BAS%)) / 365) - RefDiet(KostGrp)) 
   * DALYPerG(KostGrp,'act') * VSL) $ (GBDDiet(KostGrp) < TMREL(KostGrp))

+  ((RefDiet(KostGrp) - TMREL(KostGrp) - (SUM(Vare$KostVare(KostGrp,Vare), x(Vare,'CONS','NORGE') * EatCorr(KostGrp) * (1 - Sum(CCons, FoodLossWaste(VARE,CCons))/100)) * 1000 / (POPBAS * (1+POP)**(Y-%BAS%)) / 365))
   * DALYPerG(KostGrp,'act') * VSL) $ (GBDDiet(KostGrp) > TMREL(KostGrp))
;
*
* Target dietary recommendation of food groups in gram per person per day
EQTargetFoodConsMax(FoodGrp) $ POL('NORGE',FoodGrp,'MAX')..
     SUM(Vare$FoodVare(FoodGrp,Vare), x(Vare,'CONS','NORGE') * (1 - Sum(CCons, FoodLossWaste(VARE,CCons))/100)) * 1000 / (POPBAS * (1+POP)**(Y-%BAS%)) / 365
          =L= POL('NORGE',FoodGrp,'MAX') ;      
*
EQTargetFoodConsMin(FoodGrp) $ POL('NORGE',FoodGrp,'MIN')..
     SUM(Vare$FoodVare(FoodGrp,Vare), x(Vare,'CONS','NORGE') * (1 - Sum(CCons, FoodLossWaste(VARE,CCons))/100)) * 1000 / (POPBAS * (1+POP)**(Y-%BAS%)) / 365
          =G= POL('NORGE',FoodGrp,'MIN') ;      
*
EQDIETT(NSTOFF)$(NOT SAMEAS('FFEM',NSTOFF)).. SUM(PRODUKT$((NOT SAMEAS('BYGG',PRODUKT)) AND (NOT SAMEAS('HAVR',PRODUKT))), x(PRODUKT,'PRIM','NORGE') * NAERING(PRODUKT,NSTOFF)) / 365 / (POPBAS * ((1 + POP) ** (Y - %BAS%))) =G= POL('NORGE',NSTOFF,'GLV');

EQFORBAL..  forbal =G=  SUM(FFEMPROD$((NOT SAMEAS('FMKN',FFEMPROD)) OR (NOT SAMEAS('FFKN',FFEMPROD))),
                        x(FFEMPROD,'PRIM','NORGE') * NAERING(FFEMPROD,'FFEM'))
                     / (SUM(FFEMPROD$((NOT SAMEAS('FMKN',FFEMPROD)) OR (NOT SAMEAS('FFKN',FFEMPROD))),
                        x(FFEMPROD,'PRIM','NORGE') * NAERING(FFEMPROD,'FFEM'))
                      + SUM(FFEMPROD,
                        ( xi(FFEMPROD,'NORGE')  + xq(FFEMPROD,'NORGE')
                        + xqa(FFEMPROD,'NORGE') + xqb(FFEMPROD,'NORGE')
                        + xqs(FFEMPROD,'NORGE')) * NAERING(FFEMPROD,'FFEM'))
                      + SUM(MOELUTVARE, z(MOELUTVARE,'NORGE'))
                        -(  SUM((R,B,VARE)$MOELFLYT('FFKN',VARE), SIMDATA(R,B,'MNGD',VARE) * g(B,R)) * NAERING('FFKN','FFEM')) ) ;
*
* Landskapsindex
*
EQHNFIKRNSHR(FULLDYRK)$ (NOT SAMEAS('BRAK',FULLDYRK))..    hnfikrnshr(FULLDYRK)  =E= SUM((R,B), SIMDATA(R,B,'OMFG',FULLDYRK)*g(B,R)) / SUM((R,B,FULLFULLDYRK), SIMDATA(R,B,'OMFG',FULLFULLDYRK)*g(B,R));
EQHNFIKRNSHN..    hnfikrnshn  =E= - SUM(FULLDYRK$ (NOT SAMEAS('BRAK',FULLDYRK)),  hnfikrnshr(FULLDYRK) * LOG10(hnfikrnshr(FULLDYRK)));


*EQHNFIKRNSHN..    hnfikrnshn  =E= 1;

EQHNFIKRNNSP..    hnfikrnnsp   =E=  2.25-0.97*LOG10(SUM((R,B,KORN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',KORN)*g(B,R)) / SUM((R,B,KORN), SIMDATA(R,B,'OMFG',KORN)*g(B,R)));

EQHNFIGRVNSP..    hnfigrvnsp   =E=  2.25-0.97*LOG10(SUM((R,B,GROV), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',GROV)*g(B,R)) / SUM((R,B,GROV), SIMDATA(R,B,'OMFG',GROV)*g(B,R)));

EQHNFIGRVRUM..    hnfigrvrum   =E=  1.6-1.2*SQRT(SUM((R,B,PRDK), LU(PRDK)*SIMDATA(R,B,'OMFG',PRDK)*g(B,R)) / (SUM((R,B,GROV), SIMDATA(R,B,'OMFG',GROV)*g(B,R)/10)));

EQHNFIAPLNSP..    hnfiaplnsp   =E=  2.25-0.97*LOG10(SUM((R,B,APLN), 10*SIMDATA(R,B,'MNGD','NAVR')*SIMDATA(R,B,'OMFG',APLN)*g(B,R)) / SUM((R,B,APLN), SIMDATA(R,B,'OMFG',APLN)*g(B,R)));

EQHNFITOT..       hnfitot      =E=  (hnfikrnshn * hnfikrnnsp) * SUM((R,B,KORN), SIMDATA(R,B,'OMFG',KORN)*g(B,R)) / SUM((R,B,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE)*g(B,R))
                                  + (hnfigrvrum * hnfigrvnsp) * SUM((R,B,GROV), SIMDATA(R,B,'OMFG',GROV)*g(B,R)) / SUM((R,B,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE)*g(B,R))
                                  + (             hnfiaplnsp) * SUM((R,B,APLN), SIMDATA(R,B,'OMFG',APLN)*g(B,R)) / SUM((R,B,PLANTE)$(NOT SAMEAS('GFUB',PLANTE)), SIMDATA(R,B,'OMFG',PLANTE)*g(B,R)) ;

MODEL MARKEDSMODELL
/
        EQOBJEKT
*
* Vareopprinnelse og vareanvendelse
*
        EQXPM
        EQXPR
        EQXPSSLKM
        EQXPFSLKM
        EQXPMEIM
        EQXPKYLM
        EQXPMOEL
        EQXPOPRD
        EQXWHLS
        EQXPRIM
*
*
        EQNITR
        EQFOSF
        EQKALI
        EQSTKKBAL
        EQSAGKBAL
        EQSVNKBAL
        EQMELKBAL
        EQFJRKBAL
        EQPRINBAL
        EQPRINANDEL
        EQMOELINBAL
        EQMOELUTBAL
*        EQGFORBAL
*
* Budsjettstoette primaerjordbruk
*
        EQRTILBRK
*        EQMTILBRK
*        EQTILBRK
*
* Kostnader primaerjordbruk
*
        EQRKOSTBRK
*        EQMKOSTBRK
*        EQKOSTBRK
*
* Faktorbruk
*
        EQRFAKTOR
        EQMFAKTOR
        EQFAKTOR
        EQAREAL
        EQAREALTOTTAK
* Non-negative profit condition in the food sector
*        EQFOODSECTORPROFIT
        

*
* herunder naturlige forhold
        EQRRTAKAREAL
        EQRRTAKGROV
        EQRRTAKFULLJ
        EQRRTAKMTKRN
        EQTAKKORN
        EQRRTAKKORN
        EQRRTAKGFUB
*
* Etterspoersel
*
        EQXKM
        EQXK
        EQVAREBALANSE
*
* Transport
        EQTRNSBALANSE
*
* Handel
*
        EQIMPORT
        EQQIMPORT
        EQQAIMPORT
        EQQBIMPORT
        EQQSIMPORT

        EQEKSPORT
*
* Ligninger for politikk

        EQBEITE
        EQRRGLVAREAL
        EQSENGLVAREAL
        EQDISGLVAREAL
        EQDGGLVAREAL
        EQARBEID
        EQMARBEID
        EQRARBEID
        EQSDARBEID
        EQPRDKGLV
        EQKORNGLV
        EQGROVGLV
        EQAREAGLV
        EQAREAMGLV
        EQFULLGLV
        EQOVERGLV

        EQPRDKSDGLV
        EQPRDKFGLV
        EQPRDKMGLV
        EQMKORNGLV
        EQFKORNGLV
        EQFGROVGLV
        EQPRDKRGLV
        EQKORNRGLV
        EQGRNSRGLV
        EQFRBARGLV
        EQXPTAK
        EQXPKORNTAK
        EQXPRTAK
        EQXPGLV
        EQXPKORNGLV
        EQXPSTKKGLV
        EQXPFGLV
        EQXPFKORNGLV
        EQXPRGLV
        EQXPRKORNGLV
        EQXPMGLV
        EQXPMKORNGLV
        EQXPSDGLV
        EQNOKFOR
        EQKONSSFOR
        EQPRODSFOR
        EQXQTAK
        EQAXQTAK
        EQBXQTAK
        EQSXQTAK
        EQXETAK
        EQXPKMLKTAK
        EQXPGMLKTAK
        EQSPRED
        EQSFOR
        EQDIETT
$ifThenI.PubHealth %PubHealth%==YES
        EQHELSE
        EQHELSEOBS
$endIf.PubHealth

        EQTargetFoodConsMax
        EQTargetFoodConsMin
*
$ifthenI.Ecosys %Ecosys%==YES
        EQLANDEST 
        EQBIODIV  
        EQCULTHER 
        EQRECREAT
        EQTotEMIS_N 
$endIf.Ecosys
*
$ifthenI.LUC %LUC%==YES
        EQLUC1
        EQLUC2
        EQLUCObs
$endIf.LUC

        EQLANDESTObs 
        EQBIODIVObs  
        EQCULTHERObs 
        EQRECREATObs 

*        EQHNFITOT
*        EQHNFIKRNSHR
*        EQHNFIKRNSHN
*        EQHNFIKRNNSP
*        EQHNFIGRVRUM
*        EQHNFIGRVNSP
*        EQHNFIAPLNSP

*
* Ligninger for utslipp og miljoindikatorer

*        EQHUSDYRGJODSEL
*        EQGJODSELBAL
*        EQRNH3M
*        EQRN2ONH3M
*        EQRN2OM
*        EQRNH3S
*        EQRN2ONH3S
*        EQRN2OS
        EQCO2AVGIFT
        EQGHGXP
        EQGHGXI
        EQGHGTAK
        EQAREALUBENG


/
;
