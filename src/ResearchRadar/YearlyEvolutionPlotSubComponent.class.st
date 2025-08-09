Class {
	#name : #YearlyEvolutionPlotSubComponent,
	#superclass : #PlotlySubComponent,
	#instVars : [
		'groupByBlock',
		'publications',
		'collectionsOfNamedCounts',
		'includeTotalCount'
	],
	#category : #'ResearchRadar-seaside-subcomponents'
}

{ #category : #accessing }
YearlyEvolutionPlotSubComponent >> groupByBlock: anObject [

	groupByBlock := anObject
]

{ #category : #initialization }
YearlyEvolutionPlotSubComponent >> initialize [

	super initialize.
	groupByBlock := [ :each | Set with: '' ].
	includeTotalCount := true.
]

{ #category : #rendering }
YearlyEvolutionPlotSubComponent >> plotlyTraceFor: titleToCollectionOfAssociations from: startYear to: endYear [

	| yearlyCounts counts title |
	title := titleToCollectionOfAssociations key.
	yearlyCounts := titleToCollectionOfAssociations value asDictionary.
	counts := (startYear to: endYear) collect: [ :year |
		          yearlyCounts at: year ifAbsent: [ 0 ] ].


	^ PlotlyTrace scatter
		  name: title;
		  showlegend: title isEmptyOrNil not;
		  x: (startYear to: endYear) asArray;
		  y: counts asArray;
		  yourself
]

{ #category : #accessing }
YearlyEvolutionPlotSubComponent >> publications: anObject [

	publications := anObject.
	collectionsOfNamedCounts := OrderedCollection new.
	self updateCollectionOfNamedCounts
]

{ #category : #rendering }
YearlyEvolutionPlotSubComponent >> renderContentOn: html [

	html div
		id: html nextId;
		with: [ "This is the container" ].

	html document addLoadScript:
		(JSStream on: (html jQuery script: [ :script | 
				  self setupScriptForScatterPlot: script elementId: html lastId ]))
]

{ #category : #rendering }
YearlyEvolutionPlotSubComponent >> setupScriptForScatterPlot: script elementId: elementId [

	| plotly traces years |
	plotly := script plotly: elementId.
	years := (collectionsOfNamedCounts  flatCollect: [ :each |
		         each value collect: #key ]) .
	traces := nil.
	years ifNotEmpty: [
		traces := collectionsOfNamedCounts collect: [ :each |
			        self plotlyTraceFor: each from: years min to: years max ] ].
	plotly
		data: traces;
		layout: (PlotlyLayout new
			"	 title: (PlotlyText text: 'Title');"
			"	 width: 500 height: 500;"
				 propertyAt: 'xaxis' put: (Dictionary new
						  at: 'type' put: 'category';
						  yourself);
				 yourself).
	plotly config beResponsive.
	script << plotly
]

{ #category : #utility }
YearlyEvolutionPlotSubComponent >> updateCollectionOfNamedCounts [

	| groups |
	groups := publications flatCollectAsSet: groupByBlock.
	collectionsOfNamedCounts := groups collect: [ :group |
		                            | selection |
		                            selection := publications select: [
			                                         :each |
			                                         (groupByBlock value: each)
				                                         includes: group ].
		                            group
		                            -> (self yearlyCountsFor: selection) ].

	collectionsOfNamedCounts := collectionsOfNamedCounts
		                            asSortedCollection: [ :a :b |
		                            (a value sumNumbers: #value)
		                            > (b value sumNumbers: #value) ].
	collectionsOfNamedCounts := collectionsOfNamedCounts
		                            asOrderedCollection.
	collectionsOfNamedCounts add:
		'Total' -> (self yearlyCountsFor: publications)
]

{ #category : #utility }
YearlyEvolutionPlotSubComponent >> yearlyCountsFor: somePublications [

	^ (somePublications
		   collect: [ :each |
			   [ each year asNumber ]
				   on: Error
				   do: [ 0 ] ]
		   as: Bag) valuesAndCounts associations asSortedCollection: [ :a :b |
		  a key < b key ]
]
