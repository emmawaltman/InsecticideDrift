Date of generation: June 12, 2025
Prepared by: Emma O Waltman

TITLE
Direct insecticide exposure and access to nectar, but not exposure to insecticide drift in a buckwheat border strip, impact survival of a hymenopteran parasitoid


RUNNING TITLE
Insecticide drift and flowering border strips 


AUTHORS
1. Emma O. Waltman
	Institution: Rutgers, The State University of New Jersey
	Department: Graduate Program in Ecology and Evolution
	Email: eow3@njaes.rutgers.edu
2. Anne L. Nielsen
	Institution: Rutgers, The State University of New Jersey
	Department: Department of Entomology
	Email: nielsen@njaes.rutgers.edu 


CONTENTS:
1. Dataset: spray_cards_data.csv
2. Code: SpotOn_cards_code.R
3. Dataset: tj_survival_byarena.csv
4. Code: TJsurvival_code.R


INFORMATION ABOUT ITEM 1: DATASET spray_cards_data.csv

Description: 
This dataset contains information about the percent coverage of SpotOn cards (Innoquest) after applying different insecticide spray treatments to cards. The purpose of collecting the data was to determine what quantity of insecticide drift reaches unsprayed flower strips that border directly sprayed peach orchards. 

Dates of data collection:
July 1, 8, and August 16, 25, 2021

Geographic location of data collection:
Rutgers Agricultural Research and Extension Center. Bridgeton, NJ 08302.

Number of variables:
4

Number of cases/rows:
44

Variable list and description:
1. replicate: 1-4, refers to trial date. 
	1: July 1, 
	2: July 8, 
	3: August 16, 
	4: August 25, 2021
2. treatment: 
	control: refers to cards placed in the unsprayed/untreated control section of the buckwheat strip, 
	drift: refers to cards placed in the buckwheat where half of sprayers of an airblast sprayer were operational to directly spray peach trees across from the buckwheat, 
	spray: refers to cards placed in directly sprayed buckwheat
3. card.no: identifier of each card (1-4) for given replicate and treatment
4. percent_area_spray: percent of the card that changed color after spray treatments were applied, indicating contact with spray liquid. Percentages calculated using ImageJ (NIH). 


INFORMATION ABOUT ITEM 2: CODE SpotOn_cards_code.R

Description: 
Code to investigate statistical differences between percent coverage of cards by different spray card treatments and between coverage of drift treatment cards by different trial dates. Statistics are reported in Table 2 and Table S2 of accompanying paper. Additionally, this code includes code for Figure 2 and Figure S1 of accompanying paper.

Date last updated:
June 12, 2025

Rows of code:
169


INFORMATION ABOUT ITEM 3: DATASET tj_survival_byarena.csv

Description:
This dataset contains information about 24-hour and 48-hour survival of Trissolcus japonicus in different treatments. T. japonicus were held in polypropylene arenas, and we counted numbers of dead and alive wasps in each arena at 24- and 48-hours after introduction. 

Dates of data collection:
July 1-3 and 8-10, August 16-18 and 25-26, 2021

Number of variables:
9

Number of cases/rows:
180

Variable list and description:
1. replicate: 1-4, refers to beginning of trial date. 
	1: July 1, 
	2: July 8, 
	3: August 16, 
	4: August 25, 2021
2. treatment: refers to what plant material was inside the arena
	bwcontrol_leafna: control buckwheat sprig and no leaf
	bwdrift_leafna: drift buckwheat sprig and no leaf
	bwcontrol_leafcontrol: control buckwheat sprig and unsprayed peach tree leaf
	bwcontrol_leafspray: control buckwheat sprig and directly sprayed peach tree leaf
	bwspray_leafna: directly sprayed buckwheat sprig and no leaf
	bwspray_leafspray: directly sprayed buckwheat sprig and directly sprayed peach tree leaf
	bwna_leafspray: no buckwheat sprig and directly sprayed peach tree leaf
3. vial_id: unique identifier of the vial/arena labelled by replicate and an id number. Eg: 1.8 is vial number 8 from the July 1st replicate.
4. n_all_24: total number of T. japonicus in a given arena that did not drown (alive or dead) to 24 hours
5. n_dead_24: total number of T. japonicus in a given arena that did not drown but were otherwise dead at 24 hours
6. n_alive_24: total number of T. japonicus in a given arena that were alive at 24 hours
7. n_all_48: total number of T. japonicus in a given arena that did not drown (alive or dead) to 48 hours
8. n_dead_48: total number of T. japonicus in a given arena that did not drown but were otherwise dead at 48 hours
9. n_alive_48: total number of T. japonicus in a given arena that were alive at 48 hours


INFORMATION ABOUT ITEM 4: CODE TJsurvival_code.R

Description:
Code to investigate statistical differences between 24- and 48-hour survivorship of T. japonicus exposed to different treatments. This code includes binomial generalized linear mixed models for each time interval to predict mean survival probability based on treatment with trial as a random effect. It also includes post-hoc pairwise testing. Statistics are reported in the text of the accompanying paper, in Table 3, and in Figure 3a and 3b. Additionally, this code includes code to produce Figure 3.

Date last updated:
June 12, 2025

Rows of code: 
95
