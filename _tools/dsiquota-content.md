# DSI Quota Command

The command `dsiquota` provides information on the current space use and available space remaining for different storage resources on the cluster. 

To use the command, simply type `dsiquota [ARGS]` which will return your usage and available space allocation.

### Home drive 

`dsiquota` without args will return something like:

```
~$ dsiquota
Used: 11.0G
Limit: 50G
```

which is the space currently used (11GB) and the total allotment on the home drive (`~`).

### Project folders

To check the space usage assigned to a project use the following commands:

`dsiquota --project [PROJECT-NAME]`

**OR**

`dsiquota --project2 [PROJECT-NAME]`

**Note:** The above is either `project` or `project2` depending of if the project folder is in `/net/projects` or `/net/projects2` respectively. 

Consider the following example:

```
~$ dsiquota --project spun-hyper
Used:
Limit:
~$ dsiquota --project2 spun-hyper
Used: 89.0G
Limit: 200G
```

In this example, the `spun-hyper` project is on `project2` which means that if you look for it on `project` it returns nothing.

### Checking Scratch and Scratch 2

To check an individual's use of the scratch drives, use the following commands:

```bash
~$ dsiquota --scratch
```

and

```bash
~$ dsiquota --scratch2
```

These commands will return the current usage and limit on an individual's `scratch` locations.