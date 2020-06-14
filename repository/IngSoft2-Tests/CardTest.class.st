Class {
	#name : #CardTest,
	#superclass : #TestCase,
	#instVars : [
		'karen',
		'andre',
		'simpleBoard10',
		'juli',
		'fran',
		'mixBoard20',
		'noEffect10SquaresBoard',
		'diverseEffects20SquaresBoard',
		'gameHandler'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
CardTest >> testDeckImplementedRollingMethod [
	
]

{ #category : #tests }
CardTest >> testGameNotOverUsingCard [
	|board deck game dice p01 p02 players cards cards2|
	board := (NoEffect on:1)+(WormHole on:2)+(NoEffect on:3)+(DrawCard on:4)+(SpeedUp on:5)
	+(NoEffect on:6)+(MoonWalk on:7)+(NoEffect on:8)+(NoEffect on:9)+(SpeedUp on:10)+
	(WormHole on:11)+(NoEffect on:12)+(AtomicBomb on:13)+(NoEffect on:14)+(MoonWalk  on:15)
	+(NoEffect on:16)+(DrawCard on:17)+(WormHole on:18)+(SpeedUp on:19)+(NoEffect on:20).
	deck:=Deck new initialize.
	cards:= Acceleration newCard+Acceleration newCard.
	cards2:= Acceleration newCard+Acceleration newCard.
	p01:=Player takeOn: cards.
	p02:=Player takeOn: cards2.
	players:=p01+p02.
	dice:=Die of: 6 rolling:#(5 5 5).
	game :=Game new initialize: board playedBy: players with: 0 using: deck.
	game usingCardsplay:dice.
	self assert:p01 position equals:20.
	self assert:p02 position equals:15.
	
	
]

{ #category : #tests }
CardTest >> testImplementsDeckPositionDeterminant [
	|deck card|
	deck:= Deck new initialize.
	card:=deck randomCard.
	self assert:card type equals:'Permanent' .
	card:=deck randomCard.
	self assert:card type equals:'Instant'.
	
]

{ #category : #tests }
CardTest >> testPlayerFallOnSquareDrawCard [
	|player01 deck square game cards players panel|
	cards:= (Acceleration newCard)+(Redo newCard).
	deck:= Deck new initialize.
	player01:= Player takeOn:cards.
	panel:= (NoEffect on:1) + (NoEffect on:2)+(NoEffect on:3)+ (NoEffect on:4).
	square:= DrawCard on:1.
	players:=OrderedCollection new.players add:player01.
	game:= Game new initialize:panel playedBy: players with:2 using:deck .
	
	square applyEffectOn: player01 within: game.
	self assert:(player01 hand)size equals:3.
]

{ #category : #tests }
CardTest >> testPlayerRepeat [
	|cards player01 deck players panel game card|
	cards:=(Repeat newCard)+(Speed newCard).
	deck:=Deck initialize.
	player01:= Player takeOn:cards.
	players:= OrderedCollection new. players add:player01.
	panel:= (NoEffect on:1)+(SpeedUp on:2)+(NoEffect on:3)+(NoEffect on:4)+
	(NoEffect on:5)+(NoEffect on:6)+(NoEffect on:7).
	game:= Game new initialize: panel playedBy: players with:2  using:deck.
	card:=player01 throwCard.
	card activateThisCardOf: player01 on: player01 inside:game.
	card:=player01 throwCard.
	card activateThisCardOf: player01 on: player01 inside:game cardChosenIs:card.
	self assert:player01 position equals:6.
	
	 
]

{ #category : #tests }
CardTest >> testPlayerThrowAllCards [
	|player01 player02 cards cards2|
	cards:=(Speed newCard)+(Speed newCard).
	cards2:=(Speed newCard)+(Speed newCard).
	player01:= Player takeOn:cards.
	player02:= Player takeOn:cards2.
	player01 throwCard.
	player01 throwCard.
	self assert: (player01 hand)size equals:0.
	player02 throwCard.
	self assert: (player02 hand)size equals:1.
	
]

{ #category : #tests }
CardTest >> testPlayerThrowCard [
	|player01 cards selectedCard |
	cards:= Acceleration newCard+Acceleration newCard.
	player01:= Player takeOn:cards.
	self assert: (player01 hand)size equals:2.
	selectedCard:=player01 throwCard.
	self assert: (player01 hand)size equals:1.
	self assert: (selectedCard) class equals:Acceleration.
]

{ #category : #tests }
CardTest >> testPlayerUseCardCancellation [
	|cards cards2 p1 p2 deck  players panel game card card2 card3 |
	cards:=(Cancellation newCard)+(Speed newCard).
	cards2:=(Cancellation newCard)+(Speed newCard).
	deck:= Deck initialize.
	p1:= Player takeOn:cards.
	p2:= Player takeOn:cards2.
	players:=p1+p2.
	panel:= (NoEffect on:1) + (NoEffect on:2)+(NoEffect on:3)+ (NoEffect on:4).
	game:=Game new initialize:panel playedBy: players with:2  using:deck.
	card:=p2 throwCard.
	card activateThisCardOf: p2 on:p1  inside: game.
	card2:= p1 throwCard.
	card2 activateThisCardOf: p1 on:p2  inside:game.
	self assert: (game cardsUsed)size equals:2.
	self assert: (p1 hand)size equals:1.
	card3:=p2 throwCard.
	card3 activateThisCardOf: p2 on: p1 inside:game cardChosenIs:(Speed new).
	self assert:(game cardsUsed )size equals:2.
]

{ #category : #tests }
CardTest >> testPlayerUseCardOverload [
	|cards player01 deck player02 players panel game card |
	cards := (Overload newCard)+(Overload newCard).
	deck:= Deck initialize.
	player01 := Player takeOn:cards.
	player02 := Player takeOn:cards.
	players:=player01+player02.
	panel:= (NoEffect on:1) + (NoEffect on:2)+(NoEffect on:3)+ (NoEffect on:4).
	game := Game new initialize: panel playedBy: players with: 2 using: deck.
	GameHandler new move: player02 rolling: 2 within:game.
	card :=player01 throwCard.
	card activateThisCardOf: player01 on: player02  inside: game.
	self assert: player02 position equals:1.
	self assert: player01 position equals:1.
	self assert: (game cardsUsed)size equals:1.
	
]

{ #category : #tests }
CardTest >> testPlayerUseCardRedoOnGame [
	|cards p1 p2 cards2 deck players game panel card card2|
	cards:=(Speed newCard)+(Speed newCard).
	cards2:=(Speed newCard)+(Redo newCard).
	deck:=Deck initialize.
	p1:=Player takeOn:cards.
	p2:=Player takeOn:cards2.
	players:=p1+p2.
	panel:=(NoEffect on:1)+(NoEffect on:2)+(NoEffect on:3).
	game:= Game new initialize:panel playedBy: players with: 2 using:deck.
	
	card:=p1 throwCard.
	card activateThisCardOf: p1 on: p2 inside: game.
	card2:=p2 throwCard.
	card2 activateThisCardOf: p2 on: p1 inside: game cardChosenIs:card.
	
	self assert:p1 position equals:2.
	self assert:(game cardsUsed)size equals:2.
]

{ #category : #tests }
CardTest >> testPlayerUseCardSpeedAndAcceleration [
	|cards p1 p2 deck  players panel game card cards2 cardAcceleration|
	cards:=(Speed newCard)+(Speed newCard).
	cards2:=(Speed newCard)+(Speed newCard).
	deck:= Deck initialize.
	p1:= Player takeOn:cards.
	p2:= Player takeOn:cards2.
	players:=p1+p2.
	panel:= (NoEffect on:1) + (NoEffect on:2)+(NoEffect on:3)+ (NoEffect on:4).
	game:=Game new initialize:panel playedBy: players with:2  using:deck.
	card:=p2 throwCard.
	card activateThisCardOf: p2 on:p1  inside: game.
	self assert:p1 position equals:2.
	self assert:p2 position equals:1.
	cardAcceleration:= Acceleration new.
	self assert:(p1 hand)size equals:2.
	self assert:(p2 hand)size equals:1.
	cardAcceleration activateThisCardOf: p2 on: p1 inside: game.
	self assert: p1 position equals:3.
	self assert: p2 position equals:2.
]
