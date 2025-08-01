Class {
	#name : #Publication,
	#superclass : #Object,
	#instVars : [
		'bibtexEntry',
		'selfArchivingUrl',
		'byRipaisc',
		'ripaiscNodes',
		'topics',
		'applicationDomains',
		'countries',
		'relevanceToQse'
	],
	#category : #'RIPAISC-model'
}

{ #category : #accessing }
Publication >> abstract [

	^ bibtexEntry abstract
]

{ #category : #accessing }
Publication >> abstract: anObject [

	bibtexEntry abstract: anObject
]

{ #category : #accessing }
Publication >> applicationDomains [

	^ applicationDomains
]

{ #category : #accessing }
Publication >> applicationDomains: anObject [

	applicationDomains := anObject
]

{ #category : #accessing }
Publication >> author [

	^ bibtexEntry author
]

{ #category : #accessing }
Publication >> author: aString [

	bibtexEntry author: aString
]

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
Publication >> countries [

	^ countries
]

{ #category : #accessing }
Publication >> countries: anObject [

	countries := anObject
]

{ #category : #accessing }
Publication >> doi [

	^ bibtexEntry doi
]

{ #category : #accessing }
Publication >> doi: anObject [

	bibtexEntry doi: anObject
]

{ #category : #initialization }
Publication >> initialize [
	
	byRipaisc := false.
	countries := OrderedCollection new.
	ripaiscNodes  := OrderedCollection new.
	applicationDomains := OrderedCollection new.
	topics := OrderedCollection new. 
	bibtexEntry := BibtexEntry new. 
]

{ #category : #accessing }
Publication >> relevanceToQse [

	^ relevanceToQse
]

{ #category : #accessing }
Publication >> relevanceToQse: anObject [

	relevanceToQse := anObject
]

{ #category : #accessing }
Publication >> selfArchivingUrl [

	^ selfArchivingUrl
]

{ #category : #accessing }
Publication >> selfArchivingUrl: anObject [

	selfArchivingUrl := anObject
]

{ #category : #accessing }
Publication >> title [

	^ bibtexEntry title
]

{ #category : #accessing }
Publication >> title: anObject [

	bibtexEntry title: anObject
]

{ #category : #accessing }
Publication >> topics [

	^ topics
]

{ #category : #accessing }
Publication >> topics: anObject [

	topics := anObject
]

{ #category : #accessing }
Publication >> url [

	^bibtexEntry url
]

{ #category : #accessing }
Publication >> url: anObject [

	bibtexEntry url: anObject
]

{ #category : #accessing }
Publication >> year [

	^ bibtexEntry year
]

{ #category : #accessing }
Publication >> year: anObject [

	bibtexEntry year: anObject
]
