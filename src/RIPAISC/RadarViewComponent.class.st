Class {
	#name : #RadarViewComponent,
	#superclass : #RipaiscAbstractComponent,
	#instVars : [
		'yearlyEvolutionPlotSubcomponent',
		'topicsTaxonomyPlotSubcomponent',
		'applicationDomainsTaxonomyPlotSubcomponent',
		'countryPlotSubcomponent'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #hooks }
RadarViewComponent >> children [

	^ {
		  yearlyEvolutionPlotSubcomponent.
		  topicsTaxonomyPlotSubcomponent.
		  applicationDomainsTaxonomyPlotSubcomponent.
		  countryPlotSubcomponent }
]

{ #category : #initialization }
RadarViewComponent >> initialize [

	super initialize.
	yearlyEvolutionPlotSubcomponent := YearlyEvolutionPlotSubcomponent
		                                   new.
	topicsTaxonomyPlotSubcomponent := TaxonomyPlotSubcomponent new.

	applicationDomainsTaxonomyPlotSubcomponent := TaxonomyPlotSubcomponent
		                                              new.
		
	countryPlotSubcomponent := CountryPlotSubcomponent new. 
]

{ #category : #rendering }
RadarViewComponent >> publicationsCountByApplicationDomains [

	^ (self radar publications
		   flatCollect: [ :each | each applicationDomains ]
		   as: Bag) valuesAndCounts
]

{ #category : #rendering }
RadarViewComponent >> publicationsCountByCountries [

	^ (self radar publications
		   flatCollect: [ :each | each countries ]
		   as: Bag) valuesAndCounts
]

{ #category : #rendering }
RadarViewComponent >> publicationsCountByTopics [

	^ (self radar publications
		   flatCollect: [ :each | each topics ]
		   as: Bag) valuesAndCounts
]

{ #category : #rendering }
RadarViewComponent >> publicationsCountByYears [

	^ (self radar publications
		   collect: [ :each | each year asNumber ]
		   as: Bag) valuesAndCounts
]

{ #category : #rendering }
RadarViewComponent >> renderContentOn: html [

	html container: [
		html strong: 'Evolution of publications'.
		yearlyEvolutionPlotSubcomponent countsDictionary:
			self publicationsCountByYears.
		html render: yearlyEvolutionPlotSubcomponent.
		
				html strong: 'Publications by country'.
		countryPlotSubcomponent
			counts: self publicationsCountByCountries
			countries: self radar countries.
		html render: countryPlotSubcomponent .

		html strong: 'Publications by topic'.
		topicsTaxonomyPlotSubcomponent
			counts: self publicationsCountByTopics
			taxonomy: self radar topicsTaxonomy.
		html render: topicsTaxonomyPlotSubcomponent.


		html strong: 'Publications by application domain'.
		applicationDomainsTaxonomyPlotSubcomponent
			counts: self publicationsCountByApplicationDomains
			taxonomy: self radar applicationDomainsTaxonomy.
		html render: applicationDomainsTaxonomyPlotSubcomponent ]
]
