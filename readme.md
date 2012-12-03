# OS X AppJs Bootstrap
=========================

This is a boilerplate AppJS desktop application for OS X using Express, Twitter Bootstrap, and Font Awesome.
Please keep in mind that this is a little subject to being dated with regard to keeping up with the latest
versions of Express, Twitter Bootstrap, and Font Awesome...But that doesn't mean you couldn't update them
yourself after cloning this and it also doesn't mean this doesn't serve as a good start for your project.

For more information about AppJs, see [AppJs.org](http://www.appjs.org)

## Quickstart

You can clone this project and simply open your terminal and type in your terminal:
```./bundle.sh -open```

That will bundle and launch the little default application for you, but you really won't see much.
However, what you will be looking at is actually quite a robust application.
Just about anything you can do with Node.js you'll be able to do here. You will be running the
express framework listening on port 51686. Of course this can be changed along with many other things.

## Next Steps

You'll want to go into the ```src``` directory and start building your application.
Checkout the ```app.js``` file first. In there you will see options to change file menus in your
application along with the default port your app will listen on (which you may want to change to
avoid conflicts with other things) and more.

You can change the default application icon by building your own .icns file and replacing ```src/app.icns```
Just a small note about the application icons...OS X will cache them and while the script tries
to remove the .DS_Store file and clear that up, it may not be successful. You can typically move
the application file around or relaunch Finder to clear the cache and see changes to the app icon.
If you have the ```dist``` directory open in Finder when you go to bundle the application, you may
see it update then. You can also try changing the view in Finder to a list, etc. in order to see it update.
It's annoying, I know. I tried to make it less painful.

Be sure to look at the help for the bundle script: ```./bundle.sh --help``` for more options.
Alternatively, you can change the Info.plist file manually (or with XCode or something) after
bundling the application if you prefer.

## Misc. Notes

I included a ```.noSelect``` class in the default stylesheet (and in the .less file). You can apply
this to elements you want to disable from being highlighted when selected. This is quite useful for text
so when a user tries to click and drag to select, they won't be able to. There will be no blue (or whatever
color your CSS made it) highlight color all over.

## Why?

I wasn't totally satisified with AppJs out of the box. I felt that it didn't leave me with enough to
get started building desktop applications with relative ease. Well, they would work, but would need
to be launched from a command prompt or terminal. I saw the skeleton .app file for OS X bundles, but
it took me a while to wrap my head around how they needed to be packaged. The shell script provided
in the repository for AppJs simply didn't work - especially if you had spaces in your directory name.
However, thanks to hard work from all of those folks it did lead me to figuring it out.

I didn't want to exactly fork their repo and submit back pull requests because I wanted to take things
a slightly more dramatic direction. I wanted to include Twitter Bootstrap in my application skeleton
and I also wanted a more robust (and OS X specific) bundle script.

In the future, it would be nice to expand upon this to include scripts that would automatically
build distributable packages for Windows and Linux as well. For now, I'm just focusing on OS X.

## How?

AppJS is pretty cool. It works by using Chromium and a 32-bit (currently) version of node for OS X
and providing a wrapper for it all. This all runs in --harmony mode and essentially you've got
a web browser looking at your Node.js application without all the navigation controls, etc.
You can still hit the F12 key to bring up the developer inspector though.
Yes, that can be disabled too.

The application is 60mb+ in size, so it's not exactly the leanest...But also not the beefiest
thing I've seen. Though it does come with that overhead before your application code and assets.