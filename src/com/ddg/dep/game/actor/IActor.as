package com.ddg.dep.game.actor 
{
	import com.ddg.dep.game.collision.AABB;
	import flash.geom.Point;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface IActor 
	{
		function set Position(value:Point):void;
		function get Position():Point;
		function set Velocity(value:Point):void;
		function get Velocity():Point;
		function get Collision():AABB;
		function Interact(instigator:IActor):void;
		function Update(deltaTime:Number):void;
	}
}