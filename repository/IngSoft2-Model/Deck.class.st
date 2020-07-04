Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> assembled:cards [

	^ self new initializeWith:cards.
]

{ #category : #accessing }
Deck >> cards [

	^ cards.
]

{ #category : #initialization }
Deck >> initializeWith:cardsReceived [

	cards:=cardsReceived.
]

{ #category : #accessing }
Deck >> takeNextCard [ 
	
	^cards atRandom.
]
