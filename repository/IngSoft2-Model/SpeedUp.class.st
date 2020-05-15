Class {
	#name : #SpeedUp,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUp class >> on: boardNumber [

	| aNumber |
	aNumber := 4.
	
	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initializeWith: boardNumber
		effect: aNumber
		type: 'SpeedUp'.
]
