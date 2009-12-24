﻿package  {	import Box2DAS.*;	import Box2DAS.Collision.*;	import Box2DAS.Collision.Shapes.*;	import Box2DAS.Common.*;	import Box2DAS.Dynamics.*;	import Box2DAS.Dynamics.Contacts.*;	import Box2DAS.Dynamics.Joints.*;		public class Ragdoll extends Test {				public function Ragdoll() {			super();						Main.aboutText.text = "Ragdoll";						for (var i:int = 0; i < 2; i++){				var startX:Number = 70 + Math.random() * 20 + 480 * i;				var startY:Number = 20 + Math.random() * 50;								// BODIES								// Head				b2Def.circle.m_radius = 12.5 / physScale;				b2Def.fixture.shape = b2Def.circle;				b2Def.fixture.density = 1.0;				b2Def.fixture.friction = 0.4;				b2Def.fixture.restitution = 0.3;				b2Def.body.type = b2Body.b2_dynamicBody;				b2Def.body.position.v2 = new V2(startX / physScale, startY / physScale);								var head:b2Body = world.CreateBody(b2Def.body);				head.CreateFixture(b2Def.fixture);				//if (i == 0){					head.ApplyImpulse(new V2(Math.random() * 100 - 50, Math.random() * 100 - 50), head.GetWorldCenter());				//}								//Torso				var torso:Array = new Array;				for (var t:int = 0; t < 3; ++t)				{					b2Def.polygon.SetAsBox(15 / physScale, 10 / physScale);					b2Def.fixture.shape = b2Def.polygon;					b2Def.fixture.density = 1.0;					b2Def.fixture.friction = 0.4;					b2Def.fixture.restitution = 0.1;					b2Def.body.position.v2 = new V2(startX / physScale, (startY + 28 + t * 15) / physScale);					var torsoB:b2Body = world.CreateBody(b2Def.body);					torsoB.CreateFixture(b2Def.fixture);					torso.push(torsoB);				}								// UpperArm				b2Def.fixture.density = 1.0;				b2Def.fixture.friction = 0.4;				b2Def.fixture.restitution = 0.1;				// L				b2Def.polygon = new b2PolygonShape();				b2Def.polygon.SetAsBox(18 / physScale, 6.5 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((startX - 30) / physScale, (startY + 20) / physScale);				var upperArmL:b2Body = world.CreateBody(b2Def.body);				upperArmL.CreateFixture(b2Def.fixture);				// R				b2Def.polygon.SetAsBox(18 / physScale, 6.5 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((startX + 30) / physScale, (startY + 20) / physScale);				var upperArmR:b2Body = world.CreateBody(b2Def.body);				upperArmR.CreateFixture(b2Def.fixture);								// LowerArm				b2Def.fixture.density = 1.0;				b2Def.fixture.friction = 0.4;				b2Def.fixture.restitution = 0.1;				// L				b2Def.polygon.SetAsBox(17 / physScale, 6 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((startX - 57) / physScale, (startY + 20) / physScale);				var lowerArmL:b2Body = world.CreateBody(b2Def.body);				lowerArmL.CreateFixture(b2Def.fixture);				// R				b2Def.polygon.SetAsBox(17 / physScale, 6 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((startX + 57) / physScale, (startY + 20) / physScale);				var lowerArmR:b2Body = world.CreateBody(b2Def.body);				lowerArmR.CreateFixture(b2Def.fixture);				//				// UpperLeg				b2Def.fixture.density = 1.0;				b2Def.fixture.friction = 0.4;				b2Def.fixture.restitution = 0.1;				// L				b2Def.polygon.SetAsBox(7.5 / physScale, 22 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((startX - 8) / physScale, (startY + 85) / physScale);				var upperLegL:b2Body = world.CreateBody(b2Def.body);				upperLegL.CreateFixture(b2Def.fixture);				// R				b2Def.polygon.SetAsBox(7.5 / physScale, 22 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((startX + 8) / physScale, (startY + 85) / physScale);				var upperLegR:b2Body = world.CreateBody(b2Def.body);				upperLegR.CreateFixture(b2Def.fixture);				//				// LowerLeg				b2Def.fixture.density = 1.0;				b2Def.fixture.friction = 0.4;				b2Def.fixture.restitution = 0.1;				// L				b2Def.polygon.SetAsBox(6 / physScale, 20 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((startX - 8) / physScale, (startY + 120) / physScale);				var lowerLegL:b2Body = world.CreateBody(b2Def.body);				lowerLegL.CreateFixture(b2Def.fixture);				// R				b2Def.polygon.SetAsBox(6 / physScale, 20 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((startX + 8) / physScale, (startY + 120) / physScale);				var lowerLegR:b2Body = world.CreateBody(b2Def.body);				lowerLegR.CreateFixture(b2Def.fixture);				// JOINTS				b2Def.revoluteJoint.enableLimit = true;								// Head to shoulders				b2Def.revoluteJoint.lowerAngle = -40 / (180 / Math.PI);				b2Def.revoluteJoint.upperAngle = 40 / (180 / Math.PI);				b2Def.revoluteJoint.Initialize(torso[0], head, new V2(startX / physScale, (startY + 15) / physScale));				world.CreateJoint(b2Def.revoluteJoint);								// Upper arm to shoulders				// L				b2Def.revoluteJoint.lowerAngle = -85 / (180/Math.PI);				b2Def.revoluteJoint.upperAngle = 130 / (180/Math.PI);				b2Def.revoluteJoint.Initialize(torso[0], upperArmL, new V2((startX - 18) / physScale, (startY + 20) / physScale));				world.CreateJoint(b2Def.revoluteJoint);				// R				b2Def.revoluteJoint.lowerAngle = -130 / (180/Math.PI);				b2Def.revoluteJoint.upperAngle = 85 / (180/Math.PI);				b2Def.revoluteJoint.Initialize(torso[0], upperArmR, new V2((startX + 18) / physScale, (startY + 20) / physScale));				world.CreateJoint(b2Def.revoluteJoint);				//				// Lower arm to upper arm				// L				b2Def.revoluteJoint.lowerAngle = -130 / (180/Math.PI);				b2Def.revoluteJoint.upperAngle = 10 / (180/Math.PI);				b2Def.revoluteJoint.Initialize(upperArmL, lowerArmL, new V2((startX - 45) / physScale, (startY + 20) / physScale));				world.CreateJoint(b2Def.revoluteJoint);				// R				b2Def.revoluteJoint.lowerAngle = -10 / (180/Math.PI);				b2Def.revoluteJoint.upperAngle = 130 / (180/Math.PI);				b2Def.revoluteJoint.Initialize(upperArmR, lowerArmR, new V2((startX + 45) / physScale, (startY + 20) / physScale));				world.CreateJoint(b2Def.revoluteJoint);								// Shoulders/stomach				b2Def.revoluteJoint.lowerAngle = -15 / (180 / Math.PI);				b2Def.revoluteJoint.upperAngle = 15 / (180 / Math.PI);				b2Def.revoluteJoint.Initialize(torso[0], torso[1], new V2(startX / physScale, (startY + 35) / physScale));				world.CreateJoint(b2Def.revoluteJoint);				// Stomach/hips				b2Def.revoluteJoint.Initialize(torso[1], torso[2], new V2(startX / physScale, (startY + 50) / physScale));				world.CreateJoint(b2Def.revoluteJoint);								// Torso to upper leg				// L				b2Def.revoluteJoint.lowerAngle = -25 / (180/Math.PI);				b2Def.revoluteJoint.upperAngle = 45 / (180/Math.PI);				b2Def.revoluteJoint.Initialize(torso[2], upperLegL, new V2((startX - 8) / physScale, (startY + 72) / physScale));				world.CreateJoint(b2Def.revoluteJoint);				// R				b2Def.revoluteJoint.lowerAngle = -45 / (180/Math.PI);				b2Def.revoluteJoint.upperAngle = 25 / (180/Math.PI);				b2Def.revoluteJoint.Initialize(torso[2], upperLegR, new V2((startX + 8) / physScale, (startY + 72) / physScale));				world.CreateJoint(b2Def.revoluteJoint);				// Upper leg to lower leg				// L				b2Def.revoluteJoint.lowerAngle = -25 / (180/Math.PI);				b2Def.revoluteJoint.upperAngle = 115 / (180/Math.PI);				b2Def.revoluteJoint.Initialize(upperLegL, lowerLegL, new V2((startX - 8) / physScale, (startY + 105) / physScale));				world.CreateJoint(b2Def.revoluteJoint);				// R				b2Def.revoluteJoint.lowerAngle = -115 / (180/Math.PI);				b2Def.revoluteJoint.upperAngle = 25 / (180/Math.PI);				b2Def.revoluteJoint.Initialize(upperLegR, lowerLegR, new V2((startX + 8) / physScale, (startY + 105) / physScale));				world.CreateJoint(b2Def.revoluteJoint);			}			// Add stairs on the left			b2Def.fixture.friction = 0.4;			b2Def.fixture.restitution = 0.3;			b2Def.body.type = b2Body.b2_staticBody;			for (var j:int = 1; j <= 10; j++) {				b2Def.polygon.SetAsBox((10*j) / physScale, 10 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((10*j) / physScale, (150 + 20*j) / physScale);				head = world.CreateBody(b2Def.body);				head.CreateFixture(b2Def.fixture);			}			// Add stairs on the right			for (var k:int = 1; k <= 10; k++){				b2Def.polygon.SetAsBox((10 * k) / physScale, 10 / physScale);				b2Def.fixture.shape = b2Def.polygon;				b2Def.body.position.v2 = new V2((640-10*k) / physScale, (150 + 20*k) / physScale);				head = world.CreateBody(b2Def.body);				head.CreateFixture(b2Def.fixture);			}			b2Def.polygon.SetAsBox(30 / physScale, 40 / physScale);			b2Def.fixture.shape = b2Def.polygon;			b2Def.body.position.v2 = new V2(320 / physScale, 320 / physScale);			head = world.CreateBody(b2Def.body);			head.CreateFixture(b2Def.fixture);		}	}}