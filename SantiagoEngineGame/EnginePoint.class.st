Class {
	#name : 'EnginePoint',
	#superclass : 'Point',
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'adding' }
EnginePoint >> addVector: aVector [

	"Mueve el punto a una nueva posición en base a
	 las indicaciones del vector pasado por parámetro"
	
	x := x + (aVector module * aVector direction cos).
	y := y + (aVector module * aVector direction sin)
]
