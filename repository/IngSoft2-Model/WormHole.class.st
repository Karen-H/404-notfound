Class {
	#name : #WormHole,
	#superclass : #Effect,
	#instVars : [
		'effectNumber'
	],
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
	game lastSteppedOn: self.
]

{ #category : #accessing }
WormHole >> effectNumber [

	^ effectNumber.
]

{ #category : #initialization }
WormHole >> initialize: boardNumber with: effect type: name [

	positionOnBoard := boardNumber.
	effectNumber := effect.
	type := name.
]
