package 
{
	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class Main extends Sprite 
	{
		
		static public var stageWidth:int;
		static public var stageHeight:int;
		public function Main():void 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// entry point
			
			var timer:Timer = new Timer(10, 1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_timerComplete);
			timer.start();
			// new to AIR? please read *carefully* the readme.txt files!
		}
		
		private function timer_timerComplete(event:TimerEvent):void 
		{
			var timer:Timer = event.target as Timer;
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_timerComplete);
			
			// これが無いとスクリーンサイズがおかしい
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			
			graphics.beginFill(0x555555);
			graphics.drawRect(0, 0, stageWidth, stageHeight);
			graphics.endFill();
			
			addChild(new Canvas());
			
			trace(stageHeight,stage.stageHeight);
		}
		
		
		private function deactivate(e:Event):void 
		{
			// auto-close
			NativeApplication.nativeApplication.exit();
		}
		
	}
	
}