Class {
	#name : #WormHole,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
WormHole class >> on: boardNumber [

	| effectNumber |
	effectNumber := -4.
	
	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize: boardNumber
		with: effectNumber
		type: 'WormHole'.
]

{ #category : #playing }
WormHole >> applyEffectOn: player within: game [

	| newPosition |
	newPosition := GameHandler new 
	moveBackwards: player
	to: player position + effectNumber
	limitedBy: game board size.
	player location changeSquare: newPosition.
]
