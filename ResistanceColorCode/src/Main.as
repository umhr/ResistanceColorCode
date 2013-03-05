package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0x555555, frameRate = 60)]
	public class Main extends Sprite 
	{
		static public var stageWidth:int;
		static public var stageHeight:int;
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stageWidth = stage.stageWidth;
			stageHeight = stage.stageHeight;
			
			graphics.beginFill(0x555555);
			graphics.drawRect(0, 0, stageWidth, stageHeight);
			graphics.endFill();
			
			addChild(new Canvas());
			
		}
		
	}
	
}