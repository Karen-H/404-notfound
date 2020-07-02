Class {
	#name : #DrawCard,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DrawCard class >> on: boardNumber [

	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize: boardNumber
		type: 'DrawCard'.
]

{ #category : #playing }
DrawCard >> applyEffectOn: player within: game [

	| deck card |
	deck := game deck.
	card := deck atRandom.
	player draw: card.
	game lastSteppedOn: self.
]

{ #category : #initialization }
DrawCard >> initialize: boardNumber type: name [

	positionOnBoard := boardNumber.
	type := name.
]
