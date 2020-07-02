Class {
	#name : #AtomicBomb,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
AtomicBomb class >> on: boardNumber [

	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize: boardNumber
		type: 'AtomicBomb'.
]

{ #category : #playing }
AtomicBomb >> applyEffectOn: player within: game [

	game players do: [ :gamer | gamer location changeSquare: 1 ].
	game lastSteppedOn: self.
]

{ #category : #initialization }
AtomicBomb >> initialize: boardNumber type: name [

	positionOnBoard := boardNumber.
	type := name.
]

{ #category : #playing }
AtomicBomb >> move: player within: game [
"
	| newPosition |
	newPosition := GameHandler new
	moveForward: player
	to: player position
	within: game.
	player location changeSquare: newPosition"
]
