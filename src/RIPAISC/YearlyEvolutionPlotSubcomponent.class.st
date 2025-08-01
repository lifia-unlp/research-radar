Class {
	#name : #YearlyEvolutionPlotSubcomponent,
	#superclass : #WAComponent,
	#instVars : [
		'title',
		'sortedCounts',
		'startYear',
		'endYear'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #accessing }
YearlyEvolutionPlotSubcomponent >> countsDictionary: countsDictionary [

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
				         name: title;
				         showlegend: true;
				         x: (startYear to: endYear) asArray;
				         y: (sortedCounts collect: #value);
				         yourself) ].

	plotly
		data: data;
		layout: (PlotlyLayout new
				 title: (PlotlyText text: title);
				 width: 1000 height: 500;
				 propertyAt: 'xaxis' put: (Dictionary new
						  at: 'type' put: 'category';
						  yourself);
				 yourself).
	plotly config beResponsive.
	script << plotly
]

{ #category : #accessing }
YearlyEvolutionPlotSubcomponent >> title [

	^ title
]

{ #category : #accessing }
YearlyEvolutionPlotSubcomponent >> title: anObject [

	title := anObject
]

{ #category : #rendering }
YearlyEvolutionPlotSubcomponent >> updateRoot: aWARoot [

	super updateRoot: aWARoot.
	aWARoot javascript url: 'https://cdn.plot.ly/plotly-2.4.2.min.js'
]
