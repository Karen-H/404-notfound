Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Repeat class >> onDeck [

	| effectNumber |
	effectNumber := 0.
			
	^ self new 
		initialize: 'Repeat'
		with: effectNumber
		type: 'Instant'.
]

{ #category : #playing }
Repeat >> usedBy: player within: game [

	( game board anySatisfy: [ :tile | tile type = game lastSquareSteppedOn type ] )
		ifFalse: [ ^ self ].
	game lastSquareSteppedOn applyEffectOn: player within: game.
	player remove: self from: player hand.
	game lastUsed: self.
]
