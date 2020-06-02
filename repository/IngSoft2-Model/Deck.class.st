Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
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
	cards := OrderedCollection new.
	cards := Acceleration new + Cancellation new + Overload new + Redo new + Repeat new + Speed new.
]
