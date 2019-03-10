* Encoding: UTF-8.

* Compute the intergroup bias score in the Bahavioral Attribition Bias task.
compute BA_bias = (BA_N_CN - BA_P_CN)/(BA_N_CN + BA_P_CN).
* The arcsine transformation of the bias score.
compute BA_bias_arcsin = arsin(BA_bias).
execute.

if BA_bias >= 0 BA_bias_arcsin = arsin(sqrt(BA_bias)).
if BA_bias < 0 BA_bias_arcsin = -arsin(sqrt(-BA_bias)). 
execute.

**************************Study 1 analyses*****************************.
*The Sleep duration x Chinese Identity GLM on the bias score of the Behavior Attribution Bias Task.
GLM BA_bias with ZPSQI_slp_dur ZID_CN
  /METHOD=SSTYPE(3) 
  /PRINT=DESCRIPTIVE ETASQ
  /CRITERIA=ALPHA(.05) 
  /EMMEANS=TABLES(overall) with (ZID_CN= 1 ZPSQI_slp_dur = 1)
  /DESIGN= ZPSQI_slp_dur ZID_CN ZPSQI_slp_dur*ZID_CN.
*significant sleep x CNID interaction, F(1,164)=5.78, p= .017, ηp2 =.034.
*this analysis also estimates the bias score with high CNID (M + 1 SD) and with longer sleep duration (M + 1 SD).
*the bias score with low CNID or with shorter sleep duration can be estimated by replacing ZID_CN = 1 or ZPSQI_slp_dur=1 with replacing ZID_CN = -1 or ZPSQI_slp_dur= -1.

*Simple slope tests.
*transform sleep duration into long and short dummy variables and compute the interaction terms.
compute ZPSQI_slp_dur.ZID_CN = ZPSQI_slp_dur*ZID_CN.
compute ZPSQI_slp_dur_h = ZPSQI_slp_dur -1.
compute ZPSQI_slp_dur_l = ZPSQI_slp_dur +1.
compute ZPSQI_slp_dur_h.ZID_CN = ZPSQI_slp_dur_h*ZID_CN.
compute ZPSQI_slp_dur_l.ZID_CN = ZPSQI_slp_dur_l*ZID_CN.
execute.
*simple slope of CNID with longer sleep duration (M + 1 SD): significantly negative slope of CNID, β = -.383, p < .001.
REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT BA_bias_arcsin
 /METHOD=ENTER ZPSQI_slp_dur_h ZID_CN
 /METHOD=ENTER ZPSQI_slp_dur_h.ZID_CN.
*simple slope of CNID with shorter sleep duration (M - 1 SD): nonsignificant slope, β = -.068, p = .493.
REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT BA_bias_arcsin
 /METHOD=ENTER ZPSQI_slp_dur_l ZID_CN
 /METHOD=ENTER ZPSQI_slp_dur_l.ZID_CN.

