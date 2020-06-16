Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Redo class >> onDeck [

	| effectNumber |
	effectNumber := 0.
			
	^ self new 
		initialize: 'Redo'
		with: effectNumber
		type: 'Instant'.
]

{ #category : #playing }
Redo >> cardUsedBy: player within: game [

	player draw: game lastCardUsed.
	game lastCardUsed usedBy: player within: game.
	player remove: self from: player hand.
	game lastUsed: self
]

{ #category : #playing }
Redo >> usedBy: player within: game [

	(game deck anySatisfy: [ :card | card name = game lastCardUsed name ])
		ifFalse: [ ^ self ].
	player turn
		ifTrue: [ self cardUsedBy: player within: game ]
		ifFalse: [ game lastCardUsed type = 'Instant'
				ifTrue: [ self cardUsedBy: player within: game ] ]
]
