Class {
	#name : #PublicationsListComponent,
	#superclass : #RipaiscAbstractComponent,
	#category : #'RIPAISC-seaside'
}

{ #category : #rendering }
PublicationsListComponent >> renderContentOn: html [

	html container: [
		html paragraph: 'Publicaciones'.
		html unorderedList: [
			Radar singleton publications do: [ :each |
				self renderPublication: each on: html ] ].
		html anchor
			callback: [ self call: (PublicationEditorComponent caller: self) ];
			with: 'Nueva' ]
]

{ #category : #rendering }
PublicationsListComponent >> renderPublication: each on: html [
	html text: each title. 
]
