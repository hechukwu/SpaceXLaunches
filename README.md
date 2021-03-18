# SpaceXLaunches

An application that presents information about successful SpaceX launches. This is a test project to build a native iOS app for Jibble.


### API Used
The following API endpoints were used
- Successful SpaceX launches: GET https://api.spacexdata.com/v4/launches
- Get single rocket: GET https://api.spacexdata.com/v4/rockets/:id
- See more details about SpaceX API https://github.com/r-spacex/SpaceX-API

### Endpoints
Here's the full collection of routes. They can be checked out on Postman
[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/ed4ed700dcc55b2c1f1c)


### Development
This application was developed using [Swift](https://swift.org/) with coredata for data persistency, MVVM for design pattern, RxSwift to bind both view and viewmodels and storyboard for UI.

### Sorting

One thing that happens when multiple people work on an Xcode project is crazy merge conflicts. Anytime a file is added or removed to/from a project, Xcode sorts the project file (somewhat randomly). This creates all sorts of problems with source control and results in many headaches.

The solution is to sort the file alphabetically prior to any commit.

I accomplish this using a git pre-commit hook that calls `xUnique`.

### xUnique

[xUnique](https://github.com/truebit/xUnique) is a python module.

It can be installed by running: `pip install xUnique`

It also installs a command line script `xunique` in directory `/usr/local/bin` (make sure you have added this directory to your `$PATH`), so that xUnique can be invoked directly from the command line.

### pre-commit hook

Here is an example pre-commit hook.

You can use it as a basis for modifying your `.git/hooks/pre-commit` hook file.

```
#!/bin/sh
/path/to/Dynamic-Form/Scripts/uniquify_projects.sh
```

Make sure that it has an executable bit (`chmod +x .git/hooks/pre-commit`) and that the path is correct.
