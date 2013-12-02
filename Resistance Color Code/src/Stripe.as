package  
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class Stripe extends Sprite 
	{
		private static var _instance:Stripe;
		public function Stripe(block:Block){init();};
		public static function getInstance():Stripe{
			if ( _instance == null ) {_instance = new Stripe(new Block());};
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
			
			var bitmap:Bitmap = new Bitmap(new BitmapData(Main.stageWidth, Main.stageHeight, false, 0xFF000000));
			//graphics.beginFill(0x000000);
			//graphics.drawRect(0, 0, Main.stageWidth, Main.stageHeight);
			//graphics.endFill();
			
			var men:Shape = new Shape();
			var tx:Number = 0;
			var ty:Number = 0;
			var degrees:Number = 45;
			var radians:Number = degrees * Math.PI / 180;
			
			var th:Number = 15 * Math.cos(radians);
			var tw:Number = 15 * Math.sin(radians);
			
			var n:int = 22;
			n = Math.max(n, Main.stageWidth / (tw + 48));
			n = Math.max(n, Main.stageHeight / (th + 48));
			n = int(n * 2);
			for (var i:int = 0; i < n; i++) 
			{
				var rgb:int = Utils.rgbBrightness(PreferredNumber.BAND_COLORS[(i + 2) % 9 + 1], 0.5);
				//var rgb:int = Utils.rgbBrightness(PreferredNumber.BAND_COLORS[(i + 2) % 9 + 1], 1);
				men.graphics.beginFill(rgb);
				men.graphics.moveTo(tx, 0);
				men.graphics.lineTo(tx + tw, 0);
				men.graphics.lineTo(0, ty + th);
				men.graphics.lineTo(0, ty);
				tx += th + 48;
				ty += tw + 48;
			}
			
			bitmap.bitmapData.draw(men);
			
			addChild(bitmap);
		}
		
		
	}
	
}
class Block { };