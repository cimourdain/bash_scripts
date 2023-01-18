tests:
	docker run -it --rm -v "$(PWD):/work" ghcr.io/ffurrer2/bats:latest test -r --verbose-run 
	
format:
	docker run --rm -u "$(id -u):$(id -g)" -v "$(PWD):/mnt" -w /mnt mvdan/shfmt:latest -w /mnt/src

style:
	docker run --rm -u "$(id -u):$(id -g)" -v "$(PWD):/mnt" -w /mnt mvdan/shfmt:latest --list --diff /mnt/src

.PHONY: tests format