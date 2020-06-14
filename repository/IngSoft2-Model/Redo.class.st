Class {
	#name : #Redo,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Redo class >> newCard [
	
	^ self new
		initializeWith:'Instant'
]

{ #category : #playing }
Redo >> activateThisCardOf: player on: otherPlayer inside:game cardChosenIs:card [
	|lastCardUsed|
	lastCardUsed := (game cardsUsed)last.
	(lastCardUsed type ='Permanent')
				ifTrue:[lastCardUsed activateThisCardOf: player on: otherPlayer inside: game.]
				ifFalse:[
lastCardUsed activateThisCardOf: player on: otherPlayer inside:game cardChosenIs:card.].
	game cardsUsed removeLast.	
	game addCardUsed: lastCardUsed.
]
