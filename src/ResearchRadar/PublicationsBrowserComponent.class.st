Class {
	#name : #PublicationsBrowserComponent,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'publicationsListSubComponent',
		'hideDone'
	],
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #callbacks }
PublicationsBrowserComponent >> addNewPublication [

	| publication |
	publication := self call: (PublicationEditorComponent caller: self).
	publication ifNil: [ ^ self ].
	self radar publications add: publication.
	self save
]

{ #category : #hooks }
PublicationsBrowserComponent >> children [

	^ { publicationsListSubComponent }
]

{ #category : #publications }
PublicationsBrowserComponent >> filter: aCollectionOfPublications [

	^ aCollectionOfPublications reject: [ :each |
		  hideDone
			  ifTrue: [ each countries notEmpty ]
			  ifFalse: [ false ] ]
]

{ #category : #initialize }
PublicationsBrowserComponent >> initialize [

	super initialize.
	hideDone := true.
	publicationsListSubComponent := PublicationsListSubComponent new.
	publicationsListSubComponent
		enableEditing: true;
		showAbstracts: true
]

{ #category : #publications }
PublicationsBrowserComponent >> publicationsToShow [

	^self filter: self radar publications
]

{ #category : #rendering }
PublicationsBrowserComponent >> renderContentOn: html [

	html container: [
		self renderOptionsBarOn: html.
		publicationsListSubComponent publications: self publicationsToShow.
		html render: publicationsListSubComponent ]
]

{ #category : #rendering }
PublicationsBrowserComponent >> renderOptionsBarOn: html [

	html paragraph: [
		html anchor
			callback: [ self toogleHideDone ];
			with: [
				html text: (hideDone
							 ifTrue: [ '[Show done]' ]
							 ifFalse: [ '[Hide done]' ]) ].
		html space.
		html anchor
			callback: [ self addNewPublication ];
			with: '[Add]' ]
]

{ #category : #callbacks }
PublicationsBrowserComponent >> toogleHideDone [

	hideDone := hideDone not
]
