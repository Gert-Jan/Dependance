package com.ddg.dep.game.actor.behaviour.interaction 
{
	import com.ddg.dep.game.actor.Dude;
	import com.ddg.dep.game.actor.IActor;
	import com.ddg.dep.game.actor.Item;
	import com.ddg.dep.game.actor.ItemManager;
	import com.ddg.dep.game.collision.AABB;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class DoorBehavior implements IInteractionBehavior 
	{
		private var item:Item;
		
		public function DoorBehavior() 
		{
			
		}
		
		public function set Actor(item:IActor):void
		{
			this.item = Item(item);
		}
		
		public function Interact(instigator:IActor):void
		{
			if (instigator is Dude && Dude(instigator).Inventory != null && Dude(instigator).Inventory.Type == Item.TYPE_KEY)
			{
				OpenDoor(item);
				DestroyKey(Dude(instigator));
			}
			else if (instigator is Item && (Item(instigator).Type == Item.TYPE_DOOR || Item(instigator).Type == Item.TYPE_KEY_HOLE))
			{
				OpenDoor(instigator);
			}
		}
		
		private function OpenDoor(instigator:IActor):void
		{
			var bounds:AABB = item.Collision;
			ItemManager.Instance.DestroyItem(item);
			// also open neighboring door blocks
			var neighbor:Item;
			// top
			neighbor = ItemManager.Instance.GetItemAtPoint(new Point(bounds.minX + 8, bounds.minY - 8));
			if (neighbor != null && neighbor != instigator && (neighbor.Type == Item.TYPE_DOOR || neighbor.Type == Item.TYPE_KEY_HOLE))
				neighbor.Interact(instigator);
			// bottom
			neighbor = ItemManager.Instance.GetItemAtPoint(new Point(bounds.minX + 8, bounds.maxY + 8));
			if (neighbor != null && neighbor != instigator && (neighbor.Type == Item.TYPE_DOOR || neighbor.Type == Item.TYPE_KEY_HOLE))
				neighbor.Interact(instigator);
			// left
			neighbor = ItemManager.Instance.GetItemAtPoint(new Point(bounds.minX - 8, bounds.minY + 8));
			if (neighbor != null && neighbor != instigator && (neighbor.Type == Item.TYPE_DOOR || neighbor.Type == Item.TYPE_KEY_HOLE))
				neighbor.Interact(instigator);
			// right
			neighbor = ItemManager.Instance.GetItemAtPoint(new Point(bounds.maxX + 8, bounds.minY + 8));
			if (neighbor != null && neighbor != instigator && (neighbor.Type == Item.TYPE_DOOR || neighbor.Type == Item.TYPE_KEY_HOLE))
				neighbor.Interact(instigator);
		}
		
		private function DestroyKey(instigator:Dude):void
		{
			if (instigator.Inventory != null)
			{
				ItemManager.Instance.DestroyItem(instigator.Inventory);
				instigator.Inventory = null;
			}
		}
	}
}