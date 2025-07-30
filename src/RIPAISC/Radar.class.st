Class {
	#name : #Radar,
	#superclass : #Object,
	#instVars : [
		'publications',
		'groups',
		'projects',
		'educationalOffers',
		'countries',
		'topics'
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
	topics := (Topic fromJSON: Topic qseTaxonomyAsJson) subtopics.

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

	^ topics
]

{ #category : #accessing }
Radar >> topics: anObject [

	topics := anObject
]
