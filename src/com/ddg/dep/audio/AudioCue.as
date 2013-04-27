package com.ddg.dep.audio 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public class AudioCue 
	{
		public var sample:AudioSample;
		public var probability:Number = 1;
		
		public function AudioCue(sample:AudioSample, probability:Number) 
		{
			this.sample = sample;
			this.probability = probability;
		}
	}
}