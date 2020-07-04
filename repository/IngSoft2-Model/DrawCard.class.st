Class {
	#name : #DrawCard,
	#superclass : #Effect,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
DrawCard class >> on: boardNumber [

	self assertNumberGreaterThanZero: boardNumber.
		
	^ self new 
		initialize:'DrawCard'.
]

{ #category : #playing }
DrawCard >> applyEffectOn: player within: game [

	game beAtPlay:player.
	player draw: game deck takeNextCard.
	game lastSteppedOn: self.
]

{ #category : #initialization }
DrawCard >> initialize: name [

	type := name.
]
