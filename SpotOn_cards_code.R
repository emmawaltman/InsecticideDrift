###Spot-on cards analysis###

#packages
library(tidyverse)

##Data
spray_cards = read.csv("spray_cards_data.csv")
view(spray_cards)

####Checking difference in card coverage based on card treatment####
##Check for normality
controlpaper = spray_cards %>% filter(treatment=="control")
hist(controlpaper$percent_area_spray, breaks=12) #not normal
driftpaper = spray_cards %>% filter(treatment=="drift")
hist(driftpaper$percent_area_spray, breaks=12) #not normal
spraypaper = spray_cards %>% filter(treatment=="spray")
hist(spraypaper$percent_area_spray, breaks=12) #could be normal

##Kruskal-Wallis test
kruskal.test(percent_area_spray ~ treatment, data=spray_cards)
#Kruskal-Wallis chi-squared = 38.293, df = 2, p-value = 4.839e-09

##Mann Whitney U tests
#control vs drift
control.drift.w=wilcox.test(controlpaper$percent_area_spray,
                            driftpaper$percent_area_spray, 
                            paired=FALSE, exact=TRUE)
control.drift.w #W = 0, p-value = 4.855e-06
wilcoxonZ(controlpaper$percent_area_spray,
          driftpaper$percent_area_spray) #z=-4.59

#drift vs spray
drift.spray.w=wilcox.test(driftpaper$percent_area_spray, 
                          spraypaper$percent_area_spray,
                          paired=FALSE, exact=FALSE) 
drift.spray.w#W=0, p-value = 2.316e-06
wilcoxonZ(driftpaper$percent_area_spray, 
          spraypaper$percent_area_spray) #z=-4.74

#control vs. spray
control.spray.w=wilcox.test(controlpaper$percent_area_spray,
                            spraypaper$percent_area_spray,
                            paired=FALSE, exact=FALSE)
control.spray.w #W = 0, p-value = 6.681e-06
wilcoxonZ(controlpaper$percent_area_spray, 
          spraypaper$percent_area_spray) #z = -4.53

##Bonferroni adjustment to p-values
p_values_spray=c(0.000004855,0.000002316, 0.000006681)
p_values_spray_adjst=p.adjust(p_values_spray, method="bonferroni")
p_values_spray_adjst #1.4565e-05 6.9480e-06 2.0043e-05

##Figure of card coverage by treatment
spoton.figure=
  ggplot()+
  geom_boxplot(data=spray_cards, notch=FALSE, 
               aes(x=treatment, y=percent_area_spray, fill=treatment,
                   color=treatment),
               outlier.size=1.5,
               width=1,
               linewidth=0.85)+
  theme_classic(base_size=28)+
  theme(plot.title=element_text(hjust=0.5))+
  easy_all_text_color("Black")+
  labs(x="Buckwheat treatment area",
       y="Percent of card sprayed")+
  scale_color_manual(values=c("#3ea4e3", "#8018ed", "#d54949"))+
  scale_fill_manual(values=c("#c4e3f6", "#dabcfa", "#f0c0c0"))+
  easy_remove_legend()+
  scale_x_discrete(labels=c("Control", "Drift", "Spray"))+
  scale_y_continuous(breaks=seq(0,100,by=2), limits=c(0,100.2))+
  scale_y_break(c(7, 97))
spoton.figure
ggsave("spoton.figure.png")





####Checking difference in card coverage in the drift treatment on 4 different dates####

##Not even checking for normalcy - each date only has 4 data points

##Kruskal-Walis test
kruskal.test(percent_area_spray ~ replicate, data=driftpaper)
#Kruskal-Wallis chi-squared = 10.743, df = 3, p-value = 0.0132

#separate by replicate
drift.only=spraydata2 %>% filter (treatment == "drift" )
drift.1=drift.only%>%filter(replicate=="1")
drift.2=drift.only%>%filter(replicate=="2")
drift.3=drift.only%>%filter(replicate=="3")
drift.4=drift.only%>%filter(replicate=="4")

means.std.drift.cards=c(
  mean(drift.1$percent_area_spray),
  sd(drift.1$percent_area_spray),
  mean(drift.2$percent_area_spray),
  sd(drift.2$percent_area_spray),
  mean(drift.3$percent_area_spray),
  sd(drift.3$percent_area_spray),
  mean(drift.4$percent_area_spray),
  sd(drift.4$percent_area_spray))

##Mann Whitney U tests
#1 vs 2
rep.1.2=wilcox.test(drift.1$percent_area_spray,
                    drift.2$percent_area_spray, 
                    paired=FALSE, exact=FALSE)
rep.1.2 #W = 5, p-value = 0.4705
wilcoxonZ(drift.1$percent_area_spray,
          drift.2$percent_area_spray) # z = -0.866

#1 vs 3
rep.1.3=wilcox.test(drift.3$percent_area_spray,
                    drift.1$percent_area_spray, 
                    paired=FALSE, exact=FALSE)
rep.1.3 #W = 1, p-value = 0.0606
wilcoxonZ(drift.1$percent_area_spray,
          drift.3$percent_area_spray) # z= 2.02

#1 vs 4
rep.1.4=wilcox.test(drift.1$percent_area_spray,
                    drift.4$percent_area_spray, 
                    paired=FALSE, exact=FALSE) 
rep.1.4 #W = 1, p-value = 0.0606
wilcoxonZ(drift.1$percent_area_spray,
          drift.4$percent_area_spray) # z= -2.02

#2 vs 3
rep.2.3=wilcox.test(drift.3$percent_area_spray,
                    drift.2$percent_area_spray, 
                    paired=FALSE, exact=FALSE) 
rep.2.3 # W = 0, p-value = 0.03038
wilcoxonZ(drift.3$percent_area_spray,
          drift.2$percent_area_spray) # z = -2.31 

#2 vs 4
rep.2.4=wilcox.test(drift.2$percent_area_spray,
                    drift.4$percent_area_spray, 
                    paired=FALSE, exact=FALSE) 
rep.2.4 #W = 3, p-value = 0.1939
wilcoxonZ(drift.2$percent_area_spray,
          drift.4$percent_area_spray) # z= -1.44

#3 vs 4
rep.3.4=wilcox.test(drift.3$percent_area_spray,
                    drift.4$percent_area_spray, 
                    paired=FALSE, exact=FALSE) 
rep.3.4 #W = 0, p-value = 0.03038
wilcoxonZ(drift.3$percent_area_spray,
          drift.4$percent_area_spray) #-2.31

##Bonferroni adjustment to p-values
p_values_drift=c(0.4705,0.0606,0.0606,0.03038,0.1939,0.03038)
p_values_drift_adjst=p.adjust(p_values_drift, method="bonferroni") 
#new p values: 1.00000 0.36360 0.36360 0.18228 1.00000 0.18228

##Figure 
drift.bytrial.beeswarm= 
  ggplot(data=drift.only, aes (x=replicate,
                               y=percent_area_spray))+
  geom_beeswarm(cex=2, size=3, color='#8018ed')+
  theme_classic(base_size=28)+
  labs(x="Trial",
       y="Percent card sprayed in drift treatments")+
  scale_y_continuous(limits=c(0,6))
drift.bytrial.beeswarm
ggsave("drift.bytrial.beeswarm.png")