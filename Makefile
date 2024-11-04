NAME := avian
LISP ?= qlot exec ros run

build:
	rm -rf build/

	$(LISP) --load $(NAME).asd \
		--eval '(ql:quickload :$(NAME))' \
		--eval '(push :deploy-console *features*)' \
		--eval '(asdf:make :$(NAME))' \
		--eval '(quit)'
