Class {
	#name : 'Camera',
	#superclass : 'Object',
	#instVars : [
		'viewport'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'initialization' }
Camera >> initialize [

	viewport := Rectangle origin:(0,0) corner: (640,480).
]

{ #category : 'accessing' }
Camera >> position: aPoint [
	"Movemos la cámara en un delta representado por el punto
	 Por ejemplo. Si nos encontramos en 100@200 y aPoint es 10@45,
	 terminaríamos en 110@245"

	viewport := viewport translateBy: aPoint
]

{ #category : 'initialization' }
Camera >> setViewPortOrigin: originPoint corner: cornerPoint [ 

	viewport := Rectangle origin: originPoint corner: cornerPoint.
]

{ #category : 'accessing' }
Camera >> viewport [

	^ viewport
]
