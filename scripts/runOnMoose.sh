curl -L https://get.pharo.org/64/vm100 | bash
wget https://github.com/moosetechnology/Moose/releases/download/v10.x.x/Moose10-stable-Pharo64-10.zip
unzip Moose10-stable-Pharo64-10.zip

./pharo --headless Moose10-stable-Pharo64-10.image ./scripts/runTests.st

FILE=/tmp/result.txt
if [ ! -f "$FILE" ]; then
    echo "ERROR: $FILE does not exists!"
    exit 1
fi


cat $FILE

if grep -q ERROR "$FILE"; then
		echo "SOME ERRORS!"
		exit 1
else
		echo "ALL TEST PASSED"
		exit 0
fi
