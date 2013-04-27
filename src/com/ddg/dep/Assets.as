package com.ddg.dep 
{
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	/**
	 * @author Gert-Jan Stolk
	 */
	public dynamic class Assets 
	{
		private static const instance:Assets = new Assets();
		
		public static function get Instance():Assets
		{
			return instance;
		}
		
		public function Assets() 
		{}
		
		[Embed(source = "../../../../art/LevelTiles.png")]
		private static const tiles:Class;
		[Embed(source = "../../../../art/DudeNormal.png")]
		private static const dudeNormal:Class;
		[Embed(source = "../../../../art/DudeSmall.png")]
		private static const dudeSmall:Class;
		[Embed(source = "../../../../art/Levels.json", mimeType="application/octet-stream")]
		private static const levels:Class;
		
		public function Init():void
		{
		}
		
		private function CreateTexture(asset:Class):Texture
		{
			if (this[asset] == null)
				this[asset] = Texture.fromBitmap(new asset());
			return this[asset];
		}
		
		private function CreateTileMap(asset:Class, tileWidth:int, tileHeight:int):TextureAtlas
		{
			if (this[asset] == null)
			{
				var texture:Texture = Texture.fromBitmap(new asset());
				var atlas:TextureAtlas = new TextureAtlas(texture, null);
				var tileCountX:int = Math.floor(texture.width / tileWidth);
				var tileCountY:int = Math.floor(texture.height / tileHeight);
				for (var y:int = 0; y < tileCountY; y++)
				{
					for (var x:int = 0; x < tileCountX; x++)
					{
						var rect:Rectangle = new Rectangle(x * tileWidth, y * tileHeight, tileWidth, tileHeight);
						atlas.addRegion((y * tileCountX + x + 1).toString(), rect);
					}
				}
				this[asset] = atlas;
			}
			return this[asset];
		}
		
		private function CreateJSON(asset:Class):Object
		{
			var bytes:ByteArray = new asset();
			var jsonString:String = bytes.readUTFBytes(bytes.length);
			return JSON.parse(jsonString);
		}
		
		public function get DudeNormal():Texture { return CreateTexture(dudeNormal); }
		public function get DudeSmall():Texture { return CreateTexture(dudeSmall); }
		public function get Tiles():TextureAtlas { return CreateTileMap(tiles, Settings.TILE_WIDTH, Settings.TILE_HEIGHT); }
		public function get Levels():Object { return CreateJSON(levels); }
	}
}