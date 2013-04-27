package com.ddg.dep.game.collision 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Tile 
	{
		public var type:int;
		public var collision:AABB;
		
		public function Tile(type:int, collision:AABB) 
		{
			this.type = type;
			this.collision = collision;
		}
	}
}