Class {
	#name : #Acceleration,
	#superclass : #Card,
	#instVars : [
		'effectNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Acceleration class >> onDeck [

	| effectNumber |
	effectNumber := 1.
			
	^ self new 
		initialize: 'Acceleration'
		with: effectNumber
		type: 'Permanent'.
]

{ #category : #accessing }
Acceleration >> effectNumber [

	^ effectNumber.
]

{ #category : #initialization }
Acceleration >> initialize: effect with: aNumber type: cardType [

	name := effect.
	effectNumber := aNumber.
	type := cardType.
]

{ #category : #testing }
Acceleration >> isDestroyed:player in:otherPlayer within:game [ 
	
	game players do:[
				:person|person remove:self from: person activeCards.
			].
	
]

{ #category : #testing }
Acceleration >> isInstant:player within:game [
]

{ #category : #playing }
Acceleration >> usedBy: player within: game [

	game beAtPlay:player.
	game players do: [ :member | member active: self ].
	player remove: self from: player hand.
	game lastUsed: self.
]
