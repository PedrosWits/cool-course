[![Build Status](https://travis-ci.org/PedrosWits/course-template.svg?branch=master)](https://travis-ci.org/PedrosWits/course-template)

# Yet another Course Template

A structured template repository for writing the course material
(slides and practicals) in simple markup text files and converting them to html, ready to be delivered via **gh-pages** or a webserver.

---

## Overview

### Slides

[Revealjs](https://github.com/hakimel/reveal.js/) is used to create presentation slides. These are written in [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) and converted to a static website via [reveal-md](https://github.com/webpro/reveal-md).

### Practicals

Coursework material can be easily described in asciidoc. Using [asciidoctor](https://asciidoctor.org/docs/user-manual/) we can easily convert the source asciidoc files into self-contained static html files which can be easily deployed on a webserver and nicely viewed on the browser.

## Usage

You probably want to use this repository as a basis for your own course-material repository. The best solution, in my opinion, is to clone this repository, [remove all history, make commits and push to your own repository](https://stackoverflow.com/a/9683337):

```shell
# Step 1
git clone https://github.com/PedrosWits/course-template COURSENAME
cd COURSENAME

# Step 2
rm -rf .git

# Step 3
git init
git add .
git commit -m "Initial commit"

# Step 4
git remote add origin <github-uri>
git push -u --force origin master
```

See below for how to generate the html files for the slides and coursework.

## Lecture/Talk Slides - Revealjs

Write the slides for your talk in markdown (revealjs) and place them under the `slides/docs` folder.

### Requirements

- [node](https://nodejs.org/)
- [npm](//https://www.npmjs.com//)

### Installation

Installs **reveal-md** locally via npm:
```
cd slides && make install
```

### Slides to HTML

Convert your asciidoc files to html again with the Makefile (which just calls asciidoctor):

```
cd slides && make slides
```

The resulting HTML will be placed in `slides/build/`.

## Practicals - Asciidoc

Write your tutorials/practicals in asciidoc and place them under the `practicals/docs` folder.

### Requirements

- [ruby](https://www.ruby-lang.org/)
- [gem](https://rubygems.org/)

### Installation

Installs **asciidoctor** as a ruby gem:
```
cd practicals && make install
```

### Stylesheets

Retrieve and build the [asciidoctor stylesheets](https://github.com/asciidoctor/asciidoctor-stylesheet-factory) so that you can include them in the final html.

```
cd practicals && make stylesheets
```

### Practicals to HTML

Convert your asciidoc files to html again with the Makefile (which just calls asciidoctor):

```
cd practicals && make html
```

The resulting HTML will be placed in `practicals/build/`.

## License
MIT
