#!/bin/bash
SRC_DIR=$(pwd)

function dpkg_build()
{
	# Calculate package size and update control file before packaging.
	if [ ! -e "$1" -o ! -e "$1/DEBIAN/control" ]; then exit 1; fi
	sed '/^Installed-Size/d' -i "$1/DEBIAN/control"
	size=$(du -s --apparent-size "$1" | awk '{print $1}')
	echo "Installed-Size: $size" >> "$1/DEBIAN/control"
	dpkg -b "$1" "$2"
}

sed '/Package/d' -i "${SRC_DIR}/files/DEBIAN/control"
sed '/Depends/d' -i "${SRC_DIR}/files/DEBIAN/control"
echo "Package: base-files-thinclient-it4smart" >> "${SRC_DIR}/files/DEBIAN/control"

dpkg_build files "${1}-base-file-thinclient-it4smart.deb"

# get current version of this package
version=$(awk '/^Version:/ { print $2 }' files/DEBIAN/control)
package=$(awk '/^Package:/ { print $2 }' files/DEBIAN/control)
architecture=$(awk '/^Architecture:/ { print $2 }' files/DEBIAN/control)

mv "${1}-base-file-thinclient-it4smart.deb" "${package}_${version}_${architecture}.deb"
