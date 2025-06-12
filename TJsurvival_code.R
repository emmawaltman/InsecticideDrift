###TJ Survival Analysis###

#packages
library(tidyverse)
library(emmeans)
library(lme4)
library(dplyr)

### Import data
tj_surv = read.csv("tj_survival_byarena.csv")
view(tj_surv)

####Model 24-hour survival####
#set response variables
resp_24=cbind(tj_surv$n_alive_24, tj_surv$n_dead_24)
#model
tj_24_m = glmer(resp_24 ~ trt + (1 | replication), data=tj_surv,
                family=binomial) # AIC = 542.2
summary(tj_24_m)
Anova(tj_24_m) 
#Response: resp_24 Chisq Df Pr(>Chisq)    
              #trt 259.1  6  < 2.2e-16 ***
pairwise24=pairs(emmeans(tj_24_m, ~trt))#for pairwise comparisons
write.csv(pairwise24,"pairwise24.csv")
fixef(tj_24_m)
tj_24_means=summary(emmeans(tj_24_m, ~trt))
tj_24_means$surv_transf <- plogis(tj_24_means$emmean) #plogis to back-transform from log
tj_24_means$LCL_transf <- plogis(tj_24_means$asymp.LCL)
tj_24_means$UCL_transf <- plogis(tj_24_means$asymp.UCL)
tj_24_means

#reorder for figure
tj_24_means$trt = factor(tj_24_means$trt, levels = c("bwcontrol_leafna","bwdrift_leafna","bwcontrol_leafcontrol",
                                                   "bwcontrol_leafspray","bwspray_leafna", "bwspray_leafspray", 
                                                   "bwna_leafspray"))

##figure for 24 hours 
tj_24_survfigure=
  ggplot(data=tj_24_means, aes(x=trt,
                              y= surv_transf,
                              ymin= LCL_transf, 
                              ymax= UCL_transf, color=trt))+
  geom_linerange(size=2)+
  geom_pointrange(size=1)+
  theme_linedraw(base_size=20)+
  labs(x= "",
       y= "24-hour survival probability")+
  scale_color_manual(values=c("#3ea4e3","#8018ed", "chartreuse4","#DE8344","#C7534E", "#871015", "Black"))+
  easy_remove_legend()+
  scale_y_continuous(breaks=seq(0,1, by=0.20), limits=c(0,1.03))
tj_24_survfigure
ggsave("tj_24_survfigure.png", width=8,height=6)



####Model 48-hour survival ####
#set response variables
resp_48=cbind(tj_surv$n_alive_48, tj_surv$n_dead_48)
#model
tj_48_m = glmer(resp_48 ~ trt + (1 | replication), data=tj_surv,
                family=binomial) # AIC = 690.2309
summary(tj_48_m)
Anova(tj_48_m) 
#Response:      Chisq Df Pr(>Chisq)    
#trt          374.96  6  < 2.2e-16 ***
pairwise48=pairs(emmeans(tj_48_m, ~trt))#for pairwise comparisons
write.csv(pairwise48,"pairwise48.csv")
fixef(tj_48_m)
tj_48_means=summary(emmeans(tj_48_m, ~trt))
tj_48_means$surv_transf <- plogis(tj_48_means$emmean) #plogis to back-transform from log
tj_48_means$LCL_transf <- plogis(tj_48_means$asymp.LCL)
tj_48_means$UCL_transf <- plogis(tj_48_means$asymp.UCL)
tj_48_means

#reorder for figure
tj_48_means$trt = factor(tj_48_means$trt, levels = c("bwcontrol_leafna","bwdrift_leafna","bwcontrol_leafcontrol",
                                                     "bwcontrol_leafspray","bwspray_leafna", "bwspray_leafspray", 
                                                     "bwna_leafspray"))

##figure for 48 hours 
tj_48_survfigure=
  ggplot(data=tj_48_means, aes(x=trt,
                               y= surv_transf,
                               ymin= LCL_transf, 
                               ymax= UCL_transf, color=trt))+
  geom_linerange(size=2)+
  geom_pointrange(size=1)+
  theme_linedraw(base_size=20)+
  labs(x= "Treatment",
       y= "48-hour survival probability")+
  scale_color_manual(values=c("#3ea4e3","#8018ed", "chartreuse4","#DE8344","#C7534E", "#871015", "Black"))+
  easy_remove_legend()+
  scale_y_continuous(breaks=seq(0,1, by=0.20), limits=c(0,1.03))
tj_48_survfigure
ggsave("tj_48_survfigure.png", width=8,height=6)

