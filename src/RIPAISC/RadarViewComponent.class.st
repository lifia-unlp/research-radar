Class {
	#name : #RadarViewComponent,
	#superclass : #RipaiscAbstractComponent,
	#instVars : [
		'yearlyEvolutionPlotSubcomponent',
		'topicsTaxonomyPlotSubcomponent',
		'applicationDomainsTaxonomyPlotSubcomponent',
		'countryPlotSubcomponent',
		'selectedTab',
		'publications',
		'publicationsListSubcomponent'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #hooks }
RadarViewComponent >> children [

	^ {
		  yearlyEvolutionPlotSubcomponent.
		  topicsTaxonomyPlotSubcomponent.
		  applicationDomainsTaxonomyPlotSubcomponent.
		  countryPlotSubcomponent . publicationsListSubcomponent }
]

{ #category : #initialization }
RadarViewComponent >> initialize [

	super initialize.
	self selectLatinamerica.
	yearlyEvolutionPlotSubcomponent := YearlyEvolutionPlotSubcomponent
		                                   new
		                                   parent: self;
		groupByBlock: [ :each | each countries ]
		                                   yourself.
	topicsTaxonomyPlotSubcomponent := TaxonomyPlotSubcomponent new
		                                  parent: self;
		                                  yourself.

	applicationDomainsTaxonomyPlotSubcomponent := TaxonomyPlotSubcomponent
		                                              new
		                                              parent: self;
		                                              yourself.

	countryPlotSubcomponent := CountryPlotSubcomponent new
		                           parent: self;
		                           yourself.
	publicationsListSubcomponent := PublicationsListSubComponent new
		                                parent: self;
		                                yourself
]

{ #category : #hooks }
RadarViewComponent >> publishedCountries [

	^ (self radar publications flatCollectAsSet: [ :each |
		   each countries ]) asSortedCollection
]

{ #category : #rendering }
RadarViewComponent >> renderContentOn: html [

	html container: [
		self renderNavBarOn: html.
		selectedTab = 'Latinamerica' ifTrue: [
			^ self renderGeneralOverviewOn: html ].
		selectedTab = 'RIPAISC' ifTrue: [
			^ self renderGeneralOverviewOn: html ].
		self renderOverviewForSelectedCountryOn: html ]
]

{ #category : #rendering }
RadarViewComponent >> renderGeneralOverviewOn: html [

	html heading: selectedTab.
	html paragraph: [
		html strong:
			'Total number of  publications: ' , publications size greaseString ].
	html row: [
		html
			column: [
				html strong: 'Publications by country'.
				countryPlotSubcomponent publications: publications.
				html render: countryPlotSubcomponent ]
			mediumSize: 6.
		html
			column: [
				html strong: 'Evolution of publications'.
				yearlyEvolutionPlotSubcomponent publications: publications.
				html render: yearlyEvolutionPlotSubcomponent ]
			mediumSize: 6 ].
	^ html row: [
		  html
			  column: [
				  html strong: 'Publications by topic'.
				  topicsTaxonomyPlotSubcomponent
					  publications: publications
					  taxonomy: self radar topicsTaxonomy
					  aspect: #topics.
				  html render: topicsTaxonomyPlotSubcomponent ]
			  mediumSize: 6.
		  html
			  column: [
				  html strong: 'Publications by application domain'.
				  applicationDomainsTaxonomyPlotSubcomponent
					  publications: publications
					  taxonomy: self radar applicationDomainsTaxonomy
					  aspect: #applicationDomains.
				  html render: applicationDomainsTaxonomyPlotSubcomponent ]
			  mediumSize: 6 ]
]

{ #category : #rendering }
RadarViewComponent >> renderHierarchicalTopicFrequencyOn: html [

	| counts |
	counts := (self radar topicsTaxonomy subtopics collect: [ :each |
		           TopicProductCount topic: each publications: publications ])
		          asSortedCollection: [ :a :b |
		          a familyCount > b familyCount ].

	html paragraph: [
		html text: (counts collect: [ :each |
				 each topic label , ' (' , each familyCount greaseString , ')' ])
				asCommaStringAnd ]
]

{ #category : #hooks }
RadarViewComponent >> renderNavBarOn: html [

	| bar id item |
	id := '#navbarCollapsed'.
	bar := html navigationBar.
	bar
		beLight;
		expandLarge.
	bar background beLight.
	bar with: [
		html navigationBarBrand: 'RIPAISC radar'.

		"The toggler that is only visible when reducing the width of screen"
		html navigationBarToggler
			beButtonType;
			collapse;
			dataTarget: id;
			with: [ html navigationBarTogglerIcon ].

		html navigationBarCollapse collapse
			id: 'navbarCollapsed';
			with: [
				html navigationBarNavigation: [
						html navigationItem with: [
								html navigationLink
									callback: [ self selectLatinamerica ];
									with: 'Latinamerica';
									yourself ].
						html navigationItem with: [
							html navigationLink
								callback: [ self selectRipaisc ];
								with: 'RIPAISC';
								yourself ].
						self publishedCountries do: [ :each |
							item := html navigationItem.
							item with: [
								html navigationLink
									callback: [ self selectCountry: each ];
									with: each;
									yourself ] ] ] ] ]
]

{ #category : #rendering }
RadarViewComponent >> renderOverviewForSelectedCountryOn: html [

	html heading: selectedTab.
	self renderTotalCountOn: html.
	self renderHierarchicalTopicFrequencyOn: html.
	self renderTopicFrequencyOn: html.
	publicationsListSubcomponent publications: publications.
	html render: publicationsListSubcomponent
]

{ #category : #rendering }
RadarViewComponent >> renderTopicFrequencyOn: html [

	| counts organizedTopics |
	organizedTopics := self radar topicsTaxonomy withSubtopics.
	organizedTopics remove: self radar topicsTaxonomy.

	counts := organizedTopics collect: [ :each |
		          TopicProductCount topic: each publications: publications ].

	html paragraph: [
		counts
			do: [ :each |
				| text elem |
				text := each topic label , '(' , each ownCount greaseString , '/'
				        , each familyCount greaseString , ')'.
				elem := html span.
				each familyCount = 0
					ifTrue: [ elem class: 'tagcloud-light' ]
					ifFalse: [
						each familyCount <= 5
							ifTrue: [ elem class: 'tagcloud-medium' ]
							ifFalse: [ elem class: 'tagcloud-dark' ] ].
				elem with: each topic label ]
			separatedBy: [ html text: ', ' ] ]
]

{ #category : #rendering }
RadarViewComponent >> renderTotalCountOn: html [

	html paragraph: [
		html
			strong: 'Article count: ';
			text: publications size greaseString ]
]

{ #category : #callbacks }
RadarViewComponent >> selectCountry: aCountryName [

	selectedTab := aCountryName.
	publications := self radar publications select: [ :each |
		                each countries includes: aCountryName ]
]

{ #category : #callbacks }
RadarViewComponent >> selectLatinamerica [

	self selectCountry: 'Latinamerica'.
	publications := self radar publications
]

{ #category : #callbacks }
RadarViewComponent >> selectRipaisc [

	self selectCountry: 'RIPAISC'.
	publications := self radar publications select: [ :each |
		                each byRipaisc ]
]

{ #category : #callbacks }
RadarViewComponent >> style [

	^ '.tagcloud-light {
  color: #d0dcf2; 
}

.tagcloud-medium {
  color: #97c0f4; 
}

.tagcloud-dark {
  color: #073b92; 
}'
]
