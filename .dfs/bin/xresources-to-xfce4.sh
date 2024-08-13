#!/bin/bash
#Description: Create XFCE Terminal colorschemes from Xresources/Xdefaults files
#Place resulting .theme files in /usr/share/xfce4/terminal/colorschemes/
#Copyright: Rxtx Project <nodiscc@gmail.com>
#Thanks to u/evaryont at http://redd.it/15z69z
#License: MIT (http://opensource.org/licenses/MIT)
#TODO: does not work for any xdefaults file (see space_supreme.xdefaults)

XRESFILE="$HOME"/.Xresources
cat "$HOME"/.Xresources

if [ -z "$1" ]; then
	THEMENAME=Xresources
else
	THEMENAME="$1"
fi

TEMPFILE=""
ARRAY=""

grep -q "define" "$XRESFILE"
if [ "$?" = 0 ] #cpp-style file detected
	then TEMPFILE=`mktemp`
	cpp < "$XRESFILE" > "$TEMPFILE"
	XRESFILE="$TEMPFILE"
fi

number=0
while [ $number -lt 16 ]
do
	ARRAY=`echo $ARRAY ; egrep "\*.color$number\:" $XRESFILE | egrep -v "^\!"| awk '{print $NF}'`
	number=$(($number+1))
done

PALETTEVALUE=`echo $ARRAY | sed 's/\ /\;/g'`
BACKGROUNDVALUE=`grep background $XRESFILE | awk '{print $NF}'`
FOREGROUNDVALUE=`grep foreground $XRESFILE | awk '{print $NF}'`
CURSORCOLOR=`grep cursorColor $XRESFILE | awk '{print $NF}'`

CONTENTS=`
echo "[Scheme]"
echo "Name=${THEMENAME}"
echo "ColorPalette=$PALETTEVALUE"
echo "ColorForeground=$FOREGROUNDVALUE"
echo "ColorCursor=$CURSORCOLOR"
echo "ColorCursorForeground=$BACKGROUNDVALUE"
echo "ColorBackground=$BACKGROUNDVALUE"
echo "ColorCursorUseDefault=FALSE"
echo "ColorBoldIsBright=TRUE"`


if [ -f "$TEMPFILE" ]
	then rm "$TEMPFILE"
fi

echo "Writing ${THEMENAME}.theme to /usr/share/xfce4/terminal/colorshcemes/${THEMENAME}.theme"
sudo echo "${CONTENTS}" > /usr/share/xfce4/terminal/colorschemes/"${THEMENAME}".theme
#echo "${CONTENTS}" > "${THEMENAME}".theme
