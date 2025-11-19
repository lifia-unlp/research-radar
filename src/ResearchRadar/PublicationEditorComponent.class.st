Class {
	#name : #PublicationEditorComponent,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'publication',
		'countries',
		'applicationDomainsWithLevels',
		'topicsWithLevels',
		'producedByNetwork',
		'relevanceToTopic',
		'bibtexEntry',
		'networkNodes'
	],
	#category : #'ResearchRadar-seaside-backend'
}

{ #category : #callbacks }
PublicationEditorComponent >> accept [

	bibtexEntry title isEmpty | bibtexEntry author isEmpty
	| bibtexEntry year isEmpty ifTrue: [ ^ self ].

	publication ifNil: [ publication := Publication new ].
	bibtexEntry ifNotNil: [ :it | publication bibtexEntry: it ].
	publication
		countries: countries;
		topics: (topicsWithLevels collect: #value);
		applicationDomains: (applicationDomainsWithLevels collect: #value);
		relevanceToTopic: relevanceToTopic;
		networkNodes: networkNodes.
	self answer: publication
]

{ #category : #rendering }
PublicationEditorComponent >> applicationDomainsToChooseFrom [

	^ self radar applicationDomainsTaxonomy subtopicsWithLevels
]

{ #category : #accessing }
PublicationEditorComponent >> applicationDomainsWithLevels [

	^ applicationDomainsWithLevels
]

{ #category : #accessing }
PublicationEditorComponent >> applicationDomainsWithLevels: anObject [

	applicationDomainsWithLevels := anObject
]

{ #category : #private }
PublicationEditorComponent >> choose: elements fromElementsWithLevelsIn: elementsWithLevels [

	^ elementsWithLevels select: [ :each | elements includes: each value ]
]

{ #category : #initialize }
PublicationEditorComponent >> choose: nodes fromGroupsIn: groups [

	| groupNames |
	groupNames := nodes
		              ifNil: [ OrderedCollection new ]
		              ifNotNil: [ :it | it collect: #fullName ].
	^ self radar groups select: [ :each |
		  groupNames includes: each fullName ]
]

{ #category : #accessing }
PublicationEditorComponent >> countries [

	^ countries
]

{ #category : #accessing }
PublicationEditorComponent >> countries: anObject [

	countries := anObject
]

{ #category : #rendering }
PublicationEditorComponent >> countriesToChooseFrom [

	^ self radar countries
]

{ #category : #callbacks }
PublicationEditorComponent >> editBibtexEntry [

	| bibtexChunckImportComponent result |
	bibtexChunckImportComponent := BibtexChunckImportComponent new.
	bibtexChunckImportComponent bibtexEntry:
		(PPBibtexParser new end parse: publication bibtexEntry printString)
			first.
	result := self call: bibtexChunckImportComponent.
	result ifNotNil: [ :it | bibtexEntry := it ]
]

{ #category : #rendering }
PublicationEditorComponent >> grandTopic [

	^ self radar topicsTaxonomy label
]

{ #category : #accessing }
PublicationEditorComponent >> networkNodes [

	^ networkNodes
]

{ #category : #accessing }
PublicationEditorComponent >> networkNodes: anObject [

	networkNodes := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> producedByNetwork [

	^ producedByNetwork
]

{ #category : #accessing }
PublicationEditorComponent >> producedByNetwork: anObject [

	producedByNetwork := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> publication [

	^ publication
]

{ #category : #initialize }
PublicationEditorComponent >> publication: anObject [

	publication := anObject.
	bibtexEntry := publication bibtexEntry .

	producedByNetwork := publication byNetwork.
	countries := publication countries.
	relevanceToTopic := publication relevanceToTopic.
	topicsWithLevels := self
		                    choose: publication topics
		                    fromElementsWithLevelsIn:
		                    self topicsToChooseFrom.
	applicationDomainsWithLevels := self
		                                choose:
		                                publication applicationDomains
		                                fromElementsWithLevelsIn:
		                                self applicationDomainsToChooseFrom.
	networkNodes := self choose: publication networkNodes fromGroupsIn: self radar groups.
]

{ #category : #accessing }
PublicationEditorComponent >> relevanceToTopic [

	^ relevanceToTopic
]

{ #category : #accessing }
PublicationEditorComponent >> relevanceToTopic: anObject [

	relevanceToTopic := anObject
]

{ #category : #rendering }
PublicationEditorComponent >> renderBibtexEntryOn: html [

	html preformatted: [
		html
			text: '@';
			text: bibtexEntry type;
			text: '{';
			text: bibtexEntry citationKey;
			text: ',';
			break.
		bibtexEntry tags do: [ :tag |
			html space.
			html
				text: tag name;
				text: ' = {';
				text: tag value;
				text: '},';
				break ].
		html text: '}'.
		html break.
		html anchor
			callback: [ self editBibtexEntry ];
			with: 'Edit' ]
]

{ #category : #rendering }
PublicationEditorComponent >> renderContentOn: html [

	| groupDisplayBlock |
	groupDisplayBlock := [ :group |
	                     group country , ' - ' , group fullName , ' ('
	                     , group acronym , ')' ].

	html container: [
		self renderBibtexEntryOn: html.
		html form: [
			html formGroup: [
				html label: 'Relevance to ' , self grandTopic.
				html formSelect
					on: #relevanceToTopic of: self;
					list: self valuesForRelevanceToQse ].
			html break.

			html formGroup: [
				html label: 'Iberoamerican countries'.
				html multiSelect formControl
					on: #countries of: self;
					size: 10;
					list: self countriesToChooseFrom ].
			html break.
			html formGroup: [
				html label: 'Network groups'.
				html multiSelect formControl
					on: #networkNodes of: self;
					labels: groupDisplayBlock;
					size: 10;
					list: (self radar groups asSortedCollection: [ :a :b |
								 (groupDisplayBlock value: a) <= (groupDisplayBlock value: b) ]) ].
			html break.

			html formGroup: [
				html label: 'Topics'.
				html multiSelect formControl
					on: #topicsWithLevels of: self;
					labels: [ :each |
						(String new: each key * 4 withAll: $.) , each value label ];
					size: 10;
					list: self topicsToChooseFrom ].
			html break.
			html formGroup: [
				html label: 'Application domains'.
				html multiSelect formControl
					on: #applicationDomainsWithLevels of: self;
					labels: [ :each |
						(String new: each key * 4 withAll: $.) , each value label ];
					size: 10;
					list: self applicationDomainsToChooseFrom ].
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

{ #category : #rendering }
PublicationEditorComponent >> topicsToChooseFrom [

	^ self radar topicsTaxonomy subtopicsWithLevels
]

{ #category : #accessing }
PublicationEditorComponent >> topicsWithLevels [

	^ topicsWithLevels
]

{ #category : #accessing }
PublicationEditorComponent >> topicsWithLevels: anObject [

	topicsWithLevels := anObject
]

{ #category : #rendering }
PublicationEditorComponent >> valuesForRelevanceToQse [

	^ { 'Clear'. 'Moderately clear'. 'Unclear'. nil }
]
