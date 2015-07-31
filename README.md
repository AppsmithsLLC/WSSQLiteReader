# WSSQLiteReader
Prototype dynamic SQLite database reader which currently demonstrates:

* Dynamic form generation using XIBs and custom wrapper classess to abstract complexity away from the UITableViewController subclasses.

* Custom theme patterns

* Usage of FMDatabase to access SQLite database files

## Installation
Download the project and open WSSQLiteReader.workspace in XCode 6 with iOS 8.4 SDK installed.
You may also load your own SQLite database file by adding it to the project and modifying the dbFileName key inside the main.plist file.

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request

## History
7-30-15 - initial commit to Github

## TODO
* Add optional search bar to the WSBaseForm class
* Hide the rows property in WSFormSection and add methods to expose add/remove functionality to the array.
* Add a method to SQLiteHelper that accepts a WHERE clause and a table object
* Expand data model objects to encompass every table in Chinook_Sqlite.sqlite
* Build out custom view controllers to allow logical navigation throughout Chinook_Sqlite.sqlite
* Complete code documentation