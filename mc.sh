#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]
then
	echo "Usage: mc.sh <username> <fullversion>"
	exit 1
fi

NAME="$1"
MC="$2"

MCASSETS="${MC%.*}"
MCDIR="versions/$MC"
MCJAR="$PWD/$MCDIR/$MC.jar"

if [ -f "$MCJAR" ]
then
	echo "Using Minecraft $MCJAR"
else
	echo "Minecraft $MCJAR not found!"
	exit 1
fi

MCNATIVE="$MCDIR/natives"
LIBS=$(find "$PWD"/libraries -type f | tr '\n' ':')
JVMOPT="-Xms512m -Xmx1g"
java $JVMOPT -Djava.library.path="$MCNATIVE" -cp "$LIBS:$MCJAR" net.minecraft.client.main.Main -accessToken null --version "$MC" --assetIndex ${MCASSETS}  --username "$NAME"
