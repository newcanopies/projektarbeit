# Projektarbeit

## Backend

Pre Setup:
  - Docker & Docker Compose auf Rechner installiert

Backend starten:
  1. Persönliche IP Adresse im projektarbeit/backend/.env file anpassen (`ifconfig`) (wird im File-Explorer nicht angezeigt)
  
  	$ cd ~/projektarbeit/backend
	$ gedit .env
  	
  2. Roscore starten
  	
	$ roscore
	
  3. Turtlebot bringup and setup
  
  	$ ssh pi@{IP_ADDRESSS_TURTLEBOT}
	$ roslaunch turtlebot3_bringup turtlebot3_robot.launch
	
	# NEW TERMINAL - camerastream
	$ ssh pi@{IP_ADDRESSS_TURTLEBOT}
	# camera stream
	$ roslaunch raspicam_node camerav2_1280x960_10fps.launch enable_raw:=true
	
	# NEW TERMINAL - speaker node
	$ ssh pi@{IP_ADDRESSS_TURTLEBOT}
	$ rosrun speaker_node speaker_node.py
	
  4. Host-Laptup setup
  
	# ON HOSTS COMPUTER
	# new terminal
	$ rosrun face_recognition face_recognize_plus_Web_Video_Stream.py
	# new terminal
	$ rosrun web_video_server web_video_server
	# new terminal
	$ rosrun find_person go_to_person.py
	
  5. Map laden
  	
	$ roslaunch turtlebot3_navigation turtlebot3_navigation.launch map_file:='/{YOUR_HOME_PATH}/projektarbeit/backend/backend/catkin_ws/maps/basti_wohnung.yaml' 
  
  4. Docker-Datenbank starten

	$ cd ~/projektarbeit/backend
	$ sudo make start
	
  5. Controller starten
  
	$ cd ~/projektarbeit/backend/backend/controller
	$ python3 controller.py
	
  6. App starten
  


### Docker Container

- Controller
    - _python3.8 image_
    - Schnittstelle zwischen App, Datenbank und ROS
- Datenbank
    - _postgress image_
    - Postgress Datenbank, zugriff mit O/M Mapper SQlAlchemy aus controller
- Ros  
    - _ubuntu 16.04 image_ 
    - Vollständige Ubuntu installation mit allen Ros Konfigurationen


Die wichtigsten Docker Commands:

    $ docker ps                                     // Laufende Container anzeigen lassen
    $ docker inspect {container-name}               // Infos zu bestimmtem Container
    $ docker container kill $(docker ps -q)         // Alle laufenden Container schließen
    $ docker exec -it {container-name} bash    // ins Docker Terminal

## App

### Setup:

- Installiertes Flutter SDK
- Android / IOS Emulator
- Android Studio / IntelliJ
- Laufender Controller im selben Netzwerk


## ROS

### Setup



### Camera, Face Recognition, Stream

    Turtlebot:
    $ roslaunch raspicam_node camerav2_1280x960_10fps.launch enable_raw:=true	// Streamt Bild von Raspicam an Topic /raspicam_node/image

    Host Laptop:
    $ rosrun face_recognition face_recognition	// Startet Face Recognition Node, streamt verarbeitetes Bild an Topic /Face_Recognition_Stream 
    $ rosrun web_video_server web_video_server  	// Streamt sämtliche Image Topics an http://localhost:8080/ - Link für /Face_Recognition_Stream ist in App eingebaut

	


## GIT

    $ git status                    // Show local file changes
    $ git commit -a                 // Only commit tracked files
    $ git add .                     // Stage tracked and untracked files
    $ git commit -m '(message)'     // Commit message -> If applied, this commit will...
    $ git push                      // Push local commits
    $ git pull                      // Pull remote commits
    $ git checkout -b branch        // Create and Switch to branch
    $ git checkout branch           // Switch to branch
    $ git reset --soft HEAD~1       // Rollback not already pushed commit if you havent pulled before committing
