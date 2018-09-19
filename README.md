# Cool Course

Repository template for developing teaching course material in simple markup text files and publishing it in html, via **gh-pages** or a simple http webserver.

http://pedroswits.github.io/cool-course/

---

## Overview

The material of this course is composed of presentation slides and practical coursework.

### Slides

[Revealjs](https://github.com/hakimel/reveal.js/) is used to create presentation slides. These are written in [markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) and converted to a static website via [reveal-md](https://github.com/webpro/reveal-md).

### Practicals

Coursework material can be easily written in asciidoc. Using [asciidoctor](https://asciidoctor.org/docs/user-manual/) we can convert the source asciidoc files into self-contained static html files which can be deployed on a webserver and nicely viewed on the browser.

## Usage

### Starting your course repository

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

### Writing the content

#### Generic Course info

Generic information about the course, e.g. overview and schedule, should be written in **asciidoc**. These should be placed under the `docs/` folder.

#### Slides

The slides for your talks are **revealjs** and can be written in markdown. Place them under the `docs/slides` folder.

#### Coursework

The coursework speaks **asciidoc**. These should be placed under the `practicals/docs` folder.

### Installation & Requirements

Installation is as easy as:

```
make install
```

This installs **asciidoctor** and **compass** as ruby gems, and **reveal-md** locally via npm.

For these to work you need:

- [ruby](https://www.ruby-lang.org/)
- [gem](https://rubygems.org/)

to install the **asciidoctor** and **compass** ruby gems, and:

- [node](https://nodejs.org/)
- [npm](//https://www.npmjs.com//)

to install **reveal-md**.

### Generating the html

Generating the html is as simple as:
```
make html
```

Make reads the file structure in `docs` and creates the corresponding html file structure in the `build` folder.

```
build
├── coursework
│   └── sample.html
├── images
│   └── icons
├── index.html
├── overview.html
├── schedule.html
└── slides
    └── example
```

Coursework documents, written in asciidoc, generate a single self-contained html file, but slides documents, written in markdown, generate an entire directory containing the necessary files revealjs presentation (`build/slides/example`). However, both result in static html content, directly deployable on a webserver.

**NOTE:** Only the input files with the following patterns are inspected and converted to html by the makefile:

- `docs/*.adoc`
- `docs/slides/*.md`
- `docs/coursework/*.adoc`

### Asciidoctor extensions

Asciidoctor extensions allow you to customise some of the nicest things about asciidoc. Here, I provide an example of how to write and use a custom admonition block, with a custom icon image. More information can be find in asciidoctor's [user manual](https://asciidoctor.org/docs/user-manual/#extensions) and examples in their [extensions lab](https://github.com/asciidoctor/asciidoctor-extensions-lab).


## Deploy to **gh-pages**

### Manually

I suggest following the [approach](https://gist.github.com/cobyism/4730490).

However, this comes at the cost of removing the **build** directory from the gitignore file, which doesn't seem to make it a very elegant solution. On the other hand, it simplifies things a lot. Everytime there's an update to the **build** folder, you commit it to master and push the changes to **gh-pages** using git subtree:

```
git subtree push --prefix dist origin gh-pages
```

### Continuous Integration

If you want commits to master to automatically update **gh-pages** then continuous integration is the way to go.

I tried using **travis-ci** and **circle-ci**. The latter felt easier to customise (since we're using Ruby and Nodejs in the same build), but I couldn't get it to work properly in the end as Chromium would break when running **reveal-md**.

### Finally

Remember to activate GitHub Pages on the settings panel of your repository.

If the steps above run successfully, the project's gh-pages should be available at:

http://GIT_WHOAMI.github.io/GIT_PROJECT/

## License
MIT
