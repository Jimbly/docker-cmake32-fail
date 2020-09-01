cmake_minimum_required(VERSION 3.5)

# works, but not practical:
add_executable (Hello hello.cxx)

# Fails on Docker Desktop, works on Docker Toolbox:
file(GLOB MySRC	"*.cxx")
# Gets "incorrect number of arguments" because the glob found nothing
add_executable(Hello ${MySRC})
