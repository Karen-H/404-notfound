Class {
	#name : #Speed,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Speed class >> newCard [
	
	^ self new
		initializeWith:'Permanent'
]

{ #category : #playing }
Speed >> activateThisCardOf: player on:otherPlayer inside: game [

	otherPlayer location changeSquare:otherPlayer position +1.
	game addCardUsed:self.
	game addCardUsedPermanet: self.
]
