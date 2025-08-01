Class {
	#name : #CountryPlotSubcomponent,
	#superclass : #WAComponent,
	#instVars : [
		'title',
		'counts',
		'countries'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #'as yet unclassified' }
CountryPlotSubcomponent >> counts: theCounts countries: theCountries [

	counts := theCounts associations.
	countries := theCountries
]

{ #category : #'javascript-examples' }
CountryPlotSubcomponent >> donutOn: script elementId: elementId [

	| plotly values labels |
	plotly := script plotly: elementId.
	values := (counts collect: #value) asArray.
	labels := (counts collect: #key) asArray.
	plotly
		data: { (PlotlyTrace pie
				 values: values;
				 hole: 0.4;
				 labels: labels) };
		layout: (PlotlyLayout new
				 title: (PlotlyText text: 'Donut Chart');
				 width: 500 height: 300;
				 yourself).
	plotly config beResponsive.
	script << plotly
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

{ #category : #'javascript-examples' }
CountryPlotSubcomponent >> scriptExampleDonutOn: script elementId: elementId [

  | plotly |
  plotly := script plotly: elementId.
  plotly
    data:
      {(PlotlyTrace pie
        values: #(19 , 26 , 55);
        hole: 0.4;
        labels: #('Residential' , 'Non-Residential' , 'Utility'))};
    layout:
      (PlotlyLayout new
        title: (PlotlyText text: 'Donut Chart');
        width: 500 height: 300;
        yourself).
  plotly config beResponsive.
  script << plotly
]
