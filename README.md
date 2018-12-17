# vi-xml

XML process viewer.

## Development

### Requirements

* sassc

### Build

Modify
`src/proceso_style.scss` for styles and
`src/proceso_transform.xsl` for the template.

Build the `css` using `$ make`

## Usage

Just have this as header of your xmls:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="proceso_transform.xsl"?>
```

then open in the browser the xml file

## What does a proces look like?

Like this: https://tracsa.github.io/vi-xml/proceso.xml
