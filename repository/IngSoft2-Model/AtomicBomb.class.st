Class {
	#name : #AtomicBomb,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBomb class >> on: boardNumber [

	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initializeWith: boardNumber
		effect: boardNumber negated
		type: 'AtomicBomb'.
]
