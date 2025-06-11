SRC=src
HOST=https://github.com
REPO=$(HOST)/libxml-raku/LibXML-Writer-raku
DocProj=libxml-raku.github.io
DocRepo=$(HOST)/libxml-raku/$(DocProj)
DocLinker=../LibXML-raku/etc/resolve-links.raku
TEST_JOBS ?= 6

all : doc

test :
	@prove6 -I . -j $(TEST_JOBS) t

xtest :
	@prove6 -I . t -j $(TEST_JOBS) xt

loudtest :
	@prove6 -I . -v t

clean :

realclean : clean
	@rm -f Makefile docs/*.md docs/*/*.md

Pod-To-Markdown-installed :
	@raku -M Pod::To::Markdown -c

doc : Pod-To-Markdown-installed docs/index.md docs/Writer.md docs/Writer/Buffer.md docs/Writer/Document.md docs/Writer/File.md docs/Writer/Node.md docs/Writer/PushParser.md

docs/index.md : README.md
	(\
	    echo '[![Actions Status]($(REPO)/workflows/test/badge.svg)]($(REPO)/actions)'; \
            echo -n '[[Raku LibXML Project]](https://libxml-raku.github.io)'; \
            echo ' / [[LibXML-Writer Module]](https://libxml-raku.github.io/LibXML-Writer-raku)'; \
            echo '';\
            cat $< \
        ) > $@

docs/%.md : lib/LibXML/%.rakumod
	@raku -I . -c $<
	raku -I . --doc=Markdown $< \
	| TRAIL=LibXML/$* raku -p -n $(DocLinker) \
        > $@
