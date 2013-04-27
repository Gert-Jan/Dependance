package com.ddg.dep.audio 
{
	import flash.media.Sound;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class AudioSample 
	{
		public var bpm:int;
		public var beats:int;
		public var sound:Sound;
		
		public function AudioSample(sound:Sound, bpm:int, beats:int) 
		{
			this.sound = sound;
			this.bpm = bpm;
			this.beats = beats;
		}
	}
}