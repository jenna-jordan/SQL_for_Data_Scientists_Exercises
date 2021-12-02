# SQL for Data Scientists - Practice Exercises



## Setup

Useful link: [How to instal MySQL on macOS](https://flaviocopes.com/mysql-how-to-install/)

Install MySQL Server & Workbench via homebrew:

```bash
brew install mysql
brew install --cask mysqlworkbench
```

Start the Server from the command line:

```bash	
mysql.server start
```

Connect to the server from the command line:

```bash
mysql -u root -p
```

Now open MySQL Workbench and click to connect to the localhost database.

In the menu click "Server" -> "Data Import" 

Choose "Import from Self-Contained File", and find `FarmersMarketDatabase.sql` (in this repo, this is located in the directory `book_support_files`)

Click "Start Import"

Now, click the first icon with label "SQL+"

And now the database is all setup and we can start querying it in the SQL Script tab!
