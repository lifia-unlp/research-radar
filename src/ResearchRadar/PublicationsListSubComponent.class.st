Class {
	#name : #PublicationsListSubComponent,
	#superclass : #RadarAbstractSubComponent,
	#instVars : [
		'publications',
		'editingEnabled',
		'showAbstracts',
		'taxonomySubComponent'
	],
	#category : #'ResearchRadar-seaside-subcomponents'
}

{ #category : #hooks }
PublicationsListSubComponent >> children [

	^ { taxonomySubComponent }
]

{ #category : #rendering }
PublicationsListSubComponent >> delete: each [ 
	self radar publications remove: each.
	self save. 
]

{ #category : #rendering }
PublicationsListSubComponent >> edit: aPublication [

	| publication |
	publication := self parent call: ((PublicationEditorComponent caller: self)
			                publication: aPublication;
			                yourself).
	publication ifNil: [ ^ self ].
	self save
]

{ #category : #accessing }
PublicationsListSubComponent >> enableEditing: boolean [

	editingEnabled := boolean
]

{ #category : #initialize }
PublicationsListSubComponent >> initialize [

	super initialize.
	editingEnabled := false.
	showAbstracts := false. 
	taxonomySubComponent := TaxonomySubComponent new.
]

{ #category : #initialize }
PublicationsListSubComponent >> publications: aListOfPublications [
	publications := aListOfPublications 
]

{ #category : #rendering }
PublicationsListSubComponent >> renderActionsFor: each on: html [

	editingEnabled ifFalse: [ ^ self ].
	html break.
	html anchor
		callback: [ self edit: each ];
		with: '[edit]'.
	html space.
	html anchor
		callback: [ self delete: each ];
		with: '[delete]'
]

{ #category : #rendering }
PublicationsListSubComponent >> renderContentOn: html [

	| publicationsByYear |
	publicationsByYear := (publications groupedBy: [ :each | each year ])
		                      associations asSortedCollection: [ :a :b |
		                      a key > b key ].
	publicationsByYear do: [ :ass |
		html heading
			level: 3;
			with:
				ass key greaseString , ' (' , ass value size greaseString , ')'.
		taxonomySubComponent
			beBriefWithTaxonomy: self radar topicsTaxonomy
			and: ass value.
		html render: taxonomySubComponent.
		ass value do: [ :publication |
			html paragraph: [ self renderPublication: publication on: html ] ] ]
]

{ #category : #rendering }
PublicationsListSubComponent >> renderPublication: each on: html [

	html strong: each title , '. '.
	html space.
	html emphasis: each author , '. '.
	html text: '(' , each year , ')'.
	html break.
	html strong: 'Countries (from iberoamerica): '.
	html text: each countries asCommaStringAnd.
	html break.
	html strong: 'Groups: '.
	html text: (each networkNodes collect: [ :group |
			 group acronym , ' (' , group country , ')' ]) asCommaStringAnd.
	html break.
	html strong: 'Topics: '.
	html text:
		(each topics collect: [ :dom | dom value label ]) asCommaStringAnd.
	html break.
	html strong: 'Application domains: '.
	html text:
		(each applicationDomains collect: [ :dom | dom value label ])
			asCommaStringAnd.
	showAbstracts ifTrue: [
		html break.
		html strong: 'Abstract: '.
		html text: each abstract ].
	self renderActionsFor: each on: html
]

{ #category : #accessing }
PublicationsListSubComponent >> showAbstracts: anObject [

	showAbstracts := anObject
]
