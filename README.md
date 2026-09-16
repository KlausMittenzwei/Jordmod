Jordmod Project

Supply Side 16th of September 

The objective fnction (EQOBJEKTBRUK) calculates the objective value (objbruk) as the sum of all profits in all regions and all activities deducted by produce used as feed as given by the pmp calibrated allocation for each region and activity.

The profitt per region and activity is calculated in EQPROFITTBRUK. It is the sum of the contributionmargin/revenue?? (bidrag(PRODUKT)) per region, activity and product,
plus subsidy (bidrag(TILLSKUDD))
deducted by costs (bidrag(INNSATS))
deducted by levies for emissions (bidrag(UTSLIPPAVG))
deducted by concentrate feed levy as calculated as the fee for concentrates (KFORAVG) times the intensity level (intens) times the activity level (omfang)
deducted by nitrogen levy as calculated as the fee for concentrates (KFORAVG) times the intensity level (intens) times the activity level (omfang)
and, if applicable, levy on nitrogen emissions (bidrag("Emis_N"))


Pproduction intensities 

Production intensities are captured in the variable v_intens. Note that for some activities they are exogeneous. Exogenous intensities are defined in equation EQINTEKSO. This is true when the decision to participate in a climate measure was taken. Then the intensity is adjusted towards a specific measure exluding the rest. Accordingly the equation calculates v_intens as the intensity given in p_ENHDATA(R,VARE,PRDK,'Y') adjusted by climate effects.
