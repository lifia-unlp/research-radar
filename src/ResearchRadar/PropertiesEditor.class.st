Class {
	#name : #PropertiesEditor,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'properties',
		'project',
		'description',
		'url',
		'categoryForAll',
		'categoryForOther'
	],
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #callbacks }
PropertiesEditor >> accept [

	properties
		at: 'project' put: project;
		at: 'description' put: description;
		at: 'ulr' put: url;
		at: 'category_for_all' put: categoryForAll;
		at: 'category_for_other' put: categoryForOther.
	Radar properties: properties .
	self answer: nil
]

{ #category : #accessing }
PropertiesEditor >> categoryForAll [

	^ categoryForAll
]

{ #category : #accessing }
PropertiesEditor >> categoryForAll: anObject [

	categoryForAll := anObject
]

{ #category : #accessing }
PropertiesEditor >> categoryForOther [

	^ categoryForOther
]

{ #category : #accessing }
PropertiesEditor >> categoryForOther: anObject [

	categoryForOther := anObject
]

{ #category : #accessing }
PropertiesEditor >> description [

	^ description
]

{ #category : #accessing }
PropertiesEditor >> description: anObject [

	description := anObject
]

{ #category : #initialize }
PropertiesEditor >> initialize [

	super initialize.
	properties := Radar properties.
	project := properties at: 'project'.
	description := properties at: 'description'.
	url := properties at: 'ulr'.
	categoryForAll := properties at: 'category_for_all'.
	categoryForOther := properties at: 'category_for_other'
]

{ #category : #accessing }
PropertiesEditor >> project [

	^ project
]

{ #category : #accessing }
PropertiesEditor >> project: anObject [

	project := anObject
]

{ #category : #accessing }
PropertiesEditor >> properties [

	^ properties
]

{ #category : #accessing }
PropertiesEditor >> properties: anObject [

	properties := anObject
]

{ #category : #rendering }
PropertiesEditor >> renderContentOn: html [

	html container: [
		html form: [
			html formGroup: [
				html label: 'Project'.
				html textInput formControl on: #project of: self ].

			html formGroup: [
				html label: 'Description'.
				html textArea formControl
					on: #description of: self;
					rows: 15 ].

			html formGroup: [
				html label: 'Category for ALL countries'.
				html textInput formControl on: #categoryForAll of: self ].

			html formGroup: [
				html label: 'Category for OTHER countries'.
				html textInput formControl on: #categoryForOther of: self ].


			html formGroup: [
				html label: 'URL'.
				html textInput formControl on: #url of: self ].


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

{ #category : #accessing }
PropertiesEditor >> url [

	^ url
]

{ #category : #accessing }
PropertiesEditor >> url: anObject [

	url := anObject
]
