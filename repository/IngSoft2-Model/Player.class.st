Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'location',
		'hand',
		'effect',
		'name',
		'turn',
		'activeCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> assertTwoCardsAreDrawn: cards [

	cards size ~= 2
		ifTrue: [ InstanceCreationFailed
				signal: 'The player must draw two cards at the beginning of the game' ].
			
	
]

{ #category : #'instance creation' }
Player class >> drawing: cards name: player [
	
	self assertTwoCardsAreDrawn: cards.
	
	^ self new initializeWith: cards name: player.
]

{ #category : #drawing }
Player >> active: card [

	activeCards add: card.
]

{ #category : #accessing }
Player >> activeCards [

	^ activeCards.
]

{ #category : #accessing }
Player >> boardSquare [

	^ location boardSquare.
]

{ #category : #playing }
Player >> chooseTargetFrom: game [

	| target |
	target := UIManager default chooseFrom: 
		(game players collect: [ :player | player name ]) values: game players title: 'Choose a target'.
	[ target isNil ] whileTrue:
		[ target := UIManager default chooseFrom: 
			(game players collect: [ :player | player name ]) values: game players title: 'Choose a target' ].
	^ target.
]

{ #category : #drawing }
Player >> draw: card [

	hand add: card.
]

{ #category : #accessing }
Player >> effect [

	effect := activeCards sumNumbers: [ :card | card effectNumber ].
	^ effect.
]

{ #category : #accessing }
Player >> hand [ 

	^ hand.
]

{ #category : #initialization }
Player >> initializeWith: cards name: player [

	location := Position start.
	hand := cards.
	effect := 0.
	name := player.
	turn := false.
	activeCards := OrderedCollection new.
]

{ #category : #accessing }
Player >> lap [

	^ location lap.
]

{ #category : #accessing }
Player >> location [

	^ location.
]

{ #category : #accessing }
Player >> name [

	^ name.
]

{ #category : #accessing }
Player >> pickACard [

	| card |
	card := UIManager default
		chooseFrom: (hand collect: [ :cardboard | cardboard name ])
		values: hand
		 title: 'Pick a card'.
	[ card isNil ]
		whileTrue: [ card := UIManager default
				chooseFrom: (hand collect: [ :cardboard | cardboard name ])
				values: hand
				title: 'Pick a card' ].
	^ card
]

{ #category : #accessing }
Player >> playACardWithin: game [

	| play card |
	hand isEmpty ifTrue: [ ^ self ].
	play := self wantsToPlayACard.
	play = 'Y' ifFalse: [ ^ self ].
	card := self pickACard.
	turn 
		ifTrue: [ card usedBy: self within: game ] 
		ifFalse: [ card type = 'Instant' 
			ifTrue: [ card usedBy: self within: game ] ]
]

{ #category : #accessing }
Player >> position [

	^ location boardSquare.
]

{ #category : #removing }
Player >> remove: card from: deck [

	| usedCard |
	usedCard := deck detect: [ :cardboard | cardboard name = card name ].
	deck remove: usedCard.
]

{ #category : #accessing }
Player >> turn [

	^ turn.
]

{ #category : #accessing }
Player >> turn: value [

	turn := value.
]

{ #category : #accessing }
Player >> wantsToPlayACard [

	| play |
	play := UIManager default chooseFrom: #(#Yes #No) values: #(#Y #N) title: 'Play a card?'.
	[ play isNil ]
		whileTrue: [ play := UIManager default chooseFrom: #(#Yes #No) values: #(#Y #N) title: 'Play a card?' ].
	^ play
]
