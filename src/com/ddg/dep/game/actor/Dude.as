package com.ddg.dep.game.actor 
{
	import com.ddg.dep.audio.AudioLibrary;
	import com.ddg.dep.audio.AudioSet;
	import com.ddg.dep.game.actor.behaviour.IBehavior;
	import com.ddg.dep.game.actor.collisionfilter.ICollisionFilter;
	import com.ddg.dep.game.collision.AABB;
	import com.ddg.dep.game.collision.PointShape;
	import com.ddg.dep.game.collision.Tile;
	import com.ddg.dep.game.level.Level;
	import com.ddg.dep.game.level.LevelManager;
	import com.ddg.dep.Keys;
	import com.ddg.dep.Settings;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
	import starling.utils.MatrixUtil;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Dude 
	{
		// properties
		private var velocity:Point = new Point();
		private var isActive:Boolean;
		private var isBased:Boolean;
		
		// collision
		private var bounds:AABB;
		private var collision:PointShape;
		private var collisionFilter:ICollisionFilter;
		
		// temp vars
		private var deltaTime:Number;
		
		// behaviours
		private var gravityBehavior:IBehavior;
		private var upBehavior:IBehavior;
		private var leftBehavior:IBehavior;
		private var rightBehavior:IBehavior;
		private var downBehavior:IBehavior;
		
		// grapics
		private var sprite:Sprite = new Sprite();
		
		// audio
		private var audioSet:AudioSet;
		
		public function Dude(
			gravityBehavior:IBehavior, upBehavior:IBehavior, downBehavior:IBehavior, leftBehavior:IBehavior, rightBehavior:IBehavior, 
			bounds:AABB, collision:PointShape, collisionFilter:ICollisionFilter, image:Image, audioSet:AudioSet) 
		{
			this.gravityBehavior = gravityBehavior;
			this.gravityBehavior.Actor = this;
			this.upBehavior = upBehavior;
			this.upBehavior.Actor = this;
			this.downBehavior = downBehavior;
			this.downBehavior.Actor = this;
			this.leftBehavior = leftBehavior;
			this.leftBehavior.Actor = this;
			this.rightBehavior = rightBehavior;
			this.rightBehavior.Actor = this;
			
			this.bounds = bounds;
			this.collision = collision;
			this.collisionFilter = collisionFilter;
			trace(DudeManager.Instance);
			trace(DudeManager.Instance.Surface);
			
			sprite.addChild(image);
			sprite.pivotY = bounds.height;
			sprite.pivotX = bounds.width / 2;
			DudeManager.Instance.Surface.addChild(sprite);
			
			this.audioSet = audioSet;
		}
		
		public function set Position(value:Point):void
		{
			this.bounds.SetPosition(value.x, value.y);
		}
		
		public function get Position():Point
		{
			return new Point(bounds.minX, bounds.minY);
		}
		
		public function set Velocity(value:Point):void
		{
			this.velocity = value;
		}
		
		public function get Velocity():Point
		{
			return this.velocity;
		}
		
		public function get IsBased():Boolean
		{
			return isBased;
		}
		
		public function ToggleActive():Boolean
		{
			isActive = !isActive;
			if (!isActive)
			{
				upBehavior.OnActionStopped();
				downBehavior.OnActionStopped();
				leftBehavior.OnActionStopped();
				rightBehavior.OnActionStopped();
				audioSet.StopAll();
				Starling.juggler.removeTweens(sprite);
			}
			else
			{
				audioSet.PlayLayer(AudioLibrary.ACTION_IDLE);
				audioSet.PlayLayer(AudioLibrary.ACTION_WALK);
				audioSet.SetLayerVolume(AudioLibrary.ACTION_WALK, 0);
				IterateBounch();
			}
			return isActive;
		}
		
		public function Update(deltaTime:Number):void
		{
			this.deltaTime = deltaTime;
			UpdateBehaviors(deltaTime);
			UpdateMovement();
			UpdateLevelCollision();
			UpdateLevelChange();
			UpdateAudio();
			Draw();
		}
		
		private function UpdateBehaviors(deltaTime:Number):void
		{
			gravityBehavior.Update(deltaTime);
			upBehavior.Update(deltaTime);
			downBehavior.Update(deltaTime);
			leftBehavior.Update(deltaTime);
			rightBehavior.Update(deltaTime);
		}
		
		private function UpdateMovement():void
		{
			bounds.SetPosition(bounds.minX + velocity.x * deltaTime, bounds.minY + velocity.y * deltaTime);
		}
		
		private function UpdateLevelCollision():void
		{
			var tile:Tile = null;
			var point:Point = new Point();
			var worldPoint:Point = new Point();
			isBased = false;
			
			// bottom pushout
			for each (point in collision.bottom)
			{
				worldPoint = bounds.LocalToWorldPoint(point);
				tile = LevelManager.Instance.GetTileOnPoint(worldPoint);
				if (tile != null && collisionFilter.IsBlocking(tile.type))
				{
					bounds.SetPosition(bounds.minX, bounds.minY + tile.collision.minY - worldPoint.y);
					velocity.y = Math.min(velocity.y, 0);
					isBased = true;
				}
			}
			// top pushout
			for each (point in collision.top)
			{
				worldPoint = bounds.LocalToWorldPoint(point);
				tile = LevelManager.Instance.GetTileOnPoint(worldPoint);
				if (tile != null && collisionFilter.IsBlocking(tile.type))
				{
					bounds.SetPosition(bounds.minX, bounds.minY + tile.collision.maxY - worldPoint.y);
					velocity.y = Math.max(velocity.y, 0);
				}
			}
			// left pushout
			for each (point in collision.left)
			{
				worldPoint = bounds.LocalToWorldPoint(point);
				tile = LevelManager.Instance.GetTileOnPoint(worldPoint);
				if (tile != null && collisionFilter.IsBlocking(tile.type))
				{
					bounds.SetPosition(bounds.minX + tile.collision.maxX - worldPoint.x, bounds.minY);
					velocity.x = Math.max(velocity.x, 0);
				}
			}
			// right pushout
			for each (point in collision.right)
			{
				worldPoint = bounds.LocalToWorldPoint(point);
				tile = LevelManager.Instance.GetTileOnPoint(worldPoint);
				if (tile != null && collisionFilter.IsBlocking(tile.type))
				{
					bounds.SetPosition(bounds.minX + tile.collision.minX - worldPoint.x, bounds.minY);
					velocity.x = Math.min(velocity.x, 0);
				}
			}
		}
		
		private function UpdateLevelChange():void
		{
			var level:Level = LevelManager.Instance.CurrentLevel;
			if (velocity.x > 0 && bounds.maxX > level.X + Settings.Instance.StageWidth)
				LevelManager.Instance.CurrentLevel = LevelManager.Instance.GetLevel(level.XIndex + 1, level.YIndex);
			else if (velocity.x < 0 && bounds.minX < level.X)
				LevelManager.Instance.CurrentLevel = LevelManager.Instance.GetLevel(level.XIndex - 1, level.YIndex);
			else if (velocity.y > 0 && bounds.maxY > level.Y + Settings.Instance.StageHeight)
				LevelManager.Instance.CurrentLevel = LevelManager.Instance.GetLevel(level.XIndex, level.YIndex + 1);
			else if (velocity.y < 0 && bounds.minY < level.Y)
				LevelManager.Instance.CurrentLevel = LevelManager.Instance.GetLevel(level.XIndex, level.YIndex - 1);
		}
		
		private function IterateBounch(direction:int = 1):void
		{
			Starling.juggler.tween(sprite, audioSet.NextBeatDeltaTime + 0.05, 
			{
				transition: Transitions.EASE_OUT,
				onComplete: function():void { IterateBounch(sprite.scaleY == 1 ? direction : -direction); },
				scaleY: sprite.scaleY < 1 ? 1 : 0.95,
				skewX: sprite.scaleY == 1 ? 0 : 0.05 * direction
			});
		}
		
		private function UpdateAudio():void
		{
			if (Math.abs(velocity.x) > 0 || Math.abs(velocity.y))
				audioSet.FadeInLayer(AudioLibrary.ACTION_WALK, 0.2);
			else
				audioSet.FadeOutLayer(AudioLibrary.ACTION_WALK,0.01);
		}
		
		private function Draw():void
		{
			sprite.x = bounds.minX + (sprite.width - bounds.width) / 2 + sprite.pivotX;
			sprite.y = bounds.minY + sprite.pivotY;
		}
		
		public function OnKeyDown(event:KeyboardEvent):void
		{
			if (isActive)
			{
				switch(event.keyCode)
				{
					case Keys.UP:
						upBehavior.OnActionStarted();
						break;
					case Keys.DOWN:
						downBehavior.OnActionStarted();
						break;
					case Keys.LEFT:
						leftBehavior.OnActionStarted();
						break;
					case Keys.RIGHT:
						rightBehavior.OnActionStarted();
						break;
				}
			}
		}
		
		public function OnKeyUp(event:KeyboardEvent):void
		{
			if (isActive)
			{
				switch(event.keyCode)
				{
					case Keys.UP:
						upBehavior.OnActionStopped();
						break;
					case Keys.DOWN:
						downBehavior.OnActionStopped();
						break;
					case Keys.LEFT:
						leftBehavior.OnActionStopped();
						break;
					case Keys.RIGHT:
						rightBehavior.OnActionStopped();
						break;
				}
			}
		}
	}
}