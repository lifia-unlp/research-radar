Class {
	#name : #LandingComponent,
	#superclass : #RipaiscAbstractComponent,
	#category : #'RIPAISC-seaside'
}

{ #category : #rendering }
LandingComponent >> renderContentOn: html [

	html container: [
		html break.
		html jumbotron: [
			html row: [
				self renderPresentationColumnOn: html.
				self renderLoginColumnOn: html ] ] ]
]

{ #category : #rendering }
LandingComponent >> renderLoginColumnOn: html [

	^ html
		  column: [
			  html paragraph: [
				  html anchor
					  callback: [ self call: PrivateHomeComponent new ];
					  with: 'Intranet' ].
			  html paragraph: [
				  html anchor
					  callback: [  ];
					  with: 'Radar' ] ]
		  mediumSize: 6
]

{ #category : #rendering }
LandingComponent >> renderPresentationColumnOn: html [
	html
		column: [ html heading
				level1;
				class: 'display-4';
				with: 'Radar RIPAISC'.
			"			html image
				style: 'padding-bottom: 20px;';
				style: 'max-width: 100%;';
				url: GAFLibrary / #farmomaticJpeg."
			html paragraph
				class: 'lead';
				with:
					'El radar RIPAISC monitorea grupos, proyectos, y publicaciones en temas de Ingeniería de Software Cuántico en Iberoamérica'.
			html paragraph with: 'El radar es una iniciativa de la Red Iberoamericana para el Avance de la Ingeniería de Software Cuántico' ]
		mediumSize: 6
]
