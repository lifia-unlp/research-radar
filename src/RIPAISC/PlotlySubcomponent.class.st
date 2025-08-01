Class {
	#name : #PlotlySubcomponent,
	#superclass : #RipaiscAbstractSubComponent,
	#category : #'RIPAISC-seaside'
}

{ #category : #rendering }
PlotlySubcomponent >> updateRoot: aWARoot [

	super updateRoot: aWARoot.
	aWARoot javascript url: 'https://cdn.plot.ly/plotly-2.4.2.min.js'
]
