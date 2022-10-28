function randomize(min, max) {
	return Math.round(Math.random() * max) + min;
}

var x;
var y;
var r;
var c;
var h = an.getDocumentDOM().height;
var w = an.getDocumentDOM().width;
var fill = an.getDocumentDOM().getCustomFill();
fill.style = "solid";

for (var i = 0; i < 500; i++) {
	x = randomize(-50, w);
	y = randomize(-50, h);
	r = randomize(10, 60);
	switch(randomize(0,2)){
		case 0:
			c = "E6" //90% 
			break;
		case 1:
			c = "BF" //75%
			break;
		case 2: 
			c = "FF" //100%
			break;
		default:
			c = "FF" //100%
	};
	fill.color = "#440000"+c;
	an.getDocumentDOM().setCustomFill(fill);
	an.getDocumentDOM().addNewOval({left:x, top:y, right:x+r, bottom:y+r}, false, true);
}