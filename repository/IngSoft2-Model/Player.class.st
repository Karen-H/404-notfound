Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'location',
		'hand',
		'effect',
		'name',
		'turn',
		'activeCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> assertTwoCardsAreDrawn: cards [

	cards size ~= 2
		ifTrue: [ InstanceCreationFailed
				signal: 'The player must draw two cards at the beginning of the game' ].
			
	
]

{ #category : #'instance creation' }
Player class >> drawing: cards name: player [
	
	self assertTwoCardsAreDrawn: cards.
	
	^ self new initializeWith: cards name: player.
]

{ #category : #drawing }
Player >> active: card [

	activeCards add: card.
]

{ #category : #accessing }
Player >> activeCards [

	^ activeCards.
]

{ #category : #accessing }
Player >> boardSquare [

	^ location boardSquare.
]

{ #category : #drawing }
Player >> draw: card [

	hand add: card.
]

{ #category : #accessing }
Player >> effect [

	effect := activeCards sumNumbers: [ :card | card effectNumber ].
	^ effect.
]

{ #category : #accessing }
Player >> hand [ 

	^ hand.
]

{ #category : #initialization }
Player >> initializeWith: cards name: player [

	location := Position start.
	hand := cards.
	effect := 0.
	name := player.
	turn := false.
	activeCards := OrderedCollection new.
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
Player >> name [

	^ name.
]

{ #category : #accessing }
Player >> position [

	^ location boardSquare.
]

{ #category : #removing }
Player >> remove: card from: deck [

	| usedCard |
	usedCard := deck detect: [ :cardboard | cardboard name = card name ].
	deck remove: usedCard.
]

{ #category : #'as yet unclassified' }
Player >> throwCard:aCard [
	|cardInThisHand|
	cardInThisHand:= hand collect:[:cardBoard|cardBoard name = aCard].
	cardInThisHand ifNotNil:[
				^hand detect:[:cardd|cardd name=aCard].
			]
]

{ #category : #accessing }
Player >> turn [

	^ turn.
]

{ #category : #accessing }
Player >> turn: value [

	turn := value.
]
