package  
{
	
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
	public class Question extends Sprite 
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
			_resistor.y = (stage.stageHeight - 385) * 0.5;//40;
			addChild(_countDownCanvas);
			addChoice();
		}
		
		public function countDown(count:int):void {
			_countDownCanvas.graphics.clear();
			var rgb:int = PreferredNumber.BAND_COLORS[_index];
			var n:int = count;
			var h:int = Main.stageHeight - 20;
			for (var i:int = 0; i < n; i++) 
			{
				_countDownCanvas.graphics.beginFill(rgb);
				_countDownCanvas.graphics.drawCircle(20, h - i * 13, 3);
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
			_choiceCanvas.y = (stage.stageHeight - 385) * 0.5 + 160;// 200;
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
			
			var w:int = Main.stageWidth;
			var h:int = Main.stageHeight;
			
			graphics.beginFill(rgb, 1);
			graphics.drawRoundRect(5, 5, w - 10, h - 10, 12, 12);
			graphics.drawRoundRect(10, 10, w - 20, h - 20, 8, 8);
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
	
}