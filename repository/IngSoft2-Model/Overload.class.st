Class {
	#name : #Overload,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Overload class >> newCard [
	
	^ self new
		initializeWith:'Permanent'
]

{ #category : #playing }
Overload >> activateThisCardOf:player on:otherPlayer inside: game [
	
	otherPlayer location changeSquare: (otherPlayer position)-2.
	game addCardUsed:self.
	game addCardUsedPermanet: self.
]
