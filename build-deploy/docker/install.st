Smalltalk vm maxExternalSemaphoresSilently: 1024.
"Install the app"
Metacello new
   baseline: 'ResearchRadar';
   repository: 'github://lifia-unlp/research-radar:main';
   onConflictUseLoaded;
   onWarningLog; 
   load.
"Disable loading of preferences"	
PharoCommandLineHandler forcePreferencesOmission: true.
"Disable Epicea"
EpMonitor reset.
