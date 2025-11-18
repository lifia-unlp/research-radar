Class {
	#name : #TopicViewComponent,
	#superclass : #RadarViewComponent,
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #'accessing-urls' }
TopicViewComponent class >> baseUrl [

	^ 'topic'
]

{ #category : #'accessing-urls' }
TopicViewComponent class >> topicRadarUrlFor: aTopic [

	^ '/' , self baseUrl , '/' , aTopic label urlEncoded
]

{ #category : #rendering }
TopicViewComponent >> renderSpecificContentOn: html [

	html heading: self selectedTopic label.
	self renderTotalCountOn: html.
	self renderPlotsOn: html.
	self renderFullTaxonomyOn: html.

	publicationsListSubComponent publications: publications.
	html render: publicationsListSubComponent
]

{ #category : #rendering }
TopicViewComponent >> selectedPublications [

	| selectedTopic |
	selectedTopic := self selectedTopic.
	^ self allPublications select: [ :each | selectedTopic matches: each ]
]

{ #category : #navigating }
TopicViewComponent >> selectedTopic [

	| topicLabel taxonomy |
	taxonomy := self radar topicsTaxonomy.
	topicLabel := self filter.
	^ topicLabel ifNil: [ taxonomy ] ifNotNil: [
		  taxonomy withSubtopics
			  detect: [ :each | each label = topicLabel ]
			  ifNone: [ taxonomy ] ]
]
