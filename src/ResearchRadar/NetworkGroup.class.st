Class {
	#name : #NetworkGroup,
	#superclass : #Object,
	#instVars : [
		'acronym',
		'fullName',
		'contactName',
		'contactEmail',
		'country',
		'notes'
	],
	#category : #'ResearchRadar-model'
}

{ #category : #accessing }
NetworkGroup >> acronym [

	^ acronym
]

{ #category : #accessing }
NetworkGroup >> acronym: anObject [

	acronym := anObject
]

{ #category : #accessing }
NetworkGroup >> contactEmail [

	^ contactEmail
]

{ #category : #accessing }
NetworkGroup >> contactEmail: anObject [

	contactEmail := anObject
]

{ #category : #accessing }
NetworkGroup >> contactName [

	^ contactName
]

{ #category : #accessing }
NetworkGroup >> contactName: anObject [

	contactName := anObject
]

{ #category : #accessing }
NetworkGroup >> country [

	^ country
]

{ #category : #accessing }
NetworkGroup >> country: anObject [

	country := anObject
]

{ #category : #accessing }
NetworkGroup >> fullName [

	^ fullName
]

{ #category : #accessing }
NetworkGroup >> fullName: anObject [

	fullName := anObject
]

{ #category : #accessing }
NetworkGroup >> notes [

	^ notes
]

{ #category : #accessing }
NetworkGroup >> notes: anObject [

	notes := anObject
]
