﻿package  {	import Box2DAS.*;	import Box2DAS.Collision.*;	import Box2DAS.Collision.Shapes.*;	import Box2DAS.Common.*;	import Box2DAS.Dynamics.*;	import Box2DAS.Dynamics.Contacts.*;	import Box2DAS.Dynamics.Joints.*;	import flash.display.*;	import flash.events.*;	import flash.utils.*;	import misc.*;		public class Test extends b2World {				public var mouseJoint:b2MouseJoint = null;		public var physScale:Number;		public var world:b2World;		public var groundBody:b2Body;		public var timeStep:Number = 1 / 30;		public var velocityIterations:Number = 10;		public var positionIterations:Number = 10;		public var mp:V2;				public function Test() {			super(new V2(0, 10));			physScale = Main.scale;			world = this;			groundBody = world.m_groundBody;						b2Def.initialize();						var wall:b2PolygonShape = new b2PolygonShape;			var wallBd:b2BodyDef = new b2BodyDef;			var wallF:b2FixtureDef = new b2FixtureDef;			var wallB:b2Body;			wallBd.type = b2Body.b2_staticBody;			wall.SetAsBox(100 / physScale, 400 / physScale / 2);			wallF.shape = wall;			wallBd.position.v2 = new V2( -95 / physScale, 360 / physScale / 2);			wallB = world.CreateBody(wallBd);			wallB.CreateFixture(wallF);			wallBd.position.v2 = new V2((640 + 95) / physScale, 360 / physScale / 2);			wallB = world.CreateBody(wallBd);			wallB.CreateFixture(wallF);						wall.SetAsBox(680 / physScale / 2, 100 / physScale);						wallBd.position.v2 = new V2(640 / physScale / 2, -95 / physScale);			wallB = world.CreateBody(wallBd);			wallB.CreateFixture(wallF);			wallBd.position.v2 = new V2(640 / physScale / 2, (360 + 95) / physScale);			wallB = world.CreateBody(wallBd);			wallB.CreateFixture(wallF);						groundBody = wallB;						wall.destroy();			wallBd.destroy();			wallF.destroy();						Main.aboutText.text = "";		}				public function EnterFrame():void {			mp = new V2(Input.mousePos.x / physScale, Input.mousePos.y / physScale);			MouseDrag();			MouseDestroy();			Step(timeStep, velocityIterations, positionIterations);		}				public function MouseDestroy():void {			if (Input.mouseIsDown && Input.kd('D')) {				var body:b2Body = GetBodyAtMouse(true);				if (body) {					world.DestroyBody(body);				}			}		}				public function MouseDrag():void {			if (Input.mouseIsDown && !mouseJoint && !Input.kd('D')) {				var body:b2Body = GetBodyAtMouse(false);				if (body) {					with(b2Def.mouseJoint) {						bodyA = groundBody;						bodyB = body;						target.v2 = mp;						collideConnected = true;						maxForce = 300.0 * body.GetMass();					}					trace(b2Def.mouseJoint.target.v2);					mouseJoint = world.CreateJoint(b2Def.mouseJoint) as b2MouseJoint;					body.SetAwake(true);				}			}			if ((!Input.mouseIsDown || Input.kd('D')) && mouseJoint) {				world.DestroyJoint(mouseJoint);				mouseJoint = null;			}			if (mouseJoint) {				mouseJoint.SetTarget(mp);			}		}		private function GetBodyAtMouse(includeStatic:Boolean = false):b2Body {			var body:b2Body = null;			world.QueryAABB(function(fixture:b2Fixture):Boolean {				var b:b2Body = fixture.GetBody();				var s:b2Shape = fixture.GetShape();				if(b.IsDynamic() || includeStatic) {					if(s.TestPoint(b.GetTransform(), mp)) {						body = b;						return false;					}				}				return true;			}, AABB.FromV2(mp));			return body;		}			}	}