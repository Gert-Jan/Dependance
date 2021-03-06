package com.ddg.dep.game.actor 
{
	import com.ddg.dep.Assets;
	import com.ddg.dep.game.actor.behaviour.interaction.AddToInventoryBehavior;
	import com.ddg.dep.game.actor.behaviour.interaction.DoorBehavior;
	import com.ddg.dep.game.actor.behaviour.interaction.DummyInteractionBehavior;
	import com.ddg.dep.game.actor.behaviour.interaction.IInteractionBehavior;
	import com.ddg.dep.game.collision.AABB;
	import com.ddg.dep.game.collision.Tile;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Item implements IActor
	{
		public static const TYPE_KEY:int = 0;
		public static const TYPE_KEY_HOLE:int = 1;
		public static const TYPE_DOOR:int = 2;
		
		// properties
		private var tile:Tile = null;
		private var type:int;
		
		// collision
		private var bounds:AABB;
		
		// behaviors
		private var interactBehavior:IInteractionBehavior;
		
		// grapics
		private var sprite:Sprite = new Sprite();
		
		public function Item(type:int, bounds:AABB, image:Image, interactBehavior:IInteractionBehavior) 
		{
			this.type = type;
			this.bounds = bounds;
			
			interactBehavior.Actor = this;
			this.interactBehavior = interactBehavior;
			
			sprite.addChild(image);
			sprite.pivotY = bounds.height;
			sprite.pivotX = bounds.width / 2;
			ItemManager.Instance.Surface.addChild(sprite);
		}
		
		public static function CreateFromTile(tile:Tile):Item
		{
			var item:Item = null;
			switch(tile.type)
			{
				case Tile.ITEM_KEY:
					item = new Item(
						TYPE_KEY, 
						tile.collision, 
						new Image(Assets.Instance.Tiles.getTexture(String(tile.type))), 
						new AddToInventoryBehavior()
					);
					break;
				case Tile.ITEM_KEY_HOLE:
					item = new Item(
						TYPE_KEY_HOLE, 
						tile.collision, 
						new Image(Assets.Instance.Tiles.getTexture(String(tile.type))),
						new DoorBehavior()
					);
					break;
				case Tile.ITEM_DOOR:
					item = new Item(
						TYPE_DOOR, 
						tile.collision, 
						new Image(Assets.Instance.Tiles.getTexture(String(tile.type))),
						new DoorBehavior()
					);
					break;
			}
			if (item != null)
				item.tile = tile;
			return item;
		}
		
		public function get Type():int
		{
			return type;
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
		{ }
		
		public function get Velocity():Point
		{
			return new Point();
		}
		
		public function get Collision():AABB
		{
			return bounds;
		}
		
		public function ContainsPoint(worldPoint:Point):Boolean
		{
			return bounds.ContainsPoint(worldPoint);
		}
		
		public function Interact(instigator:IActor):void
		{
			interactBehavior.Interact(instigator);
		}
		
		public function Destroy():void
		{
			ItemManager.Instance.Surface.removeChild(sprite);
		}
		
		public function Update(deltaTime:Number):void
		{
			Draw();
		}
		
		private function Draw():void
		{
			sprite.x = bounds.minX + (sprite.width - bounds.width) / 2 + sprite.pivotX;
			sprite.y = bounds.minY + sprite.pivotY;
		}
	}
}