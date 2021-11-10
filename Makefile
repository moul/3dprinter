UPDATE_ENV = PATH=$(PATH):$(dir $(wildcard $(HOME)/Library/Python/*/bin/platformio))

.PHONY: all
all: compile

.PHONY: compile
compile: deps
	@#cd Marlin && git checkout bugfix-JyersUI && git pull
	cp ender3v2-config/*.h ./Marlin/Marlin/
	cd Marlin; $(UPDATE_ENV) platformio run --target clean
	cd Marlin; $(UPDATE_ENV) platformio run
	cp Marlin/.pio/build/STM32F103RET6_creality_maple/*.bin ender3v2-config/image.bin

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
