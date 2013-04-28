package com.ddg.dep.game.collision 
{
	import com.ddg.dep.game.level.Level;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Tile 
	{
		public static const EMPTY:int = 0;
		public static const FULL_BLACK:int = 1;
		public static const FULL_RED:int = 2;
		public static const FULL_BLUE:int = 3;
		public static const FULL_YELLOW:int = 4;
		public static const FULL_WHITE:int = 5;
		public static const FULL_GREY:int = 6;
		
		public var type:int;
		public var level:Level;
		public var collision:AABB;
		
		public function Tile(type:int, level:Level, collision:AABB) 
		{
			this.type = type;
			this.level = level;
			this.collision = collision;
		}
	}
}