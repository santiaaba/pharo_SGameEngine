"
Represento un evento para una entidad que ha salido completamente de cámara
"
Class {
	#name : 'EntityLeaveCamera',
	#superclass : 'EntityEvent',
	#instVars : [
		'camera'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'instance creation' }
EntityLeaveCamera class >> newEvent: anEntity leaveCamera: aCamera [

	^self new setEntity: anEntity;
		setCemera: aCamera.
]

{ #category : 'initialization' }
EntityLeaveCamera >> setCamera: aCamera [

	camera := aCamera.
]
