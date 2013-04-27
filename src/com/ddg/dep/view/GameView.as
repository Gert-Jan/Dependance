package com.ddg.dep.view 
{
	import com.ddg.dep.Assets;
	import com.ddg.dep.audio.AudioManager;
	import com.ddg.dep.game.actor.DudeManager;
	import com.ddg.dep.game.graphics.Camera;
	import com.ddg.dep.game.level.LevelManager;
	import com.ddg.dep.Keys;
	import com.ddg.dep.Settings;
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class GameView implements IView
	{
		private var camera:Camera = null;
		private var surface:Sprite = new Sprite();
		private var isActive:Boolean = false;
		
		public function GameView() 
		{
			Init();
			InitTest();
		}
		
		private function Init():void
		{
			LevelManager.Instance.Init();
			camera = Camera.Instance;
			surface.addChild(camera.Surface);
			
			DudeManager.Instance.Init();
			surface.addChild(DudeManager.Instance.Surface);
			
			LevelManager.Instance.CurrentLevel = LevelManager.Instance.GetLevel(0, 0);
		}
		
		private function InitTest():void
		{
			
		}
		
		public function Activate():void
		{
			if (!isActive)
			{
				isActive = true;
				ViewManager.Instance.RootSurface.addChild(surface);
			}
		}
		
		public function Deactivate():void
		{
			if (isActive)
			{
				isActive = false;
				ViewManager.Instance.RootSurface.removeChild(surface);
			}
		}
		
		public function Update(deltaTime:Number):void
		{
			AudioManager.Instance.Update(deltaTime);
			camera.Update(deltaTime);
			DudeManager.Instance.Update(deltaTime);
		}
		
		public function get IsActive():Boolean
		{
			return isActive;
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function OnKeyDown(event:KeyboardEvent):void
		{
			DudeManager.Instance.OnKeyDown(event);
			/*
			var currentLevelX:int = Math.floor(camera.X / Settings.Instance.StageWidth);
			var currentLevelY:int = Math.floor(camera.Y / Settings.Instance.StageHeight);
			switch (event.keyCode)
			{
				case Keys.UP:
					camera.MoveTo(currentLevelX * Settings.Instance.StageWidth, (currentLevelY - 1) * Settings.Instance.StageHeight, 0.5);
					break;
				case Keys.DOWN:
					camera.MoveTo(currentLevelX * Settings.Instance.StageWidth, (currentLevelY + 1) * Settings.Instance.StageHeight, 0.5);
					break;
				case Keys.LEFT:
					camera.MoveTo((currentLevelX - 1) * Settings.Instance.StageWidth, currentLevelY * Settings.Instance.StageHeight, 0.5);
					break;
				case Keys.RIGHT:
					camera.MoveTo((currentLevelX + 1) * Settings.Instance.StageWidth, currentLevelY * Settings.Instance.StageHeight, 0.5);
					break;
			}
			*/
		}
		
		public function OnKeyUp(event:KeyboardEvent):void
		{
			DudeManager.Instance.OnKeyUp(event);
		}
	}
}