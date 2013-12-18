#!/bin/bash
if [ $# -eq 1 ]; then
sed '/asus/d' $1 >tmp1.xml
sed '/mini/d' tmp1.xml >tmp2.xml
sed '/mips/d' tmp2.xml >tmp1.xml
sed '/generic\/x86/d' tmp1.xml >tmp2.xml
sed '/lge/d' tmp2.xml >tmp1.xml
sed '/accessory/d' tmp1.xml >tmp2.xml
sed '/msm8x30/d' tmp2.xml >tmp1.xml
sed '/sample/d' tmp1.xml >tmp2.xml
sed '/samsung/d' tmp2.xml >tmp1.xml
sed '/\<ti\>/d' tmp1.xml >tmp2.xml
sed '/\<cts\>/d' tmp2.xml >tmp1.xml
sed '/demos/d' tmp1.xml >tmp2.xml
sed '/docs/d' tmp2.xml >tmp1.xml
sed '/arduino/d' tmp1.xml >tmp2.xml
sed '/broadcom/d' tmp2.xml >tmp1.xml
sed '/darwin/d' tmp1.xml >tmp2.xml
sed '/eabi-4\.6/d' tmp2.xml >tmp1.xml
sed '/\/x86\//d' tmp1.xml >tmp2.xml

else
cat << EOF
Usage: $0 xxx.xml
EOF
fi
