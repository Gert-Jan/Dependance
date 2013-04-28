package com.ddg.dep.game.actor 
{
	import com.ddg.dep.Assets;
	import com.ddg.dep.audio.AudioLibrary;
	import com.ddg.dep.game.actor.behaviour.DummyBehavior;
	import com.ddg.dep.game.actor.behaviour.GravityBehavior;
	import com.ddg.dep.game.actor.behaviour.IBehavior;
	import com.ddg.dep.game.actor.behaviour.JumpBehavior;
	import com.ddg.dep.game.actor.behaviour.SpeechDefaultBehavior;
	import com.ddg.dep.game.actor.behaviour.SpeechTutorialBehavior;
	import com.ddg.dep.game.actor.behaviour.WalkBehavior;
	import com.ddg.dep.game.actor.collisionfilter.NormalCollisionFilter;
	import com.ddg.dep.game.collision.AABB;
	import com.ddg.dep.game.collision.PointShape;
	import com.ddg.dep.Keys;
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
		private var canSwitchDude:Boolean = true;
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function Init():void
		{
			var dude:Dude;
			
			// small dude
			dude = new Dude(
				Vector.<IBehavior>([
					new GravityBehavior(),
					new SpeechDefaultBehavior()
				]), 
				new JumpBehavior(0.3, 22), 
				new DummyBehavior(),
				new WalkBehavior( -150, -75),
				new WalkBehavior(150, 90),
				new AABB(1044, 250, Settings.TILE_WIDTH, Settings.TILE_HEIGHT), 
				new PointShape(
					Vector.<Point>([new Point(Settings.TILE_WIDTH / 2, Settings.TILE_HEIGHT)]),
					Vector.<Point>([new Point(Settings.TILE_WIDTH / 2, 0)]),
					Vector.<Point>([new Point(0, Settings.TILE_HEIGHT / 2)]),
					Vector.<Point>([new Point(Settings.TILE_WIDTH, Settings.TILE_HEIGHT / 2)])
				), 
				new NormalCollisionFilter(),
				new Image(Assets.Instance.DudeSmall),
				AudioLibrary.Instance.AudioSetSmallDude
			);
			allDudes.push(dude);
			ownedDudes.push(dude);
			
			// normal dude
			dude = new Dude(
				Vector.<IBehavior>([
					new GravityBehavior(), 
					new SpeechTutorialBehavior()
				]),
				new JumpBehavior(), 
				new DummyBehavior(),
				new WalkBehavior( -150, -115),
				new WalkBehavior(150, 115),
				new AABB(368, 128, Settings.TILE_WIDTH, Settings.TILE_HEIGHT * 2), 
				new PointShape(
					Vector.<Point>([new Point(Settings.TILE_WIDTH / 4, Settings.TILE_HEIGHT * 2), new Point(Settings.TILE_WIDTH / 4 * 3, Settings.TILE_HEIGHT * 2)]),
					Vector.<Point>([new Point(Settings.TILE_WIDTH / 2, 0)]),
					Vector.<Point>([new Point(0, Settings.TILE_HEIGHT / 2), new Point(0, Settings.TILE_HEIGHT + Settings.TILE_HEIGHT / 2)]),
					Vector.<Point>([new Point(Settings.TILE_WIDTH, Settings.TILE_HEIGHT / 2), new Point(Settings.TILE_WIDTH, Settings.TILE_HEIGHT + Settings.TILE_HEIGHT / 2)])
				), 
				new NormalCollisionFilter(),
				new Image(Assets.Instance.DudeNormal),
				AudioLibrary.Instance.AudioSetNormalDude
			);
			allDudes.push(dude);
			ownedDudes.push(dude);
			dude.ToggleActive();
		}
		
		public function IsNonOwnedDudeNear(dude:Dude, radius:Number):Boolean
		{
			for each (var otherDude:Dude in allDudes)
			{
				if (dude != otherDude &&
					Point.distance(dude.Position, otherDude.Position) < radius && 
					IsOwned(dude) != IsOwned(otherDude))
					return true;
			}
			return false;
		}
		
		public function IsOwned(dude:Dude):Boolean
		{
			for each (var ownedDude:Dude in ownedDudes)
			{
				if (ownedDude == dude)
					return true;
			}
			return false;
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
			if (event.keyCode == Keys.SWITCH && canSwitchDude)
			{
				ownedDudes[currentDude].ToggleActive();
				currentDude = (currentDude + 1) % ownedDudes.length;
				ownedDudes[currentDude].ToggleActive();
				canSwitchDude = false;
			}
			for each(var dude:Dude in ownedDudes)
			{
				dude.OnKeyDown(event);
			}
		}
		
		public function OnKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keys.SWITCH)
			{
				canSwitchDude = true;
			}
			for each(var dude:Dude in ownedDudes)
			{
				dude.OnKeyUp(event);
			}
		}
	}
}