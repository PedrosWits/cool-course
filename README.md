[![Build Status](https://travis-ci.org/PedrosWits/cool-course.svg?branch=master)](https://travis-ci.org/PedrosWits/cool-course)

# Cool Course

Repository template for developing teaching course material in simple markup text files and publishing it in html, via **gh-pages** or a simple http webserver.

http://pedroswits.github.io/cool-course/demo/overview.html

---

## Overview

The material of this course is composed of presentation slides and practical coursework.

### Slides

[Revealjs](https://github.com/hakimel/reveal.js/) is used to create presentation slides. These are written in [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) and converted to a static website via [reveal-md](https://github.com/webpro/reveal-md).

### Practicals

Coursework material can be easily written in asciidoc. Using [asciidoctor](https://asciidoctor.org/docs/user-manual/) we can convert the source asciidoc files into self-contained static html files which can be deployed on a webserver and nicely viewed on the browser.

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

See below how to generate the html files for the slides and coursework.

## Presentation Slides - Revealjs

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

## Coursework - Asciidoc

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

## Deploy to **gh-pages**

The repo contains a `.travis.yml` file which is configured to publish built html files directly on the **gh-pages** branch.

To make this work, you need to:

- Modify GITHUB_TOKEN with your own value obtained via **travis encrypt**.
- Activate GitHub Pages on the settings panel of your repository.

If this is done successfully, the project gh-pages should be available at:

http://GIT_WHOAMI.github.io/GIT_PROJECT/demo/overview.html

## License
MIT
