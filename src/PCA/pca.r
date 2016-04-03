#!/usr/bin/env Rscript
# library("xcms")
library("MALDIquant")
library("MALDIquantForeign")

setwd("../../data/mzXML")
mzXMLFiles <- list.files()
# xset <- xcmsSet(mzXMLFiles)
# warnings()
spectra <- importMzXml(mzXMLFiles)
# samples <- factor(sapply(spectra, function(x)metaData(x)$sampleName))
spectra <- transformIntensity(spectra, method="sqrt")
spectra <- smoothIntensity(spectra, method="SavitzkyGolay", halfWindowSize=10)
spectra <- removeBaseline(spectra, method="SNIP", iterations=100)
spectra <- calibrateIntensity(spectra, method="TIC")
spectra <- alignSpectra(spectra, halfWindowSize=20, SNR=1, tolerance=0.02, warpingMethod="lowess")
peaks <- detectPeaks(spectra, method="MAD", halfWindowSize=20, SNR=2)
peaks <- binPeaks(peaks, tolerance=0.002)
featureMatrix <- intensityMatrix(peaks, spectra)
name = vector(length = length(spectra) )
for(i in c(1:length(spectra))){
	name[[i]] <- spectra[[i]]@metaData$file
}
setwd("../PCA")
write.table(name, file="name.txt")
write.csv2(featureMatrix, file="feature.csv")

