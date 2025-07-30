Class {
	#name : #PrivateHomeComponent,
	#superclass : #RipaiscAbstractComponent,
	#category : #'RIPAISC-seaside'
}

{ #category : #rendering }
PrivateHomeComponent >> renderContentOn: html [

	html container: [
		html paragraph: [
			html anchor
				callback: [ self call: (PublicationsListComponent caller: self) ];
				with: 'Publicaciones' ] ]
]
