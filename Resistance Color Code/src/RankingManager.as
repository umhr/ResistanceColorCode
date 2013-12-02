package  
{
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author umhr
	 */
	public class RankingManager extends Sprite 
	{
		private static var _instance:RankingManager;
		public function RankingManager(block:Block){init();};
		public static function getInstance():RankingManager{
			if ( _instance == null ) {_instance = new RankingManager(new Block());};
			return _instance;
		}
		private var _rankList:Vector.<Rank> = new Vector.<Rank>();
		private var _totalScore:TextField = new TextField();
		private function init():void
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			setRanking();
			addChild(_totalScore);
		}
		private function setRanking():void 
		{
			var toX:int = (Main.stageWidth - 225) * 0.5;
			var toY:int = (Main.stageHeight - 28 * 10) * 0.5;
			for (var i:int = 0; i < 10; i++) 
			{
				_rankList[i] = new Rank(i);
				_rankList[i].x = Main.stageWidth * 0.5 - 10;
				_rankList[i].y = toY + i * 28;// 90 + i * 30;
				addChild(_rankList[i]);
			}
			setTotalScore();
			reset();
		}
		
		public function reset():void {
			var n:int = _rankList.length;
			for (var i:int = 0; i < n; i++) 
			{
				_rankList[i].reset();
			}
			_totalScore.visible = false;
		}
		
		private function setTotalScore():void 
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 21;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = 0xFFFFFF;
			textFormat.font = "_明朝";
			
			_totalScore = new TextField();
			_totalScore.defaultTextFormat = textFormat;
			_totalScore.text = "Total:";
			_totalScore.mouseEnabled = false;
			_totalScore.selectable = false;
			_totalScore.width = Main.stageWidth;
			_totalScore.height = 30;
			_totalScore.y = Main.stageHeight - 100;
		}
		
		public function setResistor():void {
			
			var tweenList:Array/*Tween24*/ = [];
			var score:Number = 0;
			var toX:int = (Main.stageWidth - 225) * 0.5;
			var toY:int = (Main.stageHeight - 28 * 10) * 0.5;
			var n:int = _rankList.length;
			for (var i:int = 0; i < n; i++) 
			{
				_rankList[i].visible = false;
				tweenList[i] = Tween24.tween(_rankList[i], 0, Ease24._2_QuadInOut).xy(toX, toY + i * 28).visible(true).delay(i * 0.1);
				_rankList[i].setResistor();
				score += _rankList[i].score;
			}
			_totalScore.y = toY + n * 28;
			Tween24.parallel.apply(this,tweenList).onComplete(onComplete).play();
			_totalScore.text = "Total: " + formatComma(Number(score + 0.0001).toFixed(1)) + " Ω";
			
			SoundManager.getInstance().play(SoundManager.SCORE);
		}
		private function onComplete():void {
			_totalScore.visible = true;
		}
		
		private function formatComma(num:String):String {
			var keta:Array = num.split(".");
			keta[0] = String(keta[0]).replace(/(\d)(?=(\d\d\d)+$)/g, "$1,");
			return keta.join(".");
		}
		
	}
	
}
class Block { };