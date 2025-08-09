"
Subcomponents do not introduce a container. 
When calling other components, it the caller is the parent (if set).
They do not offer a return button or link

"
Class {
	#name : #RadarAbstractSubComponent,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'parent'
	],
	#category : #'ResearchRadar-seaside-subcomponents'
}

{ #category : #accessing }
RadarAbstractSubComponent >> parent [

	^ parent
]

{ #category : #accessing }
RadarAbstractSubComponent >> parent: anObject [

	parent := anObject
]
