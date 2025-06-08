# About

This is a small shader example app.  

The Idea was to creat a minimalistic example written in C and have all dependancies for a windows build in a docker image. No need for Visual Studio. 

# Build
Build the container  
Run Image  
Build the app  

`docker build -t shader . && docker run -it -v ${PWD}:/host --rm --name shader shader ./buildwin.sh`

