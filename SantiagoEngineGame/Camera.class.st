"
Represento una cámara. Una sección de una escena a representar en la pantalla. Mi centro se encuentra en el centro del rectángulo que me define. Para ello utilizo un objeto un atributo llamado viewport que isntancia un RectDelta.
"
Class {
	#name : 'Camera',
	#superclass : 'Object',
	#instVars : [
		'viewport',
		'position'
	],
	#classInstVars : [
		'viewport'
	],
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'initialization' }
Camera >> initialize [

	viewport := RectDelta origin: (0@0) corner: (640@480) delta: (-320)@(-240).
	position := 320@240
]

{ #category : 'accessing' }
Camera >> position [

	^position
]

{ #category : 'initialization' }
Camera >> setPosition: aPoint [
	"Cambia a un punto del centro de la cámara"
	
	viewport setDelta: aPoint.
]

{ #category : 'initialization' }
Camera >> setViewPortOrigin: originPoint corner: cornerPoint [ 

	viewport := Rectangle origin: originPoint corner: cornerPoint.
]

{ #category : 'accessing' }
Camera >> translateBy: factor [
	"Movemos la cámara en un factor indicado por parámetro. El polimorfismo
	 de la Clase Rectangle que define el atributo viewport, permite
	 que el factor sea un punto o un número."

	position := position + factor.
	viewport translateBy: factor toPoint.
]

{ #category : 'accessing' }
Camera >> translateTo: aPoint [
	"Movemos el centro de la cámara a un punto específico de la escena"

	position := aPoint.
	viewport translateTo: aPoint.
]

{ #category : 'accessing' }
Camera >> viewport [

	^ viewport
]
