Class {
	#name : #TaxonomyPlotSubcomponent,
	#superclass : #PlotlySubcomponent,
	#instVars : [
		'publications',
		'taxonomy',
		'aspect',
		'countsDictionary'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #accessing }
TaxonomyPlotSubcomponent >> publications: aCollectionOfPublications taxonomy: aTaxonomy aspect: anAspect [

	publications := aCollectionOfPublications.
	aspect := anAspect.
	taxonomy := aTaxonomy.
	countsDictionary := (publications
		                     flatCollect: [ :each | each perform: aspect ]
		                     as: Bag) valuesAndCounts
]

{ #category : #rendering }
TaxonomyPlotSubcomponent >> renderContentOn: html [

	html unorderedList: [
		taxonomy subtopics do: [ :each |
			self renderTaxonomyTopic: each on: html ] ]
]

{ #category : #rendering }
TaxonomyPlotSubcomponent >> renderTaxonomyTopic: aTopic on: html [

	| count text |
	count := countsDictionary at: aTopic value ifAbsent: [ 0 ].
	text := aTopic label , ' (' , count greaseString , ')'.
	html listItem: [
		count = 0
			ifTrue: [ html text: text ]
			ifFalse: [ html strong: text ].
		aTopic subtopics ifNotEmpty: [ :subtopics |
			html unorderedList: [
				subtopics do: [ :subtopic |
					self renderTaxonomyTopic: subtopic on: html ] ] ] ]
]
