package  
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class QuestionManager extends Sprite 
	{
		private static var _instance:QuestionManager;
		public function QuestionManager(block:Block){init();};
		public static function getInstance():QuestionManager{
			if ( _instance == null ) {_instance = new QuestionManager(new Block());};
			return _instance;
		}
		
		public var questioList:Vector.<Question> = new Vector.<Question>();
		private function init():void
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			var n:int = 10;
			for (var i:int = 0; i < n; i++) 
			{
				var questio:Question = new Question();
				questio.index = i;
				questio.y = Main.stageHeight;
				questio.visible = false;
				addChild(questio);
				questioList.push(questio);
			}
			
		}
		
		public function reset():void {
			var n:int = questioList.length;
			for (var i:int = 0; i < n; i++) 
			{
				questioList[i].generateQuestion();
			}
		}
		
	}
	
}
class Block { };