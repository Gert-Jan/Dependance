package com.ddg.dep.ui 
{
	import com.ddg.dep.Assets;
	import com.ddg.dep.audio.AudioLibrary;
	import com.ddg.dep.game.actor.behaviour.DummyBehavior;
	import com.ddg.dep.game.actor.behaviour.GravityBehavior;
	import com.ddg.dep.game.actor.behaviour.JumpBehavior;
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
	public class UIManager 
	{
		private static const instance:UIManager = new UIManager();
		
		public static function get Instance():UIManager
		{
			return instance;
		}
		
		public function UIManager() 
		{}
		
		private var surface:Sprite = new Sprite();
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function Init():void
		{
		}
		
		public function AddWidget(widget:IWidget):void
		{
			surface.addChild(widget.Surface);
		}
		
		public function RemoveWidget(widget:IWidget):void
		{
			surface.removeChild(widget.Surface);
		}
	}
}