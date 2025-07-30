# Radar RIPAISC
Monitor de publicaciones de QSE en Latinoamerica en especial de aquellas generadas por RIPAISC.net

# Para desarrolladores

```
Metacello new
   baseline: 'RIPAISC';
   repository: 'github://lifia-unlp/ripaisc-radar:main';
   onConflictUseLoaded;
   onWarningLog; 
   load.
```
