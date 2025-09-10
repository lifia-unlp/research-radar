Class {
	#name : #RadarViewComponent,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'applicationDomainsTaxonomyPlotSubcomponent',
		'publications',
		'countryPlotSubComponent',
		'publicationsListSubComponent',
		'topicsTaxonomyPlotSubComponent',
		'yearlyEvolutionPlotSubComponent',
		'taxonomySubcomponent'
	],
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #publications }
RadarViewComponent >> allPublications [

	^ self radar publications
]

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

{ #category : #'accessing-properties' }
RadarViewComponent >> description [

	^ Radar radarProperties at: 'description'
]

{ #category : #initialization }
RadarViewComponent >> initialize [

	super initialize.
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

{ #category : #testing }
RadarViewComponent >> isStateless [
   ^true


]

{ #category : #'accessing-properties' }
RadarViewComponent >> networkName [

	^ Radar radarProperties at: 'network_name'
]

{ #category : #publications }
RadarViewComponent >> networkPublications [

	^ self allPublications select: [ :each | each byNetwork = true ]
]

{ #category : #'accessing-properties' }
RadarViewComponent >> projectName [

	^ Radar radarProperties at: 'project'
]

{ #category : #publications }
RadarViewComponent >> publicationsFor: aCountry [

	^ self radar publications select: [ :each |
		  (each countries collect: #asLowercase) includes:
			  aCountry asLowercase ]
]

{ #category : #private }
RadarViewComponent >> publishedCountries [

	^ (self allPublications flatCollectAsSet: [ :each | each countries ])
		  asSortedCollection
]

{ #category : #'accessing-properties' }
RadarViewComponent >> regionName [

	^ Radar radarProperties at: 'region'
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

	| selectedCountry selectedArea |
	selectedArea := self selectedArea.
	selectedCountry := (self publishedCountries includes: selectedArea)
		                   ifTrue: [ selectedArea ]
		                   ifFalse: [ nil ].
	html container: [
		self renderNavBarOn: html.

		selectedCountry ifNotNil: [
			publications := self publicationsFor: selectedCountry.
			self renderCountryOverviewFor: selectedCountry on: html.
			^ self ].

		selectedArea = self networkName ifTrue: [
			publications := self networkPublications.
			self renderRegionOverviewFor: self networkName on: html.
			^ self ].

		publications := self allPublications.
		self renderRegionOverviewFor: self regionName on: html ]
]

{ #category : #rendering }
RadarViewComponent >> renderCountryOverviewFor: aCountry on: html [

	html heading: aCountry.
	self renderTotalCountOn: html.
	self renderBriefTaxonomyOn: html.
	self renderFullTaxonomyOn: html.
	publicationsListSubComponent publications: publications.
	"MAke publications be grouped by year, with a simple topic cloud in front of it"
	html render: publicationsListSubComponent
]

{ #category : #rendering }
RadarViewComponent >> renderFullTaxonomyOn: html [

	taxonomySubcomponent
		beFullWithTaxonomy: self radar topicsTaxonomy
		and: publications.
	html render: taxonomySubcomponent
]

{ #category : #rendering }
RadarViewComponent >> renderNavBarOn: html [

	| bar id item |
	id := '#navbarCollapsed'.
	bar := html navigationBar.
	bar
		beLight;
		expandLarge.
	bar background beLight.
	bar with: [
		html navigationBarBrand: self projectName.

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
									url: (self urlForArea: self regionName);
									with: self regionName ;
									yourself ].
						html navigationItem with: [
							html navigationLink
								url: (self urlForArea: self networkName );
								with: self networkName ;
								yourself ].
						self publishedCountries do: [ :each |
							item := html navigationItem.
							item with: [
								html navigationLink
									url: (self urlForArea: each);
									with: each;
									yourself ] ] ] ] ]
]

{ #category : #rendering }
RadarViewComponent >> renderRegionOverviewFor: regionName on: html [

	html heading: regionName .
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

{ #category : #rendering }
RadarViewComponent >> renderTotalCountOn: html [

	html paragraph: [
		html
			strong: 'Article count: ';
			text: publications size greaseString ]
]

{ #category : #navigating }
RadarViewComponent >> selectedArea [

	| segments |
	segments := self requestContext request url path.
	segments size = 2 ifTrue: [ ^ segments second ].
	^ nil
]

{ #category : #rendering }
RadarViewComponent >> updateRoot: aWARoot [

	SBSDeploymentLibrary addLoadScriptTo: aWARoot
]

{ #category : #'accessing-properties' }
RadarViewComponent >> url [

	^ Radar radarProperties at: 'url'
]

{ #category : #rendering }
RadarViewComponent >> urlForArea: areaName [

	^ '/' , self requestContext request url path first , '/' , areaName
]
