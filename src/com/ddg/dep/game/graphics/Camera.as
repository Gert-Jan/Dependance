package com.ddg.dep.game.graphics 
{
	import com.ddg.dep.game.actor.DudeManager;
	import com.ddg.dep.game.level.Level;
	import com.ddg.dep.game.level.LevelManager;
	import com.ddg.dep.Settings;
	import flash.geom.Point;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Camera 
	{
		private static const instance:Camera = new Camera();
		
		public static function get Instance():Camera
		{
			return instance;
		}
		
		public function Camera() 
		{
			UpdateSurface();
		}
		
		private var position:Point = new Point();
		private var targetMovement:Point = new Point();
		private var targetPosition:Point = new Point();
		private var targetTime:Number = 0;
		private var surface:Sprite = new Sprite();
		
		public function SetPosition(x:Number, y:Number):void
		{
			if (position.x != x || position.y != y)
			{
				position.x = x;
				position.y = y;
				UpdateSurface();
			}
			position.x = x;
			position.y = y;
		}
		
		public function get X():Number
		{
			return position.x;
		}
		
		public function set X(x:Number):void
		{
			SetPosition(x, position.y);
		}
		
		public function get Y():Number
		{
			return position.y;
		}
		
		public function set Y(y:Number):void
		{
			SetPosition(position.x, y);
		}
		
		public function get Position():Point
		{
			return position;
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function MoveTo(x:Number, y:Number, time:Number):void
		{
			targetTime = time;
			targetPosition.x = x;
			targetPosition.y = y;
			targetMovement.x = (x - position.x) / time;
			targetMovement.y = (y - position.y) / time;
		}
		
		private function UpdateSurface():void
		{
			surface.removeChildren();
			var nw:Point = ViewToWorld(new Point(0, 0));
			var se:Point = ViewToWorld(new Point(Settings.Instance.StageWidth, Settings.Instance.StageHeight));
			for (var y:int = Math.floor(nw.y / Settings.Instance.StageHeight); y <= Math.floor(se.y / Settings.Instance.StageHeight); y++)
			{
				for (var x:int = Math.floor(nw.x / Settings.Instance.StageWidth); x <= Math.floor(se.x / Settings.Instance.StageWidth); x++)
				{
					var level:Level = LevelManager.Instance.GetLevel(x, y);
					if (level != null)
					{
						surface.addChild(level.Graphics);
					}
				}
			}
			surface.x = -nw.x;
			surface.y = -nw.y;
			var dudeSurface:Sprite = DudeManager.Instance.Surface;
			dudeSurface.x = -nw.x;
			dudeSurface.y = -nw.y;
		}
		
		public function Update(deltaTime:Number):void
		{
			if (targetTime > 0)
			{
				targetTime -= deltaTime;
				if (targetTime <= 0)
				{
					targetTime = 0;
					SetPosition(targetPosition.x, targetPosition.y);
				}
				else
				{
					SetPosition(position.x + targetMovement.x * deltaTime, position.y + targetMovement.y * deltaTime);
				}
			}
		}
		
		public function ViewToWorld(point:Point):Point
		{
			return new Point(position.x + point.x, position.y + point.y);
		}
		
		public function WorldToView(point:Point):Point
		{
			return new Point(point.x - position.x, point.y - position.y);
		}
	}
}