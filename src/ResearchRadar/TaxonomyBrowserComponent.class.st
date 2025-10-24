Class {
	#name : #TaxonomyBrowserComponent,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'taxonomy',
		'publicationsRetrievingBlock',
		'label',
		'description',
		'selectedParentTopicWithLevel',
		'selectedTopic',
		'publicationsListSubcomponent'
	],
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #callbacks }
TaxonomyBrowserComponent >> accept [

	selectedTopic label: label.
	selectedTopic description: description.
	self
		changeParentOf: selectedTopic
		to: selectedParentTopicWithLevel value.
	self  save.
]

{ #category : #callbacks }
TaxonomyBrowserComponent >> addNewTopic [

	selectedTopic := Topic labeled: 'Undefined topic'.
	label := selectedTopic label.
	description := nil.
	selectedParentTopicWithLevel := 0 -> taxonomy
]

{ #category : #callbacks }
TaxonomyBrowserComponent >> cancel [

	selectedTopic := nil.
	label := nil.
	description := nil.
	selectedParentTopicWithLevel := nil
]

{ #category : #callbacks }
TaxonomyBrowserComponent >> changeParentOf: aTopic to: parentTopic [

	(parentTopic subtopics includes: aTopic) ifTrue: [ ^ self ].
	taxonomy removeSubtopic: aTopic.
	parentTopic addSubtopic: aTopic
]

{ #category : #rendering }
TaxonomyBrowserComponent >> children [

	^ { publicationsListSubcomponent }
]

{ #category : #callbacks }
TaxonomyBrowserComponent >> deleteSelectedTopic [

	taxonomy removeSubtopic: selectedTopic.
	self select: nil. 
	self  save.
]

{ #category : #accessing }
TaxonomyBrowserComponent >> description [

	^ description
]

{ #category : #accessing }
TaxonomyBrowserComponent >> description: anObject [

	description := anObject
]

{ #category : #initialize }
TaxonomyBrowserComponent >> initialize [

	super initialize.
	publicationsListSubcomponent := PublicationsListSubComponent parent:
		                                self.
	publicationsListSubcomponent parent: self
]

{ #category : #accessing }
TaxonomyBrowserComponent >> label [

	^ label
]

{ #category : #accessing }
TaxonomyBrowserComponent >> label: anObject [

	label := anObject
]

{ #category : #callbacks }
TaxonomyBrowserComponent >> moveBackwards: aTopic [
	taxonomy moveBackwards: aTopic
]

{ #category : #callbacks }
TaxonomyBrowserComponent >> moveForward: aTopic [
	taxonomy moveForward: aTopic
]

{ #category : #accessing }
TaxonomyBrowserComponent >> publicationsForSelectedTopic [

	publicationsRetrievingBlock ifNil: [ ^ Set new ].
	^ publicationsRetrievingBlock value select: [ :each |
		  each topics , each applicationDomains includes: selectedTopic ]
]

{ #category : #accessing }
TaxonomyBrowserComponent >> publicationsRetrievingBlock: anObject [

	publicationsRetrievingBlock := anObject
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
					selectedTopic ifNotNil: [
						self renderTopicEditorFormOn: html.
						self renderPublicationsForSelectedTopicOn: html ] ]
				mediumSize: 6 ] ]
]

{ #category : #rendering }
TaxonomyBrowserComponent >> renderEditorButtonsOn: html [

	^ html formGroup: [
		  html row: [
			  html
				  column: [
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
						  with: 'Cancel' ]
				  mediumSize: 6.

			  html
				  column: [
					  html space.
					  html outlineButton
						  callback: [ self deleteSelectedTopic ];
						  beDanger;
						  beSmall;
						  with: 'Delete' ]
				  mediumSize: 6 ] ]
]

{ #category : #rendering }
TaxonomyBrowserComponent >> renderMoveControlsFor: aTopic on: html [

	html space.
	html anchor
		callback: [ self moveBackwards: aTopic ];
		with: '[Up]'.
	html space.
	html anchor
		callback: [ self moveForward: aTopic ];
		with: '[Down]'
]

{ #category : #rendering }
TaxonomyBrowserComponent >> renderPublicationsForSelectedTopicOn: html [

	self publicationsForSelectedTopic ifNotEmpty: [ :pubs |
		html break.
		publicationsListSubcomponent publications: pubs.
		html render: publicationsListSubcomponent ]
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
		self renderMoveControlsFor: aTopic on: html.
		html break.
		html text: aTopic description.

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
			html label: 'Description'.
			html formSelect
				on: #selectedParentTopicWithLevel of: self;
				labels: [ :each |
					(String new: each key * 4 withAll: $.) , each value label ];
				list: self topicsToChooseFrom ].
		self renderEditorButtonsOn: html ]
]

{ #category : #callbacks }
TaxonomyBrowserComponent >> select: anObjectOrNil [

	selectedTopic := anObjectOrNil.
	selectedTopic
		ifNil: [
			selectedParentTopicWithLevel := nil.
			label := nil.
			description := nil ]
		ifNotNil: [
			label := selectedTopic label.
			description := selectedTopic description.
			selectedParentTopicWithLevel := self topicsToChooseFrom
				                                detect: [ :each |
				                                each value
				                                ==
				                                (taxonomy parentOf: selectedTopic) ]
				                                ifNone: [ nil ] ]
]

{ #category : #accessing }
TaxonomyBrowserComponent >> selectedParentTopicWithLevel [

	^ selectedParentTopicWithLevel
]

{ #category : #accessing }
TaxonomyBrowserComponent >> selectedParentTopicWithLevel: anObject [

	selectedParentTopicWithLevel := anObject
]

{ #category : #accessing }
TaxonomyBrowserComponent >> taxonomy: anObject [

	taxonomy := anObject
]

{ #category : #callbacks }
TaxonomyBrowserComponent >> toggleSelectFor: aTopic [

	selectedTopic == aTopic
		ifTrue: [ self select: nil ]
		ifFalse: [ self select: aTopic ]
]

{ #category : #rendering }
TaxonomyBrowserComponent >> topicsToChooseFrom [

	| topics |
	topics := OrderedCollection with: 0 -> taxonomy.
	taxonomy subtopics do: [ :each |
		each withSubtopicsOn: topics atLevel: 1 ].
	^ topics
]
