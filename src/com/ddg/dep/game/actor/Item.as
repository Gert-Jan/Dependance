package com.ddg.dep.game.actor 
{
	import com.ddg.dep.Assets;
	import com.ddg.dep.game.collision.AABB;
	import com.ddg.dep.game.collision.Tile;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Item
	{
		public static const TYPE_KEY:int = 0;
		public static const TYPE_KEY_HOLE:int = 1;
		public static const TYPE_DOOR:int = 2;
		
		// properties
		private var tile:Tile = null;
		private var type:int;
		
		// collision
		private var bounds:AABB;
		
		// grapics
		private var sprite:Sprite = new Sprite();
		
		public function Item(type:int, bounds:AABB, image:Image) 
		{
			this.type = type;
			this.bounds = bounds;
			
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
					item = new Item(TYPE_KEY, tile.collision, new Image(Assets.Instance.Tiles.getTexture(String(tile.type))));
					break;
				case Tile.ITEM_KEY_HOLE:
					item = new Item(TYPE_KEY_HOLE, tile.collision, new Image(Assets.Instance.Tiles.getTexture(String(tile.type))));
					break;
				case Tile.ITEM_DOOR:
					item = new Item(TYPE_DOOR, tile.collision, new Image(Assets.Instance.Tiles.getTexture(String(tile.type))));
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
		
		public function get Collision():AABB
		{
			return bounds;
		}
		
		public function ContainsPoint(worldPoint:Point):Boolean
		{
			return bounds.ContainsPoint(worldPoint);
		}
		
		public function Interact(instigator:Dude):void
		{
			
		}
		
		public function Destroy():void
		{
			
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