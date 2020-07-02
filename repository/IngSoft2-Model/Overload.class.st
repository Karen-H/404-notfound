Class {
	#name : #Overload,
	#superclass : #Card,
	#instVars : [
		'effectNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Overload class >> onDeck [

	| effectNumber |
	effectNumber := -2.
			
	^ self new 
		initialize: 'Overload'
		with: effectNumber
		type: 'Permanent'.
]

{ #category : #accessing }
Overload >> effectNumber [

	^ effectNumber.
]

{ #category : #initialization }
Overload >> initialize: effect with: aNumber type: cardType [

	name := effect.
	effectNumber := aNumber.
	type := cardType.
]

{ #category : #testing }
Overload >> isInstant:player within:game [
	
]

{ #category : #playing }
Overload >> usedBy: player in:otherPlayer within: game [

	otherPlayer active: self.
	player remove: self from: player hand.
	game lastUsed: self.
]
