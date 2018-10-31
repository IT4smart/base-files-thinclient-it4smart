all:
	sudo bash build.sh "all"

clean:
	sudo rm -rf *.deb > /dev/null 2>&1
