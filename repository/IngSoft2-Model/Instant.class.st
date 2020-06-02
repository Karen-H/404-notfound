Class {
	#name : #Instant,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #'editing keys' }
Instant >> doIt:game [ 
	(game whoWon = Player)ifFalse:[self playThisCard].
	"hazlo puede jugarse en cualquier momento hasta que termine el juego"
		
	
]

{ #category : #'as yet unclassified' }
Instant >> playThisCard [
	"activar efecto de la carta"
]
