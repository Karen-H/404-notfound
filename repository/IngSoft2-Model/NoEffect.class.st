Class {
	#name : #NoEffect,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
NoEffect class >> on: boardNumber [

	| effectNumber |
	effectNumber := 0.
	
	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize: boardNumber
		with: effectNumber
		type: 'NoEffect'.
]
