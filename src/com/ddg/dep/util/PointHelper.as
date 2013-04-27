package com.ddg.dep.util 
{
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class PointHelper 
	{
		public static function Add(point1:Point, point2:Point):Point
		{
			return new Point(point1.x + point2.x, point1.y + point2.y);
		}
	}
}