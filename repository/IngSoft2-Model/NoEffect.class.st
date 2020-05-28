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

{ #category : #playing }
NoEffect >> move: player within: game [

	| newPosition |
	newPosition := GameHandler new
	moveForward: player
	to: player position + effectNumber
	within: game.
	player location changeSquare: newPosition
]
