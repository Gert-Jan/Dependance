package com.ddg.dep 
{
	import com.ddg.dep.audio.AudioSample;
	import flash.geom.Rectangle;
	import flash.media.Sound;
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
		[Embed(source = "../../../../art/SpeechFrames.png")]
		private static const speechFrames:Class;
		[Embed(source = "../../../../art/SpeechPhrases.png")]
		private static const speechPhrases:Class;
		
		[Embed(source = "../../../../art/audio/IdleNormal01.mp3")]
		private static const audioIdleNormal01:Class;
		[Embed(source = "../../../../art/audio/IdleSmall01.mp3")]
		private static const audioIdleSmall01:Class;
		[Embed(source = "../../../../art/audio/WalkNormal01.mp3")]
		private static const audioWalkNormal01:Class;
		[Embed(source = "../../../../art/audio/WalkSmall01.mp3")]
		private static const audioWalkSmall01:Class;
		[Embed(source = "../../../../art/audio/InventoryNormal01.mp3")]
		private static const audioInventoryNormal01:Class;
		[Embed(source = "../../../../art/audio/InventorySmall01.mp3")]
		private static const audioInventorySmall01:Class;
		
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
		
		private function CreateTileMap(asset:Class, tileWidth:int, tileHeight:int, offset:int = 0):TextureAtlas
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
						atlas.addRegion((y * tileCountX + x + offset).toString(), rect);
					}
				}
				this[asset] = atlas;
			}
			return this[asset];
		}
		
		private function CreateAudioSample(asset:Class, bpm:int, beats:int):AudioSample
		{
			if (this[asset] == null)
			{
				this[asset] = new AudioSample(Sound(new asset()), bpm, beats);
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
		public function get Tiles():TextureAtlas { return CreateTileMap(tiles, Settings.TILE_WIDTH, Settings.TILE_HEIGHT, 1); }
		public function get SpeechFrames():TextureAtlas { return CreateTileMap(speechFrames, 48, 48); }
		public function get SpeechPhrases():TextureAtlas { return CreateTileMap(speechPhrases, 32, 16); }
		public function get Levels():Object { return CreateJSON(levels); }
		public function get AudioIdleNormal01():AudioSample { return CreateAudioSample(audioIdleNormal01, 140, 8); }
		public function get AudioIdleSmall01():AudioSample { return CreateAudioSample(audioIdleSmall01, 140, 8); }
		public function get AudioWalkNormal01():AudioSample { return CreateAudioSample(audioWalkNormal01, 140, 8); }
		public function get AudioWalkSmall01():AudioSample { return CreateAudioSample(audioWalkSmall01, 140, 8); }
		public function get AudioInventoryNormal01():AudioSample { return CreateAudioSample(audioInventoryNormal01, 140, 8); }
		public function get AudioInventorySmall01():AudioSample { return CreateAudioSample(audioInventorySmall01, 140, 8); }
	}
}