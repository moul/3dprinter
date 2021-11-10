UPDATE_ENV = PATH=$(PATH):$(dir $(wildcard $(HOME)/Library/Python/*/bin/platformio))

.PHONY: all
all: compile

.PHONY: compile
compile: deps
	@#cd Marlin && git checkout bugfix-JyersUI && git pull
	cd Marlin; $(UPDATE_ENV) platformio run --target clean
	cd Marlin; $(UPDATE_ENV) platformio run

.PHONY: deps
deps: Marlin .platformio

.platformio:
	pip install -U https://github.com/platformio/platformio-core/archive/develop.zip
	$(UPDATE_ENV)	platformio update
	touch .platformio

Marlin:
	git clone git@github.com:Jyers/Marlin

.PHONY: nix
nix:
	nix-shell --run 'make all'

.PHONY: clean
clean:
	rm -f .venv-nix .platformio
	#cd Marlin; git clean -fxd
