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
				with: 'Publicaciones' ].
		html paragraph: [
			html anchor
				callback: [
					self call: ((TaxonomyBrowserComponent caller: self)
								 taxonomy: self radar topicsTaxonomy;
								 yourself) ];
				with: 'Topics taxonomy' ].
		html paragraph: [
			html anchor
				callback: [
					self call: ((TaxonomyBrowserComponent caller: self)
								 taxonomy: self radar applicationDomainsTaxonomy;
								 yourself) ];
				with: 'Application domains taxonomy' ] ]
]
