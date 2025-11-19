| apps debug toUnregister |

toUnregister := { 'bootstrap5'. 'browse'. 'examples'. 'seaside'. 'status'. 'tests'. 'tools'. 'welcome'. 'config' }.

debug := (OSEnvironment current at: 'DEBUG' ifAbsent: 'false') = 'true'.

debug ifFalse: [
	toUnregister do: [ :each | WAAdmin unregister: each ].
	WAAdmin applicationDefaults
		removeParent: WADevelopmentConfiguration instance.
].

ZnZincServerAdaptor startOn: 8080.

apps := OrderedCollection new. 

apps add: (WAAdmin
	register: CountryViewComponent   
	asApplicationAt: CountryViewComponent baseUrl ).
	
apps add: (WAAdmin
	register: RegionViewComponent    
	asApplicationAt: RegionViewComponent baseUrl ).
	
apps add: (WAAdmin
	register: TopicViewComponent   
	asApplicationAt: TopicViewComponent baseUrl ).
	
apps add: (WAAdmin
	register: PrivateHomeComponent
	asApplicationAt: PrivateHomeComponent baseUrl).

apps do: [:app | 
 app
	addLibrary: SBSDeploymentLibrary .	
].

(WAAdmin defaultDispatcher handlerAt: CountryViewComponent baseUrl)
   configuration at: #trackingStrategy put: WACookieIfSupportedSessionTrackingStrategy new.

(WAAdmin defaultDispatcher handlerAt: RegionViewComponent baseUrl)
   configuration at: #trackingStrategy put: WACookieIfSupportedSessionTrackingStrategy new.

(WAAdmin defaultDispatcher handlerAt: TopicViewComponent baseUrl)
   configuration at: #trackingStrategy put: WACookieIfSupportedSessionTrackingStrategy new.   
   
WAAdmin defaultDispatcher defaultName: RegionViewComponent baseUrl.




