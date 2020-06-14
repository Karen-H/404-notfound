Class {
	#name : #Repeat,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Repeat class >> newCard [
	
	^ self new
		initializeWith:'Instant'
]

{ #category : #playing }
Repeat >> activateThisCardOf: player on: otherPlayer inside:game cardChosenIs:card [
	|positionFinalPlayer square|
	positionFinalPlayer :=player position.
	square:= (game board) at:positionFinalPlayer .
	(square = NoEffect new) 
			ifFalse:[ 
				square applyEffectOn: player within: game.
				].
	game addCardUsed:self.
]
