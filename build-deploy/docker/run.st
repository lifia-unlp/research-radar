| apps debug |

debug := (OSEnvironment current at: 'DEBUG' ifAbsent: 'false') = 'true'.

debug ifFalse: [
	WAAdmin defaultServerManager adaptors
        do: [ :each | WAAdmin defaultServerManager unregister: each ].
	WAAdmin applicationDefaults
		removeParent: WADevelopmentConfiguration instance.
].

ZnZincServerAdaptor startOn: 8080.

applications add: (WAAdmin
	register: RadarViewComponent 
	asApplicationAt: 'research-radar').
applications add: (WAAdmin
	register: PrivateHomeComponent
	asApplicationAt: 'research-radar-admin').

apps do: [:app | 
 app
	addLibrary: JQDeploymentLibrary;
	addLibrary: JQUiDeploymentLibrary;
	addLibrary: SBSDeploymentLibrary .	
].

WAAdmin defaultDispatcher defaultName: 'research-radar'.
