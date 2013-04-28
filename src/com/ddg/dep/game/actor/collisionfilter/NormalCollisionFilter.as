package com.ddg.dep.game.actor.collisionfilter 
{
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
			if (tileType >= Tile.FULL_BLACK && tileType <= Tile.FULL_GREY)
				return true;
			return false;
		}
		
		public function IsValidTrigger(tileType:int):Boolean 
		{
			return false;
		}
	}
}