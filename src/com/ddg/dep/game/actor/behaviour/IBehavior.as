package com.ddg.dep.game.actor.behaviour 
{
	import com.ddg.dep.game.actor.Dude;
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface IBehavior 
	{
		function set Actor(dude:Dude):void;
		function Update(deltaTime:Number):void;
		function OnActionStarted():void;
		function OnActionStopped():void;
	}
}