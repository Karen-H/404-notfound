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
		with: boardNumber negated + 1
		type: 'AtomicBomb'.
]

{ #category : #playing }
AtomicBomb >> move: player within: game [

	game players do: [ :gamer | gamer location changeSquare: 1 ].
]
