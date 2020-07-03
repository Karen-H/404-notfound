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

	| playerNow tentativePosition square |
	playerNow:=game beAtPlay: player.
	playerNow turn: true.
	tentativePosition := self moveForward: playerNow to: playerNow boardSquare + playerNow effect + dice within: game.
	playerNow square: tentativePosition.
	square := game board at: tentativePosition.
	square applyEffectOn: playerNow within: game.
	playerNow turn: false.
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
	player lap: lapCount + player lap.
	^ (tentativePosition + (lapCount negated * boardSize)).
]

{ #category : #playing }
GameHandler >> shift: player to: tentativePosition within: game [ 

	| lapCount newPosition |
	lapCount := tentativePosition // game board size.
	newPosition := tentativePosition - (lapCount * game board size).
	player lap + lapCount > game laps
		ifTrue: [ 
			player lap:game laps.
			newPosition := game board size ]
		ifFalse: [ player lap: player lap + lapCount ].
	^ newPosition.
]
