Class {
	#name : #CountryPlotSubcomponent,
	#superclass : #PlotlySubcomponent,
	#instVars : [
		'publications',
		'counts'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #'javascript-examples' }
CountryPlotSubcomponent >> donutOn: script elementId: elementId [

	| plotly values labels |
	plotly := script plotly: elementId.
	values := (counts collect: #value) asArray.
	labels := (counts collect: #key) asArray.
	plotly
		data: { (PlotlyTrace pie
				 values: values;
				 propertyAt: 'textinfo' put: 'value'; 
				 hole: 0.4;
				 labels: labels) };
		layout: (PlotlyLayout new
				 yourself).
	plotly config beResponsive.
	script << plotly
]

{ #category : #'javascript-examples' }
CountryPlotSubcomponent >> publications: anObject [

	| countsDictionary |
	publications := anObject.
	countsDictionary := (publications
		                     flatCollect:  [ :each | each countries]
		                     as: Bag) valuesAndCounts.
	counts := countsDictionary associations asSortedCollection: [
		                :a
		                :b | a key < b key ].

	
]

{ #category : #'javascript-examples' }
CountryPlotSubcomponent >> renderContentOn: html [

	html div
		id: html nextId;
		with: [ "This is the container" ].

	html document addLoadScript:
		(JSStream on: (html jQuery script: [ :script |
				  self donutOn: script elementId: html lastId ]))
]
