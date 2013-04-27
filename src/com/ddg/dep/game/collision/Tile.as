package com.ddg.dep.game.collision 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Tile 
	{
		public static const EMPTY:int = 0;
		public static const FULL:int = 1;
		public static const KEY:int = 2;
		
		public var type:int;
		public var collision:AABB;
		
		public function Tile(type:int, collision:AABB) 
		{
			this.type = type;
			this.collision = collision;
		}
	}
}