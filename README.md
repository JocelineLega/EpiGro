# EpiGro

This repository contains epidemiological data from a variety of outbreaks, as well as EpiGro source codes (v.1.0) written in MATLAB. These files accompany the following research article.

<ul><li>J. Lega and H.E. Brown, <a href="http://dx.doi.org/10.1016/j.epidem.2016.10.002">Data-driven outbreak forecasting with a simple nonlinear growth model</a>, Epidemics <b>17</b>, 19-26 (2016).</li></ul>

## MATLAB Files
### EpiGro v.1.0
The codes should be run via the provided graphical user interface. To start, open MATLAB and run *Simple_Model.m* (type `Simple_Model` at the MATLAB prompt). Use the pull-down menu to upload an Excel file with the data to analyze. For a *one-wave* outbreak, the `Optimize` button will attempt to identify the parabola that best fits your data. For a *two-wave* outbreak, the fit should be done by hand with the help of the various sliders. Your own data files should contain a `Data` sheet that has the same structure as in the examples provided in the *Excel Files* folder.

## Excel Files
In each file, the `Data` sheet contains the epidemiological data. The `Output` sheet was added by `EpiGro`. It lists model parameters and compares model predictions to the reported data. When relevant, the `Metadata` sheet contains details of the data collection procedure.

### Data sources
<ul><li>Chikungunya: http://www.paho.org/hq/index.php?option=com_topics&view=readall&cid=5927&Itemid=40931&lang=en</li>
<li>Ebola: https://data.hdx.rwlabs.org/dataset/ebola-cases-2014</li>
<li>Gastroenteritis: http://www.eurosurveillance.org/ViewArticle.aspx?ArticleId=19070</li>
<li>H1N1: http://bmcresnotes.biomedcentral.com/articles/10.1186/1756-0500-3-283</li>
<li>Pertussis: http://www.cdc.gov/mmwr/preview/mmwrhtml/mm6128a1.htm</li>
<li>Salmonella: http://www.cdc.gov/salmonella/saintpaul-jalapeno/epidemic_curve.html</li>
</ul>

## License
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.
See <a href="./LICENSE.txt"> LICENSE.txt</a> in this repository for additional information.
