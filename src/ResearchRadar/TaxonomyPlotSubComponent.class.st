Class {
	#name : #TaxonomyPlotSubComponent,
	#superclass : #PlotlySubComponent,
	#instVars : [
		'publications',
		'taxonomy',
		'aspect',
		'countsDictionary'
	],
	#category : #'ResearchRadar-seaside-subcomponents'
}

{ #category : #accessing }
TaxonomyPlotSubComponent >> publications: aCollectionOfPublications taxonomy: aTaxonomy aspect: anAspect [

	publications := aCollectionOfPublications.
	aspect := anAspect.
	taxonomy := aTaxonomy.
	countsDictionary := (publications
		                     flatCollect: [ :each | each perform: aspect ]
		                     as: Bag) valuesAndCounts
]

{ #category : #rendering }
TaxonomyPlotSubComponent >> renderContentOn: html [

	html unorderedList: [
		taxonomy subtopics do: [ :each |
			self renderTaxonomyTopic: each on: html ] ]
]

{ #category : #rendering }
TaxonomyPlotSubComponent >> renderTaxonomyTopic: aTopic on: html [

	| count text |
	count := countsDictionary at: aTopic value ifAbsent: [ 0 ].
	text := aTopic label , ' (' , count greaseString , ')'.
	html listItem: [
		count = 0
			ifTrue: [ html text: text ]
			ifFalse: [
				html anchor
				   url: (TopicViewComponent topicRadarUrlFor: aTopic);
					with: [ html text: text ] ].
		aTopic subtopics ifNotEmpty: [ :subtopics |
			html unorderedList: [
				subtopics do: [ :subtopic |
					self renderTaxonomyTopic: subtopic on: html ] ] ] ]
]
