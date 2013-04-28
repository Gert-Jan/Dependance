package com.ddg.dep.game.actor.behaviour 
{
	import com.ddg.dep.game.actor.Dude;
	import com.ddg.dep.game.actor.DudeManager;
	import com.ddg.dep.ui.SpeechWidget;
	import com.ddg.dep.ui.UIManager;
	import flash.geom.Point;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class SpeechDefaultBehavior implements IBehavior 
	{
		public static const GREETINGS:Vector.<int> = Vector.<int>([SpeechWidget.PHRASE_GREETING_01, SpeechWidget.PHRASE_GREETING_02]);
		
		private var dude:Dude;
		private var widget:SpeechWidget = new SpeechWidget();
		
		public function SpeechDefaultBehavior() 
		{
			UIManager.Instance.AddWidget(widget);
		}
		
		public function set Actor(value:Dude):void 
		{
			dude = value;
		}
		
		public function Update(deltaTime:Number):void
		{
			widget.Position = dude.Position;
			if (!widget.IsVisible && DudeManager.Instance.IsNonOwnedDudeNear(dude, 40))
			{
				widget.ShowTimed(SpeechWidget.FRAME_SAY, GREETINGS[Math.floor(Math.random() * GREETINGS.length)], 0, Number.MAX_VALUE, false);
			}
			else if (widget.IsVisible && !DudeManager.Instance.IsNonOwnedDudeNear(dude, 40))
			{
				widget.Hide();
			}
		}
		
		public function OnActionStarted():void 
		{}
		
		public function OnActionStopped():void 
		{}
	}
}