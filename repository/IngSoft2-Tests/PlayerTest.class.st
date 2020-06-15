Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerCreationFailsWhenTwoCardsArentDrawn [

	| cards |
	cards := OrderedCollection with: Speed.
	self
		should: [ Player drawing: cards name: 'Player 1' ]
		raise: InstanceCreationFailed
		withMessageText: 'The player must draw two cards at the beginning of the game'
]
