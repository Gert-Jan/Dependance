package com.ddg.dep.audio 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public class AudioSet 
	{
		private var bpm:int;
		private var layers:Object = new Object();
		private var syncInterval:int;
		
		public function AudioSet(bpm:int = 140, syncInterval:int = 4) 
		{
			this.bpm = bpm;
			this.syncInterval = syncInterval;
		}
		
		public function AddLayer(name:String, layer:AudioLayer):void
		{
			layer.ParentSet = this;
			layers[name] = layer;
		}
		
		public function PlayLayer(name:String):void
		{
			AudioLayer(layers[name]).Play();
		}
		
		public function FadeInLayer(name:String, time:Number):void
		{
			AudioLayer(layers[name]).FadeIn(time);
		}
		
		public function FadeOutLayer(name:String, time:Number):void
		{
			AudioLayer(layers[name]).FadeOut(time);
		}
		
		public function SetLayerVolume(name:String, volume:Number):void
		{
			AudioLayer(layers[name]).Volume = volume;
		}
		
		public function StopLayer(name:String):void
		{
			AudioLayer(layers[name]).Stop();
		}
		
		public function StopAll():void
		{
			for each (var layer:AudioLayer in layers)
			{
				layer.Stop();
			}
		}
		
		public function BeatInterval(beats:int = 1):Number
		{
			return beats / (bpm / 60);
		}
		
		public function get NextSyncTiming():Number
		{
			var intervalTime:Number = BeatInterval(syncInterval);
			return AudioManager.Instance.Time + intervalTime - AudioManager.Instance.Time % intervalTime;
		}
		
		public function get NextBeatDeltaTime():Number
		{
			var intervalTime:Number = BeatInterval();
			return intervalTime - AudioManager.Instance.Time % intervalTime;
		}
		
		public function Update(deltaTime:Number):void
		{
			for each (var layer:AudioLayer in layers)
			{
				layer.Update(deltaTime);
			}
		}
	}
}