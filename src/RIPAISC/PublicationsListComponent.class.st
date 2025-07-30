Class {
	#name : #PublicationsListComponent,
	#superclass : #RipaiscAbstractComponent,
	#category : #'RIPAISC-seaside'
}

{ #category : #rendering }
PublicationsListComponent >> addPublication [

	| publication |
	publication := self call: (PublicationEditorComponent caller: self).
	publication ifNil: [ ^ self ].
	self radar publications add: publication.
	self save
]

{ #category : #rendering }
PublicationsListComponent >> delete: each [ 
	self radar publications remove: each.
	self save. 
]

{ #category : #rendering }
PublicationsListComponent >> edit: aPublication [

	| publication |
	publication := self call: ((PublicationEditorComponent caller: self)
			                publication: aPublication;
			                yourself).
	publication ifNil: [ ^ self ].
	self save
]

{ #category : #rendering }
PublicationsListComponent >> renderContentOn: html [

	html container: [
		html paragraph: 'Publicaciones'.
		html unorderedList: [
			self radar publications do: [ :each |
				html paragraph: [ self renderPublication: each on: html ] ] ].
		html anchor
			callback: [ self addPublication ];
			with: 'Nueva' ]
]

{ #category : #rendering }
PublicationsListComponent >> renderPublication: each on: html [

	html text: each title.
	html space.
	html anchor
		callback: [ self delete: each ];
		with: '[X]'.
	html space.
	html anchor
		callback: [ self edit: each ];
		with: '[editar]'
]
