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
	html heading: selectedTab .
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
				yearlyEvolutionPlotSubcomponent publications:
					publications.
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
	self renderTopicFrequencyOn: html.
	publicationsListSubcomponent publications: publications.
	html render: publicationsListSubcomponent
]

{ #category : #rendering }
RadarViewComponent >> renderTopicFrequencyOn: html [

	| counts |

	counts := (publications flatCollect: #topics as: Bag) valuesAndCounts
		          associations asSortedCollection: [ :a :b |
		          a value > b value ].
	html paragraph: [
		html
			strong: 'Topic frequency: ';
			text: (counts collect: [ :each |
						 each key label , ' (' , each value greaseString , ')' ])
					asCommaStringAnd ]
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
