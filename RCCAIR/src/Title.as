package  
{
	
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
	public class Title extends Sprite 
	{
		private static var _instance:Title;
		public function Title(block:Block){init();};
		public static function getInstance():Title{
			if ( _instance == null ) {_instance = new Title(new Block());};
			return _instance;
		}
		
		private var _copyRights:TextField = new TextField();
		private function init():void
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}
		
		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			addChild(Stripe.getInstance());
			
			//graphics.beginFill(0x333333, 1);
			//graphics.drawRoundRect(0, 0, w, h, 8, 8);
			//graphics.endFill();
			
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
			tf.width = Main.stageWidth;
			tf.y = 10;
			addChild(tf);
			
			setStartButton();
			
			addCopyRights();
		}
		
		private function addCopyRights():void 
		{
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 11;
			textFormat.align = TextFormatAlign.CENTER;
			textFormat.color = 0xFFFFFF;
			textFormat.font = "_明朝";
			
			_copyRights.defaultTextFormat = textFormat;
			_copyRights.text = "Created by Mizutama Inc. Sound by 音の葉っぱ～効果音・ジングル・BGMのフリー音素材集～";
			//_copyRights.mouseEnabled = false;
			_copyRights.selectable = false;
			_copyRights.width = Main.stageWidth;
			_copyRights.height = 14;
			_copyRights.y = Main.stageHeight - _copyRights.height;
			_copyRights.addEventListener(MouseEvent.MOUSE_DOWN, copyRights_mouseDown);
			addChild(_copyRights);
		}
		
		private function copyRights_mouseDown(event:MouseEvent):void 
		{
			if (SoundManager.getInstance().isOn) {
				_copyRights.text = "Created by Mizutama Inc.";
				SoundManager.getInstance().isOn = false;
			}else {
				_copyRights.text = "Created by Mizutama Inc. Sound by 音の葉っぱ～効果音・ジングル・BGMのフリー音素材集～";
				SoundManager.getInstance().isOn = true;
			}
		}
		
		private function setStartButton():void 
		{
			var button:Sprite = new Sprite();
			button.graphics.beginFill(Utils.rgbBrightness(0xE7C190, 0.8), 1);
			button.graphics.drawRoundRect(0, 0, 200, 50, 8, 8);
			button.graphics.endFill();
			
			button.graphics.beginFill(0xE7C190, 1);
			button.graphics.drawRoundRect(2, 2, 196, 46, 6, 6);
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
			tf.y = 11;
			button.addChild(tf);
			
			button.x = int((Main.stageWidth - button.width) * 0.5);
			button.y = Main.stageHeight-120;
			button.useHandCursor = true;
			button.addEventListener(MouseEvent.CLICK, button_click);
			addChild(button);
			
		}
		
		private function button_click(event:MouseEvent):void 
		{
			MoveManager.getInstance().start();
		}
		
	}
	
}
class Block { };