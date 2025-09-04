Class {
	#name : #PropertiesEditor,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'properties',
		'project',
		'networkName',
		'description',
		'url',
		'region'
	],
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #callbacks }
PropertiesEditor >> accept [

	properties := Dictionary new. 
	properties
		at: 'project' put: project;
		at: 'network_name' put: networkName ;
		at: 'description' put: description;
		at: 'ulr' put: url;
		at: 'region' put: region.
	Radar radarProperties: properties .
	self answer: nil
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
	properties := Radar radarProperties.
	project := properties at: 'project' ifAbsent: ''.
	description := properties at: 'description' ifAbsent: ''.
	networkName := properties at: 'network_name' ifAbsent: ''.
	url := properties at: 'ulr' ifAbsent: ''.
	region := properties at: 'region' ifAbsent: ''.

]

{ #category : #accessing }
PropertiesEditor >> networkName [

	^ networkName
]

{ #category : #accessing }
PropertiesEditor >> networkName: anObject [

	networkName := anObject
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

{ #category : #accessing }
PropertiesEditor >> region [

	^ region
]

{ #category : #accessing }
PropertiesEditor >> region: anObject [

	region := anObject
]

{ #category : #rendering }
PropertiesEditor >> renderContentOn: html [

	html container: [
		html form: [
			html formGroup: [
				html label: 'Project'.
				html textInput formControl on: #project of: self ].

			html formGroup: [
				html label: 'Network name'.
				html textInput formControl on: #networkName of: self ].


			html formGroup: [
				html label: 'Description'.
				html textArea formControl
					on: #description of: self;
					rows: 15 ].

			html formGroup: [
				html label: 'Region'.
				html textInput formControl on: #region of: self ].

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
