# Getting Started with R and R Studio

Hello! Welcome to POL 345 / SOC 305 / WWS 201. In order to participate in the course, you will need to install three pieces of software onto your computer.

## Install R

The first piece of software we will install is R, which we will use for our statistical work.

### Mac Users

1. Download and install [R for Mac](https://cran.rstudio.com/bin/macosx/base/R-release.pkg)

2. Open your Terminal Application (you’ll find it in the Applications > Utilities folder) and type

   `xcode-select --install`

3. Say yes to install the ‘command line tools’. (Machine tells you you’ve got them already? Then we’re all good.)

### Windows Users

1. Download and install [R for Windows](https://cran.r-project.org/bin/windows/base/R-4.2.1-win.exe)

2. Download and install [Rtools for Windows](https://cran.rstudio.com/bin/windows/Rtools/rtools42/files/rtools42-5253-5107-signed.exe)

If, in the steps above, you allowed R and RStudio to put an icon on your desktop then you now have two. Put R’s icon in
the trash and keep the RStudio one. Things will be less confusing that way.

## Install RStudio

The second piece of software we will install is RStudio, which will be provide a nice interface with R.

Go to [Rstudio's download page](https://www.rstudio.com/products/rstudio/download/) and find the section `RStudio Desktop`.  We have already done step 1, so proceed to step 2 and download Rstudio for your operating system.

If, in the steps above, you allowed R and RStudio to put an icon on your desktop then you now have two. Put R’s icon in
the trash and keep the RStudio one. Things will be less confusing that way.

## Install LaTeX for making PDF documents

Lastly, we will install LaTeX, which will allow you to compile your assignments to a PDF for submission.

For both Mac and Windows users,

1. OpenRStudio

2. Paste the following command into the Console. (It’s at the bottom left of the application window)

         install.packages('tinytex') 
         
         tinytex::install_tinytex() # takes a while

3. NOTE for Mac users: You _may_ get this error after running the second command above: 

`The directory /usr/local/bin is not writable. I recommend that you make it writable.` 

After the installation process finishes, another error most likely will appear stating 
`add_link_dir_dir: destination /usr/local/bin not writable.`

Run the following commands in Terminal to resolve this:

         sudo chown -R `whoami`:admin /usr/local/bin 
         
         ~/Library/TinyTeX/bin/*/tlmgr path add

where `whoami` is the name you use to log in to your Mac.

4. Still in RStudio, select menu File > New File > RMarkdown
5. Click the Knit icon at the top of the file that just opened (it’s a ball of blue wool with a knitting needle in it) If all goes well a PDF document will be created.

You’re all set!

### Workaround

Alternatively, you can simply generate Word documents rather than pdf documents for the work handed in during the course. If you choose to do this, you should remember to ‘print to pdf’ these documents before uploading to Blackboard.

To check Word document creation works, go to the RMarkdown document you created above and instead of clicking on the Knit button, press the menu indicator just to the right of it and choose ‘Knit to Word’.

# The pol345.student package

`pol345.student` allows students to unpack and complete questions
in the pre-precept handouts for Princeton University's course 
Politics 345.  This updated package is designed for the Fall 2021
Semster and was originally developed by Will Lowe and Marc Ratkovic 
in Fall 2019.

## Installation

The problem sets are a bit too big for CRAN, so you'll want to
make sure you've got the `devtools` package installed.  To do so, you can run

    install.packages('devtools')


Then grab the package from GitHub like this:

    devtools::install_github("ratkovic/pol345.student")
    
## Loading the Package

In order to access the course materials, you will need to load the library. This can be done with the command

    library(pol345.student)

This will allow you to call all the functions in the package.  This needs to be run only once per session.

## Updating

The package can be updated while installed by calling 

    update_package()
    
For good measure, now *restart* your R session. In RStudio use the menu: 
`Session > Restart R`.

## Usage

### Working on a handout

To start work on handout one, type
```
pol345.student::get_handout(1)
```
This will unpack the handout materials into a folder called
`handout1` in your *current working directory*.
(Type `getwd()` if you're not sure where that is. 
You can change it using `setwd` or through RStudio's 
Session menu).

If you want to *fresh start* on the same handout, you'll can unpack 
again under a different name (the `get_handout` function won't
overwrite an existing folder.) To do this add a 
`newname` argument when y ou call the function. So, if you want 
your new copy to be called "handout1-for-real", then use 
```
pol345.student::get_handout(1, newname = "handout1-for-real")
```
Provided there's not already a folder of that name in your 
current working directory, you'll get a fresh set of 
handout materials unpacked there.

If you want to preview the questions in a handout materials *without* 
unpacking it into your local file system, use
```
pol345.student::preview_handout(1)
```

### Working on a precept

Working on precept is just the same; just use
`get_precept(1)`, 
`get_precept(1, newname = "precept1-second-go")`, or 
`preview_precept(1)` as above.

### Sneak preview

You can view precept 1's 'answers' with
```{r}
pol345.student::get_precept_answers(1)
```
Note: this shows one way to answer the questions. Often 
there will be others, so do not automatically assume that 
your code is incorrect if it does not match the code in the 
answers.

## Status

[![Travis-CI Build Status](https://travis-ci.org/conjugateprior/pol345.student.svg?branch=master)](https://travis-ci.org/conjugateprior/pol345.student) [![Build status](https://ci.appveyor.com/api/projects/status/rfj426c7ddq4ni72?svg=true)](https://ci.appveyor.com/project/conjugateprior/pol345-student)
