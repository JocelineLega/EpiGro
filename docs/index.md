# EpiGro

EpiGro is a disease outbreak forecasting tool. It started (<a href="#v1">v.1.0</a>) as a phenonmenological model that described incidence as a quadratic function of the cumulative number of cases. <a href="#v2">Version 2.0</a> incorporated the exact definition of the ICC (Incidence - Cumulative Cases) curve for the SIR model, thereby transforming EpiGro into a mechanistic model. <a href="#v3">Version 3.0</a>, developed for COVID-19 forecasting, combines the mechanistic approach of EpiGro (v.2.0) with data assimilation techniques.

## <a NAME=v1 />EpiGro v.1.0
### Model
EpiGro v.1.0 was developed in response to the <a href="https://www.innocentive.com/ar/challenge/9933617">DARPA Chikungunya Challenge</a> and is described in <a href="http://dx.doi.org/10.1016/j.epidem.2016.10.002">Lega \& Brown (2016)</a>. The approach relies on the empirical observation that weekly incidence data for the 2014 outbreak of chikungunya in Guadeloupe, plotted as a function of the cumulative number of cases, can be fitted with a parabola. This simple fact means that the cumulative number of cases may in turn be approximated by a quantity that follows logistic growth, confirming previous observations reported in the literature for other diseases (<a href="https://doi.org/10.1371/currents.outbreaks.b4690859d91684da963dc40e00f3da81">Chowell et al., 2014</a>).

EpiGro <a href="https://www.darpa.mil/news-events/2015-05-27">won the DARPA Challenge</a> and an analysis of the methods used by challenge participants revealed that simpler models generally performed better than complex ones (<a href="http://dx.doi.org/10.1186/s12879-018-3124-7">Del Valle et al., 2018</a>). More details on our approach may be found on our <a href="http://www.u.arizona.edu/~lega/CHIK_Site/CHIK_Challenge.html">chikungunya modeling challenge site</a>.

### Release
The codes released for EpiGro v.1.0 consist of a MATLAB Graphical User Interface (GUI) that compares cumulative epidemiological data to logistic growth, by fitting a prabola to incidence (growth rate) plotted as a function of the cumulative cases. Users may import their own epidemiological data or select some of the datasets provided. The GUI also allows to model outbreaks that are comprised of two separate waves (via the two-parabola option).

![EpiGro GUI](./EpiGro_GUI.jpg)

## <a NAME=v2 />EpiGro v.2.0
### Model
EpiGro v.2.0 fits outbreak epidemiological data to the ICC curve of the SIR model. The exact formulation, derived in <a href="http://arxiv.org/abs/2005.08134">Lega (2020)</a>, is given by

$${\mathcal I} = \displaystyle \beta \left(C + \frac{N}{R_0} \ln\left(1 - \frac{C}{N}\right) - \frac{N}{R_0} \ln(\kappa) \right) \left(1 - \frac{C}{N} \right),$$

where $\mathcal I$ is incidence, $\beta$ is the contact rate of the disease, $C$ is the cumulative number of cases, $N$ is the size of the population, $R_0$ is the basic reproductive number, and $\kappa$ represents initial conditions. 

The following results are also established in <a href="http://arxiv.org/abs/2005.08134">Lega (2020)</a>.

1. Solving the differential equation given by the above ICC curve (with incidence $\mathcal I$ equal to the time derivative of $C$) is equivalent to solving the SIR model.
2. For fixed $N$, there is a unique set of parameter values $\beta$, $R_0$, and $\kappa$ that minimizes the RMSE between the resulting ICC curve and the data points. This form of itentifiability is one of the main advantages of fitting ICC curves, rather than epidemiological curves, to outbreak data.

Due to its equivalence with the SIR model, EpiGro v.2.0 is a mechanistic approach that fits a SIR model to outbreak data.

### Release
The MATLAB codes provided for version 2.0 of EpiGro find the ICC curve associated with user-provided epidemiological data, estimate ranges of suitable parameter values in the presence of reporting noise, and describe a method to find a range of values of $N$ if the latter variable is unknown. Simple forecasting based on a fit of the ICC curve to the data is also discussed.

![ICC curve for the COVID-19 outbreak in Arizona](./EpiGro_v2.png)

## <a NAME=v3 />EpiGro v.3.0 - EpiGro-DA
### Model
EpiGro v.3.0, or EpiGro-DA combines Bayesian data assimilation methods with the exact formulation of the SIR ICC curve, to provide forecasts for ongoing outbreaks. Details are provided in Biegel \& Lega (2020).

Priors are found by processing the early stages of the outbreak data with EpiGro v.2.0. The data assimilation step identifies parameters by minimizing a cost function that combines distance from prior values as well as distance between data points collected in the last 5 days and the selected ICC curve. Forecasts are obtained by integration of the ICC curve for parameter values in the posterior distribution.

## License
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
See <a href="../LICENSE.txt"> LICENSE.txt</a> in this repository for additional information.
