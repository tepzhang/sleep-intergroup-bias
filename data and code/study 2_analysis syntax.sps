* Encoding: UTF-8.


*************Behavior Attribution Bias Task**********************************.
*the Group x CNID GLM on the bias score of Behavior Attribution Bias Task.
GLM BA_bias BY group WITH ZID_CN 
  /METHOD=SSTYPE(3) 
  /INTERCEPT=INCLUDE 
  /PRINT=ETASQ DESCRIPTIVE
 /EMMEANS TABLES(group) with (ZID_CN = -1)
  /CRITERIA=ALPHA(.05) 
  /DESIGN=group ZID_CN ZID_CN*group.
*group * ZCNID interaction: F(1,63)=3.95, p = .051, partial eta-squared = .059. 
*this analysis also estimates both groups' bias score at low CNID (M - 1 SD), the bias score of the 2 groups at high CNID can be estimated by replacing (ZID_CN = -1) with (ZID_CN = 1).

*Simple slope tests.
*transform CNID into high and low dummy variables and calculate the interaction terms.
compute group_t = 1-group.
compute group_t.ZID_CN = group_t*ZID_CN.
execute.
*simple slope of CNID in the control group: beta= -.510, p= .005.
REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT BA_bias 
 /METHOD=ENTER group_t ZID_CN
 /METHOD=ENTER group_t.ZID_CN.
*simple slope of CNID in the deprived group: beta= -.034, p= .837.
REGRESSION 
  /MISSING LISTWISE 
  /STATISTICS COEFF OUTS R ANOVA CHANGE 
  /CRITERIA=PIN(.05) POUT(.10) 
  /NOORIGIN 
  /DEPENDENT BA_bias 
 /METHOD=ENTER group ZID_CN
 /METHOD=ENTER group.ZID_CN.

