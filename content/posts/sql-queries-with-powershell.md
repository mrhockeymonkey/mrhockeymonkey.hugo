---
title: "Sql Queries with Powershell"
categories: ["Powershell", "SQL"]
date: 2016-03-08
---

UPDATE:
The best way to run a sql query from powershell 5 is to install the SqlServer PSModule!
```powershell
Install-Module SqlServer
Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery" -ServerInstance "MyComputer\MainInstance"

TimeOfQuery
-----------
9/21/2017 2:48:24 PM
```

Running SQL queries from powershell can be extremely powerfull. However some implementation I have see often result with off object types such as DBNull. This is my method that seems to work quite nicely for me. 

<script src="https://gist.github.com/mrhockeymonkey/6579466589ebae7a0ecad83347ee725e.js"></script>