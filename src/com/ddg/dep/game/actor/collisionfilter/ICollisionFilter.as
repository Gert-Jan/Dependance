package com.ddg.dep.game.actor.collisionfilter 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface ICollisionFilter 
	{
		function IsBlocking(tileType:int):Boolean
		function IsValidTrigger(tileType:int):Boolean
	}
}