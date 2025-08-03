Class {
	#name : #RadarViewComponent,
	#superclass : #RipaiscAbstractComponent,
	#instVars : [
		'applicationDomainsTaxonomyPlotSubcomponent',
		'selectedTab',
		'publications',
		'countryPlotSubComponent',
		'publicationsListSubComponent',
		'topicsTaxonomyPlotSubComponent',
		'yearlyEvolutionPlotSubComponent',
		'taxonomySubcomponent'
	],
	#category : #'RIPAISC-seaside-components'
}

{ #category : #hooks }
RadarViewComponent >> children [

	^ {
		  yearlyEvolutionPlotSubComponent.
		  topicsTaxonomyPlotSubComponent.
		  applicationDomainsTaxonomyPlotSubcomponent.
		  countryPlotSubComponent.
		  publicationsListSubComponent.
		  taxonomySubcomponent }
]

{ #category : #initialization }
RadarViewComponent >> initialize [

	super initialize.
	self selectLatinamerica.
	yearlyEvolutionPlotSubComponent := YearlyEvolutionPlotSubComponent
		                                   new
		                                   parent: self;
		                                   groupByBlock:
			                                   [ :each | each countries ]
				                                   yourself.
	topicsTaxonomyPlotSubComponent := TaxonomyPlotSubComponent new
		                                  parent: self;
		                                  yourself.
	applicationDomainsTaxonomyPlotSubcomponent := TaxonomyPlotSubComponent
		                                              new
		                                              parent: self;
		                                              yourself.
	countryPlotSubComponent := CountryPlotSubComponent new
		                           parent: self;
		                           yourself.
	publicationsListSubComponent := PublicationsListSubComponent new
		                                parent: self;
		                                yourself.
	taxonomySubcomponent := TaxonomySubComponent new
]

{ #category : #hooks }
RadarViewComponent >> publishedCountries [

	^ (self radar publications flatCollectAsSet: [ :each |
		   each countries ]) asSortedCollection
]

{ #category : #rendering }
RadarViewComponent >> renderBriefTaxonomyOn: html [

	taxonomySubcomponent
		beBriefWithTaxonomy: self radar topicsTaxonomy
		and: publications.
	html render: taxonomySubcomponent
]

{ #category : #rendering }
RadarViewComponent >> renderContentOn: html [

	html container: [
		self renderNavBarOn: html.
		selectedTab = 'Latin America' ifTrue: [
			^ self renderGeneralOverviewOn: html ].
		selectedTab = 'RIPAISC' ifTrue: [
			^ self renderGeneralOverviewOn: html ].
		self renderOverviewForSelectedCountryOn: html ]
]

{ #category : #rendering }
RadarViewComponent >> renderFullTaxonomyOn: html [

	taxonomySubcomponent
		beFullWithTaxonomy: self radar topicsTaxonomy
		and: publications.
	html render: taxonomySubcomponent
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
				countryPlotSubComponent publications: publications.
				html render: countryPlotSubComponent ]
			mediumSize: 6.
		html
			column: [
				html strong: 'Evolution of publications'.
				yearlyEvolutionPlotSubComponent publications: publications.
				html render: yearlyEvolutionPlotSubComponent ]
			mediumSize: 6 ].
	^ html row: [
		  html
			  column: [
				  html strong: 'Publications by topic'.
				  topicsTaxonomyPlotSubComponent
					  publications: publications
					  taxonomy: self radar topicsTaxonomy
					  aspect: #topics.
				  html render: topicsTaxonomyPlotSubComponent ]
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
									with: 'Latin America';
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
	self renderBriefTaxonomyOn: html.
	self renderFullTaxonomyOn: html.
	publicationsListSubComponent publications: publications.
	"MAke publications be grouped by year, with a simple topic cloud in front of it"
	html render: publicationsListSubComponent
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

	self selectCountry: 'Latin America'.
	publications := self radar publications
]

{ #category : #callbacks }
RadarViewComponent >> selectRipaisc [

	self selectCountry: 'RIPAISC'.
	publications := self radar publications select: [ :each |
		                each byRipaisc ]
]
