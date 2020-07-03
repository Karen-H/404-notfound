Class {
	#name : #Position,
	#superclass : #Object,
	#instVars : [
		'lap',
		'boardSquare'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Position class >> positionNewLap: lap withNewSquare: square [
	
	^self new
		initialize: lap
		withSquare: square.
]

{ #category : #accessing }
Position >> boardSquare [

	^ boardSquare.
]

{ #category : #initialization }
Position >> initialize:lapNow withSquare: squareNow [

	lap := lapNow.
	boardSquare := squareNow.
]

{ #category : #accessing }
Position >> lap [

	^ lap.
]

{ #category : #'as yet unclassified' }
Position >> results:players [
	
	^ players sort: [ :aPlayer :anotherPlayer |
		aPlayer boardSquare  > anotherPlayer boardSquare 
			or: [ aPlayer boardSquare  = anotherPlayer boardSquare 
				and: [ aPlayer boardSquare  > anotherPlayer lap ] ] ]
]
