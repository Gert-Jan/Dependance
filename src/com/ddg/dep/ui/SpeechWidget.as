package com.ddg.dep.ui 
{
	import com.ddg.dep.Assets;
	import flash.geom.Point;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * @author Gert-Jan Stolk
	 */
	public class SpeechWidget implements IWidget
	{
		public static const PHRASE_TUTORIAL_LEFT:int = 0;
		public static const PHRASE_TUTORIAL_RIGHT:int = 1;
		public static const PHRASE_TUTORIAL_UP:int = 2;
		public static const PHRASE_TUTORIAL_DOWN:int = 3;
		public static const PHRASE_TOTORIAL_SWITCH:int = 4;
		public static const PHRASE_GREETING_01:int = 5;
		public static const PHRASE_GREETING_02:int = 6;
		public static const PHRASE_ASK_JOIN:int = 7;
		public static const PHRASE_ITEM_PRESENT:int = 8;
		
		public static const FRAME_SAY:int = 0;
		public static const FRAME_THINK:int = 1;

		private var frame:int = 0;
		private var phrase:int = 0;
		
		private var surface:Sprite = new Sprite();
		private var frameImage:Image;
		private var frameSprite:Sprite = new Sprite();
		private var phraseImage:Image;
		private var phraseSprite:Sprite = new Sprite();
		
		private var delayTimer:DelayedCall = new DelayedCall(null, Number.MAX_VALUE);
		private var showTimer:DelayedCall = new DelayedCall(null, Number.MAX_VALUE);
		
		public function SpeechWidget()
		{
			frameImage = new Image(Assets.Instance.SpeechFrames.getTexture(String(0)));
			frameSprite.addChild(frameImage);
			phraseImage = new Image(Assets.Instance.SpeechPhrases.getTexture(String(0)));
			phraseSprite.addChild(phraseImage);
			phraseSprite.x = 8;
			phraseSprite.y = 8;
			surface.addChild(frameSprite);
			surface.addChild(phraseSprite);
			surface.pivotX = surface.width / 2;
			surface.pivotY = surface.height;
			Starling.juggler.add(delayTimer);
			Starling.juggler.add(showTimer);
			surface.visible = false;
		}
		
		public function get IsVisible():Boolean
		{
			return surface.visible;
		}
		
		public function get Frame():int
		{
			return frame;
		}
		
		public function get Phrase():int
		{
			return phrase;
		}
		
		public function get Surface():Sprite
		{
			return surface;
		}
		
		public function set Position(point:Point):void
		{
			surface.x = point.x;
			surface.y = point.y;
		}
		
		public function Show(frame:int, phrase:int, cancelTimers:Boolean = true):void
		{
			if (cancelTimers)
			{
				Starling.juggler.remove(delayTimer);
				Starling.juggler.remove(showTimer);
			}
			this.frame  = frame;
			this.phrase = phrase;
			frameImage.texture = Assets.Instance.SpeechFrames.getTexture(String(frame));
			phraseImage.texture = Assets.Instance.SpeechPhrases.getTexture(String(phrase));
			surface.visible = true;
		}
		
		public function ShowTimed(frame:int, phrase:int, delay:Number, time:Number, overwrite:Boolean = true):void
		{
			if (overwrite || (delayTimer.isComplete))
			{
				Starling.juggler.remove(delayTimer);
				Starling.juggler.remove(showTimer);
				delayTimer.reset(Show, delay, [frame, phrase, false]);
				showTimer.reset(Hide, delay + time);
				Starling.juggler.add(delayTimer);
				Starling.juggler.add(showTimer);
			}
		}
		
		public function Hide():void
		{
			surface.visible = false;
			Starling.juggler.remove(delayTimer);
			Starling.juggler.remove(showTimer);
		}
		
		public function DelayedHide(delay:Number):void
		{
			Starling.juggler.remove(delayTimer);
			delayTimer.reset(Hide, delay);
			Starling.juggler.add(delayTimer);
		}
	}
}