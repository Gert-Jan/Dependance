package com.ddg.dep.view 
{
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.KeyboardEvent;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class ViewManager 
	{
		private static const instance:ViewManager = new ViewManager();
		
		public static function get Instance():ViewManager
		{
			return instance;
		}
		
		public function ViewManager() 
		{}
		
		private var viewStack:Vector.<IView> = new Vector.<IView>();
		private var root:Sprite;
		
		public function Init(root:Sprite):void
		{
			this.root = root;
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, OnKeyUp);
			viewStack.push(new GameView());
			viewStack[0].Activate();
		}
		
		public function Update(deltaTime:Number):void
		{
			for each (var view:IView in viewStack)
			{
				if (view.IsActive)
					view.Update(deltaTime);
			}
		}
		
		public function OnKeyDown(event:KeyboardEvent):void
		{
			for each (var view:IView in viewStack)
			{
				if (view.IsActive)
					view.OnKeyDown(event);
			}
		}
		
		public function OnKeyUp(event:KeyboardEvent):void
		{
			for each (var view:IView in viewStack)
			{
				if (view.IsActive)
					view.OnKeyUp(event);
			}
		}
		
		public function get RootSurface():Sprite
		{
			return root;
		}
	}
}