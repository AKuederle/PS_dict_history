## Dic_History

A little project which should ease a multi shell PowerShell workflow.
It allows to quickly change your current working directory to the working directory of the shell you last made a directory change.

###Usage

You have multiple instances of PowerShell open.

Shell 1:
```PowerShell
C:\>
```

Shell 2:
```PowerShell
C:\>
```

Now you change the directory using the cd alias in Shell 1.

Shell 1:
```PowerShell
C:\> cd .\Users
C:\Users\>
```
Now you realise you quickly need a second shell working in the same directory. This can be done using the rec alias provided by this module.

Shell 2:
```PowerShell
C:\> rec
C:\Users\>
```

The rec command will always bring you back to the directory of the last shell, in which a cd command was executed.
Please note, that this module only overwrites the cd alias, but now other alias or function, which can accomplish a directroy change. If you are using Set-Location, Pop-Location or Push-Location or one of ther aliases (beside cd) the rec command will not work.

### Installation

Download (or clone) the project and put it anywhere you like. Then open your PowerShell and type:

````PowerShell
>>> notepad $PROFILE
```

Copy and paste the following line to the beginning of the opened profile.ps1

```PowerShell
. path_to_the_downloaded_project_folder\dic_history.ps1
```

### How it works

The **log_cd** function of the module does basicly the same as **cd** (it changes the directory), but also writes the new directory together with the process id of the currently active PowerShell into a temporary file.
Whenever the **revover_d** function is called, it looks into this file and searches (based on the process id) for the last entry, which was not produced by the shell instance itself and moves the directory to the one specifed in this entry.

To call the **log_cd** function every time the directory is changed, the **cd** alias is redirected to this function.
For convenience the **recover_d** function is assigened to the shortcut **rec**.

