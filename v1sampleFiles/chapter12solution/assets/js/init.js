var o = {
	init: function(){
		this.diagram();
	},
	random: function(l, u){
		return Math.floor((Math.random()*(u-l+1))+l);
	},
	diagram: function(){
		var r = Raphael('diagram', 321, 350),
			rad = 25, // center black radius
			defaultText = 'Skills', // center black text
			speed = 200;
			r.circle(140, 170, 34).attr({ stroke: 'none', fill: '#2a2a2a' });// center black radius
		
		var title = r.text(140, 170, defaultText).attr({ // center black text
			font: '12px Arial ',
			fill: '#fff'
		}).toFront();
		
		r.customAttributes.arc = function(value, color, rad){  // return path and stroke
			var v = 3.6*value,
				alpha = v == 360 ? 359.99 : v,
				random = o.random(91, 240),
				a = (random-alpha) * Math.PI/180,
				b = random * Math.PI/180,
				sx = 140 + rad * Math.cos(b),
				sy = 170 - rad * Math.sin(b),
				x = 140 + rad * Math.cos(a),
				y = 170 - rad * Math.sin(a),
				path = [['M', sx, sy], ['A', rad, rad, 0, +(alpha > 180), 1, x, y]];
			return { path: path, stroke: color }
		}
		
		// getting the percentage, colour, text 
		$('.get').find('.arc').each(function(i){
			var t = $(this), 
				color = t.find('.color').val(),
				value = t.find('.percent').val(),
				text = t.find('.text').text();
			
			rad += 20;	
			var z = r.path().attr({ arc: [value, color, rad], 'stroke-width': 15 });
			
			z.mouseover(function(){ // on mouse over showing center text 
                this.animate({ 'stroke-width': 20, opacity: .85 }, 1000, 'elastic');
                if(Raphael.type != 'VML') //solves IE problem
				this.toFront();
				title.stop().animate({ opacity: 0 }, speed, '>', function(){
					this.attr({ text: text + '\n' + value + '%' }).animate({ opacity: 1 }, speed, '<');
				});
            }).mouseout(function(){ // on mouse out function
				this.stop().animate({ 'stroke-width': 15, opacity: 1 }, speed*4, 'elastic');
				title.stop().animate({ opacity: 0 }, speed, '>', function(){
					title.attr({ text: defaultText }).animate({ opacity: 1 }, speed, '<');
				});	
            });
		});
		
	}
}
$(function(){ o.init(); });
