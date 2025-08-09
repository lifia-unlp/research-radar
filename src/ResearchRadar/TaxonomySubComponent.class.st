Class {
	#name : #TaxonomySubComponent,
	#superclass : #RadarAbstractSubComponent,
	#instVars : [
		'style',
		'taxonomy',
		'publications'
	],
	#category : #'ResearchRadar-seaside-subcomponents'
}

{ #category : #rendering }
TaxonomySubComponent >> beBriefWithTaxonomy: theTaxonomy and: thePublications [

	style := 'brief'.
	taxonomy := theTaxonomy.
	publications := thePublications
]

{ #category : #rendering }
TaxonomySubComponent >> beFullWithTaxonomy: theTaxonomy and: thePublications [

	style := 'full'.
	taxonomy := theTaxonomy.
	publications := thePublications
]

{ #category : #initialization }
TaxonomySubComponent >> initialize [

	super initialize.
	style := 'brief'.
	publications := Set new
]

{ #category : #rendering }
TaxonomySubComponent >> renderBriefOn: html [

	| counts |
	counts := (taxonomy subtopics collect: [ :each |
		           TopicProductCount topic: each publications: publications ])
		          asSortedCollection: [ :a :b |
		          a familyCount > b familyCount ].

	html text: (counts collect: [ :each |
			 each topic label , ' (' , each familyCount greaseString , ')' ])
			asCommaStringAnd
]

{ #category : #rendering }
TaxonomySubComponent >> renderContentOn: html [

	taxonomy ifNil: [ ^ html text: 'No taxonomy was provided' ].
	publications ifEmpty: [ ^ html text: 'No publications to organize' ].
	html paragraph
		class: 'taxonomy';
		with: [
			style = 'brief' ifTrue: [ ^ self renderBriefOn: html ].
			style = 'full' ifTrue: [ ^ self renderFullOn: html ] ]
]

{ #category : #rendering }
TaxonomySubComponent >> renderFullOn: html [

	| counts organizedTopics |
	organizedTopics := taxonomy withSubtopics.
	organizedTopics remove: taxonomy.

	counts := organizedTopics collect: [ :each |
		          TopicProductCount topic: each publications: publications ].


	counts
		do: [ :each |
			| elem |
			elem := html span.
			each familyCount = 0
				ifTrue: [ elem class: 'tagcloud-light' ]
				ifFalse: [
					each familyCount <= 5
						ifTrue: [ elem class: 'tagcloud-medium' ]
						ifFalse: [ elem class: 'tagcloud-dark' ] ].
			elem with: each topic label ]
		separatedBy: [ html text: ', ' ]
]

{ #category : #hooks }
TaxonomySubComponent >> style [

	^ '
.tagcloud-light {
  color: #d0dcf2; 
}

.tagcloud-medium {
  color: #97c0f4; 
}

.tagcloud-dark {
  color: #073b92; 
}'
]
