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
		initialize: 'WormHole'
		with: effectNumber.
]

{ #category : #playing }
WormHole >> applyEffectOn: player within: game [

	| newPosition |
	game beAtPlay:player.
	newPosition := GameHandler new 
	moveBackwards: player
	to: player boardSquare  + effectNumber
	limitedBy: game board size within:game.
	player square: newPosition.
	game lastSteppedOn: self.
]

{ #category : #accessing }
WormHole >> effectNumber [

	^ effectNumber.
]

{ #category : #initialization }
WormHole >> initialize: name with: effect [

	effectNumber := effect.
	type := name.
]
