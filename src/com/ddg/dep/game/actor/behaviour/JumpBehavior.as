package com.ddg.dep.game.actor.behaviour 
{
	import com.ddg.dep.game.actor.Dude;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class JumpBehavior implements IBehavior 
	{
		private var dude:Dude;
		private var isJumping:Boolean;
		private var jumpTime:Number = 0;
		private var maxJumpTime:Number;
		private var jumpPower:Number;
		
		public function JumpBehavior(maxJumpTime:Number = 0.3, jumpPower:Number = 30) 
		{
			this.maxJumpTime = maxJumpTime;
			this.jumpPower = jumpPower;
		}
		
		public function set Actor(value:Dude):void 
		{
			this.dude = value;
		}
		
		public function Update(deltaTime:Number):void
		{
			if (dude.IsBased && jumpTime > 0.1)
			{
				isJumping = false;
				jumpTime = maxJumpTime;
			}
			// jump progress
			if (isJumping)
			{
				// set jump velocity on dude
				var vel:Point = dude.Velocity;
				vel.y -= jumpPower * (1 - jumpTime / maxJumpTime);
				dude.Velocity = vel;
				// update jumptime
				jumpTime = Math.min(jumpTime + deltaTime, maxJumpTime);
			}
		}
		
		public function OnActionStarted():void 
		{
			//init jumping
			if (!isJumping && dude.IsBased)
			{
				isJumping = true;
			}
		}
		
		public function OnActionStopped():void
		{
			// terminate jumping
			isJumping = false;
			jumpTime = 0;
		}
	}
}