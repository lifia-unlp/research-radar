Class {
	#name : #RadarAbstractComponent,
	#superclass : #WAComponent,
	#instVars : [
		'caller'
	],
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #accessing }
RadarAbstractComponent class >> caller: aComponent [

	^ self new
		  caller: aComponent;
		  yourself
]

{ #category : #accessing }
RadarAbstractComponent >> caller [

	^ caller
]

{ #category : #accessing }
RadarAbstractComponent >> caller: anObject [

	caller := anObject
]

{ #category : #'save-restore' }
RadarAbstractComponent >> radar [

 ^ Radar singleton. 
]

{ #category : #updating }
RadarAbstractComponent >> rendererClass [
	^ SBSHtmlCanvas
]

{ #category : #'save-restore' }
RadarAbstractComponent >> save [

	Radar save
]

{ #category : #updating }
RadarAbstractComponent >> updateRoot: aWARoot [
	super updateRoot: aWARoot.
	aWARoot
		beHtml5;
		title: 'Radar RIPAISC'.
	aWARoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1.0'.

]
