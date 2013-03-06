package  
{
	
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
	public class Choice extends Sprite 
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
			//_textField.cacheAsBitmap = false;
			_textField.text = value.getText();
			//_textField.cacheAsBitmap = true;
			_judgment.graphics.clear();
			
			_resistorData = value;
		}
		
		public function set isGood(value:Boolean):void 
		{
			if (value) {
				// 正解
				SoundManager.getInstance().play(SoundManager.OK);
				_judgment.graphics.beginFill(0xFF0000);
				_judgment.graphics.drawCircle(0, 0, 45);
				_judgment.graphics.drawCircle(0, 0, 35);
				_judgment.graphics.endFill();
			}else {
				// 不正解
				SoundManager.getInstance().play(SoundManager.NG);
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
	
}