Class {
	#name : #BaselineOfRIPAISC,
	#superclass : #BaselineOf,
	#category : #BaselineOfRIPAISC
}

{ #category : #baselines }
BaselineOfRIPAISC >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self
				petitBibtex: spec;
				doi: spec;
				seaside: spec;
				bootstrap5: spec;
				plotly: spec.
			spec
				package: 'RIPAISC'
				with: [ spec
						requires:
							#('Seaside3' 'Bootstrap5'  'Seaside-Plotly-Core' ) ] ].

]

{ #category : #baselines }
BaselineOfRIPAISC >> bootstrap5: spec [
	spec
		baseline: 'Bootstrap5'
		with: [ spec repository: 'github://astares/Seaside-Bootstrap5:master/src' ].


]

{ #category : #baselines }
BaselineOfRIPAISC >> doi: spec [
	spec
		package: 'DOI'
		with: [ spec repository: 'github://cientopolis/petitbibtex' ]
]

{ #category : #baselines }
BaselineOfRIPAISC >> petitBibtex: spec [
	spec
		baseline: 'PetitBibtex'
		with: [ spec repository: 'github://cientopolis/petitbibtex' ]
]

{ #category : #baselines }
BaselineOfRIPAISC >> plotly: spec [
	spec
		package: 'Seaside-Plotly-Core'
		with: [ spec repository: 'github://emaringolo/seaside-plotlyjs/src' ].

]

{ #category : #baselines }
BaselineOfRIPAISC >> seaside: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec repository: 'github://SeasideSt/Seaside:master/repository' ].
	spec
		package: 'Seaside-REST-Core'
		with: [ spec repository: 'github://SeasideSt/Seaside:master/repository' ]
]
