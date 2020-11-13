#!/usr/bin/env python


#For writing a ROS Node
import rospy 
#from nav_msgs.msg import face_text_data

#For Face Recognition
import face_recognition
import cv2

#For Google Text To Speach
from gtts import gTTS
language = 'de'

#For connecting OpenCv with ROS
from cv_bridge import CvBridge, CvBridgeError
#import image_transport

#Contains the messages we need
from sensor_msgs.msg import Image

import sensor_msgs
import std_msgs

import numpy as np




import vlc




######     Get Image from Raspicam and convert to CV2_Image #################################################################################

class image_converter:
	def __init__(self):
		self.bridge = CvBridge()
		self.image_sub = rospy.Subscriber("/raspicam_node/image", Image, self.callback_raspi_image)

	def callback_raspi_image(self, data):
		try:
			cv_image = self.bridge.imgmsg_to_cv2(data, "bgr8") 
		except Exception as e:
			print(e)
			print("Fehler in 'self.bridge.imgmsg_to_cv2(data, 'bgr8')'")

		cv2.imshow("Image Window", cv_image)
		cv2.waitKey(3)

#		face_recognition(cv_image)

######     /Image Converter Class ###########################################################################################################


######     Get name, message and face encoding from db    #####################################################################################################################

def callback_textdata():
	person_name = msg.name
	message = msg.message
	person_face_encoding = msg.face_encoding[0]

######     /Get Data    #####################################################################################################################

######     Publish Message   ################################################################################################################

def talker(tts):
	pub = rospy.Publisher('chatter', String)
	pub.publish(message)

######     /Publish Message   ################################################################################################################

######     Face Recognition    ###############################################################################################################


def my_face_recognition():
	known_face_encoding = ["Stefan"]
	known_face_name = ["Stefan"]

	face_locations = []
	face_encodings = []
	face_names = []
	process_this_frame = True


	try:
		vcap = cv2.VideoCapture("rtsp://raspberrypi.local:11311/", mux)
	except Exception as e:
		print("##########################################")
		print e
#	cap = cv2.VideoCapture("rtsp://raspberrypi.local:8554/")

	

	while True:
	
		# Grab a single frame of video
		ret, frame = vcap.read()

		
		cv2.imshow("Image Window", frame)
		cv2.waitKey(3)



	
		# Resize frame of video to 1/4 size for faster face recognition processing
		small_frame = cv2.resize(frame, (0, 0), fx=0.25, fy=0.25)

		#Convert the image from BGR color (which OpenCV uses) to RGB color (which face_recognition uses)
		rgb_small_frame = small_frame[:, :, ::-1]

		recognised_name = "unkonown"

		# Only process every other frame of video to save time
		if process_this_frame:
			# Find all the faces and face encodings in the current frame of video
			face_locations = face_recognition.face_locations(small_frame)
			face_encodings = face_recognition.face_encodings(small_frame, face_locations)

#		for face_encoding in face_encodings:
			# See if the face is a match for the known face(s)
#			matches = face_recognition.compare_faces(known_face_encoding, face_encoding)

		# If a match was found in known_face_encodings, just use the first one
#		if True in matches:
#			first_match_index = matches.index(True)
#			recognised_name = known_face_name[first_match_index]
			
#			print("Person erkannt: " + recognised_name)

#			tts = "Hallo" + recognised_name


#			try:
#				talker(tts)
#			except:
#				print("Fehler im Talker")


#			break

		process_this_frame = not process_this_frame





		for (top, right, bottom, left), name in zip(face_locations, face_names):
			# Scale back up face locations since the frame we detected in was scaled to 1/4 size
			top *= 4
			right *= 4
			bottom *= 4
			left *= 4

			# Draw a box around the face
			cv2.rectangle(frame,(left, top),(right, bottom),(0, 0, 255),2)

			# Draw a label with a name below the face
			cv2.rectangle(frame, (left, bottom - 35), (right, bottom), (0, 0, 255), cv2.FILLED)
			font = cv2.FONT_HERSHEY_DUPLEX
			cv2.putText(frame, name, (left + 6, bottom - 6), font, 1.0, (255, 255, 255), 1)

		    # Display the resulting image
			cv2.imshow('Video', frame)

		    # Hit 'q' on the keyboard to quit!
			if cv2.waitKey(1) & 0xFF == ord('q'):
				cv2.destroyAllWindows()

			# Release handle to the webcam
		#	cv2.destroyAllWindows()

######     /Face Recognition    #############################################################################################################



######     Main         #####################################################################################################################

if __name__=='__main__':


#### Stream mit vlc funktioniert!
#	player=vlc.MediaPlayer('rtsp://raspberrypi.local:11311/')
#	player.play()



#	ic = image_converter()

	rospy.init_node('face_recognition', anonymous=True)

	my_face_recognition()

	try:
		rospy.spin()
	except KeybooardInterrupt:
		print("Shutting down")
	cv2.destroyAllWindows()


######     /Main         #####################################################################################################################


######     Display the results         #######################################################################################################

#def showimage():
#    # Display the results
#	for (top, right, bottom, left), name in zip(face_locations, face_names):
#        	# Scale back up face locations since the frame we detected in was scaled to 1/4 size
#		top *= 4
#		right *= 4
#		bottom *= 4
#		left *= 4
#
        # Draw a box around the faceq
#	cv2.rectangle(frame, (left, top), (right, bottom), (0, 0, 255), 2)
#
        # Draw a label with a name below the face
#	cv2.rectangle(frame, (left, bottom - 35), (right, bottom), (0, 0, 255), cv2.FILLED)
#	font = cv2.FONT_HERSHEY_DUPLEX
#	cv2.putText(frame, name, (left + 6, bottom - 6), font, 1.0, (255, 255, 255), 1)

    # Display the resulting image
#	cv2.imshow('Video', frame)

    # Hit 'q' on the keyboard to quit!
#	if cv2.waitKey(1) & 0xFF == ord('q'):
#		cv2.destroyAllWindows()

	# Release handle to the webcam
#	cv2.destroyAllWindows()

######     /Display the results         ######################################################################################################