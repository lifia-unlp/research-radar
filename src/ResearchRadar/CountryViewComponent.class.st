Class {
	#name : #CountryViewComponent,
	#superclass : #RadarViewComponent,
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #'accessing-urls' }
CountryViewComponent class >> baseUrl [

	^ 'country'
]

{ #category : #'accessing-url-parts' }
CountryViewComponent >> defaultFilter [

	^ menuSubcomponent countries 
		  ifEmpty: [ super defaultFilter ]
		  ifNotEmpty: [ menuSubcomponent countries first ]
]

{ #category : #rendering }
CountryViewComponent >> renderSpecificContentOn: html [

	| country |
	country := self filter. 
	html heading: country.
	self renderTotalCountOn: html.
	self renderBriefTaxonomyOn: html.
	self renderFullTaxonomyOn: html.
	publicationsListSubComponent publications: publications.
	"MAke publications be grouped by year, with a simple topic cloud in front of it"
	html render: publicationsListSubComponent
]

{ #category : #rendering }
CountryViewComponent >> selectedPublications [

	^ self radar publications select: [ :each |
		  (each countries collect: #asLowercase) includes:
			  self filter asLowercase ]
]
