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
Radar class >> monitor [

	^ monitor ifNil: [ monitor := Monitor new ]
]

{ #category : #accessing }
Radar class >> readFrom: aFilename [

	| file |
	file := FileLocator workingDirectory / (aFilename , '.fuel').
	file exists ifFalse: [ ^ singleton := nil ].
	singleton := FLMaterializer new
		             filePath: file fullName;
		             materializeRoot
]

{ #category : #accessing }
Radar class >> repositoryFilename [

	^ 'ripaisc-radar'
]

{ #category : #accessing }
Radar class >> resetSingleton [

	 singleton := nil.
]

{ #category : #accessing }
Radar class >> save [

	self monitor critical: [
		self save: self singleton on: self repositoryFilename ]
]

{ #category : #accessing }
Radar class >> save: aRadar on: aFilename [

	| file |
	file := FileLocator workingDirectory / (aFilename , '.fuel').
	FLSerializer serialize: aRadar toFileNamed: file fullName.
	file := FileLocator workingDirectory
	        /
	        (aFilename , '-' , Date today ddmmyyyy asValidSelector
	         , '.fuel').
	FLSerializer serialize: aRadar toFileNamed: file fullName
]

{ #category : #accessing }
Radar class >> singleton [

	^ singleton ifNil: [

		  self monitor critical: [
			  self readFrom: self repositoryFilename.
			  singleton ifNil: [ singleton := self new ] ] ]
]

{ #category : #accessing }
Radar >> applicationDomains [

	^self applicationDomainsTaxonomy subtopics
]

{ #category : #accessing }
Radar >> applicationDomainsTaxonomy [

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
	taxonomy := (Topic labeled: 'Quantum computing')
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
