Class {
	#name : #BibtexChunckImportComponent,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'doi',
		'entryText',
		'error'
	],
	#category : #'ResearchRadar-seaside-backend'
}

{ #category : #callbacks }
BibtexChunckImportComponent >> accept [

	| entries |
	entries := PPBibtexParser new end parse: entryText.
	entries isPetitFailure ifTrue: [
		error := 'No puedo obtener una entrada válida: '
		         , entries message , ' at '
		         , entries position printString.
		^ self ].
	self answer: entries first cleanupLatexAccentsAndBraces
]

{ #category : #accessing }
BibtexChunckImportComponent >> bibtexEntry: bibtexEntry [
	entryText := bibtexEntry printString
]

{ #category : #callbacks }
BibtexChunckImportComponent >> cancel [ 
	self answer: nil
]

{ #category : #accessing }
BibtexChunckImportComponent >> doi [

	^ doi
]

{ #category : #accessing }
BibtexChunckImportComponent >> doi: anObject [

	doi := anObject
]

{ #category : #accessing }
BibtexChunckImportComponent >> entryText [

	^ entryText 
]

{ #category : #callbacks }
BibtexChunckImportComponent >> entryText: aBibtexString [
   entryText := aBibtexString 
]

{ #category : #callbacks }
BibtexChunckImportComponent >> fetch [

	| bibtexEntry |
	[ bibtexEntry := DoiOrgAPI new get: 'https://doi.org/' , doi ]
		on: Error
		do: [ bibtexEntry := nil ].
	bibtexEntry ifNil: [
		entryText := BibtexEntry emptyArticle printString.
		^ error := 'No pude encontrar información para ese DOI. Es probable que todavía no haya sido publicado.' ].
	entryText := bibtexEntry cleanupLatexAccentsAndBraces printString
]

{ #category : #rendering }
BibtexChunckImportComponent >> renderBibtexTextEditorFormOn: html [

	html form: [
		html formGroup: [
			html textArea
				formControl;
				rows: 20;
				on: #entryText of: self;
				id: 'bibtex'.
			html break.
			html formButton
				bePrimary;
				callback: [ self accept ];
				with: 'Accept'.
			html space.
			html formButton
				beSecondary;
				callback: [ self answer: nil ];
				with: 'Cancel'.
			html space ] ]
]

{ #category : #rendering }
BibtexChunckImportComponent >> renderButtonsOn: html [

	html paragraph: [
		error ifNil: [
			html space.
			html formButton
				bePrimary;
				callback: [ self accept ];
				with: 'Aceptar'.
			html space ].
		html formButton
			beSecondary;
			callback: [ self cancel ];
			with: 'Cancelar' ]
]

{ #category : #rendering }
BibtexChunckImportComponent >> renderContentOn: html [

	html heading level3 with: 'Bibtex'.
	self renderFetchFormOn: html.
	html break.
	self renderBibtexTextEditorFormOn: html.
	error ifNotNil: [
		html alert
			beDanger;
			with: error ].
	error := nil
]

{ #category : #rendering }
BibtexChunckImportComponent >> renderFetchFormOn: html [

	html form: [
		html inputGroup with: [
			html inputGroupPrepend: [
				html formButton
					bePrimary;
					callback: [ self fetch ];
					with: 'Fetch' ].
				html space.
			html textInput
				formControl;
				on: #doi of: self;
				placeholder: '10.1430/8105 ' ] ]
]

{ #category : #callbacks }
BibtexChunckImportComponent >> types [

	^ Dictionary new
		  at: 'inproceedings' put: 'Articulo de conferencia';
		  at: 'article' put: 'Artículo de revista';
		  at: 'book' put: 'Libro';
		  at: 'inbook' put: 'Capítulo de libro';
		  at: 'techreport' put: 'Reporte técnico';
		  at: 'phdthesis' put: 'Tesis de doctorado';
		  at: 'mastersthesis' put: 'Tesis de maestría';
		  at: 'incollection' put: 'Parte de libro';
		  at: 'misc' put: 'Otro';
		  yourself
]
