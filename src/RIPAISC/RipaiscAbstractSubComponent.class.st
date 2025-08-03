"
Subcomponents do not introduce a container. 
When calling other components, it the caller is the parent (if set).
They do not offer a return button or link

"
Class {
	#name : #RipaiscAbstractSubComponent,
	#superclass : #RipaiscAbstractComponent,
	#instVars : [
		'parent'
	],
	#category : #'RIPAISC-seaside-subcomponents'
}

{ #category : #accessing }
RipaiscAbstractSubComponent >> parent [

	^ parent
]

{ #category : #accessing }
RipaiscAbstractSubComponent >> parent: anObject [

	parent := anObject
]
