package com.ddg.dep.audio 
{
	import com.ddg.dep.Assets;
	/**
	 * @author Gert-Jan Stolk
	 */
	public dynamic class AudioLibrary 
	{
		private static const instance:AudioLibrary = new AudioLibrary();
		
		public static function get Instance():AudioLibrary
		{
			return instance;
		}
		
		public function AudioLibrary() 
		{}
		
		public static const ACTION_IDLE:String = "idle";
		public static const ACTION_WALK:String = "walk";
		public static const ACTION_INVENTORY:String = "Inventory";
		
		public function get AudioSetNormalDude():AudioSet
		{
			if (this["NormalDude"] == null)
			{
				var audioSet:AudioSet = new AudioSet(140, 4);
				var layer:AudioLayer;
				
				layer = new AudioLayer();
				layer.AddCue(new AudioCue(Assets.Instance.AudioIdleNormal01, 1));
				audioSet.AddLayer(ACTION_IDLE, layer);
				
				layer = new AudioLayer();
				layer.AddCue(new AudioCue(Assets.Instance.AudioWalkNormal01, 1));
				audioSet.AddLayer(ACTION_WALK, layer);
				
				layer = new AudioLayer();
				layer.AddCue(new AudioCue(Assets.Instance.AudioInventoryNormal01, 1));
				audioSet.AddLayer(ACTION_INVENTORY, layer);
				
				AudioManager.Instance.AddSet(audioSet);
				this["NormalDude"] = audioSet;
			}
			return this["NormalDude"];
		}
		
		public function get AudioSetSmallDude():AudioSet
		{
			if (this["SmallDude"] == null)
			{
				var audioSet:AudioSet = new AudioSet(140, 4);
				var layer:AudioLayer;
				layer = new AudioLayer();
				
				layer.AddCue(new AudioCue(Assets.Instance.AudioIdleSmall01, 1));
				audioSet.AddLayer(ACTION_IDLE, layer);
				layer = new AudioLayer();
				
				layer.AddCue(new AudioCue(Assets.Instance.AudioWalkSmall01, 1));
				audioSet.AddLayer(ACTION_WALK, layer);
				
				layer = new AudioLayer();
				layer.AddCue(new AudioCue(Assets.Instance.AudioInventorySmall01, 1));
				audioSet.AddLayer(ACTION_INVENTORY, layer);
				
				AudioManager.Instance.AddSet(audioSet);
				this["SmallDude"] = audioSet;
			}
			return this["SmallDude"];
		}
	}
}