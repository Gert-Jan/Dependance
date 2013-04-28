package com.ddg.dep.game.actor.behaviour.interaction 
{
	import com.ddg.dep.game.actor.Dude;
	import com.ddg.dep.game.actor.IActor;
	import com.ddg.dep.game.actor.Item;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class AddToInventoryBehavior implements IInteractionBehavior 
	{
		private var item:Item;
		
		public function AddToInventoryBehavior() 
		{
			
		}
		
		public function set Actor(item:IActor):void
		{
			this.item = Item(item);
		}
		
		public function Interact(instigator:IActor):void
		{
			if (Dude(instigator).Inventory == null)
				Dude(instigator).Inventory = item;
		}
	}
}