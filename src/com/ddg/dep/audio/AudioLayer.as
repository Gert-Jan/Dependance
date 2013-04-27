package com.ddg.dep.audio 
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class AudioLayer 
	{
		private var parentSet:AudioSet;
		private var cues:Vector.<AudioCue> = new Vector.<AudioCue>();
		
		private var isPlaying:Boolean = false;
		private var nextCueTiming:Number = 0;
		private var channel:SoundChannel = null;
		
		private var totalFadeTime:Number = 0.0;
		private var fadeTime:Number = 0.0;
		private var volume:Number = 1.0;
		private var targetVolume:Number = 0.0;
		
		public function AudioLayer() 
		{}
		
		public function set ParentSet(value:AudioSet):void
		{
			this.parentSet = value;
		}
		
		public function AddCue(cue:AudioCue):void
		{
			cues.push(cue);
		}
		
		private function GetNextCue():AudioCue
		{
			var totalProbability:Number = 0;
			var cue:AudioCue;
			for each (cue in cues)
				totalProbability += cue.probability;
			var next:Number = Math.random() * totalProbability;
			for each (cue in cues)
			{
				next -= cue.probability;
				if (next < 0)
					return cue;
			}
			return cues[cues.length - 1];
		}
		
		private function PlayNextCue(immediate:Boolean):void
		{
			var nextCue:AudioCue = GetNextCue();
			nextCueTiming = NextLoopTiming(nextCue.sample);
			//trace(nextCueTiming - AudioManager.Instance.Time);
			if (immediate)
			{
				channel = nextCue.sample.sound.play(nextCueTiming - AudioManager.Instance.Time - IntervalTime(nextCue.sample), 0);
				Volume = volume;
			}
		}
		
		private function IntervalTime(sample:AudioSample):Number
		{
			return sample.beats / (sample.bpm / 60);
		}
		
		public function NextLoopTiming(sample:AudioSample):Number
		{
			var intervalTime:Number = IntervalTime(sample);
			return AudioManager.Instance.Time + intervalTime - AudioManager.Instance.Time % intervalTime;
		}
		
		public function set Volume(volume:Number):void
		{
			trace(volume, channel);
			this.volume = volume;
			if (channel != null)
				channel.soundTransform = new SoundTransform(volume, 0);
		}
		
		public function FadeIn(time:Number):void
		{
			if (targetVolume != 1.0 && totalFadeTime != time)
			{
				targetVolume = 1.0;
				totalFadeTime = time;
				fadeTime = time;
			}
		}
		
		public function FadeOut(time:Number):void
		{
			if (targetVolume != 0.0 && totalFadeTime != time)
			{
				targetVolume = 0.0;
				totalFadeTime = time;
				fadeTime = time;
			}
		}
		
		public function Play():void
		{
			isPlaying = true;
			PlayNextCue(false);
		}
		
		public function Stop():void
		{
			isPlaying = false;
		}
		
		public function Update(deltaTime:Number):void
		{
			if (isPlaying)
			{
				if (AudioManager.Instance.IsPastTime(nextCueTiming))
				{
					PlayNextCue(true);
				}
			}
			if (totalFadeTime > 0)
			{
				Volume = volume + ((targetVolume - volume) * (deltaTime / fadeTime));
				fadeTime -= deltaTime;
				if (fadeTime <= 0)
				{
					totalFadeTime = 0;
					Volume = targetVolume;
				}
			}
		}
	}
}