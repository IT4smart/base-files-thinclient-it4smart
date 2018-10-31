all:
	@echo "Specify a target:\nmake armv6l\nmake armv7\nmake i386\n"

armv6l:
	sudo bash build.sh "armv6l"

armv7:
	sudo bash build.sh "armv7"

clean:
	sudo rm -rf *.deb > /dev/null 2>&1
