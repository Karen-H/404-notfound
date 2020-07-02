Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'lap',
		'boardSquare'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Position class >> start [

	^ self new.
]

{ #category : #accessing }
Position >> boardSquare [

	^ boardSquare.
]

{ #category : #accessing }
Position >> changeLap: newLap [

	lap := newLap.
]

{ #category : #playing }
Position >> changeSquare: newPosition [

	boardSquare := newPosition.
]

{ #category : #initialization }
Position >> initialize [

	super initialize.
	lap := 0.
	boardSquare := 1.
]

{ #category : #initialization }
Position >> initializeWithSquareNew:squareNow lapNEW: lapNow [

	lap := lapNow.
	boardSquare := squareNow.
]

{ #category : #accessing }
Position >> lap [

	^ lap.
]

{ #category : #accessing }
Position >> lap: newLap [

	|newPosition|
	newPosition:= self initializeWithSquareNew: self boardSquare lapNEW:newLap.
	^newPosition.
]

{ #category : #playing }
Position >> square: newSquare [
	
	|newPosition|
	newPosition :=self initializeWithSquareNew: newSquare lapNEW: self lap.
	^newPosition. 
	
]
