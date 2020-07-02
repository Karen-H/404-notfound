Class {
	#name : #SpeedUp,
	#superclass : #Effect,
	#instVars : [
		'effectNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
SpeedUp class >> on: boardNumber [

	| effectNumber |
	effectNumber := 4.
	
	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize:  'SpeedUp'
		with: effectNumber.
]

{ #category : #playing }
SpeedUp >> applyEffectOn: player within: game [

	| newPosition |
	newPosition := GameHandler new
	moveForward: player
	to: player position + effectNumber
	within: game.
	player location changeSquare: newPosition.
	game lastSteppedOn: self.
]

{ #category : #accessing }
SpeedUp >> effectNumber [

	^ effectNumber.
]

{ #category : #initialization }
SpeedUp >> initialize: name with: effect [

	effectNumber := effect.
	type := name.
]
