package com.ddg.dep.game.actor.behaviour.interaction 
{
	import com.ddg.dep.game.actor.Dude;
	import com.ddg.dep.game.actor.IActor;
	import com.ddg.dep.game.actor.Item;
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface IInteractionBehavior 
	{
		function set Actor(actor:IActor):void;
		function Interact(instigator:IActor):void;
	}
}