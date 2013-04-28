package com.ddg.dep.game.actor.collisionfilter 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface ICollisionFilter 
	{
		function IsBlocking(tileType:int):Boolean
		function IsItemBlocking(itemType:int):Boolean
	}
}