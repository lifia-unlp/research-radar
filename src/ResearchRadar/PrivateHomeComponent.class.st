Class {
	#name : #PrivateHomeComponent,
	#superclass : #RadarAbstractComponent,
	#instVars : [
		'secret'
	],
	#category : #'ResearchRadar-seaside-backend'
}

{ #category : #'accessing-urls' }
PrivateHomeComponent class >> baseUrl [

	^ 'research-radar-admin'
]

{ #category : #rendering }
PrivateHomeComponent >> renderContentOn: html [

	html container: [
		(secret notNil and: [ secret trimBoth = Radar knownSecret ])
			ifTrue: [
				self renderLinkToGroupsOn: html.
				self renderLinkToPublicationsOn: html.
				self renderLinkToTopicsTaxonomyOn: html.
				self renderLinkToApplicationDomainsTaxonomyOn: html.
				self renderLinkToUploadFileOn: html.
				self renderLinkToPropertiesEditor: html ]
			ifFalse: [ self renderRequestForSecretOn: html ] ]
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
PrivateHomeComponent >> renderLinkToGroupsOn: html [

	html paragraph: [
		html anchor
			callback: [
				self call: (NetworkGroupsBrowser new
							 caller: self;
							 yourself) ];
			with: 'Grupos' ]
]

{ #category : #rendering }
PrivateHomeComponent >> renderLinkToPropertiesEditor: html [

	^ html paragraph: [
		  html anchor
			  callback: [ self call: PropertiesEditor new ];
			  with: 'Properties editor' ]
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

{ #category : #rendering }
PrivateHomeComponent >> renderLinkToUploadFileOn: html [

	html paragraph: [
		html anchor
			callback: [
				self call: (BulkImportWizard new
							 caller: self;
							 yourself) ];
			with: 'Upload' ]
]

{ #category : #rendering }
PrivateHomeComponent >> renderRequestForSecretOn: html [

	html form: [
		html formGroup: [
			html label: 'What''s your secret?'.
			html textInput formControl on: #secret of: self ] ]
]

{ #category : #accessing }
PrivateHomeComponent >> secret [

	^ secret
]

{ #category : #accessing }
PrivateHomeComponent >> secret: aString [

	secret := aString.
	Radar knownSecret ifNil: [ Radar knownSecret: aString ]
]
