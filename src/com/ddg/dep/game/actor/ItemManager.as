package com.ddg.dep.game.actor 
{
	import com.ddg.dep.Assets;
	import com.ddg.dep.game.collision.Tile;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class ItemManager 
	{
		private static const instance:ItemManager = new ItemManager();
		
		public static function get Instance():ItemManager
		{
			return instance;
		}
		
		public function ItemManager() 
		{}
		
		private var surface:Sprite = new Sprite();
		private var items:Vector.<Item> = new Vector.<Item>();
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function Init():void
		{
		}
		
		public function CreateItemFromTile(tile:Tile):void
		{
			items.push(Item.CreateFromTile(tile));
		}
		
		public function DestroyItem(item:Item):void
		{
			item.Destroy();
			items.splice(items.indexOf(item), 1);
		}
		
		public function GetItemAtPoint(worldPoint:Point):Item
		{
			for each (var item:Item in items)
			{
				if (item.ContainsPoint(worldPoint))
					return item;
			}
			return null;
		}
		
		public function Update(deltaTime:Number):void
		{
			for each(var item:Item in items)
			{
				item.Update(deltaTime);
			}
		}
	}
}