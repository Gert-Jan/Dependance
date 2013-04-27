package com.ddg.dep.game.level 
{
	import com.ddg.dep.Assets;
	import com.ddg.dep.game.collision.AABB;
	import com.ddg.dep.game.collision.Tile;
	import com.ddg.dep.Settings;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class LevelManager 
	{
		private static const instance:LevelManager = new LevelManager();
		
		public static function get Instance():LevelManager
		{
			return instance;
		}
		
		public function LevelManager() 
		{}
		
		private static var MAP_SETUP:Vector.<Vector.<int>> = Vector.<Vector.<int>>
		([
			Vector.<int>([00,01]),
			Vector.<int>([01,01])
		]);
		private var map:Vector.<Vector.<Level>> = null;
		private var levels:Vector.<Level> = new Vector.<Level>;
		
		public function Init():void
		{
			LoadLevels();
		}
		
		private function LoadLevels():void
		{
			trace("Loading levels...");
			var lvls:Object = Assets.Instance.Levels;
			var lvlMap:Object = new Object();
			for each (var layer:Object in lvls.layers)
			{
				lvlMap[layer.name] = layer;
			}
			trace("Loading levels done...");
			trace("Creating map...");
			InitMap();
			for (var y:int = 0; y < MAP_SETUP.length; y++)
			{
				for (var x:int = 0; x < MAP_SETUP[0].length; x++)
				{
					var lvl:Object = lvlMap[MAP_SETUP[y][x]];
					map[x][y] = new Level(x, y, lvl.width, lvl.height, Vector.<int>(lvl.data));
				}
			}
			trace("Creating map done...");
		}
		
		private function InitMap():void
		{
			map = new Vector.<Vector.<Level>>(MAP_SETUP[0].length, true);
			for (var i:int = 0; i < map.length; i++)
				map[i] = new Vector.<Level>(MAP_SETUP.length, true);
		}
		
		public function GetLevel(x:int, y:int):Level
		{
			if (x >= 0 && x < map.length && 
				y >= 0 && y < map[0].length)
				return map[x][y];
			else
				return null;
		}
		
		public function GetOverlappingTiles(query:AABB):Vector.<Tile>
		{
			var result:Vector.<Tile> = new Vector.<Tile>();
			for (var levelY:int = Math.floor(query.minY / Settings.Instance.StageHeight); levelY <= Math.floor(query.maxY / Settings.Instance.StageHeight); levelY++)
			{
				for (var levelX:int = Math.floor(query.minX / Settings.Instance.StageWidth); levelX <= Math.floor(query.maxX / Settings.Instance.StageWidth); levelX++)
				{
					var level:Level = GetLevel(levelX, levelY);
					if (level != null)
					{
						for (var tileY:int = Math.floor((query.minY - level.Y) / Settings.TILE_HEIGHT); tileY <= Math.floor((query.maxY - level.Y) / Settings.TILE_HEIGHT); tileY++)
						{
							for (var tileX:int = Math.floor((query.minX - level.X) / Settings.TILE_WIDTH); tileX <= Math.floor((query.maxX - level.X) / Settings.TILE_WIDTH); tileX++)
							{
								var tile:Tile = level.GetTile(tileX, tileY);
								if (tile != null)
								{
									result.push(tile);
								}
							}
						}
					}
				}
			}
			return result;
		}
		
		public function GetTileOnPoint(point:Point):Tile
		{
			var level:Level = GetLevel(Math.floor(point.x / Settings.Instance.StageWidth), Math.floor(point.y / Settings.Instance.StageHeight));
			if (level != null)
			{
				return level.GetTile(Math.floor((point.x - level.X) / Settings.TILE_WIDTH), Math.floor((point.y - level.Y) / Settings.TILE_HEIGHT));
			}
			return null;
		}
	}
}