Class {
	#name : #BaselineOfResearchRadar,
	#superclass : #BaselineOf,
	#category : #BaselineOfResearchRadar
}

{ #category : #baselines }
BaselineOfResearchRadar >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self
				petitBibtex: spec;
				doi: spec;
				seaside: spec;
				bootstrap5: spec;
				neoCSV: spec;
				plotly: spec.
			spec
				package: 'ResearchRadar'
				with: [ spec
						requires:
							#('Seaside3' 'Bootstrap5'  'Seaside-Plotly-Core' ) ] ].

]

{ #category : #baselines }
BaselineOfResearchRadar >> bootstrap5: spec [
	spec
		baseline: 'Bootstrap5'
		with: [ spec repository: 'github://astares/Seaside-Bootstrap5:master/src' ].


]

{ #category : #baselines }
BaselineOfResearchRadar >> doi: spec [
	spec
		package: 'DOI'
		with: [ spec repository: 'github://cientopolis/petitbibtex' ]
]

{ #category : #baselines }
BaselineOfResearchRadar >> neoCSV: spec [
	spec
		baseline: 'NeoCSV'
		with: [ spec repository: 'github://svenvc/NeoCSV/repository' ]
]

{ #category : #baselines }
BaselineOfResearchRadar >> petitBibtex: spec [
	spec
		baseline: 'PetitBibtex'
		with: [ spec repository: 'github://cientopolis/petitbibtex' ]
]

{ #category : #baselines }
BaselineOfResearchRadar >> plotly: spec [
	spec
		package: 'Seaside-Plotly-Core'
		with: [ spec repository: 'github://emaringolo/seaside-plotlyjs/src' ].

]

{ #category : #baselines }
BaselineOfResearchRadar >> seaside: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec repository: 'github://SeasideSt/Seaside:master/repository' ].
	spec
		package: 'Seaside-REST-Core'
		with: [ spec repository: 'github://SeasideSt/Seaside:master/repository' ]
]
