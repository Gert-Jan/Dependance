package com.ddg.dep.game.actor 
{
	import com.ddg.dep.Assets;
	import com.ddg.dep.game.actor.behaviour.DummyBehavior;
	import com.ddg.dep.game.actor.behaviour.GravityBehavior;
	import com.ddg.dep.game.actor.behaviour.JumpBehavior;
	import com.ddg.dep.game.actor.behaviour.WalkBehavior;
	import com.ddg.dep.game.actor.collisionfilter.NormalCollisionFilter;
	import com.ddg.dep.game.collision.AABB;
	import com.ddg.dep.game.collision.PointShape;
	import com.ddg.dep.Settings;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class DudeManager 
	{
		private static const instance:DudeManager = new DudeManager();
		
		public static function get Instance():DudeManager
		{
			return instance;
		}
		
		public function DudeManager() 
		{}
		
		private var surface:Sprite = new Sprite();
		private var allDudes:Vector.<Dude> = new Vector.<Dude>();
		private var ownedDudes:Vector.<Dude> = new Vector.<Dude>();
		private var currentDude:int = 0;
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function Init():void
		{
			var dude:Dude;
			// normal dude
			dude = new Dude(
				new GravityBehavior(), 
				new JumpBehavior(), 
				new DummyBehavior(),
				new WalkBehavior( -150, -75),
				new WalkBehavior(150, 90),
				new AABB(100, 100, Settings.TILE_WIDTH, Settings.TILE_HEIGHT * 2), 
				new PointShape(
					Vector.<Point>([new Point(Settings.TILE_WIDTH / 2, Settings.TILE_HEIGHT * 2)]),
					Vector.<Point>([new Point(Settings.TILE_WIDTH / 2, 0)]),
					Vector.<Point>([new Point(0, Settings.TILE_HEIGHT / 2), new Point(0, Settings.TILE_HEIGHT + Settings.TILE_HEIGHT / 2)]),
					Vector.<Point>([new Point(Settings.TILE_WIDTH, Settings.TILE_HEIGHT / 2), new Point(Settings.TILE_WIDTH, Settings.TILE_HEIGHT + Settings.TILE_HEIGHT / 2)])
				), 
				new NormalCollisionFilter(),
				new Image(Assets.Instance.DudeNormal)
			);
			allDudes.push(dude);
			ownedDudes.push(dude);
			dude.ToggleActive();
		}
		
		public function Update(deltaTime:Number):void
		{
			for each(var dude:Dude in allDudes)
			{
				dude.Update(deltaTime);
			}
		}
		
		public function OnKeyDown(event:KeyboardEvent):void
		{
			for each(var dude:Dude in ownedDudes)
			{
				dude.OnKeyDown(event);
			}
		}
		
		public function OnKeyUp(event:KeyboardEvent):void
		{
			for each(var dude:Dude in ownedDudes)
			{
				dude.OnKeyUp(event);
			}
		}
	}
}