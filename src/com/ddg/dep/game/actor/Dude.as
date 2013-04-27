package com.ddg.dep.game.actor 
{
	import com.ddg.dep.game.actor.behaviour.IBehavior;
	import com.ddg.dep.game.actor.collisionfilter.ICollisionFilter;
	import com.ddg.dep.game.collision.AABB;
	import com.ddg.dep.game.collision.PointShape;
	import com.ddg.dep.game.collision.Tile;
	import com.ddg.dep.game.level.LevelManager;
	import com.ddg.dep.Keys;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.KeyboardEvent;
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
		
		public function Dude(
			gravityBehavior:IBehavior, upBehavior:IBehavior, downBehavior:IBehavior, leftBehavior:IBehavior, rightBehavior:IBehavior, 
			bounds:AABB, collision:PointShape, collisionFilter:ICollisionFilter, image:Image) 
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
			DudeManager.Instance.Surface.addChild(sprite);
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
			}
			return isActive;
		}
		
		public function Update(deltaTime:Number):void
		{
			this.deltaTime = deltaTime;
			UpdateBehaviors(deltaTime);
			UpdateMovement();
			UpdateLevelCollision();
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
		
		private function Draw():void
		{
			sprite.x = bounds.minX;
			sprite.y = bounds.minY;
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