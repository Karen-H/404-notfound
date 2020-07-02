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

{ #category : #playing }
GameHandler >> move: player rolling: dice within: game [

	| tentativePosition square |
	player turn: true.
	tentativePosition := self moveForward: player to: player position + player effect + dice within: game.
	player location changeSquare: tentativePosition.
	square := game board at: tentativePosition.
	square applyEffectOn: player within: game.
	player turn: false.
]

{ #category : #playing }
GameHandler >> moveBackwards: player to: tentativePosition limitedBy: boardSize [

	( self fallsBehindFinalPosition: tentativePosition )
		ifTrue: [ ^ self shift: player to: tentativePosition limitedBy: boardSize ]
		ifFalse: [ ^ tentativePosition ].
]

{ #category : #playing }
GameHandler >> moveForward: player to: tentativePosition within: game [

	( self exceedsFinalPosition: tentativePosition limitedBy: game board size ) 
		ifTrue: [ ^ self shift: player to: tentativePosition within: game ]
		ifFalse: [ ^ tentativePosition ].
]

{ #category : #playing }
GameHandler >> shift: player to: tentativePosition limitedBy: boardSize [

	| lapCount |
	lapCount := 0.
	player location changeLap: lapCount + player lap.
	^ (tentativePosition + (lapCount negated * boardSize)).
]

{ #category : #playing }
GameHandler >> shift: player to: tentativePosition within: game [ 

	| lapCount newPosition |
	lapCount := tentativePosition // game board size.
	newPosition := tentativePosition - (lapCount * game board size).
	player lap + lapCount > game laps
		ifTrue: [ 
			player location changeLap:game laps.
			newPosition := game board size ]
		ifFalse: [ player location changeLap: player lap + lapCount ].
	^ newPosition.
]
