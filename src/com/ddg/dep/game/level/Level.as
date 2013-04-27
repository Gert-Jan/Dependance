package com.ddg.dep.game.level 
{
	import com.ddg.dep.Assets;
	import com.ddg.dep.game.collision.AABB;
	import com.ddg.dep.game.collision.Tile;
	import com.ddg.dep.Settings;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Level 
	{
		private var x:int = 0;
		private var y:int = 0;
		private var width:int = 0;
		private var height:int = 0;
		private var data:Vector.<int> = null;
		private var sprite:Sprite = new Sprite();
		private static var tileSheet:TextureAtlas = Assets.Instance.Tiles;
		
		public function Level(x:int, y:int, width:int, height:int, data:Vector.<int>) 
		{
			this.x = x * Settings.Instance.StageWidth;
			this.y = y * Settings.Instance.StageHeight;
			this.width = width;
			this.height = height;
			this.data = data;
			InitSprite();
		}
		
		private function InitSprite():void
		{
			for (var y:int = 0; y < height; y++)
			{
				for (var x:int = 0; x < width; x++)
				{
					var tile:Tile = GetTile(x, y);
					if (tile != null)
					{
						var image:Image = new Image(tileSheet.getTexture(tile.type.toString()));
						image.x = x * Settings.TILE_WIDTH;
						image.y = y * Settings.TILE_HEIGHT;
						sprite.addChild(image);
					}
				}
			}
			sprite.x = this.x;
			sprite.y = this.y;
		}
		
		public function get X():int
		{
			return x;
		}
		
		public function get Y():int
		{
			return y;
		}
		
		public function GetTile(x:int, y:int):Tile
		{
			if (x >= 0 && x < width &&
				y >= 0 && y < height &&
				data[y * width + x] > 0)
				return new Tile(data[y * width + x], new AABB(this.x + x * Settings.TILE_WIDTH, this.y + y * Settings.TILE_HEIGHT, Settings.TILE_WIDTH, Settings.TILE_HEIGHT));
			else
				return null;
		}
		
		public function get Graphics():Sprite
		{
			return sprite;
		}
	}
}