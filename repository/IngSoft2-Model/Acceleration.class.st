Class {
	#name : #Acceleration,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Acceleration class >> newCard [
	
	^ self new
		initializeWith:'Permanent'
]

{ #category : #playing }
Acceleration >> activateThisCardOf: player on:otherPlayer inside: game [

	game players do:[:onePlayer|onePlayer location changeSquare: onePlayer position +1].
	game addCardUsed:self.
	game addCardUsedPermanet: self.
]
