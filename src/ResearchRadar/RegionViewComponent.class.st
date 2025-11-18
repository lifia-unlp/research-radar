Class {
	#name : #RegionViewComponent,
	#superclass : #RadarViewComponent,
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #'accessing-urls' }
RegionViewComponent class >> baseUrl [

	^ 'region'
]

{ #category : #rendering }
RegionViewComponent >> defaultFilter [

	^ menuSubcomponent regions
		  ifEmpty: [ super defaultFilter ]
		  ifNotEmpty: [ menuSubcomponent regions first ]
]

{ #category : #rendering }
RegionViewComponent >> renderSpecificContentOn: html [

	| region |
	region := self filter.
	html heading: region.
	html paragraph: [
		html strong:
			'Total number of  publications: ' , publications size greaseString ].
	self renderPlotsOn: html.
	html row: [
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
RegionViewComponent >> selectedPublications [

	self filter = self defaultFilter ifFalse: [
		^ self allPublications select: [ :each | "It could be nill"
			  each byNetwork = true ] ].
	^ self allPublications
]
