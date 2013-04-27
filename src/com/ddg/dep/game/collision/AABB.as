package com.ddg.dep.game.collision 
{
	import com.ddg.dep.util.PointHelper;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class AABB 
	{
		public var minX:Number, maxX:Number, minY:Number, maxY:Number;
		public var width:Number, height:Number;
		
		public function AABB(x:Number, y:Number, width:Number, height:Number) 
		{
			this.minX = x;
			this.maxX = x + width;
			this.minY = y;
			this.maxY = y + height;
			this.width = width;
			this.height = height;
		}
		
		public function SetPosition(x:Number, y:Number):void
		{
			minX = x;
			maxX = x + width;
			minY = y;
			maxY = y + height;
		}
		
		public function LocalToWorldPoint(point:Point):Point
		{
			return PointHelper.Add(new Point(minX, minY), point);
		}
	}
}