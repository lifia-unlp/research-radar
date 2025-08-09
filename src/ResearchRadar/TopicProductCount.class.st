Class {
	#name : #TopicProductCount,
	#superclass : #Object,
	#instVars : [
		'topic',
		'ownCount',
		'familyCount'
	],
	#category : #'ResearchRadar-model'
}

{ #category : #initialization }
TopicProductCount class >> topic: anObject publications: aCollectionOfPublications [

	^ self new
		  topic: anObject publications: aCollectionOfPublications;
		  yourself
]

{ #category : #accessing }
TopicProductCount >> familyCount [

	^ familyCount
]

{ #category : #accessing }
TopicProductCount >> ownCount [

	^ ownCount
]

{ #category : #accessing }
TopicProductCount >> topic [

	^ topic
]

{ #category : #initialization }
TopicProductCount >> topic: anObject publications: aCollectionOfPublications [

	topic := anObject.
	self updateWith: aCollectionOfPublications
]

{ #category : #private }
TopicProductCount >> updateWith: aCollectionOfPublications [

	ownCount := 0.
	familyCount := 0.
	aCollectionOfPublications do: [ :each |
		(topic matches: each) ifTrue: [ ownCount := ownCount + 1 ].
		(topic withSubtopicsMatches: each) ifTrue: [
			familyCount := familyCount + 1 ] ]
]
