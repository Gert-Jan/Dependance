package com.ddg.dep 
{
	import com.ddg.dep.view.ViewManager;
	import flash.utils.getTimer;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class Game extends Sprite
	{
		public function Game() 
		{
			ViewManager.Instance.Init(this);
			this.addEventListener(EnterFrameEvent.ENTER_FRAME, Update);
		}
		
		private function Update():void
		{
			UpdateDeltaTime();
			ViewManager.Instance.Update(deltaTime);
		}
		
		private var t1:int;
		private var t2:int;
		private var deltaTime:Number;
		private function UpdateDeltaTime():void
		{
			t2 = getTimer();
			deltaTime = (t2 - t1) * 0.001;
			t1 = t2;
			// air for android deltatime can be 0 potentially causing a lot of devision-by-zero misery
			if (deltaTime < 0.001)
				deltaTime = 0.001;
			// add a max deltaTime to fix collision extremity
			if (deltaTime > 0.05)
				deltaTime = 0.05;
		}
	}
}