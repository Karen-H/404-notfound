Class {
	#name : #DrawCard,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DrawCard class >> on: boardNumber [

	| effectNumber |
	effectNumber := 0.
	
	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize: boardNumber
		with: effectNumber
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
