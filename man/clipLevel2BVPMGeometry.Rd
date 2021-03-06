% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/clipLevel2BVPM.R
\name{clipLevel2BVPMGeometry}
\alias{clipLevel2BVPMGeometry}
\title{Clip GEDI Canopy Cover and Vertical Profile Metrics by geometry}
\usage{
clipLevel2BVPMGeometry(level2BVPM, polygon_spdf, split_by)
}
\arguments{
\item{level2BVPM}{A GEDI Level2B object (output of \code{\link[rGEDI:readLevel1B]{readLevel1B}} function).
An S4 object of class "gedi.level2b".}

\item{polygon_spdf}{Polygon. An object of class \code{\link[sp]{SpatialPolygonsDataFrame-class}},
which can be loaded as an ESRI shapefile using \code{\link[raster:shapefile]{raster::shapefile()}} function in the \emph{raster} package.}

\item{split_by}{Polygon id. If defined, GEDI data will be clipped by each polygon using the attribute specified by \code{split_by} from the attribute table.}
}
\value{
An S4 object of class \code{\link[data.table:data.table]{data.table-class}}
containing the Canopy Cover and Vertical Profile metrics.
}
\description{
This function clips GEDI level2B derived
Canopy Cover and Vertical Profile metrics within a given geometry
}
\examples{
# Specifying the path to GEDI level2B data (zip file)
level2B_fp_zip <- system.file("extdata",
                  "GEDI02_B_2019108080338_O01964_T05337_02_001_01_sub.zip",
                  package="rGEDI")

# Unzipping GEDI level2A data
level2Bpath <- unzip(level2B_fp_zip,exdir = dirname(level2B_fp_zip))

# Reading GEDI level2B data (h5 file)
level2b<-readLevel2B(level2Bpath=level2Bpath)

# Extracting canopy cover and vertical profile metrics
level2BVPM<-getLevel2BVPM(level2b)

# Specifying the path to shapefile
polygon_filepath <- system.file("extdata", "stands_cerrado.shp", package="rGEDI")

# Reading shapefile as SpatialPolygonsDataFrame object
library(raster)
polygon_spdf<-shapefile(polygon_filepath)

# Clipping level2BVPM by geometry
level2b_clip_geometry <- clipLevel2BVPMGeometry(level2BVPM,polygon_spdf,split_by="id")

\donttest{
library(leaflet)
leaflet() \%>\%
 addCircleMarkers(level2b_clip_geometry$longitude_bin0,
                  level2b_clip_geometry$latitude_bin0,
                  radius = 1,
                  opacity = 1,
                  color = "red")  \%>\%
 addScaleBar(options = list(imperial = FALSE)) \%>\%
 addPolygons(data=polygon_spdf,weight=1,col = 'white',
             opacity = 1, fillOpacity = 0) \%>\%
 addProviderTiles(providers$Esri.WorldImagery)
}

close(level2b)
}
\seealso{
https://lpdaac.usgs.gov/products/gedi02_bv001/
}
