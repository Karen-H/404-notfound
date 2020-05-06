Class {
	#name : #Handler,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
Handler class >> canMove: player with: dice max: boardSize [

	^ player position + dice <= boardSize.
]

{ #category : #'as yet unclassified' }
Handler class >> move: player with: dice limit: boardSize [

	| newPosition |
	newPosition := (self canMove: player with: dice max: boardSize)
		ifTrue: [ player position + dice ]
		ifFalse: [ boardSize ].
	player goTo: newPosition.
]
