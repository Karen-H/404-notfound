Class {
	#name : #NoEffect,
	#superclass : #Square,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
NoEffect class >> on: boardNumber [

	| aNumber |
	aNumber := 0.
	
	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initializeWith: boardNumber
		effect: aNumber
		type: 'NoEffect'.
]
