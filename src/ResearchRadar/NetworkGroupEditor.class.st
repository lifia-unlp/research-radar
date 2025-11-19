Class {
	#name : #NetworkGroupEditor,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'group',
		'acronym',
		'fullName',
		'contactName',
		'contactEmail',
		'country',
		'notes'
	],
	#category : #'ResearchRadar-seaside-backend'
}

{ #category : #visiting }
NetworkGroupEditor >> accept [

	group
		acronym: acronym;
		fullName: fullName;
		contactName: contactName;
		contactEmail: contactEmail;
		country: country;
		notes: notes.
	self answer: group
]

{ #category : #accessing }
NetworkGroupEditor >> acronym [

	^ acronym
]

{ #category : #accessing }
NetworkGroupEditor >> acronym: anObject [

	acronym := anObject
]

{ #category : #accessing }
NetworkGroupEditor >> contactEmail [

	^ contactEmail
]

{ #category : #accessing }
NetworkGroupEditor >> contactEmail: anObject [

	contactEmail := anObject
]

{ #category : #accessing }
NetworkGroupEditor >> contactName [

	^ contactName
]

{ #category : #accessing }
NetworkGroupEditor >> contactName: anObject [

	contactName := anObject
]

{ #category : #accessing }
NetworkGroupEditor >> country [

	^ country
]

{ #category : #accessing }
NetworkGroupEditor >> country: anObject [

	country := anObject
]

{ #category : #accessing }
NetworkGroupEditor >> fullName [

	^ fullName
]

{ #category : #accessing }
NetworkGroupEditor >> fullName: anObject [

	fullName := anObject
]

{ #category : #accessing }
NetworkGroupEditor >> group [

	^ group
]

{ #category : #accessing }
NetworkGroupEditor >> group: anObject [

	group := anObject.
	acronym := anObject acronym.
	fullName := anObject fullName.
	contactName := anObject contactName.
	contactEmail := anObject contactEmail .
	country := anObject country.
	notes := anObject notes
]

{ #category : #accessing }
NetworkGroupEditor >> notes [

	^ notes
]

{ #category : #accessing }
NetworkGroupEditor >> notes: anObject [

	notes := anObject
]

{ #category : #rendering }
NetworkGroupEditor >> renderContentOn: html [

	html container: [
		html form: [
			html formGroup: [
				html label: 'Acronym'.
				html textInput formControl on: #acronym of: self ].

			html formGroup: [
				html label: 'Full name'.
				html textInput formControl on: #fullName of: self ].

			html formGroup: [
				html label: 'Contact name'.
				html textInput formControl on: #contactName of: self ].

			html formGroup: [
				html label: 'Contact email'.
				html textInput formControl on: #contactEmail of: self ].

			html formGroup: [
				html label: 'Country'.
				html textInput formControl on: #country of: self ].

			html formGroup: [
				html label: 'Notes'.
				html textInput formControl on: #notes of: self ].
			html break.
			html formGroup: [
				html formButton
					callback: [ self accept ];
					bePrimary;
					with: 'Accept'.
				html space.
				html formButton
					callback: [ self answer: nil ];
					beSecondary;
					with: 'Cancel'.
				html space ] ] ]
]
