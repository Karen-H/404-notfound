Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> assembled [

	^ self new.
]

{ #category : #accessing }
Deck >> cards [

	^ cards.
]

{ #category : #initialization }
Deck >> initialize [ 

	super initialize.
	cards := Acceleration onDeck + Cancellation onDeck + Overload onDeck 
				+ Redo onDeck + Repeat onDeck + Speed onDeck.
]

{ #category : #'as yet unclassified' }
Deck >> takeNextCard [ 
	
	^cards atRandom.
]
