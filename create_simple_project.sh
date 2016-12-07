PATH=$1
PROJNAME=`/usr/bin/basename $1`
SOURCE_PATH=`/usr/bin/dirname ${BASH_SOURCE[0]}`

echo "Creating project ${PROJNAME} at ${PATH}"

if [ -d "$PATH" ]; then
    echo "Directory already exists"
    exit
fi

/bin/mkdir ${PATH} ${PATH}/src ${PATH}/test

/usr/bin/sed "s/__BINNAME__/${PROJNAME}/g" ${SOURCE_PATH}/Makefile.template > ${PATH}/Makefile
/usr/bin/sed "s/__BINNAME__/${PROJNAME}/g" ${SOURCE_PATH}/src/template.cc >  ${PATH}/src/${PROJNAME}.cc
/usr/bin/sed "s/__BINNAME__/${PROJNAME}/g" ${SOURCE_PATH}/test/template_test.cc > ${PATH}/test/${PROJNAME}_test.cc
/bin/cp ${SOURCE_PATH}/gitignore_template ${PATH}/.gitignore
cd ${PATH}
/usr/bin/git init
/usr/bin/git add Makefile src/*.cc test/*.cc .gitignore
/usr/bin/git commit -m "Initial commit for ${PROJNAME}"
