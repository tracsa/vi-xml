.PHONY: clean

STYLE_HREF = <link rel=\"stylesheet\" href=\"proceso_style.css\"\/>

all: build/proceso_style.css build/proceso_transform.xsl

build/proceso_style.css: src/proceso_style.scss
	sassc src/proceso_style.scss build/proceso_style.css

build/proceso_transform.xsl: src/proceso_transform.xsl
	sed "s/<link rel=\"stylesheet\" href=\"proceso_style.css\"\/>/$(STYLE_HREF)/g" src/proceso_transform.xsl > build/proceso_transform.xsl

clean:
	rm build/proceso_style.css
	rm build/proceso_transform.xsl
