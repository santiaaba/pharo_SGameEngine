Class {
	#name : 'EngineOrderedCollection',
	#superclass : 'OrderedCollection',
	#category : 'SantiagoEngineGame',
	#package : 'SantiagoEngineGame'
}

{ #category : 'as yet unclassified' }
EngineOrderedCollection >> search: arg1 into: arg2 [

	| tmp1 tmp2 |
	tmp1 := firstIndex.
	tmp2 := nil.
	[ tmp1 < lastIndex and: tmp2 isNil ] whileTrue: [
		tmp2 := arg2 search: arg1 with: (self at: tmp1).
		tmp1 := tmp1 + 1 ].
	^ tmp2
]

{ #category : 'as yet unclassified' }
EngineOrderedCollection >> search: arg1 with: arg2 [

	| tmp1 tmp2 |
	tmp1 := firstIndex.
	tmp2 := nil.
	[ tmp1 < lastIndex and: tmp2 isNil ] whileTrue: [
		(arg1 cull: arg2 cull: (self at: tmp1)) ifTrue: [
			tmp2 := FLPair new.
			tmp2
				right: (self at: tmp1);
				left: arg2 ].
		tmp1 := tmp1 + 1 ].
	^ tmp2
]
