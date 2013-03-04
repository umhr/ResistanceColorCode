package  
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author umhr
	 */
	public class TitleManager extends Sprite 
	{
		private static var _instance:TitleManager;
		public function TitleManager(block:Block){init();};
		public static function getInstance():TitleManager{
			if ( _instance == null ) {_instance = new TitleManager(new Block());};
			return _instance;
		}
		
		private function init():void
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			graphics.beginFill(0x333333, 1);
			graphics.drawRoundRect(0, 0, 465, 465, 8, 8);
			graphics.endFill();
			
			addChild(Title.getInstance());
			addChild(RankingManager.getInstance());
			
		}
		
	}
	
}
class Block { };