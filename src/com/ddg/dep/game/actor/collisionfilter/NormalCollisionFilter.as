package com.ddg.dep.game.actor.collisionfilter 
{
	import com.ddg.dep.game.actor.Item;
	import com.ddg.dep.game.collision.Tile;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class NormalCollisionFilter implements ICollisionFilter 
	{
		public function NormalCollisionFilter() 
		{
			
		}
		
		public function IsBlocking(tileType:int):Boolean 
		{
			return tileType >= Tile.FULL_BLACK && tileType <= Tile.FULL_GREY;
		}
		
		public function IsItemBlocking(itemType:int):Boolean
		{
			return itemType == Item.TYPE_DOOR || 
				itemType == Item.TYPE_KEY_HOLE;
		}
	}
}