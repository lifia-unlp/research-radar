Class {
	#name : #PrivateHomeComponent,
	#superclass : #RipaiscAbstractComponent,
	#category : #'RIPAISC-seaside'
}

{ #category : #rendering }
PrivateHomeComponent >> renderContentOn: html [

	html container: [
		self renderLinkToPublicationsOn: html.
		self renderLinkToTopicsTaxonomyOn: html.
		self renderLinkToApplicationDomainsTaxonomyOn: html ]
]

{ #category : #rendering }
PrivateHomeComponent >> renderLinkToApplicationDomainsTaxonomyOn: html [

	^ html paragraph: [
		  html anchor
			  callback: [
				  self call: ((TaxonomyBrowserComponent caller: self)
							   taxonomy: self radar applicationDomainsTaxonomy;
							   publicationsRetrievingBlock: [ self radar publications ];
							   yourself) ];
			  with: 'Application domains taxonomy' ]
]

{ #category : #rendering }
PrivateHomeComponent >> renderLinkToPublicationsOn: html [

	html paragraph: [
		html anchor
			callback: [
				self call: (PublicationsBrowserComponent new
							 caller: self;
							 yourself) ];
			with: 'Publicaciones' ]
]

{ #category : #rendering }
PrivateHomeComponent >> renderLinkToTopicsTaxonomyOn: html [

	html paragraph: [
		html anchor
			callback: [
				self call: ((TaxonomyBrowserComponent caller: self)
							 taxonomy: self radar topicsTaxonomy;
							 publicationsRetrievingBlock: [ self radar publications ];
							 yourself) ];
			with: 'Topics taxonomy' ]
]
