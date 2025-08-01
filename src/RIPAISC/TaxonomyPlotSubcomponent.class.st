Class {
	#name : #TaxonomyPlotSubcomponent,
	#superclass : #WAComponent,
	#instVars : [
		'title',
		'taxonomy',
		'countsDictionary'
	],
	#category : #'RIPAISC-seaside'
}

{ #category : #accessing }
TaxonomyPlotSubcomponent >> counts: theCounts taxonomy: anObject [

	taxonomy := anObject.
	countsDictionary := theCounts asDictionary 
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

{ #category : #accessing }
TaxonomyPlotSubcomponent >> title: anObject [

	title := anObject
]
