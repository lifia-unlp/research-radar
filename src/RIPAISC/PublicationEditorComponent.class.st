Class {
	#name : #PublicationEditorComponent,
	#superclass : #RipaiscAbstractComponent,
	#instVars : [
		'title',
		'selfArchivingUrl',
		'url',
		'abstract',
		'authors',
		'year',
		'doi',
		'countries',
		'topics',
		'applicationAreas',
		'producedByRipaisc'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #accessing }
PublicationEditorComponent >> abstract [

	^ abstract
]

{ #category : #accessing }
PublicationEditorComponent >> abstract: anObject [

	abstract := anObject
]

{ #category : #callbacks }
PublicationEditorComponent >> accept [
  self halt. 
]

{ #category : #accessing }
PublicationEditorComponent >> applicationAreas [

	^ applicationAreas
]

{ #category : #accessing }
PublicationEditorComponent >> applicationAreas: anObject [

	applicationAreas := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> authors [

	^ authors
]

{ #category : #accessing }
PublicationEditorComponent >> authors: anObject [

	authors := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> availableApplicationDomains [

	| col |
	col := OrderedCollection new.
	Radar singleton applicationDomains  do: [ :each |
		each withSubtopicsOn: col atLevel: 0 ].
	^ col
]

{ #category : #rendering }
PublicationEditorComponent >> availableCountries [

	^ Radar singleton countries
]

{ #category : #accessing }
PublicationEditorComponent >> availableTopics [

	| col |
	col := OrderedCollection new.
	Radar singleton topics do: [ :each |
		each withSubtopicsOn: col atLevel: 0 ].
	^ col
]

{ #category : #accessing }
PublicationEditorComponent >> countries [

	^ countries
]

{ #category : #accessing }
PublicationEditorComponent >> countries: anObject [

	countries := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> doi [

	^ doi
]

{ #category : #accessing }
PublicationEditorComponent >> doi: anObject [

	doi := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> producedByRipaisc [

	^ producedByRipaisc
]

{ #category : #accessing }
PublicationEditorComponent >> producedByRipaisc: anObject [

	producedByRipaisc := anObject
]

{ #category : #rendering }
PublicationEditorComponent >> renderContentOn: html [

	html container: [
		html form: [
			html formGroup: [
				html label: 'Título'.
				html textInput formControl on: #title of: self ].


			html formGroup: [
				html label: 'Año'.
				html textInput formControl on: #year of: self ].

			html formGroup: [
				html label: 'Autores'.
				html textInput formControl on: #authors of: self ].

			html formGroup
				formCheck;
				with: [
					html formCheckLabel with: [
							html formCheckbox
								on: #producedByRipaisc of: self;
								with: 'Algun autor pertenece a RIPAISC?' ] ].

			html formGroup: [
				html label: 'Resumen'.
				html textArea formControl
					on: #abstract of: self;
					rows: 5 ].
			html formGroup: [
				html label: 'DOI'.
				html textInput formControl on: #doi of: self ].

			html formGroup: [
				html label: 'URL'.
				html textInput formControl on: #url of: self ].

			html formGroup: [
				html label: 'URL de autoarchivado'.
				html textInput formControl on: #selfArchivingUrl of: self ].

			html formGroup: [
				html label: 'Páises involucrados'.
				html multiSelect formControl
					on: #countries of: self;
					size: 10;
					list: self availableCountries ].

			html formGroup: [
				html label: 'Temas'.
				html multiSelect formControl
					on: #topics of: self;
					labels: [ :each |
						(String new: each key * 4 withAll: $.) , each value label ];
					size: 10;
					list: self availableTopics ].

			html formGroup: [
				html label: 'Áreas de aplicación'.
				html multiSelect formControl
					on: #applicationAreas of: self;
					labels: [ :each |
						(String new: each key * 4 withAll: $.) , each value label ];
					size: 10;
					list: self availableApplicationDomains ].

			html formGroup: [
				html formButton
					callback: [ self accept ];
					bePrimary;
					with: 'Aceptar'.
				html space.
				html formButton
					callback: [ self answer ];
					beSecondary;
					with: 'Cancelar'.
				html space ] ] ]
]

{ #category : #accessing }
PublicationEditorComponent >> selfArchivingUrl [

	^ selfArchivingUrl
]

{ #category : #accessing }
PublicationEditorComponent >> selfArchivingUrl: anObject [

	selfArchivingUrl := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> title [

	^ title
]

{ #category : #accessing }
PublicationEditorComponent >> title: anObject [

	title := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> topics [

	^topics 
]

{ #category : #accessing }
PublicationEditorComponent >> topics: anObject [

	topics := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> url [

	^ url
]

{ #category : #accessing }
PublicationEditorComponent >> url: anObject [

	url := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> year [

	^ year
]

{ #category : #accessing }
PublicationEditorComponent >> year: anObject [

	year := anObject
]
