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

{ #category : #accessing }
Position >> lap [

	^ lap.
]
