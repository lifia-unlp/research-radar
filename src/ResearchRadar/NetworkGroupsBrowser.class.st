Class {
	#name : #NetworkGroupsBrowser,
	#superclass : #RadarAbstractComponent,
	#category : #'ResearchRadar-seaside-backend'
}

{ #category : #adding }
NetworkGroupsBrowser >> addGroup [

	| newGroup |
	newGroup := self call: (NetworkGroupEditor new
			             group: NetworkGroup new;
			             yourself).
	newGroup ifNotNil: [ :it |
		self radar groups add: it.
		self save ]
]

{ #category : #adding }
NetworkGroupsBrowser >> delete: aGroup [

	self radar groups remove: aGroup.
	self save
]

{ #category : #adding }
NetworkGroupsBrowser >> edit: aGroup [

	| editedGroup |
	editedGroup := self call: (NetworkGroupEditor new
			                group: aGroup;
			                yourself).
	editedGroup ifNotNil: [ :it | self save ]
]

{ #category : #rendering }
NetworkGroupsBrowser >> renderContentOn: html [

	html container: [
		self radar groups do: [ :each |
			html paragraph: [
				html text: each fullName.
				html text: ' (' , each acronym , '). '.
				html text: each country , '. '.
				html text:
					'"' , each contactName , '" <' , each contactEmail , '> '.
				html anchor
					callback: [ self edit: each ];
					with: '[Edit]'.
				html space.
				html anchor
					callback: [ self delete: each ];
					with: '[Delete]' ] ].

		html break.
		html anchor
			callback: [ self addGroup ];
			with: [ html formButton bePrimary with: 'Add' ] ]
]
