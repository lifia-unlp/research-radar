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
				callback: [
					self call: (PublicationsBrowserComponent new
								 caller: self;
								 yourself) ];
				with: 'Publicaciones' ].
		html paragraph: [
			html anchor
				callback: [
					self call: ((TaxonomyBrowserComponent caller: self)
								 taxonomy: self radar topicsTaxonomy;
								 publicationsRetrievingBlock: [ self radar publications ];
								 yourself) ];
				with: 'Topics taxonomy' ].
		html paragraph: [
			html anchor
				callback: [
					self call: ((TaxonomyBrowserComponent caller: self)
								 taxonomy: self radar applicationDomainsTaxonomy;
								 publicationsRetrievingBlock: [ self radar publications ];
								 yourself) ];
				with: 'Application domains taxonomy' ] ]
]
