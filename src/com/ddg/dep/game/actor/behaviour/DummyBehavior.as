package com.ddg.dep.game.actor.behaviour 
{
	import com.ddg.dep.game.actor.Dude;
	import com.ddg.dep.game.actor.IActor;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class DummyBehavior implements IBehavior 
	{
		public function DummyBehavior() 
		{}
		
		public function set Actor(value:IActor):void 
		{}
		
		public function Update(deltaTime:Number):void
		{}
		
		public function OnActionStarted():void 
		{}
		
		public function OnActionStopped():void
		{}
	}
}