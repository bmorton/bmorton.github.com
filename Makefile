jekyll:
	@echo "\n\nhttp://localhost:1337/\n\n"
	@jekyll --auto --server 1337
clean:
	find . -name '*~' -exec rm -fv {} \;