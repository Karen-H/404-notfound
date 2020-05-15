Class {
	#name : #WormHole,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormHole class >> on: boardNumber [

	| aNumber |
	aNumber := -4.
	
	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initializeWith: boardNumber
		effect: aNumber
		type: 'WormHole'.
]
