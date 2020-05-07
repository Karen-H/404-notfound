Class {
	#name : #GameHandler,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GameHandler class >> canMove: player with: dice max: boardSize [

	^ player position + dice <= boardSize.
]

{ #category : #playing }
GameHandler class >> move: player with: dice limit: boardSize [

	| newPosition |
	newPosition := (self canMove: player with: dice max: boardSize)
		ifTrue: [ player position + dice ]
		ifFalse: [ boardSize ].
	player goTo: newPosition.
]
