Class {
	#name : #YearlyEvolutionPlotSubcomponent,
	#superclass : #PlotlySubcomponent,
	#instVars : [
		'sortedCounts',
		'startYear',
		'endYear',
		'publications'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #accessing }
YearlyEvolutionPlotSubcomponent >> publications: anObject [

	| countsDictionary |
	publications := anObject.
	countsDictionary := (publications
		                     collect: [ :each | each year asNumber ]
		                     as: Bag) valuesAndCounts.
	sortedCounts := countsDictionary associations asSortedCollection: [
		                :a
		                :b | a key < b key ].
	startYear := countsDictionary keys min.
	endYear := countsDictionary keys max
]

{ #category : #rendering }
YearlyEvolutionPlotSubcomponent >> renderContentOn: html [

	html div
		id: html nextId;
		with: [ "This is the container" ].

	html document addLoadScript:
		(JSStream on: (html jQuery script: [ :script | 
				  self setupScriptForScatterPlot: script elementId: html lastId ]))
]

{ #category : #rendering }
YearlyEvolutionPlotSubcomponent >> setupScriptForScatterPlot: script elementId: elementId [

	| plotly data |
	plotly := script plotly: elementId.
	data := nil.
	sortedCounts ifNotEmpty: [
		data := Array with: (PlotlyTrace scatter
				         showlegend: true;
				         x: (startYear to: endYear) asArray;
				         y: (sortedCounts collect: #value);
				         yourself) ].

	plotly
		data: data;
		layout: (PlotlyLayout new
				 width: 500 height: 400;
				 propertyAt: 'xaxis' put: (Dictionary new
						  at: 'type' put: 'category';
						  yourself);
				 yourself).
	plotly config beResponsive.
	script << plotly
]
