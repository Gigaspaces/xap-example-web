@echo off

call "%~dp0..\..\..\bin\setenv.bat"
set DIR_NAME=%~dp0
if not defined M2_HOME set M2_HOME=%~dp0..\..\tools\maven\apache-maven-3.0.2 rem needed to upgraded to 3.2.5

if "%1" == "clean" (
  cd %DIR_NAME%
  call "%M2_HOME%\bin\mvn.bat" clean
  cd %CD%
) else (
	if "%1" == "compile" (
	    cd %DIR_NAME%
		call "%M2_HOME%\bin\mvn.bat" compile
		cd %CD%
	) else (
		if "%1" == "package" (
		    cd %DIR_NAME%		
			call "%M2_HOME%\bin\mvn.bat" package
			cd %CD%
		) else (
			if "%1" == "deploy" (
				cd %DIR_NAME%		
				call "%XAP_HOME%\bin\gs.bat" deploy target\PlainWebAppExample.war
				cd %CD%
			) else (
				if "%1" == "undeploy" (
					cd %DIR_NAME%
				    call "%XAP_HOME%\bin\gs.bat" undeploy PlainWebAppExample
					cd %CD%
				) else (
                    echo.
                    echo Error: Invalid input command %1
                    echo.
                    echo The available commands are:
                    echo.
                    echo clean                    --^> Cleans all output dirs
                    echo compile                  --^> Builds all; don't create WAR file
                    echo package                  --^> Builds the distribution
                    echo deploy                   --^> Deploys the web app on the service grid
                    echo undeploy                 --^> Undeploys the web app from the service grid
                    echo.
					)	
				)
			)
		)
	)
)
 


