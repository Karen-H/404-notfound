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
GameHandler class >> exceedsMovement: player with: aNumber max: game [

	| tentativePosition lapCount |
	( self exceedsFinalPosition: aNumber max: game boardSquares ) 
		ifTrue: [ 
			lapCount := aNumber // game boardSquares.
			tentativePosition := aNumber - ( lapCount * game boardSquares ).
			player lap + lapCount > game laps 
				ifTrue: [ 
					player changeLap: game laps.
					tentativePosition := game boardSquares ]
				ifFalse: [ player changeLap: player lap + lapCount ] ]
		ifFalse: [ tentativePosition := aNumber ].
	^ tentativePosition.
]

{ #category : #testing }
GameHandler class >> fallsBehind: player with: aNumber max: boardSize [

	| tentativePosition lapCount |
	lapCount := 0.
	( self fallsBehindFinalPosition: aNumber )
		ifTrue: [ 
			lapCount := aNumber // boardSize.
			tentativePosition := aNumber + (lapCount negated * boardSize).
			player changeLap: lapCount ]
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
						(self fallsBehind: member with: member position + effect max: game boardSquares) ] ].
		type = 'WormHole'
			ifTrue: [ newPosition := self
				fallsBehind: player
				with: player position + effect
				max: game boardSquares.
				player goTo: newPosition ].
		(type = 'AtomicBomb' or: [ type = 'MoonWalk' or: type = 'WormHole' ])
			ifTrue: [ ^ self ].
			newPosition := self
			exceedsMovement: player
			with: player position + effect
			max: game.
			player goTo: newPosition
]

{ #category : #playing }
GameHandler class >> move: player with: dice of: game [

	| tentativePosition effect squareType |
	tentativePosition := self exceedsMovement: player with: player position + dice max: game.
	effect := ( game board detect: [ :square | square number = tentativePosition ] ) effectNumber.
	squareType := ( game board detect: [ :square | square number = tentativePosition ] ) type.
	player goTo: tentativePosition.
	self move: player due: squareType with: effect within: game.
]
