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
		initialize: 'MoonWalk'
		with: effectNumber.
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
MoonWalk >> initialize: name with: effect [

	effectNumber := effect.
	type := name.
]

{ #category : #playing }
MoonWalk >> moving:otherPlayers in:game [
	otherPlayers 
	do: [ :member | member square: 
			(GameHandler new moveBackwards: member to: member boardSquare  + effectNumber limitedBy: game board size within:game) ].
	game lastSteppedOn: self.
]
