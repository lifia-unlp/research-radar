Class {
	#name : #Publication,
	#superclass : #Object,
	#instVars : [
		'bibtexEntry',
		'selfArchivingUrl',
		'byNetwork',
		'networkNodes',
		'topics',
		'applicationDomains',
		'countries',
		'relevanceToTopic'
	],
	#category : #'ResearchRadar-model'
}

{ #category : #accessing }
Publication >> abstract [

	^ bibtexEntry abstract
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
Publication >> bibtexEntry [

	^ bibtexEntry
]

{ #category : #accessing }
Publication >> bibtexEntry: anObject [

	bibtexEntry := anObject
]

{ #category : #accessing }
Publication >> byNetwork [

	^ networkNodes isEmptyOrNil not
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

{ #category : #initialization }
Publication >> initialize [
	
	byNetwork := false.
	countries := OrderedCollection new.
	networkNodes  := OrderedCollection new.
	applicationDomains := OrderedCollection new.
	topics := OrderedCollection new. 
	bibtexEntry := BibtexEntry new. 
]

{ #category : #accessing }
Publication >> networkNodes [

	^ networkNodes
]

{ #category : #accessing }
Publication >> networkNodes: anObject [

	networkNodes := anObject
]

{ #category : #accessing }
Publication >> relevanceToTopic [

	^ relevanceToTopic
]

{ #category : #accessing }
Publication >> relevanceToTopic: anObject [

	relevanceToTopic := anObject
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
Publication >> year [

	^ bibtexEntry year
]
