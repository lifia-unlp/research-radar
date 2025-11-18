Class {
	#name : #BulkImportWizard,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'dataRows',
		'bibtexEntriesFromFile',
		'newEntries',
		'headerRow',
		'typeColumn',
		'titleColumn',
		'authorColum',
		'affiliationsColumn',
		'abstractColumn',
		'doiColumn',
		'yearColumn',
		'urlColumn',
		'typeMappings'
	],
	#category : #'ResearchRadar-seaside-backend'
}

{ #category : #accessing }
BulkImportWizard >> abstractColumn [

	^ abstractColumn
]

{ #category : #accessing }
BulkImportWizard >> abstractColumn: anObject [

	abstractColumn := anObject
]

{ #category : #accessing }
BulkImportWizard >> affiliationsColumn [

	^ affiliationsColumn
]

{ #category : #accessing }
BulkImportWizard >> affiliationsColumn: anObject [

	affiliationsColumn := anObject
]

{ #category : #accessing }
BulkImportWizard >> authorColum [

	^ authorColum
]

{ #category : #accessing }
BulkImportWizard >> authorColum: anObject [

	authorColum := anObject
]

{ #category : #callbacks }
BulkImportWizard >> cancel [

	^ self answer: nil
]

{ #category : #callbacks }
BulkImportWizard >> createBibtexEntriesFromRows [

	bibtexEntriesFromFile := dataRows collect: [ :each |
		                         | entry |
		                         entry := BibtexEntry empty:
			                                  (typeMappings at:
				                                   (each at:
					                                    (headerRow indexOf:
						                                     typeColumn))).
		                         entry title:
			                         (each at: (headerRow indexOf: titleColumn)).
		                         entry author:
			                         (each at: (headerRow indexOf: authorColum)).
		                         entry abstract:
			                         ((each at:
				                           (headerRow indexOf: abstractColumn))
			                          , '\\Affiliations '
			                          ,
			                          (each at:
				                           (headerRow indexOf: affiliationsColumn)))
				                         withCRs.
		                         entry doi:
			                         (each at: (headerRow indexOf: doiColumn)).
		                         entry year:
			                         (each at: (headerRow indexOf: yearColumn)).
		                         entry url:
			                         (each at: (headerRow indexOf: urlColumn)).
		                         entry ]
]

{ #category : #callbacks }
BulkImportWizard >> deleteTempFileIfExists [

	| uploadedFile |
	uploadedFile := 'uploaded-file.csv' asFileReference.
	(uploadedFile notNil and: [ uploadedFile asFileReference exists ])
		ifTrue: [ uploadedFile asFileReference delete ]
]

{ #category : #accessing }
BulkImportWizard >> doiColumn [

	^ doiColumn
]

{ #category : #accessing }
BulkImportWizard >> doiColumn: anObject [

	doiColumn := anObject
]

{ #category : #callbacks }
BulkImportWizard >> initialize [

	super initialize.
	typeMappings := Dictionary new. 
]

{ #category : #callbacks }
BulkImportWizard >> proceedWithImport [

	typeMappings ifEmpty: [ ^ self ].
	bibtexEntriesFromFile isNil & dataRows notNil ifTrue: [
		({
			 typeColumn.
			 titleColumn.
			 authorColum.
			 affiliationsColumn.
			 abstractColumn.
			 doiColumn.
			 yearColumn.
			 urlColumn } includes: nil) ifTrue: [ ^ self ].
		self createBibtexEntriesFromRows ].
	newEntries ifNotNil: [
		newEntries do: [ :each |
			Radar singleton publications add: (Publication new
					 bibtexEntry: each;
					 yourself) ].
		self save.
		self answer: nil ]
]

{ #category : #callbacks }
BulkImportWizard >> readFile [

	dataRows := (NeoCSVReader on: 	'uploaded-file.csv' asFileReference readStream) upToEnd
		            asOrderedCollection.
	headerRow := dataRows  first.
	dataRows removeFirst.
]

{ #category : #callbacks }
BulkImportWizard >> receiveFile: aFile [

	| file |
	file := 'uploaded-file.csv' asFileReference.
	file exists ifTrue: [ file delete ].
	file binaryWriteStreamDo: [
		:uploadStream | uploadStream nextPutAll: aFile rawContents ]
]

{ #category : #rendering }
BulkImportWizard >> render: aBibtexEntry asCitationOn: html [

	html text: aBibtexEntry title , '. ' , aBibtexEntry author , ' ('
		, aBibtexEntry year , ')'
]

{ #category : #rendering }
BulkImportWizard >> renderColumnMapingSelectorsOn: html [

	| labelsToAspects |
	labelsToAspects := {
		                   ('Column that hold the type' -> #typeColumn).
		                   ('Column that holds the title' -> #titleColumn).
		                   ('Column that holds the author' -> #authorColum).
		                   ('Column that holds afiliations or countries'
		                    -> #affiliationsColumn).
		                   ('Column that holds the abstract'
		                    -> #abstractColumn).
		                   ('Column that holds the DOI' -> #doiColumn).
		                   ('Column that holds the year' -> #yearColumn).
		                   ('Column that holds the URL' -> #urlColumn) }.
	labelsToAspects do: [ :each |
		html formGroup: [
			html label: each key.
			html formSelect
				on: each value of: self;
				list: headerRow ] ]
]

{ #category : #rendering }
BulkImportWizard >> renderConfigurationFormOn: html [

	html form: [
		self renderColumnMapingSelectorsOn: html.
		typeColumn ifNotNil: [ self renderTypeMappingSelectorsOn: html ].
		self renderProceedCancelButtonsOn: html ]
]

{ #category : #rendering }
BulkImportWizard >> renderContentOn: html [

	dataRows ifNil: [ ^ self renderUploadFormOn: html ].
	bibtexEntriesFromFile ifNil: [
		^ self renderConfigurationFormOn: html ].
	self renderFinalImportReportOn: html
]

{ #category : #rendering }
BulkImportWizard >> renderFinalImportReportOn: html [

	| existingSignatures potentialDuplicates |
	existingSignatures := self radar publications collect: [ :each |
		                      self signatureFor: each ].
	potentialDuplicates := bibtexEntriesFromFile select: [ :each |
		                       existingSignatures includes:
			                       (self signatureFor: each) ].
	newEntries := bibtexEntriesFromFile copyWithoutAll:
		              potentialDuplicates.
	html paragraph: [
		html strong: 'The following new entries will be added.' ].
	html unorderedList: [
		newEntries do: [ :each |
			html listItem: [ self render: each asCitationOn: html ] ] ].
	html paragraph: [
		html strong:
			'The following new entries are considered duplicates and will be ignored.' ].
	html unorderedList: [
		potentialDuplicates do: [ :each |
			html listItem: [ self render: each asCitationOn: html ] ] ].
	html form: [ self renderProceedCancelButtonsOn: html ]
]

{ #category : #'rendering-buttons' }
BulkImportWizard >> renderProceedCancelButtonsOn: html [

	html break.
	html formButton
		callback: [ self proceedWithImport ];
		bePrimary;
		with: 'Proceed'.
	html space.
	^ html formButton
		  callback: [ self cancel ];
		  beSecondary;
		  with: 'Cancel'
]

{ #category : #'rendering-buttons' }
BulkImportWizard >> renderReadFileCancelButtonsOn: html [

	html break.
	html formButton
		callback: [ self readFile ];
		bePrimary;
		with: 'Submit'.
	html space.
	^ html formButton
		  callback: [ self cancel ];
		  beSecondary;
		  with: 'Cancel'
]

{ #category : #rendering }
BulkImportWizard >> renderTypeMappingSelectorsOn: html [

	self usedTypes do: [ :each |
		html formGroup: [
			html label: 'Type for "' , each , '"'.
			html formSelect
				callback: [ :value | typeMappings at: each put: value ];
				selected: [ typeMappings at: each ifAbsent: [ 'misc' ] ];
				list: { 'article'. 'inproceedings'. 'inbook'. 'misc' } ] ]
]

{ #category : #rendering }
BulkImportWizard >> renderUploadFormOn: html [

	html container: [
		html paragraph:
			'This form will add a list of articles to your review. '.
		html form
			multipart;
			with: [
				html formGroup: [
						html label
							for: 'file';
							with: 'File'.
						html break.
						html fileUpload
							callback: [ :value | self receiveFile: value ];
							id: 'file' ].
				self renderReadFileCancelButtonsOn: html ] ]
]

{ #category : #utility }
BulkImportWizard >> signatureFor: each [

	| basicTitle |
	basicTitle := each title asValidSelector asLowercase.
	^ basicTitle copyFrom: 1 to: (20 min: basicTitle size)
]

{ #category : #accessing }
BulkImportWizard >> titleColumn [

	^ titleColumn
]

{ #category : #accessing }
BulkImportWizard >> titleColumn: anObject [

	titleColumn := anObject
]

{ #category : #accessing }
BulkImportWizard >> typeColumn [
	^ typeColumn
]

{ #category : #accessing }
BulkImportWizard >> typeColumn: anObject [

	typeColumn := anObject
]

{ #category : #accessing }
BulkImportWizard >> urlColumn [

	^ urlColumn
]

{ #category : #accessing }
BulkImportWizard >> urlColumn: anObject [

	urlColumn := anObject
]

{ #category : #rendering }
BulkImportWizard >> usedTypes [

	| index |
	index := headerRow indexOf: typeColumn.
	^ dataRows collect: [ :each | each at: index ] as: Set
]

{ #category : #accessing }
BulkImportWizard >> yearColumn [

	^ yearColumn
]

{ #category : #accessing }
BulkImportWizard >> yearColumn: anObject [

	yearColumn := anObject
]
