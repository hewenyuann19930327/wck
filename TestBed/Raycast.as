﻿package {
	
	import Box2DAS.*;
	import Box2DAS.Collision.*;
	import Box2DAS.Collision.Shapes.*;
	import Box2DAS.Common.*;
	import Box2DAS.Dynamics.*;
	import Box2DAS.Dynamics.Contacts.*;
	import Box2DAS.Dynamics.Joints.*;
	import misc.*;
	import flash.events.*;
	
	import flash.display.MovieClip;
	
	public class Raycast extends Test {
		
		var drawOn:MovieClip = new MovieClip()
		
		var l:b2Body;
		var r:b2Body;
		var c:b2Body;
		
		public function Raycast() {
			super();
			Main.txt.text = "Raycast:\n";
			Main.debug.parent.addChild(drawOn);
			
			l = makeCircle(200,300,13)
			c = makeCircle(350,0,50)
			r = makeCircle(500,300,13)
		}
		
		public override function EnterFrame():void {
			super.EnterFrame();
			doRaycast();
		}

		
		private function makeCircle(X,Y, rad):b2Body{
			b2Def.circle.m_radius = rad / scale;
			b2Def.body.position.x = X / scale;
			b2Def.body.position.y = Y / scale;
			b2Def.body.type = b2Body.b2_dynamicBody;
			var b:b2Body = b2Def.body.create(this);
			var f:b2Fixture;
			with(b2Def.fixture) {
				shape = b2Def.circle;
				density = 1.0;
				f = create(b);
			}
			
			return b
		}
		
		
		private function doRaycast():void{
			var p1:V2 = l.GetWorldCenter()
			var p2:V2 = r.GetWorldCenter()
			
			this.RayCast(GetBodyCallback, new V2(p1.x, p1.y), new V2(p2.x, p2.y));
			var f:b2Fixture;
			var lambda:Number = 1;
			
			function GetBodyCallback(fixture:b2Fixture, point:V2, normal:V2, fraction:Number):Number{
				f = fixture;
				f.m_body.GetUserData().alpha -= .2
				lambda = fraction
				
				return lambda
			}
			p1.multiplyN(30)
			p2.multiplyN(30)
			
			drawOn.graphics.clear();
			drawOn.graphics.lineStyle(2,0xff0000,1);
			drawOn.graphics.moveTo(p1.x, p1.y);
			drawOn.graphics.lineTo( (p2.x * lambda + (1 - lambda) * p1.x),
									(p2.y * lambda + (1 - lambda) * p1.y) );
		}
	}
}