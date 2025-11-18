Class {
	#name : #TopicViewComponent,
	#superclass : #RadarViewComponent,
	#category : #'ResearchRadar-seaside-components'
}

{ #category : #'accessing-urls' }
TopicViewComponent class >> baseUrl [

	^ 'topic-radar'
]

{ #category : #'accessing-urls' }
TopicViewComponent class >> topicRadarUrlFor: aTopic [

	^ self baseUrl , '?topic=' , aTopic label urlEncoded
]

{ #category : #rendering }
TopicViewComponent >> renderContentOn: html [

	| selectedTopic |
	selectedTopic := self selectedTopic.

	html container: [
		self renderNavBarOn: html.

		publications := self allPublications select: [ :each |
			                selectedTopic matches: each ].

		html heading: selectedTopic label.
		self renderTotalCountOn: html.
		self renderPlotsOn: html.
		self renderFullTaxonomyOn: html.

		publicationsListSubComponent publications: publications.
		html render: publicationsListSubComponent ]
]
