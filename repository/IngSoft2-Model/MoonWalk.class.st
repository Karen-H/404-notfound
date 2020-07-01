Class {
	#name : #MoonWalk,
	#superclass : #Effect,
	#instVars : [
		'effectNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
MoonWalk class >> on: boardNumber [

	| effectNumber |
	effectNumber := boardNumber even
		ifTrue: [ -2 ]
		ifFalse: [ -3 ].
		
	self assertNumberGreaterThanZero: boardNumber.
	
	^ self new 
		initialize: boardNumber 
		with: effectNumber
		type: 'MoonWalk'.
]

{ #category : #playing }
MoonWalk >> applyEffectOn: player within: game [

	| otherPlayers |
	otherPlayers := game players reject: [ :gamer | gamer = player ].
	self moving:otherPlayers in:game.
		
]

{ #category : #accessing }
MoonWalk >> effectNumber [

	^ effectNumber.
]

{ #category : #initialization }
MoonWalk >> initialize: boardNumber with: effect type: name [

	positionOnBoard := boardNumber.
	effectNumber := effect.
	type := name.
]

{ #category : #playing }
MoonWalk >> move: player within: game [

	| newPosition |
	newPosition := GameHandler new
	moveForward: player
	to: player position + effectNumber
	within: game.
	player location changeSquare: newPosition
]

{ #category : #playing }
MoonWalk >> moving:otherPlayers in:game [
	otherPlayers 
	do: [ :member | member location changeSquare: 
			(GameHandler new moveBackwards: member to: member position + effectNumber limitedBy: game board size) ].
	game lastSteppedOn: self.
]
