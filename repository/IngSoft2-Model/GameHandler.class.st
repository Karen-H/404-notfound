Class {
	#name : #GameHandler,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GameHandler >> exceedsFinalPosition: tentativePosition limitedBy: boardSize [

	^ tentativePosition > boardSize.
]

{ #category : #testing }
GameHandler >> fallsBehindFinalPosition: tentativePosition [

	^ tentativePosition < 1.
]

{ #category : #'as yet unclassified' }
GameHandler >> move: player rolling: dice within: game [

	| tentativePosition square |
	tentativePosition := self moveForward: player to: player position + dice within: game.
	player location changeSquare: tentativePosition.
	square := game board at: tentativePosition.
	square applyEffectOn: player within: game.
]

{ #category : #testing }
GameHandler >> moveBackwards: player to: tentativePosition limitedBy: boardSize [

	| newPosition lapCount |
	lapCount := 0.
	( self fallsBehindFinalPosition: tentativePosition )
		ifTrue: [ 
			lapCount := tentativePosition // boardSize.
			newPosition := tentativePosition + (lapCount negated * boardSize).
			player location changeLap: lapCount + player lap ]
		ifFalse: [ newPosition := tentativePosition ].
	^ newPosition.
]

{ #category : #testing }
GameHandler >> moveForward: player to: tentativePosition within: game [

	| newPosition lapCount |
	( self exceedsFinalPosition: tentativePosition limitedBy: game board size ) 
		ifTrue: [ 
			lapCount := tentativePosition // game board size.
			newPosition := tentativePosition - ( lapCount * game board size ).
			player lap + lapCount > game laps 
				ifTrue: [ 
					player location changeLap: game laps.
					newPosition := game board size ]
				ifFalse: [ player location changeLap: player lap + lapCount ] ]
		ifFalse: [ newPosition := tentativePosition ].
	^ newPosition.
]

{ #category : #'as yet unclassified' }
GameHandler >> moving: player rolling: dice within: game [ 
	| tentativePosition square |
	tentativePosition := self moveForward: player to: player position + dice within: game.
	player location changeSquare: tentativePosition.
	square := game board at: tentativePosition.
	square applyEffectOn: player within: game.
]

{ #category : #testing }
GameHandler >> throwingCard: player within:game [
	((player hand)size =0)ifFalse:[
		self utilizeThis: player throwCard on:player within:game.
		].
]

{ #category : #'as yet unclassified' }
GameHandler >> utilizeThis: card on: player within:game [
	(card type='Permanent')
		ifTrue:[card activateThisCardOf: player on: player inside: game.]
		ifFalse:[
card activateThisCardOf: player on: player inside:game cardChosenIs:card.].
]
