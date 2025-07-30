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
				seaside: spec;
				bootstrap: spec;
				plotly: spec.
			spec
				package: 'RIPAISC'
				with: [ spec
						requires:
							#('Seaside3' 'Bootstrap-Core' 'Bootstrap-Widgets' 'Seaside-Plotly-Core' 'PetitBibtex') ] ].

]

{ #category : #baselines }
BaselineOfRIPAISC >> bootstrap: spec [
	spec
		package: 'Bootstrap-Core'
		with: [ spec repository: 'github://astares/Seaside-Bootstrap/src' ].
	spec
		package: 'Bootstrap-Widgets'
		with: [ spec repository: 'github://astares/Seaside-Bootstrap/src' ].
	spec
		package: 'Bootstrap-Jasny'
		with: [ spec repository: 'github://astares/Seaside-Bootstrap/src' ]
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
