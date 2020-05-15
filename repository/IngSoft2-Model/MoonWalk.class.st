Class {
	#name : #MoonWalk,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> on: boardNumber [

	| aNumber |
	aNumber := boardNumber even
		ifTrue: [ -2 ]
		ifFalse: [ -3 ].
		
	self assertNumberGreaterThanZero: boardNumber.
	
	^ self new 
		initializeWith: boardNumber 
		effect: aNumber
		type: 'MoonWalk'.
]
