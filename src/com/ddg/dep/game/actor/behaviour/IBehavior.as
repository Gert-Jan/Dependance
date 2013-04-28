package com.ddg.dep.game.actor.behaviour 
{
	import com.ddg.dep.game.actor.Dude;
	import com.ddg.dep.game.actor.IActor;
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface IBehavior 
	{
		function set Actor(actor:IActor):void;
		function Update(deltaTime:Number):void;
		function OnActionStarted():void;
		function OnActionStopped():void;
	}
}