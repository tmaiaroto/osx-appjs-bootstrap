#!/bin/bash

function realpath_f () {(cd "$1" && echo "$(pwd -P)")}

function usage() {
    echo "OS X AppJS Application Bundler"
    echo "---------------------------------"
    echo "This simple little script will copy your Node.js application from the 'src' directory,"
    echo "along with everything else you need, into a bundled OS X application for distribution."
    echo ""
    echo "NOTE: You may wish to edit the Info.plist file in the final .app bundle to taste."
    echo "Though you can edit most of it using command line options with this script."
    echo "Also keep in mind that your application code is not protected or encoded in any way."
    echo ""
    echo "Options:"
    echo "  -h, --help      This screen"
    echo "  -f --force      Overwrites any existing application bundle"
    echo "  -o, --open      Runs the application immediately after build"
    # TODO:
    # echo "  -t --test       Tests the application before bundling it"
    echo "  --name=         Your desired application file name (defaults to: MyApp)"
    echo "  --displayname=, --display-name=, --bundle-display-name="
    echo "                  Your desired application display name (defaults to file name)"
    echo "  --bundle-identifier=, --identifier="
    echo "                  Optional bundle identifier (org.appjs.myapp by default)"
    echo ""
    echo "Example Usage:"
    echo "  ./bundle.sh                       Bundles MyApp.app in 'dist'"
    echo "  ./bundle.sh --open                Bundles the application then launches it"
    echo "  ./bundle.sh --name=HelloWorld     Will bundle a HelloWorld.app file in 'dist'"
    echo "  ./bundle.sh --name='App Name'     Will bundle an app with spaces in its name"
    echo ""
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        --name)
            APPNAME=$VALUE
            ;;
        --displayname | --display-name | --bundle-display-name)
            DISPLAY_NAME=$VALUE
            ;;
        --identifier | --bundle-identifier)
            BUNDLE_IDENTIFIER=$VALUE
            BUNDLE_NAME=${BUNDLE_IDENTIFIER//./}
            ;;
        -o | --open)
			RUNIT=true
			;;
		-f | --force)
			FORCE=true
			;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            echo "Try -h for help."
            echo ""
            # usage
            exit 1
            ;;
    esac
    shift
done

# Optional app bundle name.
if [[ -z ${APPNAME} ]]; then
	APPNAME='MyApp';
fi;

if [[ -z ${DISPLAY_NAME} ]]; then
    DISPLAY_NAME=${APPNAME};
fi;

basedir="$( realpath_f `dirname ${0}` )";
MACDIR="${basedir}";
TARDIR="${MACDIR}/dist";

# If we aren't forcing the build, stop if there's something that will be overwritten.
if ! [ ${FORCE} ]; then
	if [ -d "${TARDIR}/${APPNAME}.app" ]; then
	  echo "Error: ${TARDIR}/${APPNAME} already exists.";
	  echo ""
	  exit 1;
	fi;
fi;

# Create the 'dist' directory if need be.
if ! [ -d "${TARDIR}" ]; then
	mkdir -p "${TARDIR}";
fi;

# Clear the .DS_Store file which will help clear any app icon cache.
if [ -f "${TARDIR}/.DS_Store" ]; then
    rm "${TARDIR}/.DS_Store";
fi;
# Also remove the app bundle to clear the cache.
rm -fr "${TARDIR}/${APPNAME}.app";

# Copy the files to the proper places.
cp -Rpa "${MACDIR}/AppBundle.skel.app" "${TARDIR}/${APPNAME}.app";
cp -Rpa "${basedir}/bin"/* "${TARDIR}/${APPNAME}.app/Contents/MacOS/bin/";
cp -Rpa "${basedir}/src"/* "${TARDIR}/${APPNAME}.app/Contents/Resources/";

# Write some settings to the plist file for the application name and such.
defaults write "${TARDIR}/${APPNAME}.app/Contents/Info" CFBundleDisplayName "${APPNAME}";

if [ ${DISPLAY_NAME} ]; then
    defaults write "${TARDIR}/${APPNAME}.app/Contents/Info" CFBundleDisplayName "${DISPLAY_NAME}";
fi;

if [ ${BUNDLE_IDENTIFIER} ]; then
    defaults write "${TARDIR}/${APPNAME}.app/Contents/Info" CFBundleIdentifier "${BUNDLE_IDENTIFIER}";
fi;

if [ ${BUNDLE_NAME} ]; then
    defaults write "${TARDIR}/${APPNAME}.app/Contents/Info" CFBundleName "${BUNDLE_NAME}";
fi;


# Optionally launch the application after packaging.
if [ ${RUNIT} ]; then
	open "${TARDIR}/${APPNAME}.app";
fi;