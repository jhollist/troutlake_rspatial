
# R for Spatial Analysis

Not too long ago, the standard advice for mixing spatial analysis and R
was to do your spatial analysis tasks with a GIS and your statistical
analysis of the results of that analysis with R. However, since the late
2000’s there has been a rapid increase in the spatial data handling and
analysis capability of R. The `rgdal`, `rgeos`, `raster`, and `sp`
packages (through the very significant effort of the package authors)
provided the foundation for doing GIS entirely within R. More recently a
new route for handling vector data has emerged in the [`sf`
package](https://cran.r-project.org/package=sf). Most current
development for vector processing is focusing on `sf`. As such, this
mini-workshop will as well (with a little bit of `sp` thrown in for good
measure). Raster data is still mostly dealt with via the
[`raster`](https://cran.r-project.org/package=raster) package (although
this is changing too) and we will also be using that.

Also, there are some really nice resource available for learning how to
use R for spatial data analysis. A couple I like:

  - [Geocomputation with R](https://geocompr.robinlovelace.net/)
  - [r-spatial](https://www.r-spatial.org/)
  - [rspatial](https://www.rspatial.org/)

## Lesson Outline

  - [`sf`](#sf)
  - [`raster`](#raster)
  - [`rgdal` and `sp`](#rgdal-and-sp)
  - [Aside: Interacting with an external
    GIS](#aside-interacting-with-an-external-gis)
  - [Mapping packages](#mappping-packages)

## sf

The [`sf` package](http://r-spatial.github.io/sf/) provides vector data
handling via the Simple Features standard, an Open Geospatial Consortium
and International Standards Organization standard for spatial data. In
addition, `sf` provides a tidy spatial data format that allows for
manipulation with the popular `dplyr` package.

On Windows, getting `sf` added is no different than adding any other
package that is on CRAN. If you are on linux or macOS then you’ll need
to put in a bit more effort (i.e. need to have GDAL installed). Best
instructions for getting all this set up are at
<https://github.com/r-spatial/sf#installing>. If you are on macOS, you
will need XCode and `homebrew` installed. To do so, open up a Terminal
window the type:

    xcode-select --install

Once that finishes we can get the latest version of `homebrew` with this
incantation:

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

Copy and paste this, hit return and then you should be ready to get the
libraries needed for `sf`. With `homebrew` installed, we can now install
what we need; gdal and geos.

    brew install gdal
    brew install geos

If you are on linux, I’ll assume you can get gdal and geos on your own\!

In theory, we should be good to install `sf` now:

``` r
install.packages("sf")
library("sf")
```

You get a lot with `sf`. It provides the ability to work with a very
wide array of spatial data formats (eg. points, lines, polygons,
geometry collections, and more) plus many of the standard GIS
functionalities (overlays, buffers, projections, etc.). One other
package to be aware of that I have used often in conjunction with `sf`
is [`lwgeom`](https://r-spatial.github.io/lwgeom/) which provides some
additional functionality, but we won’t be looking at that one today.

## raster

For our raster data processing we will use the venerable `raster`
package.

To install, just do:

``` r
install.packages("raster")
library("raster")
```

The [`raster` package](https://rspatial.org/raster/index.html) has been
around for some time and provides a lot of raster functionality. It has
been extended with other packages such as `gdistance` which provides the
ability to work with cost surfaces in R, and `landsat` which provides
tools to process Landsat data. Similar to how `sf` recently replaced
some older packages, a few new packages are being developed that likely
will eventually replace `raster`. Two to be aware of are `terra` and
`stars`. The development of the `terra` package is being led by Robert
Hijmans (the author of `raster`) and according to the
[repository](https://github.com/rspatial/terra) promises to have a,
“very similar, but simpler, interface” and should be, “much faster.”
The [`stars` package](https://r-spatial.github.io/stars/), led by Edzer
Pebesma, also the lead for `sf`, is for multi-dimensional spatiotemporal
arrays. It largely has a different niche than `raster` or `terra` so is
perhaps a compliment, but I’d expect there to be some degree of overlap.
Both of these packages are in development but will likely see much more
use in the future. We will still focus on `raster` for this workshop.

## rgdal and sp

While we won’t be using the `rgdal` and `sp` packages directly, `raster`
does depend on them so I wanted to mention them briefly. The `rgdal`
package provides tools for reading and writing multiple spatial data
formats. It is based on the [Geospatial Data Abstraction Library
(GDAL)](http://www.gdal.org/) which is a project of the Open Source
Geospatial Foundation (OSGeo). The `sp` package has been the *de-facto*
package for spatial data handling and is required for us to use the
`raster` package.

As before, nothing special to get set up with `rgdal` or `sp` on
windows:

``` r
install.packages("rgdal")
library("rgdal")

install.packages("sp")
library("sp")
```

If you’ve succesfully installed `sf` (and gdal and geos) on macOS then
you should be good to go with the above functions for installing `rgdal`
and `sp` on macOS.

## Aside: Interacting with an external GIS

Although we won’t be working with external GIS in this workshop, there
are several packages that provide ways to move back and forth from
another GIS and R.

  - [spgrass6](https://cran.r-project.org/web/packages/spgrass6/index.html):
    Provides an interface between R and
    [GRASS 6+](https://grass.osgeo.org/download/software/#g64x). Allows
    for running R from within GRASS as well as running GRASS from within
    R.  
  - [rgrass7](https://cran.r-project.org/web/packages/rgrass7/index.html):
    Same as `spgrass6`, but for the latest version of GRASS,
    [GRASS 7](https://grass.osgeo.org/download/software/#g70x).
  - [RPyGeo](https://cran.r-project.org/web/packages/RPyGeo/index.html):
    A wrapper for accessing ArcGIS from R. Utilizes intermediate python
    scripts to fire up ArcGIS. Hasn’t been updated in some time.
  - [RSAGA](https://cran.r-project.org/web/packages/RSAGA/index.html): R
    interface to the command line version of [SAGA
    GIS](http://www.saga-gis.org/en/index.html).
  - [RQGIS](https://cran.r-project.org/package=RQGIS): Provides an
    interface to [QGIS](http://www.qgis.org/en/site/) from R.

## Mapping packages

There are many different packages available for creating maps in R, in
the demos to come we will focus on two packages, `ggplot2` and
`mapview`, in addition to the default plotting that `sf` and `raster`
provide.

To make sure these are installed:

``` r
install.packages("ggplot2")
library("ggplot2")

install.packages("mapview")
library("mapview")
```

We will use `ggplot2` to build static maps, and use `mapview` for
interactive maps. In addition to these, it probably pays to be aware of
a few others that are commonly used for mapping.

  - [`leaflet`](https://rstudio.github.io/leaflet/): R wrapper for the
    Leaflet javascript library. The `mapview` package is actually a
    wrapper (in-part) around this pacakge
  - [`tmap`](https://github.com/mtennekes/tmap): Built for making
    thematic maps and has built in support to scale bars, north arrows,
    etc.
  - [`ggmap`](https://github.com/dkahle/ggmap): Built on top of
    `ggplot2`, `ggmap` allows for combining spatial data with map tiles
    from sources such as Goolge Maps or Stamen Maps.
