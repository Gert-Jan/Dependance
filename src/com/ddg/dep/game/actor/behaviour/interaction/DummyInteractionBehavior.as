package com.ddg.dep.game.actor.behaviour.interaction 
{
	import com.ddg.dep.game.actor.Dude;
	import com.ddg.dep.game.actor.Item;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class DummyInteractionBehavior implements IInteractionBehavior 
	{
		public function DummyInteractionBehavior() 
		{}
		
		public function set Actor(item:Item):void
		{}
		
		public function Interact(instigator:Dude):void
		{}
	}
}