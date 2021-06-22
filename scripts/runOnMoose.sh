curl -L https://get.pharo.org/64/vm80 | bash
wget https://github.com/moosetechnology/Moose/releases/download/v8.0.2/Moose8-stable.zip
unzip Moose8-stable.zip

./pharo --headless Moose8-stable.image ./scripts/runTests.st

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
