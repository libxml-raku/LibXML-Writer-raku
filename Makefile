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

doc : Pod-To-Markdown-installed docs/index.md docs/LibXML/Writer.md docs/LibXML/Writer/Buffer.md docs/LibXML/Writer/Document.md docs/LibXML/Writer/File.md docs/LibXML/Writer/PushParser.md

docs/index.md : README.md
	(\
	    echo '[![Actions Status]($(REPO)/workflows/test/badge.svg)]($(REPO)/actions)'; \
            echo '';\
            cat $< \
        ) > $@

docs/LibXML/%.md : lib/LibXML/%.rakumod
	@raku -I . -c $<
	raku -I . --doc=Markdown $< \
	| TRAIL=LibXML/$* raku -p -n $(DocLinker) \
        > $@
