"
Soy una mejora de la clase OrderedCollection
"
Class {
	#name : 'GOrderedCollection',
	#superclass : 'OrderedCollection',
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'as yet unclassified' }
GOrderedCollection >> with: anotherCollection findFirstPair: aBlock [
	"Evaluo todos los elementos de la primer colección
	 con todos los elementos de la segunda colección,
	 en el orden en que aparecen. Cuando encuentro un
	 par de elementos que verifican aBlock, lo devuelvo
	 y dejo de evaluar."
	
	 | pair i j |
	 i := 1.
	 pair := nil.
	 [ pair isNil and:( i <= self size) ] whileTrue: [
		j := 1.
		[ pair isNil and:( j <= anotherCollection size) ] whileTrue: [
			(aBlock value: (self at:i) value:(anotherCollection at:j)) ifTrue: [
				pair := FLPair new left: (self at:i); right: (anotherCollection at:j)
			].
			j := j + 1.
		].
		i := i + 1.
	 ].
	^pair
]
