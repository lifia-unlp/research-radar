Class {
	#name : #RipaiscAbstractComponent,
	#superclass : #WAComponent,
	#instVars : [
		'caller'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #accessing }
RipaiscAbstractComponent class >> caller: aComponent [

	^ self new
		  caller: aComponent;
		  yourself
]

{ #category : #accessing }
RipaiscAbstractComponent >> caller [

	^ caller
]

{ #category : #accessing }
RipaiscAbstractComponent >> caller: anObject [

	caller := anObject
]

{ #category : #updating }
RipaiscAbstractComponent >> rendererClass [
	^ SBSHtmlCanvas
]

{ #category : #updating }
RipaiscAbstractComponent >> updateRoot: aWARoot [
	super updateRoot: aWARoot.
	aWARoot
		beHtml5;
		title: 'Radar RIPAISC'.
	aWARoot meta
		name: 'viewport';
		content: 'width=device-width, initial-scale=1.0'.
	aWARoot stylesheet
		url:
			'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'
]
