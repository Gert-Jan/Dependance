package com.ddg.dep.game.actor.behaviour 
{
	import com.ddg.dep.game.actor.Dude;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class WalkBehavior implements IBehavior 
	{
		private var dude:Dude;
		private var isWalking:Boolean = false;
		private var speed:Number;
		private var airSpeed:Number;
		
		public function WalkBehavior(speed:Number, airSpeed:Number) 
		{
			this.speed = speed;
			this.airSpeed = airSpeed;
		}
		
		public function set Actor(value:Dude):void 
		{
			this.dude = value;
		}
		
		public function Update(deltaTime:Number):void
		{
			if (isWalking)
			{
				// set jump velocity on dude
				var vel:Point = dude.Velocity;
				vel.x = dude.IsBased ? speed : airSpeed;
				dude.Velocity = vel;
			}
		}
		
		public function OnActionStarted():void 
		{
			isWalking = true;
		}
		
		public function OnActionStopped():void
		{
			var vel:Point = dude.Velocity;
			if (speed > 0)
				vel.x = Math.min(vel.x, 0);
			else
				vel.x = Math.max(vel.x, 0);
			dude.Velocity = vel;
			isWalking = false;
		}
	}
}