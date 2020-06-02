Class {
	#name : #Permanent,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #adding }
Permanent >> addAditionalEffectWhenFinishTurn:player [
	"efecto que se le alica a cada turno del player"
]

{ #category : #'as yet unclassified' }
Permanent >> myTurnIplayThisCardAt:player [
	self addAditionalEffectWhenFinishTurn:player.
]
