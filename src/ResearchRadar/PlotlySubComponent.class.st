Class {
	#name : #PlotlySubComponent,
	#superclass : #RadarAbstractSubComponent,
	#category : #'ResearchRadar-seaside-subcomponents'
}

{ #category : #rendering }
PlotlySubComponent >> updateRoot: aWARoot [

	super updateRoot: aWARoot.
	aWARoot javascript url: 'https://cdn.plot.ly/plotly-2.4.2.min.js'
]
