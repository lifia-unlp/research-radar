Class {
	#name : #RadarMenuSubcomponent,
	#superclass : #RadarAbstractSubComponent,
	#instVars : [
		'brand',
		'countries',
		'regions'
	],
	#category : #'ResearchRadar-seaside-subcomponents'
}

{ #category : #accessing }
RadarMenuSubcomponent >> brand [

	^ brand
]

{ #category : #initialization }
RadarMenuSubcomponent >> brand: aBrandString regions: regionNames countries: countryNames [

	brand := aBrandString.
	regions := regionNames.
	countries := countryNames
]

{ #category : #accessing }
RadarMenuSubcomponent >> countries [

	^ countries
]

{ #category : #initialization }
RadarMenuSubcomponent >> initialize [

	super initialize.
	regions := OrderedCollection new.
	countries := OrderedCollection new.
	brand := 'Research radar'
]

{ #category : #accessing }
RadarMenuSubcomponent >> regions [

	^ regions
]

{ #category : #rendering }
RadarMenuSubcomponent >> renderContentOn: html [

	| bar id  |
	id := '#navbarCollapsed'.
	bar := html navigationBar.
	bar
		beLight;
		expandLarge.
	bar background beLight.
	bar with: [
		html navigationBarBrand: brand.

		"The toggler that is only visible when reducing the width of screen"
		html navigationBarToggler
			beButtonType;
			collapse;
			dataTarget: id;
			with: [ html navigationBarTogglerIcon ].

		html navigationBarCollapse collapse
			id: 'navbarCollapsed';
			with: [
				html navigationBarNavigation: [
						regions do: [ :aLabel |
								html navigationItem with: [
										html navigationLink
											url: (self urlForRegionView: aLabel);
											with: aLabel;
											yourself ] ].

						countries do: [ :aLabel |
							html navigationItem with: [
								html navigationLink
									url: (self urlForCountryView: aLabel);
									with: aLabel;
									yourself ] ] ] ] ]
]

{ #category : #rendering }
RadarMenuSubcomponent >> urlForCountryView: aLabel [

	^ '/' , CountryViewComponent baseUrl , '/' , aLabel
]

{ #category : #rendering }
RadarMenuSubcomponent >> urlForRegionView: aLabel [

	^ '/' , RegionViewComponent baseUrl , '/' , aLabel
]
