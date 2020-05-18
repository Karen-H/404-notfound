Class {
	#name : #GameHandler,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #testing }
GameHandler class >> exceedsFinalPosition: aNumber max: boardSize [

	^ aNumber > boardSize.
]

{ #category : #testing }
GameHandler class >> fallsBehind: player with: aNumber max: boardSize [

	| tentativePosition lapCount |
	lapCount := 0.
	( self fallsBehindFinalPosition: aNumber )
		ifTrue: [ 
			lapCount := aNumber // boardSize.
			tentativePosition := aNumber + (lapCount negated * boardSize).
			player changeLap: lapCount + player lap ]
		ifFalse: [ tentativePosition := aNumber ].
	^ tentativePosition.
]

{ #category : #testing }
GameHandler class >> fallsBehindFinalPosition: aNumber [

	^ aNumber < 1.
]

{ #category : #accessing }
GameHandler class >> move: player due: type with: effect within: game [
	
	| otherPlayers newPosition |
		type = 'AtomicBomb'
			ifTrue: [ game players do: [ :gamer | gamer goTo: 1 ] ].
		type = 'MoonWalk'
			ifTrue: [ otherPlayers := game players reject: [ :gamer | gamer = player ].
				otherPlayers
					do: [ :member | member goTo: 
						(self fallsBehind: member with: member position + effect max: game board size) ] ].
		type = 'WormHole'
			ifTrue: [ newPosition := self
				fallsBehind: player
				with: player position + effect
				max: game board size.
				player goTo: newPosition ].
		(type = 'AtomicBomb' or: [ type = 'MoonWalk' or: type = 'WormHole' ])
			ifTrue: [ ^ self ].
			newPosition := self
			moveForward: player
			with: player position + effect
			within: game.
			player goTo: newPosition
]

{ #category : #playing }
GameHandler class >> move: player with: dice of: game [

	| tentativePosition effect squareType |
	tentativePosition := self moveForward: player with: player position + dice within: game.
	effect := ( game board at: tentativePosition ) effectNumber.
	squareType := ( game board at: tentativePosition ) type.
	player goTo: tentativePosition.
	self move: player due: squareType with: effect within: game.
]

{ #category : #testing }
GameHandler class >> moveForward: player with: aNumber within: game [

	| tentativePosition lapCount |
	( self exceedsFinalPosition: aNumber max: game board size ) 
		ifTrue: [ 
			lapCount := aNumber // game board size.
			tentativePosition := aNumber - ( lapCount * game board size ).
			player lap + lapCount > game laps 
				ifTrue: [ 
					player changeLap: game laps.
					tentativePosition := game board size ]
				ifFalse: [ player changeLap: player lap + lapCount ] ]
		ifFalse: [ tentativePosition := aNumber ].
	^ tentativePosition.
]
