Class {
	#name : #PublicationEditorComponent,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'publication',
		'title',
		'selfArchivingUrl',
		'url',
		'abstract',
		'authors',
		'year',
		'doi',
		'countries',
		'producedByRipaisc',
		'bibtexEntry',
		'applicationDomainsWithLevels',
		'topicsWithLevels',
		'relevanceToQse'
	],
	#category : #'ResearchRadar-seaside-components'
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

	publication ifNil: [ publication := Publication new ].
	bibtexEntry ifNotNil: [ publication bibtexEntry: bibtexEntry ].
	publication
		title: title;
		selfArchivingUrl: selfArchivingUrl;
		url: url;
		abstract: abstract;
		author: authors;
		year: year;
		doi: doi;
		countries: countries;
		topics: (topicsWithLevels collect: #value);
		applicationDomains: (applicationDomainsWithLevels collect: #value);
		relevanceToQse: relevanceToQse ;
		byRipaisc: producedByRipaisc.
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

{ #category : #accessing }
PublicationEditorComponent >> authors [

	^ authors
]

{ #category : #accessing }
PublicationEditorComponent >> authors: anObject [

	authors := anObject
]

{ #category : #private }
PublicationEditorComponent >> choose: elements fromElementsWithLevelsIn: elementsWithLevels [

	^ elementsWithLevels select: [ :each | elements includes: each value ]
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

{ #category : #accessing }
PublicationEditorComponent >> doi [

	^ doi
]

{ #category : #accessing }
PublicationEditorComponent >> doi: anObject [

	doi := anObject
]

{ #category : #callbacks }
PublicationEditorComponent >> fetchBibtex [

	doi ifNil: [ ^ self ].
	bibtexEntry := DoiOrgAPI new get: 'https://doi.org/' , doi.
	bibtexEntry ifNil: [
		title := 'Fetching failed'.
		year := 'Fetching failed'.
		authors := 'Fetching failed'.
		abstract := 'Fetching failed'.
		url := 'Fetching failed'.
		^ self ].
	bibtexEntry := bibtexEntry cleanupLatexAccentsAndBraces.
	title := bibtexEntry title.
	year := bibtexEntry year.
	authors := bibtexEntry author.
	abstract := bibtexEntry abstract.
	url := bibtexEntry url
]

{ #category : #accessing }
PublicationEditorComponent >> producedByRipaisc [

	^ producedByRipaisc
]

{ #category : #accessing }
PublicationEditorComponent >> producedByRipaisc: anObject [

	producedByRipaisc := anObject
]

{ #category : #accessing }
PublicationEditorComponent >> publication [

	^ publication
]

{ #category : #initialize }
PublicationEditorComponent >> publication: anObject [

	publication := anObject.
	title := publication title.
	abstract := publication abstract.
	year := publication year.
	doi := publication doi.
	url := publication url.
	authors := publication author.
	producedByRipaisc := publication byRipaisc.
	selfArchivingUrl := publication selfArchivingUrl.
	countries := publication countries.
	relevanceToQse := publication relevanceToQse .
	topicsWithLevels := self
		                    choose: publication topics
		                    fromElementsWithLevelsIn:
		                    self topicsToChooseFrom.
	applicationDomainsWithLevels := self
		                                choose:
		                                publication applicationDomains
		                                fromElementsWithLevelsIn:
		                                self applicationDomainsToChooseFrom.
	bibtexEntry := publication bibtexEntry
]

{ #category : #accessing }
PublicationEditorComponent >> relevanceToQse [

	^ relevanceToQse
]

{ #category : #accessing }
PublicationEditorComponent >> relevanceToQse: anObject [

	relevanceToQse := anObject
]

{ #category : #rendering }
PublicationEditorComponent >> renderContentOn: html [

	html container: [
		html form: [
			html formGroup: [
				html label: 'DOI'.
				publication ifNil: [
					html space.
					html outlineButton
						callback: [ self fetchBibtex ];
						bePrimary;
						beSmall;
						with: 'Fetch' ] ].
			html textInput formControl on: #doi of: self.


			html formGroup: [
				html label: 'Title'.
				html textInput formControl on: #title of: self ].


			html formGroup: [
				html label: 'Year'.
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
				html label: 'Abstract'.
				html textArea formControl
					on: #abstract of: self;
					rows: 15 ].

			html formGroup: [
				html label: 'URL'.
				html textInput formControl on: #url of: self ].

			html formGroup: [
				html label: 'Self archiving URL'.
				html textInput formControl on: #selfArchivingUrl of: self ].

			html formGroup: [
				html label: 'Iberoamerican countries'.
				html multiSelect formControl
					on: #countries of: self;
					size: 10;
					list: self countriesToChooseFrom ].

			html formGroup: [
				html label: 'Topics'.
				html multiSelect formControl
					on: #topicsWithLevels of: self;
					labels: [ :each |
						(String new: each key * 4 withAll: $.) , each value label ];
					size: 10;
					list: self topicsToChooseFrom ].

			html formGroup: [
				html label: 'Application domains'.
				html multiSelect formControl
					on: #applicationDomainsWithLevels of: self;
					labels: [ :each |
						(String new: each key * 4 withAll: $.) , each value label ];
					size: 10;
					list: self applicationDomainsToChooseFrom ].


			html formGroup: [
				html label: 'Relevance to QSE'.
				html formSelect
					on: #relevanceToQse of: self;
					list: self valuesForRelevanceToQse ].

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

{ #category : #accessing }
PublicationEditorComponent >> url [

	^ url
]

{ #category : #accessing }
PublicationEditorComponent >> url: anObject [

	url := anObject
]

{ #category : #rendering }
PublicationEditorComponent >> valuesForRelevanceToQse [

	^ { 'Clear'. 'Moderately clear'. 'Unclear'. nil }
]

{ #category : #accessing }
PublicationEditorComponent >> year [

	^ year
]

{ #category : #accessing }
PublicationEditorComponent >> year: anObject [

	year := anObject
]
