************************************************************************
*
*   Jordmod 
*
*   Ansvarlig: Klaus, Ruralis
*   Formaal: Parametre for beregning av økosystemtjenester
*   Kommentarer: 
*   Status:
************************************************************************

$ontext
Source: Samfunnsøkonomisk analyse, beregninger og figurer.xlsx
WTP totalt per dekar alt areal per år for landskapsestestikk       3164    NOK 2023  2834.42 NOK 2021
WTP totalt per dekar grovfôr inkl. utmarksbeite per år for biodiv  1190    NOK 2023  1066.04 NOK 2021
WTP totalt per dekar alt areal per år for kulturarv                1085    NOK 2023   971.98 NOK 2021
WTP totalt per år ved tap av rekreasjonsdager per dekar alt areal   959    NOK 2023   859.10 NOK 2021
Variabel    Enhet   Ansvarlig   Lav Snitt   Høy
$offtext

Parameters
WTPLandest(R)  Willingness to pay for landscape esthethics in 2021-NOK per daa
WTPBiodiv(R)   Willingness to pay for biodiversity in 2021-NOK per daa
WTPCulther(R)  Willingness to pay for cultural heritage in 2021-NOK per daa
WTPRecreat(R)  Willingness to pay for recreation in 2021-NOK per daa
Ref_landest(R) Agricultural area excl outlying fields related to landscape esthethics base year
Ref_biodiv(R)  Fodder area incl outlying fields related to biodiversity in 2035 reference run
Ref_culther(R) Agricultural area excl outlying fields related to cultural heritage in 2035 reference run
Ref_recreat(R) Agricultural area excl outlying fields related to recreation in 2035 reference run
Ref_LUC(R,*)   Agricultural area by type (CROP and GRAS) related to land use change in 2035 reference run
;

* 1000 2023-NOK per daa
* BNP-realprisjustering tilbake til 2021 [/1.556 * 1.345],
* fremskrevet med realprisjustering [0.005]
* 
* fremskrevet til 2035
WTPLandest(R) = 3.164 / 1.556 * 1.345 * (1 + KPI + 0.005) ** (Y - %BAS%);
WTPBiodiv(R)  = 1.190 / 1.556 * 1.345 * (1 + KPI + 0.005) ** (Y - %BAS%);
WTPCulther(R) = 1.085 / 1.556 * 1.345 * (1 + KPI + 0.005) ** (Y - %BAS%);
WTPRecreat(R) = 0.959 / 1.556 * 1.345 * (1 + KPI + 0.005) ** (Y - %BAS%);

*
*
Parameter ScaleES(*) Scaling of ecosystem service values;
* statistisk usikkerhet ved betalingsvillighetstallene
ScaleES('upp') = 1.08;
ScaleES('val') = 1;
ScaleES('low') = .92;
ScaleES('zer') = 1;
*
* imputed values for sensitivity analysis
ScaleES('upp') = 1.2;
ScaleES('val') = 1;
ScaleES('low') = .8;
ScaleES('zer') = 1;

*


$onText
Variabel    Enhet   Ansvarlig   Lav Snitt   Høy
N-avrenning uten tilleggskostnad for økosystemer for eutrofiering ved kyst
2021-kr/kg N   66,94976979  161,6400738    256,2323547

N-avrenning tilleggskostnaden for økosystemer for for eutrofiering i ved kyst
2021-kr/kg N   121,3525842   217,8073038   317,3987622

Lystgass - Increased ultra-violet light exposure from ozone --crops
2021-kr/kg N2O  13,03707084   13,03707084   13,03707084

Ammoniakk (utslipp til luft sin skade på naturmangfold)
2021-kr/kg NH3  25,28995696   75,7718478    126,2537386
$offText

Parameter ScaleEmisCost(Emis,r,*) Scaling of ecosystem service values;
* statistisk usikkerhet ved betalingsvillighetstallene
ScaleEmisCost('NTAP',r,'upp') = 256.2323547 / 161.6400738;
ScaleEmisCost('NTAP',r,'val') = 1;
ScaleEmisCost('NTAP',r,'low') = 66.94976979 / 161.6400738;
ScaleEmisCost('NTAP',r,'zer') = 1;
*
ScaleEmisCost('NTAP',nitratdir,'upp') = 317.3987622 / 217.8073038;
ScaleEmisCost('NTAP',nitratdir,'val') = 1;
ScaleEmisCost('NTAP',nitratdir,'low') = 121.3525842 / 217.8073038;
ScaleEmisCost('NTAP',nitratdir,'zer') = 0;
*
ScaleEmisCost('N2O',r,'upp') = 1;
ScaleEmisCost('N2O',r,'val') = 1;
ScaleEmisCost('N2O',r,'low') = 1;
ScaleEmisCost('N2O',r,'zer') = 1;
*
ScaleEmisCost('NH3',r,'upp') = 126.2537386 / 75.7718478;
ScaleEmisCost('NH3',r,'val') = 1;
ScaleEmisCost('NH3',r,'low') = 25.28995696 / 75.7718478;
ScaleEmisCost('NH3',r,'zer') = 1;
*
*
Parameter EmisCost(Emis,r) Damage cost of emission items in kr per kg item;
EmisCost('NTAP',r)         = 161.6400738 / 1.556 * 1.345 * (1 + KPI + 0.005) ** (Y - %BAS%);
EmisCost('NTAP',nitratdir) = (161.6400738 + 217.8073038) / 1.556 * 1.345 * (1 + KPI + 0.005) ** (Y - %BAS%);
EmisCost('N2O',r)          = 13.03707084 / 1.556 * 1.345 * (1 + KPI + 0.005) ** (Y - %BAS%);
EmisCost('NH3',r)          = 75.7718478 / 1.556 * 1.345 * (1 + KPI + 0.005) ** (Y - %BAS%);
*
*
* land use emission coefficient in tonn CO2-e per daa
* positive value: emission
* negative value: uptake
* Source: Mittenzwei and Prestvik
*
Parameter LandUse(r,cropType,cropType);
* t CO2-ekv per daa
LandUse(r,'crop','crop') =  0.2073 ; 
LandUse(r,'gras','gras') = -0.0242 ;
*
* Uncertaintt, IPPC Code 4B1 (crop), 4C1 (grass)
* Source: NIR 2025 Annex II Table A2-6 CSC
Parameter ScaleLandUse(cropType,*) ;
ScaleLandUse('crop','upp') = 1.18;
ScaleLandUse('crop','val') = 1;
ScaleLandUse('crop','low') = 0.82;
ScaleLandUse('crop','zer') = 1;
ScaleLandUse('gras','upp') = 1.5;
ScaleLandUse('gras','val') = 1;
ScaleLandUse('gras','low') = 0.5;
ScaleLandUse('gras','zer') = 1;
*
*
*
Table LandUseChange(r,cropType,cropType)
* Miljødirektoratet
* t CO2-ekv per daa
* Effekt i 20 år
        crop.other gras.other  other.crop  other.gras   
011101  -5.137      -6.397      17.940      11.642
021101  -5.137      -6.397      17.940      11.642
021103  -5.137      -6.397      17.940      11.642
041101  -5.137      -6.397      17.940      11.642
041203  -5.137      -6.397      17.940      11.642
04125A  -5.137      -6.397      17.940      11.642
051103  -5.137      -6.397      17.940      11.642
05125A  -5.137      -6.397      17.940      11.642
061101  -5.137      -6.397      17.940      11.642
06125A  -5.137      -6.397      17.940      11.642
071101  -5.137      -6.397      17.940      11.642
081103  -6.333      -7.457      18.810      12.513
081203  -6.333      -7.457      18.810      12.513
08125A  -6.333      -7.457      18.810      12.513
09225A  -6.333      -7.457      18.810      12.513
10225A  -6.333      -7.457      18.810      12.513
112102  -6.333      -7.457      18.810      12.513
112203  -6.333      -7.457      18.810      12.513
11215B  -6.333      -7.457      18.810      12.513
11225B  -6.333      -7.457      18.810      12.513
12325B  -4.036      -6.397      17.940      11.624
14325B  -4.036      -6.397      17.940      11.624
15325B  -5.343      -6.397      16.727      10.427
164104  -5.343      -6.397      16.727      10.427
164204  -5.343      -6.397      16.727      10.427
16425A  -5.343      -6.397      16.727      10.427
174104  -5.343      -6.397      16.727      10.427
17425A  -5.343      -6.397      16.727      10.427
185206  -5.909      -6.397      17.940      11.542
195206  -5.909      -6.397      17.940      11.542
195207  -5.909      -6.397      17.940      11.542
205207  -5.909      -6.397      17.940      11.542
;

* Uncertaintt, IPPC Code
* Table A2-5 mineral soils, Table A2-6 organic soils
*crop.other:  A2-6 cropland to forest land (25)    
*gras.other:  A2-6 intensive grassland cropland 4B2 (18)
*other.crop: A2-6 unmanaged wetlands to cropland 4B2 (18)
*other.gras: A2-6 unmanaged wetlands to intensive grassland 4C2 (50)      
* Source: NIR 2025 Annex II Table A2-6 CSC
Table ScaleLandUseChange(cropType,cropType,*)
           upp      val  low    zer
crop.other  1.25     1    0.75   1
gras.other  1.18     1    0.83   1
other.crop  1.18     1    0.83   1
other.gras  1.5      1    0.5    1 
;
*
* calibrate to annual amount
Parameter LUCCoeff(r,cropType,cropType);
LUCCoeff(r,cropType,cropTypeType) = LandUse(r,cropType,cropTypeType) + LandUseChange(r,cropType,cropTypeType)/20;
*
* Source: PH0ES0.gdx
* UAAR = all crop activities excluding outlying fields
* AGRI = all crop activities including outlying fields
* FODD = all roughage activities including outlying fields (GFUB)
* CROP = all crop actitivities on arable land
* GRAS = permanent grassland excluding outlying fields (GFUB)
TABLE RefArea(R,CropType) Agricultural area and gras area in reference run 2030 in 1000 daa
       UAAR        AGRI        FODD        CROP       GRAS
011101  761.8036    788.7671    149.1754    743.6156    18.1880
021101  190.3612    192.9070     16.9582    188.1640     2.1971
021103  580.1092    629.8510    185.0148    551.2565    28.8526
041101  392.0612    440.4935    249.6860    340.1548    51.9064
041203  421.0861    421.0861     78.0563    410.7277    10.3584
04125A  191.1313    317.4363    299.7509    172.4648    18.6665
051103  404.3441    534.7621    404.8306    356.6762    47.6679
05125A  508.5222    704.5232    681.1701    397.8873   110.6350
061101  316.5001    418.0831    241.2027    296.2250    20.2750
06125A  177.5487    243.7355    217.7250    125.2577    52.2910
071101  409.3180    438.6798    117.0414    400.5363     8.7817
081103   52.4429     59.9503     36.3594     47.6051     4.8378
081203   57.8453     67.2029     39.4177     54.4873     3.3580
08125A   90.3714    133.0677    125.9422     70.7591    19.6123
09225A  105.6375    137.7922    122.5358     90.9456    14.6919
10225A  189.6847    212.4824    208.4197    138.0986    51.5861
112102  450.7123    571.1083    498.8942    317.6635   133.0487
112203  177.1738    184.9389    184.9389     69.6083   107.5655
11215B   53.8850     53.8850     53.8017     18.9291    34.9559
11225B  368.5097    458.3922    457.1421    157.8361   210.6736
12325B  343.4706    391.8087    382.5529    164.2312   179.2394
14325B  335.5995    335.5995    328.2313    195.8957   139.7039
15325B  572.2587    667.0257    659.7387    445.0486   127.2101
164104  287.4297    350.7497    234.7241    261.8451    25.5846
164204   64.2526     71.9641     50.8779     58.4829     5.7697
16425A  316.3331    362.6372    359.1220    246.9414    69.3917
174104  381.0583    455.4471    253.3062    353.0861    27.9722
17425A  405.0843    432.8717    426.3819    347.2332    57.8512
185206  635.8562    715.5292    711.2311    507.2460   128.6102
195206  153.5281    153.5281    149.3813    131.6864    21.8416
195207   36.0388     36.0388     36.0388     30.1256     5.9132
205207   85.1611     85.1611     85.1611     73.2047    11.9565
;
*
* Relevant agricultural area in base year in 1000 daa
Ref_landest(R)    = RefArea(R,'UAAR');
Ref_biodiv(R)     = RefArea(R,'FODD');
Ref_culther(R)    = RefArea(R,'AGRI');
Ref_recreat(R)    = RefArea(R,'AGRI');
Ref_LUC(R,'CROP') = RefArea(R,'CROP');
Ref_LUC(R,'GRAS') = RefArea(R,'GRAS');
