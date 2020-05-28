Class {
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'location'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Player class >> ready [

	^ self new.
]

{ #category : #accessing }
Player >> boardSquare [

	^ location boardSquare.
]

{ #category : #initialization }
Player >> initialize [

	super initialize.
	location := Position start.
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
Player >> position [

	^ location boardSquare.
]
