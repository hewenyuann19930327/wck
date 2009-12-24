﻿package  {	import Box2DAS.*;	import Box2DAS.Collision.*;	import Box2DAS.Collision.Shapes.*;	import Box2DAS.Common.*;	import Box2DAS.Dynamics.*;	import Box2DAS.Dynamics.Contacts.*;	import Box2DAS.Dynamics.Joints.*;	import misc.*;		public class MyTest extends Test	{		public function MyTest() 		{			super();			Main.aboutText.text = "something"			//world.SetGravity(new V2());						var definition:Object = {				friction:1.0,				restitution:0.5,				bodies: [					{						name:"head", x:0, y:0,						angle:30 * 3.15 / 180,						shapes:[ 							{ type:"circle", x:0, y:0, r:1 } ,						] 					},					{						name:"torso", x:0, y:3,						shapes:[							{ type:"box", x:0, y:0, hx:1, hy:2 } 						]					},					{						name:"rightarm", x:3, y:1.5,						shapes:[							{ type:"box", hx:2, hy:0.5 } 						]					},					{						name:"leftarm", x:-3, y:1.5,						shapes:[							{ type:"box", hx:2, hy:0.5 } 						]					},					{						name:"leftleg", x:-0.5, y:7,						shapes:[							{ type:"box", hx:0.5, hy:2 } 						]					},					{						name:"rightleg", x:0.5, y:7,						shapes:[							{ type:"box", hx:0.5, hy:2 } 						]					},				],				joints: [					{						type:"revolute",						body1:"head",						body2:"torso",						x: 0, y: 1					},					{						type:"revolute",						body1:"rightarm",						body2:"torso",						x: 1, y: 1.5					},					{						type:"revolute",						body1:"leftarm",						body2:"torso",						x: -1, y: 1.5					},					{						type:"revolute",						body1:"leftleg",						body2:"torso",						x: -0.5, y: 5					},					{						type:"revolute",						body1:"rightleg",						body2:"torso",						x: 0.5, y: 5					}				]			}						var o:Object = Create(definition, 5, 2, 0, 1);			Create(definition, 10, 10, 30 * 3.14 / 180, 2, "small", o);			trace((o.torso as b2Body).GetPosition());			trace((o.smalltorso as b2Body).GetPosition());		}				private function Get(obj:Object, prop:*, def:*):*		{			return obj.hasOwnProperty(prop) ? obj[prop] : def;		}				private function MakeV2(x:Number, y:Number, gx:Number, gy:Number, ga:Number, scale:Number):V2		{			var v:V2 = new V2(x / scale, y / scale);			v.rotate(ga);			v.x += gx;			v.y += gy;			return v;		}				public function Create(definition:Object, x:Number = 0, y:Number = 0, angle:Number = 0, scale:Number = 1, prefix:String = "", objects:Object = null):Object		{			if (!objects)				objects = new Object;							var bd:b2BodyDef = new b2BodyDef;			var poly:b2PolygonShape = new b2PolygonShape;			var circ:b2CircleShape = new b2CircleShape;			var f:b2FixtureDef = new b2FixtureDef;			var rj:b2RevoluteJointDef = new b2RevoluteJointDef();			var gFriction:Number = Get(definition, "friction", 0);			var gRestitution:Number = Get(definition, "restitution", 1);			var gDensity:Number = Get(definition, "density", 1);			if (definition.hasOwnProperty("bodies") && null != definition.bodies as Array) 			{				for each(var body:* in definition.bodies)				{					if (null == body as Object)						continue;											switch(Get(body, "type", "dynamic"))					{						case "kinematic": bd.type = b2Body.b2_kinematicBody; break;						case "static": bd.type = b2Body.b2_staticBody; break;						default: bd.type = b2Body.b2_dynamicBody; 					}										bd.userData = Get(body, "userData", null);					bd.position.v2 = MakeV2(Get(body, "x", 0), Get(body, "y", 0), x, y, angle, scale);					bd.linearVelocity.v2 = MakeV2(Get(body, "vx", 0), Get(body, "vy", 0), 0, 0, angle, scale);					bd.angle = Get(body, "angle", 0) + angle;					bd.angularVelocity = Get(body, "av", 0);					bd.linearDamping = Get(body, "linearDamping", 0);					bd.angularDamping = Get(body, "angularDamping", 0);					bd.allowSleep = Get(body, "allowSleep", true);					bd.awake = Get(body, "awake", true);					bd.fixedRotation = Get(body, "fixedRotation", false);					bd.bullet = Get(body, "bullet", false);					bd.active = Get(body, "active", true);					bd.inertiaScale = Get(body, "inertiaScale", 1.0);										var friction:Number = Get(body, "friction", gFriction);					var restitution:Number = Get(body, "restitution", gRestitution);					var density:Number = Get(body, "density", gDensity);										var b:b2Body = world.CreateBody(bd);					if (body.hasOwnProperty("name") && null != body.name as String)					{						objects[prefix + body.name] = b;					}										if (body.hasOwnProperty("shapes") && null != body.shapes as Array)					{						for each(var shape:* in body.shapes)						{							if (null == shape as Object)								continue;															switch(Get(shape, "type", ""))							{							case "circle":								circ.m_radius = Get(shape, "r", 1) / scale;								circ.m_p.x = Get(shape, "x", 0) / scale;								circ.m_p.y = Get(shape, "y", 0) / scale;								f.shape = circ;								break;							case "box":								poly.SetAsBox(Get(shape, "hx", 1) / scale, Get(shape, "hy", 1) / scale, 									new V2(Get(shape, "x", 0) / scale, Get(shape, "y", 0) / scale));								f.shape = poly;								break;							default:								f.shape = null;							}														if (f.shape != null)							{								f.userData = Get(shape, "userData", null);								f.friction = Get(shape, "friction", friction);								f.restitution = Get(shape, "restitution", restitution);								f.density = Get(shape, "density", density);								f.isSensor = Get(shape, "sensor", false);								//f.filter =								b.CreateFixture(f);							}						}					}				}			}						if (definition.hasOwnProperty("joints") && null != definition.joints as Array)			{				for each(var joint:* in definition.joints)				{					if (null == joint as Object)						continue;										var b1:b2Body = Get(objects, prefix + Get(joint, "body1", ""), null);					var b2:b2Body = Get(objects, prefix + Get(joint, "body2", ""), null);					if (!b1 || !b2)						continue;											var jd:b2JointDef;					switch(Get(joint, "type", null))					{					case "revolute":												rj.Initialize(b1, b2, 							MakeV2(Get(joint, "x", 0), Get(joint, "y", 0), x, y, angle, scale));						jd = rj;						break;					default:						jd = null;					}										if (!jd)						continue;										jd.userData = Get(joint, "userData", null);					jd.collideConnected = Get(joint, "collideConnected", false);										var j:b2Joint = world.CreateJoint(jd);					if (null != Get(joint, "name", null) as String)					{						objects[joint.name] = j;					}				}			}						bd.destroy();			poly.destroy();			circ.destroy();			f.destroy();			rj.destroy();			return objects;		}			}	}