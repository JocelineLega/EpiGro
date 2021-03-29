# EpiGro

This repository contains epidemiological data from a variety of outbreaks, as well as EpiGro source codes (v.1.0 and v.2.0) written in MATLAB. These files accompany the following research articles.

<ul><li>J. Lega and H.E. Brown, <a href="http://dx.doi.org/10.1016/j.epidem.2016.10.002">Data-driven outbreak forecasting with a simple nonlinear growth model</a>, Epidemics <b>17</b>, 19-26 (2016).</li>
<li>J. Lega, <a href="https://arxiv.org/abs/2005.08134">Parameter Estimation from ICC Curves</a>, to appear in J. Biological Dynamics (2021).</li>
</ul>

## MATLAB Files
### EpiGro v.1.0
The codes should be run via the provided graphical user interface. To start, open MATLAB and run *Simple_Model.m* (type `Simple_Model` at the MATLAB prompt). Use the pull-down menu to upload an Excel file with the data to analyze. For a *one-wave* outbreak, the `Optimize` button will attempt to identify the parabola that best fits your data. For a *two-wave* outbreak, the fit should be done by hand with the help of the various sliders. Your own data files should contain a `Data` sheet that has the same structure as in the examples provided in the *Excel Files* folder.

### EpiGro v.2.0
A single MATLAB live script is provided, whose sections correspond to different figures of the J. Biol. Dyn. article.

## Data Files
### EpiGro v.1.0
In each file, the `Data` sheet contains the epidemiological data. The `Output` sheet was added by `EpiGro`. It lists model parameters and compares model predictions to the reported data. When relevant, the `Metadata` sheet contains details of the data collection procedure.

### EpiGro v.2.0
The Excel files contain cumulative case counts for each day since the beginning of the corresponding outbreak. The `.mat` files were created by the MATLAB code in `Parameter_Estimation_ICC_Curves_Figures.mlx` and were used to produce the figures in the J. Biol. Dyn. article.

### Data sources
<ul><li><a href="http://www.paho.org/hq/index.php?option=com_topics&view=readall&cid=5927&Itemid=40931&lang=en">Chikungunya</a></li>
<li><a href="https://www.who.int/emergencies/diseases/novel-coronavirus-2019/situation-reports">COVID-19</a></li>
<li><a href="https://data.hdx.rwlabs.org/dataset/ebola-cases-2014">Ebola</a></li>
<li><a href="http://www.eurosurveillance.org/ViewArticle.aspx?ArticleId=19070">Gastroenteritis</a></li>
<li><a href="http://bmcresnotes.biomedcentral.com/articles/10.1186/1756-0500-3-283">H1N1</a></li>
<li><a href="http://www.cdc.gov/mmwr/preview/mmwrhtml/mm6128a1.htm">Pertussis</a></li>
<li><a href="http://www.cdc.gov/salmonella/saintpaul-jalapeno/epidemic_curve.html">Salmonella</a></li>
</ul>

## License
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
See <a href="./LICENSE.txt"> LICENSE.txt</a> in this repository for additional information.
