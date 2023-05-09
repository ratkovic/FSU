# Causal Inference and Machine Learning Shortcourse

Hello! Welcome to the FSU short course on Machine Learning and Causal Inference. We will be working from an overleaf available [here](https://www.overleaf.com/read/dhrpjympcfkm).

If you have R and RStudio installed on your computer, you're just about good to go.  Make sure that you have the pacakges `cli`, `grf`,`ranger`, `MDEI`, and `devtools` installed from CRAN.  You will also need the `PLCE` package from my github, which can be downloaded `devtools::install_github('ratkovic/PLCE')`. 

Finally, with those in place, install this package using  `devtools::install_github('ratkovic/FSU')`. 


## Loading in a handout 

With all of the packages in, run `FSU::get_handout(1)` and then you will be given instructions on how to access the handout.  The handout will be used to illustrate ideas from the discussion as well as introduce you to methods for causal inference and machine learning.


## Updating the package

This package will be updated throughout the course.  You can download the most recent version of this package by running  `FSU::update_package()`.


The structure of this package builds off work first done by Will Lowe, so thank him when you see him.


# Working from Docker

If you have problems downloading these packages, you can run them from Docker.  To do so, please follow these steps.

* Install Docker on their your machine. Detailed instructions for various operating systems can be found in the Docker documentation:

	+ Windows: [https://docs.docker.com/desktop/windows/install/](https://docs.docker.com/desktop/windows/install/)
 	+ macOS: [https://docs.docker.com/desktop/mac/install/](https://docs.docker.com/desktop/mac/install/)
	+ Linux (Ubuntu): [https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)


* Make sure Docker is running by opening Docker Desktop.

* Open a terminal or command prompt. Enter:

`docker pull marcratkovic/rstudio_fsu`

then from the command line run

`docker run -d -p 8787:8787 marcratkovic/rstudio_fsu`

* Open a browser and enter the url `http://localhost:8787`

You should be good to go, with `devtools` downloaded!




