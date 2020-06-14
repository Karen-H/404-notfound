Class {
	#name : #Cancellation,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Cancellation class >> newCard [
	
	^ self new
		initializeWith:'Instant'
]

{ #category : #playing }
Cancellation >> activateThisCardOf: player on: otherPlayer inside:game cardChosenIs:card [
	|cardInTableNow|
	cardInTableNow:=game cardOnTableInsideGame.
	(cardInTableNow includes: card)
					ifTrue:[cardInTableNow remove:card.
							  game addCardUsed:self.]
					ifFalse:[player draw:self].
 
]
