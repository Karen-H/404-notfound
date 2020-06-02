Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'location',
		'hand'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #asserting }
Player class >> assertOnlyValid: cards on: deck [

	(cards
		anySatisfy:
			[ :card | deck includes: card ])
		ifTrue: [ InstanceCreationFailed
				signal: 'Must play with valid cards' ]
]

{ #category : #'instance creation' }
Player class >> assertTwoCardsAreDrawn: cards [

	cards size ~= 2
		ifTrue: [ InstanceCreationFailed
				signal: 'The player must draw two cards at the beginning of the game' ].
			
	
]

{ #category : #'as yet unclassified' }
Player class >> drawing: cards from: deck [
	
	self assertTwoCardsAreDrawn: cards.
	self assertOnlyValid: cards on: deck.
	
	^ self new initializeWith: cards.
]

{ #category : #accessing }
Player >> boardSquare [

	^ location boardSquare.
]

{ #category : #drawing }
Player >> draw: card [

	hand := hand + card.
]

{ #category : #accessing }
Player >> hand [ 

	^ hand.
]

{ #category : #initialization }
Player >> initializeWith: cards [

	location := Position start.
	hand := cards.
]

{ #category : #accessing }
Player >> lap [

	^ location lap.
]

{ #category : #accessing }
Player >> location [

	^ location.
]

{ #category : #accessing }
Player >> position [

	^ location boardSquare.
]
