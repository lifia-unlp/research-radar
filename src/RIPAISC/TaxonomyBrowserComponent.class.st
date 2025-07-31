Class {
	#name : #TaxonomyBrowserComponent,
	#superclass : #RipaiscAbstractComponent,
	#instVars : [
		'taxonomy',
		'selectedTopic',
		'label',
		'description',
		'parent'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #callbacks }
TaxonomyBrowserComponent >> addNewTopic [
	selectedTopic := Topic labeled: 'Undefined topic'.
	label := selectedTopic label.
	description := selectedTopic description. 
]

{ #category : #callbacks }
TaxonomyBrowserComponent >> cancel [
	selectedTopic := nil.
	label := nil.
	description := nil.
	parent := nil.
	
]

{ #category : #accessing }
TaxonomyBrowserComponent >> description [

	^ description
]

{ #category : #accessing }
TaxonomyBrowserComponent >> description: anObject [

	description := anObject
]

{ #category : #accessing }
TaxonomyBrowserComponent >> label [

	^ label
]

{ #category : #accessing }
TaxonomyBrowserComponent >> label: anObject [

	label := anObject
]

{ #category : #accessing }
TaxonomyBrowserComponent >> parent [

	^ parent
]

{ #category : #accessing }
TaxonomyBrowserComponent >> parent: anObject [

	parent := anObject
]

{ #category : #rendering }
TaxonomyBrowserComponent >> renderContentOn: html [

	html container: [
		html row: [
			html
				column: [
					self renderTaxonomyTopic: taxonomy on: html.
					html form: [
						html formButton
							callback: [ self addNewTopic ];
							bePrimary;
							beSmall;
							with: 'Add new topic' ] ]
				mediumSize: 6.
			html
				column: [
				selectedTopic ifNotNil: [ self renderTopicEditorFormOn: html ] ]
				mediumSize: 6 ] ]
]

{ #category : #rendering }
TaxonomyBrowserComponent >> renderTaxonomyTopic: aTopic on: html [

	html listItem: [
		aTopic == taxonomy
			ifTrue: [ html text: aTopic label ]
			ifFalse: [
				html anchor
					callback: [ self toggleSelectFor: aTopic ];
					with: [
						aTopic == selectedTopic
							ifTrue: [ html strong: aTopic label ]
							ifFalse: [ html text: aTopic label ] ] ].

		aTopic subtopics ifNotEmpty: [ :subtopics |
			html unorderedList: [
				subtopics do: [ :subtopic |
					self renderTaxonomyTopic: subtopic on: html ] ] ] ]
]

{ #category : #rendering }
TaxonomyBrowserComponent >> renderTopicEditorFormOn: html [

	html form: [
		html formGroup: [
			html label: 'Label'.
			html textInput formControl on: #label of: self ].
		html formGroup: [
			html label: 'Description'.
			html textArea formControl
				on: #description of: self;
				rows: 3 ].
		html formGroup: [
			html formSelect
				on: #parent of: self;
				list: self topicsToChooseFrom ].
		html formGroup: [
			html formButton
				callback: [ self accept ];
				bePrimary;
				beSmall;
				with: 'Accept'.
			html space.
			html formButton
				callback: [ self cancel ];
				beSecondary;
				beSmall;
				with: 'Cancel'.
			html space ] ]
]

{ #category : #accessing }
TaxonomyBrowserComponent >> taxonomy [

	^ taxonomy
]

{ #category : #accessing }
TaxonomyBrowserComponent >> taxonomy: anObject [

	taxonomy := anObject
]

{ #category : #rendering }
TaxonomyBrowserComponent >> toggleSelectFor: aTopic [

	selectedTopic == aTopic
		ifTrue: [ selectedTopic := nil ]
		ifFalse: [ selectedTopic := aTopic ]
]

{ #category : #rendering }
TaxonomyBrowserComponent >> topicsToChooseFrom [ 
	| topics |
	topics := OrderedCollection new. 
	taxonomy subtopics do: [ :each | each withSubtopicsOn: topics atLevel: 0 ].
	^topics
]
