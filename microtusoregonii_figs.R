packages <- c("tidyverse", "ggplot2", "ggrepel", "reshape2", "colourpicker", "ggsci", "viridis", "IDPmisc", "gridExtra")
ipak(packages)

#install.packages("devtools")
#devtools::install_github("r-lib/svglite")
#library(svglite)

set.seed(42)


######## DOTPLOT ######## 
######## DOTPLOT ######## 

ReadsPerGeneExint <- read.delim("~/Research/sexmammals/microtus/ReadsPerGeneExint.moregoni", header=FALSE, comment.char="#")
colnames(ReadsPerGeneExint) <- c("chrom", "Gene", "Contig", "pos2map",
                                 "F1R1_reads", "F1R1_RPM",
                                 "F1R2_reads", "F1R2_RPM",
                                 "M1R1_reads", "M1R1_RPM",
                                 "M1R2_reads", "M1R2_RPM",
                                 "F2R1_reads", "F2R1_RPM",
                                 "F2R2_reads", "F2R2_RPM",
                                 "M2R1_reads", "M2R1_RPM",
                                 "M2R2_reads", "M2R2_RPM",
                                 "Fem_covg", "MF_covg")
ReadsPerGeneExint <- ReadsPerGeneExint %>%  separate(Gene, c("Gene", "Suffix") , ":")
ReadsPerGeneExint$Favg_RPM <- rowMeans(ReadsPerGeneExint[,c(7,9,15,17)]) 
ReadsPerGeneExint$Mavg_RPM <- rowMeans(ReadsPerGeneExint[,c(11,13,19,21)])

#ReadsPerGeneExint$density <- get_density(ReadsPerGeneExint$MF_covg, ReadsPerGeneExint$Fem_covg, n=200)
#cutoff_low <- boxplot.stats(log(ReadsPerGeneExint$Fem_covg/ReadsPerGeneExint$MF_covg))$stats[1] # lowest extreme bound
#cutoff_high <- boxplot.stats(log(ReadsPerGeneExint$Fem_covg/ReadsPerGeneExint$MF_covg))$stats[5] # highest extreme bound

Y = ReadsPerGeneExint %>%  filter(chrom == "Y")
X = ReadsPerGeneExint %>%  filter(chrom == "X" & log(MF_covg) > 1.7) 
XY = rbind(X,Y)

ReadsPerGeneExint$log2Favg_RPM <- log2(ReadsPerGeneExint$Favg_RPM)
ReadsPerGeneExint$log2Mavg_RPM <- log2(ReadsPerGeneExint$Mavg_RPM)

cols3 <- c("#919191", "#575DFF", "#FA3232") #c("#FA3232", "#575DFF", "#26BD3A")

B6<- ReadsPerGeneExint %>% 
  # filter(Contig %in% largecontigs$Contig) %>% 
  ggplot(aes(log2(Favg_RPM),log2(Mavg_RPM), label=Gene, color=chrom), group=chrom) + 
  geom_point(aes(shape=chrom, fill=chrom, size=chrom)) +#, color="#454040") +
  geom_smooth(data=subset(ReadsPerGeneExint, chrom == "A"), method=lm,  se=FALSE) +
  geom_smooth(data=subset(ReadsPerGeneExint, chrom == "X" & log(MF_covg) < 1.7), method=lm,  se=FALSE) +
  geom_label_repel(data = ReadsPerGeneExint %>%
                     filter(Gene %in% XY$Gene), #  filter(Gene %in% XY$Gene)
                   show.legend = FALSE, force = 10, #tried changing force
                   box.padding=1, # here is what controls how many labels show
                   segment.size = 0.3,
                   size=7, #label size
                   aes(fontface = 'bold.italic')) +
  scale_fill_manual(values = cols3) +
  scale_color_manual(values = cols3) +
  scale_shape_manual(values=c(18, 15, 19)) + #24, 23, 21))  +# 18, 15, 19
  scale_size_manual(values=c(2,2,2))  + 
  theme(
    axis.ticks = element_line(size = 1.5), 
    panel.grid.major = element_line(colour = "gray85"), 
    panel.grid.minor = element_line(colour = "gray94"), 
    plot.title = element_text(size = 18, face="bold", hjust=0.5),
    axis.title = element_text(size = 22, face = "bold"), 
    axis.text.x = element_text(size = 22, face = "bold"), 
    axis.text.y = element_text(size = 22, face = "bold"), 
    legend.text = element_text(size = 22, face = "bold"), 
    legend.title = element_text(size = 0, face = "bold"), 
    panel.background = element_rect(fill = NA), 
    legend.position=c(0.9,0.2),
  #  legend.key = element_rect(fill = "white"), 
    legend.background = element_rect(),
    legend.box.background = element_rect(colour = "black",size = 2)) +
  #  xlim(0,18) +
  labs(x = "Female reads per million (log2)", 
       y = "Male reads per million (log2)",
       title="")
######## DOTPLOT ######## 
######## DOTPLOT ######## 
  

######## COVERAGE ACROSS CONTIG ########
######## COVERAGE ACROSS CONTIG ########
Coverage.1000k <- read.delim("~/Research/sexmammals/microtus/Coverage.1000k.Noelle.formatted.", header=FALSE, comment.char="#")
#View(Coverage.1000k)
colnames(Coverage.1000k) <- c("Contig", "Start", "End", "Moregoni_F1", "Moregoni_M1", "Moregoni_F2", "Magrestis_M", "Mochrogaster_F", "Moregoni_M2")

contigs <- read.delim("~/Research/sexmammals/microtus/XLinkedContigs.Micoch")
contigs <- contigs %>% select(Contig, Call.A.X.Unknown.)
colnames(contigs)[2] <- "Chrom"

c <- left_join(Coverage.1000k, contigs, "Contig")
c$avg <- rowMeans(c[,c(4,6,7,8)]) # 9 and 5 are males
n <- c %>%  select(Start, End, avg)

c0 <- gather(c, "Sample", "Readcovg", 4:9 ) # gather species names
c0$Chrom[c0$Chrom == ""]  <- NA

c1 <- c0
c1$Sample <- gsub("Magrestis_M", "M. agrestis male", x = c1$Sample)
c1$Sample <- gsub("Moregoni_F1", "M. oregoni female 1", x = c1$Sample)
c1$Sample <- gsub("Moregoni_F2", "M. oregoni female 2", x = c1$Sample)
c1$Sample <- gsub("Moregoni_M1", "M. oregoni male 1", x = c1$Sample)
c1$Sample <- gsub("Moregoni_M2", "M. oregoni male 2", x = c1$Sample)
c1$Sample <- gsub("Mochrogaster_F", "M. ochrogaster female", x = c1$Sample)
c1$Sample <- factor(c1$Sample,levels(factor(c1$Sample))[c(3,4,5,6,2,1)])

n <- c1 %>% 
  filter(Contig == 'NC_022026.1' & 
           Sample == 'M. ochrogaster female') %>% 
  select(Start, End, Readcovg)

colnames(n)[3] <- "Mochr_covg"
c1 <- left_join(c1, n, c("Start", "End"))
c1$Ochnorm_Readcovg <- c1$Readcovg/c1$Mochr_covg

c1$t <- (c1$Readcovg - min(c1$Mochr_covg,na.rm = T))/(max(c1$Mochr_covg,na.rm = T) - min(c1$Mochr_covg,na.rm = T))

#labelz = seq(0,125,5)
#blanks = rep("", 4)
#labelz = unlist(lapply(labelz, append, blanks))

labelz = c("0", "", "", "", "", "5", "", "", "", "", "10", "", "", "", "","15", "", "", "", "",  "20", "", "", "", "", "25" , "", "", "", "",  "30" , "", "", "", "",  "35" , "", "", "", "",  "40" , "", "", "", "",  "45" , "", "", "", "",  "50" , "", "", "", "",  "55" , "", "", "", "",  "60")


cols1 = c("red", "#FF66CC", "#2200FF", "#66CCFF","black", "#26BD3A") #"orange" 2nd to last for ochro

A6<- c1 %>% 
  filter(Contig == 'NC_022026.1') %>% 
  filter(Sample != 'M. ochrogaster female') %>%  
  ggplot() +
  geom_point(aes(x=as.factor(Start), y=Ochnorm_Readcovg, color = Sample),size=1) +
  geom_line(aes(group = Sample, x=as.factor(Start), y=Ochnorm_Readcovg, color = Sample)) +
  # geom_point(aes(x=as.factor(Start), y=Ochnorm_Readcovg, color = Sample),size=1,shape=8) +
  # geom_line(linetype = "dashed",aes(group = Sample, x=as.factor(Start), y=Ochnorm_Readcovg,alpha=0.5)) +
  scale_y_continuous(breaks=seq(0,12,1)) +
  scale_x_discrete(labels = labelz) + 
  scale_colour_manual(values = cols1) + 
  theme(
    axis.text.x = element_text(size = 22, face = "bold"), #, vjust=0.5, angle=-90),  
    axis.text.y = element_text(size = 22, face="bold"),
    axis.title = element_text(size = 22, face = "bold"),
    axis.text = element_text(size = 22, face = "bold"),
  panel.grid.major = element_line(colour = "gray85"), 
  panel.grid.minor = element_line(colour = "gray94"), 
    panel.background = element_rect(fill = NA),
    plot.title = element_text(hjust = 0.25, face = "bold"),
    legend.title=element_text(size=0),
    legend.text=element_text(size=15, face="bold"),
    legend.background = element_blank(),
    legend.box.background = element_rect(color = "black", size=1),
    legend.position = c(.9,.9)) +
  labs(title = "", #Read Coverage Across Largest M. oregoni X-Linked Contig (NC_022026.1)
       x = "Genomic position (Mb)",
       y = "Normalized read coverage")

######## COVERAGE ACROSS CONTIG ########
######## COVERAGE ACROSS CONTIG ########


######## BOXPLOT ######## 
######## BOXPLOT ######## 
c2 <- c0
c2$Sample <- gsub("Magrestis_M","M. agrestis\nMale", x = c2$Sample)
c2$Sample <- gsub("Moregoni_F1","M. oregoni\nFemale 1", x = c2$Sample)
c2$Sample <- gsub("Moregoni_F2","M. oregoni\nFemale 2", x = c2$Sample)
c2$Sample <- gsub("Moregoni_M1","M. oregoni\nMale 1", x = c2$Sample)
c2$Sample <- gsub("Moregoni_M2","M. oregoni\nMale 2", x = c2$Sample)
c2$Sample <- gsub("Mochrogaster_F","M. ochrogaster\nFemale", x = c2$Sample)
c2$Sample <- factor(c2$Sample,levels(factor(c2$Sample))[c(3,4,1,5,6,2)])

# WANT CONTIGS WITH >10 GENES
largecontigs = ReadsPerGeneExint %>% group_by(Contig) %>% tally() %>%  data.frame() %>% filter(n > 10)
c2_largecontigs <- semi_join(c2, largecontigs, "Contig")

Samples_A_meds <- c2_largecontigs %>% 
  filter(Chrom == "A") %>% 
  group_by(Sample) %>% 
  mutate(Acovg = median(Readcovg)) %>%  
  select(Sample, Acovg) %>% 
  unique()

# dividing all the genes in each species/sample by the median autosomal coverage in that species/sample
c2_largecontigs <- left_join(c2_largecontigs, Samples_A_meds, "Sample") ### HERE
c2_largecontigs$Readcovg_Anormd <- c2_largecontigs$Readcovg/c2_largecontigs$Acovg

cols2 = c("#FA3232", "#575DFF")

# ORDER: 
c2_largecontigs$Sample <- factor(c2_largecontigs$Sample, levels=c("M. ochrogaster\nFemale", "M. agrestis\nMale", "M. oregoni\nFemale 1", "M. oregoni\nFemale 2", "M. oregoni\nMale 1", "M. oregoni\nMale 2"))

#expression(paste(italic("M. ochrogaster"), "\n", "Female"))

c2_largecontigs %>% 
  filter(is.na(Chrom) == FALSE) %>% 
  # filter(Contig == 'NC_022026.1') %>%
  ggplot(aes(x=Sample, y=log2(Readcovg_Anormd), color=Chrom, fill=Chrom)) +
  geom_point(alpha=0.5, pch = 20, position = position_jitterdodge()) +
  geom_boxplot(color="black",outlier.shape = NA) + #outlier.colour = NULL, outlier.fill = NULL, outlier.size = 0.5) + 
  scale_fill_manual(values = cols2) +
  scale_color_manual(values = cols2) +
  scale_y_continuous(breaks=seq(-2,2,0.5), limits = c(-2,2)) +
 # scale_x_discrete("", labels=c(expression(paste(italic("M. ochrogaster"), "Female")),"","","","","")) + 
  theme(
    panel.grid.major = element_line(colour = "gray90"), #90
    panel.grid.minor = element_line(colour = "gray60"), 
    panel.background = element_rect(fill = NA),
    axis.title = element_text(size = 26, face="bold"),
    axis.text = element_text(size = 36, face="bold"), 
    axis.text.x = element_text(size = 22, face="bold"),  
    axis.text.y = element_text(size = 26, face="bold"), #16
    legend.title = element_text(size = 10, colour = NA), 
    legend.key = element_rect(fill = "white"), 
    legend.background = element_rect(fill = "NA"),
    legend.text = element_text(size = 29), #20
    legend.box.background = element_rect(colour = "black",size = 1)) +
  labs(
       x = "",
       y = "Read coverage (log2)", 
       title="")  
######## BOXPLOT ######## 
######## BOXPLOT ######## 

### TABLE
ygenes <- c("Sry", "Ddx3y", "Usp9y","Ube1y")
ReadsPerGeneExint %>% 
  filter(Gene %in% ygenes) %>% 
  select(Gene, F1R1_RPM, F1R2_RPM, F2R1_RPM, F2R2_RPM, M1R1_RPM, M1R2_RPM, M2R1_RPM, M2R2_RPM)


t <- ReadsPerGeneExint %>% 
  filter(chrom == "Y") %>% 
  select(Gene, F1R1_RPM, F1R2_RPM, F2R1_RPM, F2R2_RPM, M1R1_RPM, M1R2_RPM, M2R1_RPM, M2R2_RPM) %>% 
  mutate(Female1 = (F1R1_RPM + F1R2_RPM)/2) %>% 
  mutate(Female2 = (F2R1_RPM + F2R2_RPM)/2) %>% 
  mutate(Male1 = (M1R1_RPM + M1R2_RPM)/2) %>% 
  mutate(Male2 = (M2R1_RPM + M2R2_RPM)/2) %>% 
  mutate(MF = ((Male1 + Male2)/2)/ ((Female1 + Female2)/2)) %>% 
  select(Gene, Female1, Female2, Male1, Male2, MF) 
  
t[,-1] <-round(t[,-1],2)


