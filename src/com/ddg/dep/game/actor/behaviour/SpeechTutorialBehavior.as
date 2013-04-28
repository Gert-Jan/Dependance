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
	public class SpeechTutorialBehavior implements IBehavior 
	{
		private static const STEP_WALK_LEFT:int = 0;
		private static const STEP_WALK_RIGHT:int = 1;
		private static const STEP_JUMP:int = 2;
		private static const STEP_INTERACT:int = 3;
		private static const STEP_SWITCH:int = 4;
		private static const STEP_DONE:int = 5;
		
		private static const LEVEL_OFFSET_X:int = 0;
		private static const LEVEL_OFFSET_Y:int = 0;
		
		private var dude:Dude;
		private var widget:SpeechWidget = new SpeechWidget();
		private var tutorialStep:int = STEP_WALK_LEFT;
		
		public function SpeechTutorialBehavior() 
		{
			UIManager.Instance.AddWidget(widget);
		}
		
		public function set Actor(value:Dude):void 
		{
			dude = value;
			//defaultBehavior.Actor = value;
		}
		
		public function Update(deltaTime:Number):void
		{
			widget.Position = dude.Position;
			if (tutorialStep < STEP_DONE)
			{
				switch (tutorialStep)
				{
					case STEP_WALK_LEFT:
						if (!widget.IsVisible || widget.Phrase != SpeechWidget.PHRASE_TUTORIAL_LEFT)
						{
							widget.Show(SpeechWidget.FRAME_THINK, SpeechWidget.PHRASE_TUTORIAL_LEFT, true);
						}
						if (dude.Velocity.x < 0)
						{
							widget.DelayedHide(1);
							tutorialStep = STEP_WALK_RIGHT;
						}
						break;
					case STEP_WALK_RIGHT:
						if (!widget.IsVisible && dude.Position.y > LEVEL_OFFSET_Y + 200)
						{
							widget.ShowTimed(SpeechWidget.FRAME_THINK, SpeechWidget.PHRASE_TUTORIAL_RIGHT, 0.3, Number.MAX_VALUE, false);
						}
						if (dude.Velocity.x > 0)
						{
							widget.DelayedHide(1);
							tutorialStep = STEP_JUMP;
						}
						break;
					case STEP_JUMP:
						if (widget.Phrase != SpeechWidget.PHRASE_TUTORIAL_UP && dude.Position.x > LEVEL_OFFSET_X + 320)
						{
							widget.Show(SpeechWidget.FRAME_THINK, SpeechWidget.PHRASE_TUTORIAL_UP, true);
						}
						if (dude.Velocity.y < 0)
						{
							widget.DelayedHide(1);
							tutorialStep = STEP_INTERACT;
						}
						break;
					case STEP_INTERACT:
						if (widget.Phrase != SpeechWidget.PHRASE_TUTORIAL_DOWN && DudeManager.Instance.IsNonOwnedDudeNear(dude, 40))
						{
							widget.ShowTimed(SpeechWidget.FRAME_THINK, SpeechWidget.PHRASE_TUTORIAL_DOWN, 0, 2, true);
						}
						break;
					case STEP_SWITCH:
						//defaultBehavior.Update(deltaTime);
						break;
				}
			}
		}
		
		public function OnActionStarted():void 
		{}
		
		public function OnActionStopped():void 
		{}
	}
}