Class {
	#name : #Radar,
	#superclass : #Object,
	#instVars : [
		'publications',
		'groups',
		'projects',
		'educationalOffers',
		'countries',
		'taxonomy'
	],
	#classInstVars : [
		'singleton',
		'monitor'
	],
	#category : #'RIPAISC-persistence'
}

{ #category : #accessing }
Radar class >> resetSingleton [

	 singleton := nil.
]

{ #category : #accessing }
Radar class >> save: aRadar on: aFilename [

	monitor critical: [
		aFilename asFileReference writeStreamDo: [ :stream |
			(STONWriter on: stream)
				prettyPrint: true;
				newLine: OSPlatform current lineEnding;
				nextPut: aRadar ] ]
]

{ #category : #accessing }
Radar class >> singleton [

	^ singleton ifNil: [
		  monitor := Monitor new.
		  singleton := self new. ]
]

{ #category : #accessing }
Radar >> applicationDomains [

	^self applicationTaxonomy subtopics
]

{ #category : #accessing }
Radar >> applicationTaxonomy [

	^ taxonomy subtopics second
]

{ #category : #accessing }
Radar >> countries [

	^ countries
]

{ #category : #accessing }
Radar >> countries: anObject [

	countries := anObject
]

{ #category : #accessing }
Radar >> educationalOffers [

	^ educationalOffers
]

{ #category : #accessing }
Radar >> educationalOffers: anObject [

	educationalOffers := anObject
]

{ #category : #accessing }
Radar >> groups [

	^ groups
]

{ #category : #accessing }
Radar >> groups: anObject [

	groups := anObject
]

{ #category : #initialization }
Radar >> initialize [

	publications := OrderedCollection new.
	groups := OrderedCollection new.
	projects := OrderedCollection new.
	educationalOffers := OrderedCollection new.
	taxonomy := Topic
		            labeled: 'Quantum computing';
		            description: 'Root element of the taxonomy';
		            yourself.
	taxonomy subtopics
		add: (Topic fromJSON: Topic qseTaxonomyAsJson);
		add: (Topic fromJSON: Topic domainsTaxonomyAsJson).
	countries := { 'Argentina'. 'Bolivia'. 'Brasil'. 'Chile'. 'Colombia'.
	             'Costa Rica'. 'Cuba'. 'Ecuador'. 'El Salvador'.
	             'España'. 'Guatemala'. 'Guinea Ecuatorial'.
	             'Honduras'. 'México'. 'Nicaragua'. 'Panamá'. 'Paraguay'.
	             'Perú'. 'Portugal'. 'Puerto Rico'. 'República Dominicana'.
	             'Uruguay'. 'Venezuela' }
]

{ #category : #accessing }
Radar >> projects [

	^ projects
]

{ #category : #accessing }
Radar >> projects: anObject [

	projects := anObject
]

{ #category : #accessing }
Radar >> publications [

	^ publications
]

{ #category : #accessing }
Radar >> publications: anObject [

	publications := anObject
]

{ #category : #accessing }
Radar >> topics [

	^ self topicsTaxonomy subtopics
]

{ #category : #accessing }
Radar >> topicsTaxonomy [

	^ taxonomy subtopics first
]
