Class {
	#name : #Speed,
	#superclass : #Card,
	#instVars : [
		'effectNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Speed class >> onDeck [

	| effectNumber |
	effectNumber := 1.
			
	^ self new 
		initialize: 'Speed'
		with: effectNumber
		type: 'Permanent'.
]

{ #category : #accessing }
Speed >> effectNumber [

	^ effectNumber.
]

{ #category : #initialization }
Speed >> initialize: effect with: aNumber type: cardType [

	name := effect.
	effectNumber := aNumber.
	type := cardType.
]

{ #category : #testing }
Speed >> isDestroyed:player in:otherPlayer within:game [ 
	
	otherPlayer remove:self from: otherPlayer activeCards.
]

{ #category : #testing }
Speed >> isInstant:player within:game [
	
]

{ #category : #playing }
Speed >> usedBy: player in:otherPlayer within: game [

	otherPlayer active:self.
	player remove: self from: player hand.
	game lastUsed: self.
]
