package com.ddg.dep.audio 
{
	/**
	 * @author Gert-Jan Stolk
	 */
	public class AudioManager 
	{
		private static const instance:AudioManager = new AudioManager();
		
		public static function get Instance():AudioManager
		{
			return instance;
		}
		
		public function AudioManager() 
		{}
		
		private var sets:Vector.<AudioSet> = new Vector.<AudioSet>();
		
		private var averageDeltaTime:Number = 0;
		private var timerStarted:Number = new Date().getTime() / 1000;
		private var timer:Number = 0;
		
		public function AddSet(audioSet:AudioSet):void
		{
			sets.push(audioSet);
		}
		
		public function get Time():Number
		{
			return timer;
		}
		
		public function get OffsetTolerance():Number
		{
			return 0.3 * averageDeltaTime;
		}
		
		public function IsDueTime(time:Number):Boolean
		{
			return timer + OffsetTolerance > time;
		}
		
		public function IsPastTime(time:Number):Boolean
		{
			return  timer > time;
		}
		
		public function Update(deltaTime:Number):void
		{
			if (averageDeltaTime == 0)
				averageDeltaTime = deltaTime;
			else
				averageDeltaTime = averageDeltaTime * (9 / 10) + deltaTime * (1 / 10);
			timer = new Date().getTime() / 1000 - timerStarted;
			
			for each (var audioSet:AudioSet in sets)
			{
				audioSet.Update(deltaTime);
			}
		}
	}
}