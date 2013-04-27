package com.ddg.dep.view 
{
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	/**
	 * @author Gert-Jan Stolk
	 */
	public interface IView 
	{
		function Activate():void;
		function Deactivate():void;
		function Update(deltaTime:Number):void;
		function get IsActive():Boolean;
		function get Surface():Sprite;
		function OnKeyDown(event:KeyboardEvent):void;
		function OnKeyUp(event:KeyboardEvent):void;
	}
}