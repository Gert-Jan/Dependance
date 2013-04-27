package com.ddg.dep.game.collision 
{
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class PointShape 
	{
		public var bottom:Vector.<Point>;
		public var top:Vector.<Point>;
		public var left:Vector.<Point>;
		public var right:Vector.<Point>;
		
		public function PointShape(bottom:Vector.<Point>, top:Vector.<Point>, left:Vector.<Point>, right:Vector.<Point>) 
		{
			this.bottom = bottom;
			this.top = top;
			this.left = left;
			this.right = right;
		}
	}
}