Class {
	#name : #PublicationEditorComponent,
	#superclass : #RipaiscAbstractComponent,
	#category : #'RIPAISC-seaside'
}

{ #category : #rendering }
PublicationEditorComponent >> renderContentOn: html [

	html container: [
		html form: [
			html formGroup: [
				html label: 'Título'.
				html textInput formControl ].
			html formGroup: [
				html label: 'Año'.
				html textInput formControl ].
			html formGroup: [
				html label: 'Autores'.
				html textInput formControl ].
			html formGroup
				formCheck;
				with: [
					html formCheckLabel with: [
							html formCheckbox: 'Algun autor pertenece a RIPAISC?' ] ].
			html formGroup: [
				html label: 'Resumen'.
				html textArea formControl rows: 5 ].
			html formGroup: [
				html label: 'DOI'.
				html textInput formControl ].
			html formGroup: [
				html label: 'Páises involucrados'.
				html multiSelect formControl list: Radar singleton countries ].
						html formGroup: [
				html label: 'Temas'.
				html multiSelect formControl list: Radar singleton topics ]
			] ]
]
