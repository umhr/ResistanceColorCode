package  
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * 抵抗器の形を作ります。
	 * ...
	 * @author umhr
	 */
	public class Resistor extends Sprite 
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
}