@set DOCKER_IMAGE=%1
@if "%DOCKER_IMAGE%" == "" set DOCKER_IMAGE=cmakefail
@echo DOCKER_IMAGE=%DOCKER_IMAGE%

@REM Check if Docker Desktop is running
@docker info >nul 2>nul
@if errorlevel 1 (
	@REM Get Docker config
	@FOR /f "tokens=*" %%I IN ('docker-machine.exe env --shell=cmd default') DO @%%I
	if "%DOCKER_HOST%" == "" (
		echo No docker host found, pleast launch Docker Quickstart Terminal
	 	exit /b 1
	)
	@echo Using Docker Toolbox Host "%DOCKER_HOST%"...
) else (
  @echo Using Docker Desktop
)

@for /D %%I in (%~dp0) do @set PROJECT_ROOT=%%~fIapp
@echo PROJECT_ROOT=%PROJECT_ROOT%
@set REMOTE_PROJECT_ROOT=/%PROJECT_ROOT::=%
@set REMOTE_PROJECT_ROOT=%REMOTE_PROJECT_ROOT:\=/%
@echo REMOTE_PROJECT_ROOT=%REMOTE_PROJECT_ROOT%

@mkdir app\build 2>nul
docker run -i --rm -v %REMOTE_PROJECT_ROOT%:/app %DOCKER_IMAGE% /bin/sh -c "cd /app/build && cmake /app && make || echo Failed"

