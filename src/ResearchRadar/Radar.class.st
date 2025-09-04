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
	#category : #'ResearchRadar-persistence'
}

{ #category : #secrets }
Radar class >> knownSecret [

	self secretFile ifExists: [ :it |
		^ it readStreamDo: [ :stream | stream contents ] ].
	^ nil
]

{ #category : #secrets }
Radar class >> knownSecret: aString [

	self secretFile writeStreamDo: [ :stream |
		stream nextPutAll: aString ]
]

{ #category : #accessing }
Radar class >> monitor [

	^ monitor ifNil: [ monitor := Monitor new ]
]

{ #category : #properties }
Radar class >> properties [

	self propertiesFile ifExists: [ :it |
		^ it readStreamDo: [ :stream | STON fromString: stream contents ] ].
	^ self propertiesDefault 
]

{ #category : #properties }
Radar class >> properties: aDictionary [

	self propertiesDefault keysAndValuesDo: [ :key :value |
		aDictionary at: key ifAbsentPut: value ].

	self monitor critical: [
		self propertiesFile writeStreamDo: [ :stream |
			stream nextPutAll: (STON toStringPretty: aDictionary) ] ]
]

{ #category : #properties }
Radar class >> propertiesDefault [

	^ Dictionary new
		  at: 'project' put: 'Research Radar';
		  at: 'description' put: 'Monitoring regional research';
		  at: 'ulr' put: 'https://github.com/lifia-unlp/research-radar';
		  at: 'region' put: 'World';
		  at: 'network_name' put: 'Network';
		  yourself
]

{ #category : #properties }
Radar class >> propertiesFile [

	^ self repositoryFolder / 'properties.txt'
]

{ #category : #accessing }
Radar class >> readFrom: aFileReference [

	aFileReference exists ifFalse: [ ^ singleton := nil ].
	singleton := FLMaterializer new
		             filePath: aFileReference fullName;
		             materializeRoot
]

{ #category : #accessing }
Radar class >> repositoryFile [

	^ self repositoryFolder / 'research-radar.fuel'
]

{ #category : #accessing }
Radar class >> repositoryFolder [

	^ FileLocator workingDirectory / 'data'
]

{ #category : #accessing }
Radar class >> resetSingleton [

	 singleton := nil.
]

{ #category : #accessing }
Radar class >> save [

	self monitor critical: [
		self save: self singleton on: self repositoryFile ]
]

{ #category : #accessing }
Radar class >> save: aRadar on: aFileReference [

	FLSerializer serialize: aRadar toFileNamed: aFileReference fullName.
	FLSerializer
		serialize: aRadar
		toFileNamed:
		aFileReference fullName
		, ('-' , Date today ddmmyyyy asValidSelector)
]

{ #category : #accessing }
Radar class >> secretFile [

	^ self repositoryFolder / 'secret.txt'
]

{ #category : #accessing }
Radar class >> singleton [

	^ singleton ifNil: [

		  self monitor critical: [
			  self readFrom: self repositoryFile.
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
