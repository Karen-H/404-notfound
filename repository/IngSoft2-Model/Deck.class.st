Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards',
		'cardsPositionlist'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
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
	cards := (Acceleration newCard) + (Cancellation newCard) + (Overload newCard) + 
	         (Redo newCard) +(Repeat newCard) + (Speed newCard).
	cardsPositionlist:=Die of: 6 rolling:#(1 2 3 4 5 6).
	
]

{ #category : #accesing }
Deck >> randomCard [
	|positionTaken|
	positionTaken:= cardsPositionlist roll.
	^cards at:positionTaken.
	
]
