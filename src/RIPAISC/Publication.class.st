Class {
	#name : #Publication,
	#superclass : #Object,
	#instVars : [
		'bibtexEntry',
		'selfArchivingUrl',
		'byRipaisc',
		'coutries',
		'nodes'
	],
	#category : #'RIPAISC-model'
}

{ #category : #accessing }
Publication >> bibtexEntry [

	^ bibtexEntry
]

{ #category : #accessing }
Publication >> bibtexEntry: anObject [

	bibtexEntry := anObject
]

{ #category : #accessing }
Publication >> byRipaisc [

	^ byRipaisc
]

{ #category : #accessing }
Publication >> byRipaisc: anObject [

	byRipaisc := anObject
]

{ #category : #accessing }
Publication >> coutries [

	^ coutries
]

{ #category : #accessing }
Publication >> coutries: anObject [

	coutries := anObject
]

{ #category : #initialization }
Publication >> initialize [

	byRipaisc := false.
	coutries := OrderedCollection new.
	nodes := OrderedCollection new
]

{ #category : #accessing }
Publication >> nodes [

	^ nodes
]

{ #category : #accessing }
Publication >> nodes: anObject [

	nodes := anObject
]

{ #category : #accessing }
Publication >> selfArchivingUrl [

	^ selfArchivingUrl
]

{ #category : #accessing }
Publication >> selfArchivingUrl: anObject [

	selfArchivingUrl := anObject
]
