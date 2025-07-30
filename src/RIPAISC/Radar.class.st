Class {
	#name : #Radar,
	#superclass : #Object,
	#instVars : [
		'publications'
	],
	#classInstVars : [
		'singleton'
	],
	#category : #'RIPAISC-persistence'
}

{ #category : #accessing }
Radar class >> resetSingleton [

	 singleton := nil.
]

{ #category : #accessing }
Radar class >> singleton [

	^ singleton ifNil: [ singleton := self new ]
]
