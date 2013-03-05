package  
{
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author umhr
	 */
	public class MoveManager 
	{
		private static var _instance:MoveManager;
		public function MoveManager(block:Block){init();};
		public static function getInstance():MoveManager{
			if ( _instance == null ) {_instance = new MoveManager(new Block());};
			return _instance;
		}
		
		private var _floor:int;
		public var isTween:Boolean;
		private var _timer:Timer = new Timer(1000, 5);
		private var _titleManager:TitleManager = TitleManager.getInstance();
		private var _questionManager:QuestionManager = QuestionManager.getInstance();
		private function init():void
		{
			setPosition();
		}
		
		private function setPosition():void 
		{
			_titleManager.x = 0;
			_questionManager.questioList[0].x = Main.stageWidth;
			_questionManager.questioList[0].y = 0;
		}
		
		public function start():void {
			if (isTween) { return };
			
			_questionManager.reset();
			
			_titleManager.visible = true;
			_titleManager.x = 0;
			_questionManager.questioList[0].visible = true;
			_questionManager.questioList[0].x = Main.stageWidth;
			_questionManager.questioList[0].y = 0;
			_floor = 0;
			isTween = true;
			
			Tween24.parallel(
				Tween24.tween(_titleManager, 0.5, Ease24._2_QuadOut).x( -Main.stageWidth).visible(false),
				Tween24.tween(_questionManager.questioList[0], 0.5, Ease24._2_QuadOut).x( 0),
				Tween24.tween(this, 0.5, null, { isTween:false } )
			).onComplete(startTimer).play();
			
			var n:int = _questionManager.questioList.length;
			for (var i:int = 0; i < n; i++) 
			{
				_questionManager.questioList[i].countDown(5);
			}
			
		}
		
		private function startTimer():void 
		{
			_timer.reset();
			_timer.addEventListener(TimerEvent.TIMER, timer_timer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timer_timerComplete);
			_timer.start();
		}
		
		private function timer_timer(event:TimerEvent):void 
		{
			_questionManager.questioList[_floor].countDown(5 - _timer.currentCount);
		}
		
		private function timer_timerComplete(event:TimerEvent):void 
		{
			_timer.removeEventListener(TimerEvent.TIMER, timer_timer);
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timer_timerComplete);
			next();
		}
		
		public function next():void 
		{
			if (isTween) { return };
			
			_timer.reset();
			if (_floor < 9) {
				nextQuestion(_floor, _floor + 1);
			}else {
				backToTitle();
			}
			
			_floor ++;
			
		}
		
		private function backToTitle():void 
		{
			_titleManager.visible = true;
			_titleManager.x = -Main.stageWidth;
			_questionManager.questioList[9].x = 0;
			isTween = true;
			
			Tween24.parallel(
				Tween24.tween(_titleManager, 0.5, Ease24._2_QuadOut).x( 0),
				Tween24.tween(_questionManager.questioList[9], 0.5, Ease24._2_QuadOut).x( Main.stageWidth).visible(false),
				Tween24.tween(this, 0.5, null, { isTween:false } )
			).onComplete(onComplete).delay(0.5).play();
			
			RankingManager.getInstance().reset();
		}
		
		private function onComplete():void 
		{
			RankingManager.getInstance().setResistor();
		}
		
		private function nextQuestion(oldFloor:int, newFloor:int):void 
		{
			var oldTarget:Question = _questionManager.questioList[oldFloor];
			var newTarget:Question = _questionManager.questioList[newFloor];
			
			oldTarget.y = 0;
			newTarget.visible = true;
			newTarget.x = 0;
			newTarget.y = Main.stageHeight;
			isTween = true;
			
			Tween24.parallel(
				Tween24.tween(oldTarget, 0.5, Ease24._2_QuadOut).y( -Main.stageHeight).visible(false),
				Tween24.tween(newTarget, 0.5, Ease24._2_QuadOut).y( 0),
				Tween24.tween(this, 0.5, null, { isTween:false } )
			).delay(0.5).onComplete(startTimer).play();
			
		}
		
		public function get floor():int {
			return _floor;
		}
		
	}
	
}
class Block { };