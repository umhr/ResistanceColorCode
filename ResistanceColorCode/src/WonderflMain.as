package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author umhr
	 */
	[SWF(width = 465, height = 465, backgroundColor = 0x555555, frameRate = 60)]
	public class WonderflMain extends Sprite 
	{
		
		public function WonderflMain():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			graphics.beginFill(0x555555);
			graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			graphics.endFill();
			
			addChild(new Canvas());
			
			
		}
		
	}
	
}


	
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	class Canvas extends Sprite 
	{
		
		public function Canvas() 
		{
			init();
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
			
			addChild(TitleManager.getInstance());
			
			addChild(QuestionManager.getInstance());
			
			MoveManager.getInstance();
		}
	}
	

	
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author umhr
	 */
	class Choice extends Sprite 
	{
		
		public function Choice() 
		{
			init();
		}
		
		private var _judgment:Shape = new Shape();
		private var _resistorData:ResistorData;
		private var _textField:TextField = new TextField();
		private function init():void 
		{
			graphics.beginFill(Utils.rgbBrightness(0xEEEEEE, 0.9), 1);
			graphics.drawRoundRect(0, 0, 180, 110, 8, 8);
			graphics.endFill();
			
			graphics.beginFill(0xEEEEEE, 1);
			graphics.drawRoundRect(2, 2, 176, 106, 6, 6);
			graphics.endFill();
			buttonMode = true;
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 48;
			textFormat.align = TextFormatAlign.CENTER;
			
			_textField.width = 180;
			_textField.height = 65;
			_textField.selectable = false;
			_textField.mouseEnabled = false;
			_textField.defaultTextFormat = textFormat;
			_textField.text = "0 Ω";
			_textField.y = 25;
			addChild(_textField);
			
		}
		
		public function get resistorData():ResistorData 
		{
			return _resistorData;
		}
		
		public function set resistorData(value:ResistorData):void 
		{
			_textField.text = value.getText();
			_judgment.graphics.clear();
			
			_resistorData = value;
		}
		
		public function set isGood(value:Boolean):void 
		{
			if (value) {
				// 正解
				_judgment.graphics.beginFill(0xFF0000);
				_judgment.graphics.drawCircle(0, 0, 45);
				_judgment.graphics.drawCircle(0, 0, 35);
				_judgment.graphics.endFill();
			}else {
				// 不正解
				_judgment.graphics.lineStyle(10, 0x333333, 1, false, "normal", CapsStyle.SQUARE, JointStyle.MITER);
				_judgment.graphics.moveTo(-35, -35);
				_judgment.graphics.lineTo(35, 35);
				_judgment.graphics.moveTo(35, -35);
				_judgment.graphics.lineTo(-35, 35);
			}
			_judgment.x = this.width * 0.5;
			_judgment.y = this.height * 0.5;
			addChild(_judgment);
		}
		
	}
	

	import flash.display.GradientType;
	import flash.geom.Matrix;
	/**
	 * ...
	 * @author umhr
	 */
	class Gradation {
		public function Gradation() { };
		
		/**
		 * RoundRectのグラデーションを設定します。
		 * @param    target graphicを持つインスタンス
		 * @param    x
		 * @param    y
		 * @param    width
		 * @param    height
		 * @param    r 丸角の描画に使用される楕円の幅
		 * @param    colors
		 * @param    alphas
		 * @param    rations
		 */
		static public function drawGradientRoundRect(target:*, x:Number, y:Number, width:Number, height:Number, r:Number, colors:Array, alphas:Array = null, rations:Array = null):void {
			
			var n:int = colors.length;
			var i:int;
			var d:Number;
			
			if (n == 1) {
				var rgb:uint = colors[0];
				colors[1] = rgb;
				n = 2;
			}
			
			if (!alphas) {
				alphas = [];
				for (i = 0; i < n; i++) 
				{
					alphas.push(1);
				}
			}
			if (!rations) {
				rations = [];
				for (i = 0; i < n; i++) 
				{
					d = i / (n - 1);
					rations.push(Math.floor(d * 255));
				}
			}
			target.graphics.beginGradientFill.apply(null, gradientFill(y, height, colors, alphas, rations));
			target.graphics.drawRoundRect(x, y, width, height, r, r);
			target.graphics.endFill();
		}
		
		/**
		 * Circleのグラデーションを設定します。
		 * @param    target
		 * @param    x
		 * @param    y
		 * @param    r
		 * @param    colors
		 * @param    alphas
		 * @param    rations
		 */
		static public function drawGradientCircle(target:*,x:Number, y:Number, r:int, colors:Array, alphas:Array, rations:Array):void {
			target.graphics.beginGradientFill.apply(null, gradientFill(y - r, r + r, colors, alphas, rations));
			target.graphics.drawCircle(x, y, r);
			target.graphics.endFill();
		}
		
		static private function gradientFill(y:Number, height:int, colors:Array, alphas:Array, rations:Array):Array {
			var result:Array = [GradientType.LINEAR, colors, alphas, rations];
			var matrix:Matrix = new Matrix();
			matrix.createGradientBox(1, height, Math.PI * 0.5, 0, y);
			result.push(matrix);
			return result;
		}
		
		/**
		 * 色の明度を相対的に変えます。
		 * rgb値と割合を与えて、結果を返す。
		 * rgbは、0xffffff段階の値。
		 * ratioが0の時に0x000000に、1の時にそのまま、2の時には0xffffffになる。
		 * 相対的に、ちょっと暗くしたい時には、ratioを0.8に、
		 * ちょっと明るくしたい時にはratioを1.2などに設定する。
		 * @param    rgb
		 * @param    ratio
		 * @return
		 */
		static public function rgbBrightness(rgb:int, ratio:Number):int {
			if(ratio < 0 || 2 < ratio){ratio = 1;trace("function colorBrightness 範囲外")}
			var _r:int = rgb >> 16;//16bit右にずらす。
			var _g:int = rgb >> 8 & 0xff;//8bit右にずらして、下位8bitのみを取り出す。
			var _b:int = rgb & 0xff;//下位8bitのみを取り出す。
			if(ratio <= 1){
				_r *= ratio;
				_g *= ratio;
				_b *= ratio;
			}else{
				_r = (255 - _r)*(ratio-1)+_r;
				_g = (255 - _g)*(ratio-1)+_g;
				_b = (255 - _b)*(ratio-1)+_b;
			}
			return _r<<16 | _g<<8 | _b;
		}
		
	}

	import a24.tween.Ease24;
	import a24.tween.Tween24;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author umhr
	 */
	class MoveManager 
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
			_questionManager.questioList[0].x = 465;
			_questionManager.questioList[0].y = 0;
		}
		
		public function start():void {
			if (isTween) { return };
			
			_questionManager.reset();
			
			_titleManager.visible = true;
			_titleManager.x = 0;
			_questionManager.questioList[0].visible = true;
			_questionManager.questioList[0].x = 465;
			_questionManager.questioList[0].y = 0;
			_floor = 0;
			isTween = true;
			
			Tween24.parallel(
				Tween24.tween(_titleManager, 0.5, Ease24._2_QuadOut).x( -465).visible(false),
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
			_titleManager.x = -465;
			_questionManager.questioList[9].x = 0;
			isTween = true;
			
			Tween24.parallel(
				Tween24.tween(_titleManager, 0.5, Ease24._2_QuadOut).x( 0),
				Tween24.tween(_questionManager.questioList[9], 0.5, Ease24._2_QuadOut).x( 465).visible(false),
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
			newTarget.y = 465;
			isTween = true;
			
			Tween24.parallel(
				Tween24.tween(oldTarget, 0.5, Ease24._2_QuadOut).y( -465).visible(false),
				Tween24.tween(newTarget, 0.5, Ease24._2_QuadOut).y( 0),
				Tween24.tween(this, 0.5, null, { isTween:false } )
			).delay(0.5).onComplete(startTimer).play();
			
		}
		
		public function get floor():int {
			return _floor;
		}
		
	}
	
class Block { };


	/**
	 * ...
	 * @author umhr
	 */
	class PreferredNumber 
	{
		static public const BLACK:int = 0x000000;
		static public const BROWN:int = 0xA52A2A;
		static public const RED:int = 0xFF0000;
		static public const ORENGE:int = 0xFFA500;
		static public const YELLOW:int = 0xFFFF00;
		static public const GREEN:int = 0x00FF00;
		static public const BLUE:int = 0x0000FF;
		static public const VIOLET:int = 0x800080;
		static public const GRAY:int = 0x999999;
		static public const WHITE:int = 0xFFFFFF;
		
		static public const SILVER:int = 0xCCCCCC;
		static public const GOLD:int = 0xFFD700;
		static public const NONE:int = 0xFF0000;//仮
		
		static public const BAND_COLORS:Vector.<int> = Vector.<int>([
		BLACK, BROWN, RED, ORENGE, YELLOW, GREEN, 
		BLUE, VIOLET, GRAY, WHITE, GOLD, SILVER]);
		
		static public const MULTIPLIER_COLORS:Vector.<int> = Vector.<int>([
		SILVER, GOLD, BLACK, BROWN, RED, ORENGE, 
		YELLOW, GREEN, BLUE, VIOLET, GRAY, WHITE]);
		static public const TOLERANCE_COLORS:Object = {
			"1":BROWN, "2":RED, "5":GOLD, "0.5":GREEN, "0.25":BLUE, "0.1":VIOLET,
			"0.05":GRAY, "10":SILVER, "20":NONE
		}
		
		static public const E3:Vector.<String> = Vector.<String>(["1.0", "2.2", "4.7"]);
		// 20%
		static public const E6:Vector.<String> = Vector.<String>(["1.0", "1.5", "2.2", "3.3", "4.7", "6.8"]);
		// 10%
		static public const E12:Vector.<String> = Vector.<String>(["1.0", "1.2", "1.5", "1.8", "2.2", "2.7", "3.3", "3.9", "4.7", "5.6", "6.8", "8.2"]);
		// 5%
		static public const E24:Vector.<String> = Vector.<String>([
			"1.0", "1.1", "1.2", "1.3", "1.5", "1.6", "1.8", "2.0", "2.2", "2.4", "2.7", "3.0",
			"3.3", "3.6", "3.9", "4.2", "4.7", "5.1", "5.6", "6.2", "6.8", "7.5", "8.2", "9.0"
		]);
		// 2%
		static public const E48:Vector.<String> = Vector.<String>([
			"1.00", "1.05", "1.10", "1.15", "1.21", "1.27", "1.33", "1.40", "1.47", "1.54", "1.61", "1.69",
			"1.78", "1.86", "1.96", "2.05", "2.15", "2.26", "2.37", "2.49", "2.61", "2.74", "2.87", "3.01",
			"3.16", "3.32", "3.48", "3.65", "3.83", "4.02", "4.22", "4.42", "4.64", "4.87", "5.11", "5.36",
			"5.62", "5.90", "6.19", "6.49", "6.81", "7.15", "7.50", "7.87", "8.25", "8.66", "9.09", "9.53"
		]);
		// 1%
		static public const E96:Vector.<String> = Vector.<String>([
			"1.00", "1.02", "1.05", "1.07", "1.10", "1.13", "1.15", "1.18", "1.21", "1.24", "1.27", "1.30",
			"1.33", "1.37", "1.40", "1.43", "1.47", "1.50", "1.54", "1.58", "1.61", "1.65", "1.69", "1.74",
			"1.78", "1.81", "1.86", "1.91", "1.96", "2.00", "2.05", "2.10", "2.15", "2.21", "2.26", "2.32",
			"2.37", "2.43", "2.49", "2.55", "2.61", "2.67", "2.74", "2.80", "2.87", "2.94", "3.01", "3.09",
			"3.16", "3.23", "3.32", "3.40", "3.48", "3.57", "3.65", "3.73", "3.83", "3.92", "4.02", "4.12",
			"4.22", "4.32", "4.42", "4.53", "4.64", "4.75", "4.87", "4.99", "5.11", "5.23", "5.36", "5.49",
			"5.62", "5.76", "5.90", "6.04", "6.19", "6.34", "6.49", "6.65", "6.81", "6.97", "7.15", "7.32",
			"7.50", "7.68", "7.87", "8.06", "8.25", "8.45", "8.66", "8.87", "9.09", "9.31", "9.53", "9.76"
		]);
		// 0.5%
		static public const E192:Vector.<String> = Vector.<String>([
			"1.00", "1.01", "1.02", "1.04", "1.05", "1.06", "1.07", "1.09", "1.10", "1.11", "1.13", "1.14",
			"1.15", "1.17", "1.18", "1.20", "1.21", "1.23", "1.24", "1.26", "1.27", "1.29", "1.30", "1.32",
			"1.33", "1.35", "1.37", "1.38", "1.40", "1.42", "1.43", "1.45", "1.47", "1.49", "1.50", "1.52",
			"1.54", "1.56", "1.58", "1.60", "1.61", "1.64", "1.65", "1.66", "1.69", "1.71", "1.74", "1.76",
			"1.78", "1.80", "1.81", "1.84", "1.86", "1.89", "1.91", "1.93", "1.96", "1.98", "2.00", "2.03",
			"2.05", "2.08", "2.10", "2.13", "2.15", "2.18", "2.21", "2.23", "2.26", "2.29", "2.32", "2.34",
			"2.37", "2.40", "2.43", "2.46", "2.49", "2.52", "2.55", "2.58", "2.61", "2.64", "2.67", "2.71",
			"2.74", "2.77", "2.80", "2.84", "2.87", "2.91", "2.94", "2.98", "3.01", "3.05", "3.09", "3.12",
			"3.16", "3.20", "3.23", "3.28", "3.32", "3.36", "3.40", "3.43", "3.48", "3.52", "3.57", "3.61",
			"3.65", "3.70", "3.73", "3.78", "3.83", "3.88", "3.92", "3.97", "4.02", "4.07", "4.12", "4.17",
			"4.22", "4.27", "4.32", "4.37", "4.42", "4.48", "4.53", "4.59", "4.64", "4.70", "4.75", "4.81",
			"4.87", "4.93", "4.99", "5.05", "5.11", "5.17", "5.23", "5.30", "5.36", "5.42", "5.49", "5.56",
			"5.62", "5.69", "5.76", "5.83", "5.90", "5.97", "6.04", "6.12", "6.19", "6.26", "6.34", "6.42",
			"6.49", "6.57", "6.65", "6.72", "6.81", "6.90", "6.97", "7.06", "7.15", "7.22", "7.32", "7.41",
			"7.50", "7.59", "7.68", "7.77", "7.87", "7.96", "8.06", "8.16", "8.25", "8.35", "8.45", "8.56",
			"8.66", "8.76", "8.87", "8.98", "9.09", "9.20", "9.31", "9.42", "9.53", "9.65", "9.76", "9.88"
		]);
		public function PreferredNumber() 
		{
			
		}
		
	}

	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author umhr
	 */
	class Question extends Sprite 
	{
		private var _resistor:Resistor = new Resistor();
		private var _index:int;
		private var _choiceList:Vector.<Choice> = new Vector.<Choice>();
		private var _choiceCanvas:Sprite = new Sprite();
		private var _countDownCanvas:Shape = new Shape();
		private var _count:int;
		public var answerData:ResistorData;
		public function Question() 
		{
			init();
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
			
			addChild(_resistor);
			_resistor.x = (stage.stageWidth - _resistor.width) * 0.5;
			_resistor.y = 40;
			addChild(_countDownCanvas);
			addChoice();
		}
		
		public function countDown(count:int):void {
			_countDownCanvas.graphics.clear();
			var rgb:int = PreferredNumber.BAND_COLORS[_index];
			var n:int = count;
			for (var i:int = 0; i < n; i++) 
			{
				//_countDownCanvas.graphics.beginFill(PreferredNumber.BAND_COLORS[i]);
				_countDownCanvas.graphics.beginFill(rgb);
				_countDownCanvas.graphics.drawCircle(20, 445 - i * 13, 3);
				_countDownCanvas.graphics.endFill();
			}
			_count = count;
		}
		
		public function generateQuestion():void {
			
			var e24:Vector.<String> = PreferredNumber.E24;
			var n:int = e24.length;
			var answer:Array = Utils.shuffle(n);
			var seikai:int = Math.floor(Math.random() * 4);
			var isAtari:Boolean = Math.random() < 0.25;
			
			var list:Array/*Number*/ = [];
			for (var i:int = 0; i < 4; i++) 
			{
				var resisitorData:ResistorData = new ResistorData();
				
				if (isAtari) {
					// 桁違い
					resisitorData.base = e24[answer[0]];
					resisitorData.torelancePercent = 5;
					resisitorData.pow = i;
					if (i < 2 && Math.random() < 0.5) {
						resisitorData.pow += 4;
					}
				}else {
					resisitorData.base = e24[answer[i]];
					resisitorData.torelancePercent = 5;
					resisitorData.pow = Math.random() * 3;
					resisitorData.pow += Math.random() * 3;
					resisitorData.pow += Math.random() * 3;
				}
				
				_choiceList[i].resistorData = resisitorData.clone();
				
				if (seikai == i) {
					answerData = resisitorData.clone();
				}
			}
			
			_resistor.resistorData = answerData.clone();
			_count = 5;
		}
		
		private function addChoice():void 
		{
			var n:int = 4;
			for (var i:int = 0; i < n; i++) 
			{
				var choice:Choice = new Choice();
				choice.x = (i % 2) * 190;
				choice.y = Math.floor(i * 0.5) * 120;
				choice.addEventListener(MouseEvent.MOUSE_UP, choice_mouseUp);
				choice.useHandCursor = true;
				_choiceCanvas.addChild(choice);
				_choiceList.push(choice);
			}
			_choiceCanvas.x = (stage.stageWidth - _choiceCanvas.width) * 0.5;
			_choiceCanvas.y = 200;
			addChild(_choiceCanvas);
		}
		
		private function choice_mouseUp(event:MouseEvent):void 
		{
			if (MoveManager.getInstance().isTween) {
				return;
			}
			var choice:Choice = event.target as Choice;
			if (choice.resistorData.toString() == _resistor.resistorData.toString()) {
				choice.isGood = true;
				answerData.isGood = true;
			}else {
				choice.isGood = false;
			}
			MoveManager.getInstance().next();
		}
		
		public function set index(value:int):void 
		{
			_index = value;
			
			var rgb:int = PreferredNumber.BAND_COLORS[_index];
			
			graphics.beginFill(rgb, 1);
			graphics.drawRoundRect(5, 5, 455, 455, 12, 12);
			graphics.drawRoundRect(10, 10, 445, 445, 8, 8);
			graphics.endFill();
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 48;
			textFormat.font = "_明朝";
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = rgb;
			
			var textField:TextField = new TextField();
			textField.defaultTextFormat = textFormat;
			textField.text = String(_index);
			textField.mouseEnabled = false;
			textField.selectable = false;
			textField.width = 50;
			textField.height = 50;
			textField.x = 8;
			textField.y = 10;
			
			addChild(textField);
		}
		
		public function get count():int 
		{
			return _count;
		}
		
	}
	

	
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	class QuestionManager extends Sprite 
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
				questio.y = i * 465;
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
	

	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author umhr
	 */
	class Rank extends Sprite 
	{
		private var _index:int;
		private var _score:Number;
		public function Rank(index:int) 
		{
			_index = index;
			init();
		}
		private function init():void 
		{
			addRank();
		}
		private function addRank():void 
		{
			var circle:Sprite = new Sprite();
			circle.graphics.beginFill(PreferredNumber.BAND_COLORS[_index], 1);
			circle.graphics.drawCircle(10, 10, 8);
			circle.graphics.endFill();
			circle.mouseEnabled = false;
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 14;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = ((2 < _index && _index < 6) || _index == 9)?0x000000:0xFFFFFF;
			textFormat.font = "_明朝";
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = textFormat;
			tf.text = _index.toString();
			tf.mouseEnabled = false;
			tf.selectable = false;
			tf.width = circle.width;
			tf.height = circle.height;
			tf.x = 2;
			tf.y = 1;
			circle.addChild(tf);
			
			addChild(circle);
		}
		public function reset():void {
			removeAll();
			addRank();
		}
		public function setResistor():void {
			reset();
			
			var question:Question = QuestionManager.getInstance().questioList[_index];
			
			var resisterData:ResistorData = question.answerData.clone();
			var resistor:Resistor = new Resistor();
			resistor.scaleX = resistor.scaleY = 0.25;
			resistor.x = 30;
			resistor.y = -6;
			resistor.resistorData = resisterData.clone();
			addChild(resistor);
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 12;
			//textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = 0xFFFFFF;
			textFormat.font = "_明朝";
			
			var bonus:int = question.count;
			if(bonus == 0){
				bonus = 1;
			}
			//±
			var text:String = resisterData.getText();
			text += " ±";
			text += resisterData.torelancePercent
			text += " = ";
			
			_score = Number(resisterData.base) * (Math.pow(10, resisterData.pow)) * (1 + resisterData.torelancePercent*(2*Math.random()-1) / 100);
			text += formatComma(Number(_score + 0.0001).toFixed(1)) + " Ω";
			
			if (!resisterData.isGood) {
				text = "Mistake!";
				_score = 0;
				textFormat.color = 0x666666;
			}
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = textFormat;
			tf.text = text;
			tf.mouseEnabled = false;
			tf.selectable = false;
			tf.width = 200;
			tf.height = 18;
			tf.x = 100;
			tf.y = 2;
			addChild(tf);
			
		}
		
		private function formatComma(num:String):String {
			var keta:Array = num.split(".");
			keta[0] = String(keta[0]).replace(/(\d)(?=(\d\d\d)+$)/g, "$1,");
			return keta.join(".");
		}
		
		private function removeAll():void 
		{
			while (numChildren > 0) {
				removeChildAt(0);
			}
		}
		
		public function get score():Number 
		{
			return _score;
		}
	}
	

	
	import a24.tween.Ease24;
	import a24.tween.EventTween24;
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
	class RankingManager extends Sprite 
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
			for (var i:int = 0; i < 10; i++) 
			{
				_rankList[i] = new Rank(i);
				_rankList[i].x = 225;
				_rankList[i].y = 90 + i * 30;
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
			_totalScore.width = 465;
			_totalScore.height = 30;
			_totalScore.y = 356;
		}
		
		public function setResistor():void {
			var tweenList:Array/*Tween24*/ = [];
			var score:Number = 0;
			var n:int = _rankList.length;
			for (var i:int = 0; i < n; i++) 
			{
				_rankList[i].visible = false;
				tweenList[i] = Tween24.tween(_rankList[i], 0, Ease24._2_QuadInOut).xy(120, 75 + i * 28).visible(true).delay(i * 0.1);
				_rankList[i].setResistor();
				score += _rankList[i].score;
			}
			Tween24.parallel.apply(this,tweenList).onComplete(onComplete).play();
			//_totalScore.text = "Total Score: " + Number(score + 0.0001).toFixed(1) + " Ω";
			_totalScore.text = "Total: " + formatComma(Number(score + 0.0001).toFixed(1)) + " Ω";
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
	

	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * 抵抗器の形を作ります。
	 * ...
	 * @author umhr
	 */
	class Resistor extends Sprite 
	{
		public function Resistor() 
		{
			init();
		}
		private var _0ohmBand:Shape = new Shape();
		private var _resistorData:ResistorData;
		private var _bandList:Vector.<Shape> = new Vector.<Shape>();
		private function init():void 
		{
			Gradation.drawGradientRoundRect(this, 0, 35, 240, 60, 16, [Utils.rgbBrightness(0xE7C190, 1.2), Utils.rgbBrightness(0xE7C190, 0.8)]);
			
			var n:int = 4;
			for (var i:int = 0; i < n; i++) 
			{
				var band:Shape = new Shape();
				addChild(band);
				band.x = 40 + 40 * i;
				band.y = 35;
				if (i == 3) {
					band.x += 20;
				}
				_bandList.push(band);
			}
			
			_0ohmBand.graphics.beginFill(0x000000);
			_0ohmBand.graphics.drawRect(0, 0, 20, 60);
			_0ohmBand.graphics.endFill();
			_0ohmBand.x = int(240 - 20) * 0.5;
			_0ohmBand.y = 35;
			addChild(_0ohmBand);
			
			reset();
		}
		
		public function reset():void {
			var band:Shape;
			// Band 数値
			for (var i:int = 0; i < 4; i++) 
			{
				band = _bandList[i];
				band.graphics.clear();
			}
			_0ohmBand.visible = true;
		}
		
		private function setBands(base:String, pow:int, torelancePercent:Number = 5):void {
			_0ohmBand.visible = false;
			
			var valList:Vector.<int> = new Vector.<int>();
			valList[0] = int(base.substr(0, 1));
			valList[1] = int(base.substr(2, 1));
			
			var keta:int = pow+1;
			
			var n:int = 2;
			var i:int = 0;
			var band:Shape;
			
			// Band 数値
			for (i = 0; i < n; i++) 
			{
				band = _bandList[i];
				band.graphics.clear();
				band.graphics.beginFill(PreferredNumber.BAND_COLORS[valList[i]]);
				band.graphics.drawRect(0, 0, 14, 60);
				band.graphics.endFill();
			}
			
			// Multiplier 位取り
			band = _bandList[2];
			band.graphics.clear();
			band.graphics.beginFill(PreferredNumber.MULTIPLIER_COLORS[keta]);
			band.graphics.drawRect(0, 0, 14, 60);
			band.graphics.endFill();
			
			// Torelance 誤差
			band = _bandList[3];
			band.graphics.clear();
			var rgb:int = PreferredNumber.TOLERANCE_COLORS[torelancePercent];
			Gradation.drawGradientRoundRect(band, 0, 0, 60, 14, 0, [Utils.rgbBrightness(rgb, 0.9), Utils.rgbBrightness(rgb, 1.5)]);
			band.rotation = 90;
		}
		
		public function get resistorData():ResistorData 
		{
			return _resistorData;
		}
		
		public function set resistorData(value:ResistorData):void 
		{
			setBands(value.base, value.pow, value.torelancePercent);
			_resistorData = value;
		}
	}

	
	/**
	 * ...
	 * @author umhr
	 */
	class ResistorData 
	{
		private var _base:String;
		private var _pow:int;
		private var _torelancePercent:Number;
		private var _isGood:Boolean;
		public function ResistorData() 
		{
			
		}
		
		public function clone():ResistorData {
			var result:ResistorData = new ResistorData();
			result._base = _base;
			result._pow = _pow;
			result._torelancePercent = _torelancePercent;
			result._isGood = _isGood;
			return result;
		}
		
		public function toString():String {
			var result:String = "ResistorData:{";
			result += "base:" + _base + ",";
			result += "pow:" + _pow + ",";
			result += "torelancePercent:" + _torelancePercent + ",";
			result += "isGood:" + _isGood;
			result += "}";
			return result;
		}
		
		public function getText():String {
			var text:String = "";
			var km:String = "";
			
			var tempPow:int = _pow;
			
			if (tempPow > 5) {
				km = "M";
				tempPow -= 6;
			}else if (pow > 2) {
				km = "K";
				tempPow -= 3;
			}
			
			if (tempPow > 0) {
				text = _base.replace(/\./g, "");
				if (tempPow > 1) {
					text += Math.pow(10, tempPow - 1).toString().substr(1);
				}
			}else {
				text = _base.toString();
			}
			
			if (text.substr(1) == ".0") {
				text = text.substr(0, 1);
			}
			
			text = text + km + " Ω";
			
			return text;
		}
		
		public function get base():String 
		{
			return _base;
		}
		
		public function set base(value:String):void 
		{
			_base = value;
		}
		
		public function get pow():int 
		{
			return _pow;
		}
		
		public function set pow(value:int):void 
		{
			_pow = value;
		}
		
		public function get torelancePercent():Number 
		{
			return _torelancePercent;
		}
		
		public function set torelancePercent(value:Number):void 
		{
			_torelancePercent = value;
		}
		
		public function get isGood():Boolean 
		{
			return _isGood;
		}
		
		public function set isGood(value:Boolean):void 
		{
			_isGood = value;
		}
		
	}
	

	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author umhr
	 */
	class Title extends Sprite 
	{
		private static var _instance:Title;
		public function Title(block:Block){init();};
		public static function getInstance():Title{
			if ( _instance == null ) {_instance = new Title(new Block());};
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
			
			var w:int = stage.stageWidth;
			var h:int = stage.stageHeight;
			
			graphics.beginFill(0x333333, 1);
			graphics.drawRoundRect(0, 0, w, h, 8, 8);
			graphics.endFill();
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 48;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = 0xFFFFFF;
			textFormat.font = "_明朝";
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = textFormat;
			tf.text = "抵抗のカラーコード";
			var n:int = 6;
			for (var i:int = 0; i < n; i++) 
			{
				tf.setTextFormat(new TextFormat(textFormat.font, textFormat.size, PreferredNumber.BAND_COLORS[i + 1]), i + 3, i + 4);
			}
			tf.mouseEnabled = false;
			tf.selectable = false;
			tf.width = stage.stageWidth;
			tf.y = 10;
			addChild(tf);
			
			setStartButton();
			
		}
		
		
		private function setStartButton():void 
		{
			var button:Sprite = new Sprite();
			button.graphics.beginFill(Utils.rgbBrightness(0xE7C190, 0.8), 1);
			button.graphics.drawRoundRect(0, 0, 200, 30, 8, 8);
			button.graphics.endFill();
			
			button.graphics.beginFill(0xE7C190, 1);
			button.graphics.drawRoundRect(2, 2, 196, 26, 6, 6);
			button.graphics.endFill();
			button.buttonMode = true;
			
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 24;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = 0x000000;
			textFormat.font = "_明朝";
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = textFormat;
			tf.text = "PLAY";
			tf.mouseEnabled = false;
			tf.selectable = false;
			tf.width = button.width;
			tf.height = 28;
			button.addChild(tf);
			
			button.x = int((stage.stageWidth - button.width) * 0.5);
			button.y = 400;
			button.useHandCursor = true;
			button.addEventListener(MouseEvent.CLICK, button_click);
			addChild(button);
			
		}
		
		private function button_click(event:MouseEvent):void 
		{
			MoveManager.getInstance().start();
		}
		
		
	}
	

	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author umhr
	 */
	class TitleManager extends Sprite 
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
	

	import flash.geom.ColorTransform;
	//Dump
	import flash.utils.getQualifiedClassName;
	
	//zSort
	import flash.display.DisplayObjectContainer;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.geom.Matrix;
	class Utils {
		public function Utils():void { };
		
		static public function numberFormat(num:String):String {
			return num.replace(/(\d)(?=(\d\d\d)+$)/g, "$1,");
		}
		
		/**
		 * フィールドカラーに変色します.
		 * 6桁16進数から、2桁ぶんずつを取り出す。 
		 * 色情報は24bit。r8bit+g8bit+b8bit。24桁の二進数 
		 * @param	rgb
		 * @param	ratio
		 * @return
		 */
		static public function colorFromRGB(rgb:int, ratio:Number = 1):ColorTransform {	
			//ratioが1以外の場合、明度変更関数へ
			if(ratio != 1){rgb = rgbBrightness(rgb,ratio)};
			var color:ColorTransform = new ColorTransform();
			color.redMultiplier = color.blueMultiplier = color.greenMultiplier = 0;
			color.redOffset = rgb >> 16;//16bit右にずらす。
			color.greenOffset = rgb >> 8 & 0xff;//8bit右にずらして、下位8bitのみを取り出す。
			color.blueOffset = rgb & 0xff;//下位8bitのみを取り出す。
			return color;
		}
		/*
		色の明度を相対的に変える関数。
		rgb値と割合を与えて、結果を返す。
		rgbは、0xffffff段階の値。
		ratioが0の時に0x000000に、1の時にそのまま、2の時には0xffffffになる。
		相対的に、ちょっと暗くしたい時には、ratioを0.8に、
		ちょっと明るくしたい時にはratioを1.2などに設定する。
		*/
		static public function rgbBrightness(rgb:int,ratio:Number):int{
			if(ratio < 0 || 2 < ratio){ratio = 1;trace("function colorBrightness 範囲外")}
			var _r:int = rgb >> 16;//16bit右にずらす。
			var _g:int = rgb >> 8 & 0xff;//8bit右にずらして、下位8bitのみを取り出す。
			var _b:int = rgb & 0xff;//下位8bitのみを取り出す。
			if(ratio <= 1){
				_r *= ratio;
				_g *= ratio;
				_b *= ratio;
			}else{
				_r = (255 - _r)*(ratio-1)+_r;
				_g = (255 - _g)*(ratio-1)+_g;
				_b = (255 - _b)*(ratio-1)+_b;
			}
			return _r<<16 | _g<<8 | _b;
		}
		//shuffle
		static public function shuffle(num:int):Array {
			var _array:Array = new Array();
			for (var i:int = 0; i < num; i++) {	
				_array[i] = Math.random();
			}
			return _array.sort(Array.RETURNINDEXEDARRAY);
		}
		//Dump
		static public function dump(obj:Object, isTrace:Boolean = true):String {
			var str:String = returnDump(obj)
			if (isTrace) {
				trace(str);
			}
			return str;
		}
		static public function returnDump(obj:Object):String {
			var str:String = _dump(obj);
			if (str.length == 0) {
				str = String(obj);
			}else if (getQualifiedClassName(obj) == "Array") {
				str = "[\n" + str.slice( 0, -2 ) + "\n]";
			}else {
				str = "{\n" + str.slice( 0, -2 ) + "\n}";
			}
			return str;
		}
		
		static public function traceDump(obj:Object):void {
			trace(returnDump(obj));
		}
		
		//zSort
		static private function _dump(obj:Object, indent:int = 0):String {
			var result:String = "";
			
			var da:String = (getQualifiedClassName(obj) == "Array")?'':'"';
			
			var tab:String = "";
			for ( var i:int = 0; i < indent; ++i ) {
				tab += "    ";
			}
			
			for (var key:String in obj) {
				if (typeof obj[key] == "object") {
					var type:String = getQualifiedClassName(obj[key]);
					if (type == "Object" || type == "Array") {
						result += tab + da + key + da + ":"+((type == "Array")?"[":"{");
						var dump_str:String = _dump(obj[key], indent + 1);
						if (dump_str.length > 0) {
							result += "\n" + dump_str.slice(0, -2) + "\n";
							result += tab;
						}
						result += (type == "Array")?"],\n":"},\n";
					}else {
						result += tab + '"' + key + '":<' + type + ">,\n";
					}
				}else if (typeof obj[key] == "function") {
					result += tab + '"' + key + '":<Function>,\n';
				}else {
					var dd:String = (typeof obj[key] == "string")?"'":"";
					result += tab + da + key + da + ":" + dd + obj[key] +dd + ",\n";
				}
			}			
			return result;
		}
		static public function zSort(target:DisplayObjectContainer, generation:int = 2):void {
			if(generation == 0 || !target.root){return};
			var n:int = target.numChildren;
			var array:Array = [];
			var reference:Array = [];
			for (var i:int = 0; i < n; i++) {
				if (target.getChildAt(i).transform.matrix3D) {
					var poz:Vector3D = target.getChildAt(i).transform.getRelativeMatrix3D(target.root.stage).position;
					var point:Point = target.root.stage.transform.perspectiveProjection.projectionCenter;
					array[i] = poz.subtract(new Vector3D(point.x, point.y, -target.root.stage.transform.perspectiveProjection.focalLength)).length;
					reference[i] = target.getChildAt(i);
				}
			}
			var temp:Array = array.sort(Array.NUMERIC | Array.RETURNINDEXEDARRAY);
			for (i = 0; i < n; i++) {
				if (target.getChildAt(i).transform.matrix3D) {
					target.setChildIndex(reference[temp[i]],0);
					if(reference[temp[i]].numChildren > 1){
						zSort(reference[temp[i]], generation - 1);
					}
				}
			}
			//return;
			for (i = 0; i < n; i++) {
				if (target.getChildAt(i).transform.matrix3D) {
					target.getChildAt(i).visible = (target.getChildAt(i).transform.getRelativeMatrix3D(target.root.stage).position.z > -400);
				}
			}
		}
	}
