new:
	node CSVGenerator.js
	R -f imagegen.r
	mv out*.png output