Class {
	#name : #RadarViewComponent,
	#superclass : #RipaiscAbstractComponent,
	#instVars : [
		'yearlyEvolutionPlotSubcomponent'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #hooks }
RadarViewComponent >> children [

	^ { yearlyEvolutionPlotSubcomponent }
]

{ #category : #initialization }
RadarViewComponent >> initialize [

	super initialize.
	yearlyEvolutionPlotSubcomponent := YearlyEvolutionPlotSubcomponent
		                                   new
]

{ #category : #rendering }
RadarViewComponent >> publicationsCountsByYears [

	^ (self radar publications
		   collect: [ :each | each year asNumber ]
		   as: Bag) valuesAndCounts
]

{ #category : #rendering }
RadarViewComponent >> renderContentOn: html [

	yearlyEvolutionPlotSubcomponent countsDictionary:
		self publicationsCountsByYears.
	html render: yearlyEvolutionPlotSubcomponent
]
