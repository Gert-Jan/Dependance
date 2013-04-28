package com.ddg.dep.game.actor.behaviour 
{
	import com.ddg.dep.game.actor.Dude;
	import com.ddg.dep.game.actor.IActor;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class GravityBehavior implements IBehavior 
	{
		private var actor:IActor;
		private var gravity:Number;
		private var terminalVelocity:Number;
		
		public function GravityBehavior(gravity:Number = 500, terminalVelocity:Number = 1000) 
		{
			this.gravity = gravity;
			this.terminalVelocity = terminalVelocity;
		}
		
		public function set Actor(value:IActor):void 
		{
			actor = value;
		}
		
		public function Update(deltaTime:Number):void
		{
			var vel:Point = actor.Velocity;
			vel.y = Math.min(terminalVelocity, vel.y + gravity * deltaTime);
			actor.Velocity = vel;
		}
		
		public function OnActionStarted():void 
		{}
		
		public function OnActionStopped():void 
		{}
	}
}