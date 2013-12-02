package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
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
		private var _tempSilet:Sprite = new Sprite();
		private var _silet:Bitmap = new Bitmap(new BitmapData(240, 60, true, 0x00000000));
		private var _resistorSilet:ChainShape = new ChainShape();
		private function init():void 
		{
			Gradation.drawGradientRoundRect(_tempSilet, 0, 0, 240, 60, 16, [Utils.rgbBrightness(0xE7C190, 1.2), Utils.rgbBrightness(0xE7C190, 0.8)]);
			
			//_resistorSilet.y = 55;
			addChild(_resistorSilet);
			
			var n:int = 4;
			for (var i:int = 0; i < n; i++) 
			{
				var band:Shape = new Shape();
				_tempSilet.addChild(band);
				band.x = 40 + 40 * i;
				//band.y = 35;
				if (i == 3) {
					band.x += 20;
				}
				_bandList.push(band);
			}
			
			//_0ohmBand.graphics.beginFill(0x000000);
			//_0ohmBand.graphics.drawRect(0, 0, 20, 60);
			//_0ohmBand.graphics.endFill();
			//_0ohmBand.x = int(240 - 20) * 0.5;
			//_0ohmBand.y = 35;
			//addChild(_0ohmBand);
			
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
			
			var rgb:int;
			
			// Multiplier 位取り
			band = _bandList[2];
			band.graphics.clear();
			if(keta == 1){
				// 金の場合
				band.x = 40 + 40 * 2 + 14;
				rgb = PreferredNumber.MULTIPLIER_COLORS[keta];
				Gradation.drawGradientRoundRect(band, 0, 0, 60, 14, 0, [Utils.rgbBrightness(rgb, 0.9), Utils.rgbBrightness(rgb, 1.5)]);
				band.rotation = 90;
			}else {
				band.x = 40 + 40 * 2;
				band.graphics.beginFill(PreferredNumber.MULTIPLIER_COLORS[keta]);
				band.graphics.drawRect(0, 0, 14, 60);
				band.rotation = 0;
			}
			band.graphics.endFill();
			
			// Torelance 誤差
			band = _bandList[3];
			band.graphics.clear();
			rgb = PreferredNumber.TOLERANCE_COLORS[torelancePercent];
			Gradation.drawGradientRoundRect(band, 0, 0, 60, 14, 0, [Utils.rgbBrightness(rgb, 0.9), Utils.rgbBrightness(rgb, 1.5)]);
			band.rotation = 90;
			
			draw();
		}
		
		private function draw():void 
		{
			_silet.bitmapData.fillRect(_silet.bitmapData.rect, 0x00000000);
			_silet.bitmapData.draw(_tempSilet);
			
			_resistorSilet.graphics.beginBitmapFill(_silet.bitmapData, new Matrix(1.1, 0, 0, 2, -117.5 - 10, -72.5));
			_resistorSilet.moveTo(90.8, -34.8).curveTo(82.8, -41.5, 72.4, -41.5).curveTo(65.8, -41.5, 56.7, -38.1).curveTo(47.6, -34.8, 42.2, -34.8)
			.lineTo( -42.2, -34.8).curveTo( -47.5, -34.8, -56.7, -38.1).curveTo( -65.8, -41.5, -72.5, -41.5).curveTo( -82.8, -41.5, -90.8, -34.8)
			.curveTo( -94.7, -31.3, -101, -22.4).curveTo( -106.3, -17.2, -110.1, -13.1).curveTo( -117.5, -5.3, -117.5, -0)
			.curveTo( -117.5, 4.5, -110.7, 11.8).curveTo( -100.8, 22.2, -97.8, 27).curveTo( -93.3, 34.1, -86.2, 37.9)
			.curveTo( -79.6, 41.5, -72.3, 41.5).curveTo( -62, 41.5, -55.5, 38.4).curveTo( -48.5, 35.2, -42.2, 34.9)
			.curveTo( -33.1, 34.4, 0, 34.4).curveTo(33.2, 34.4, 42.2, 34.9).curveTo(48.5, 35.2, 55.4, 38.4).curveTo(61.9, 41.5, 72.3, 41.5)
			.curveTo(79.6, 41.5, 86.2, 37.9).curveTo(93.3, 34.1, 97.8, 27).curveTo(100.8, 22.2, 110.7, 11.8).curveTo(117.5, 4.5, 117.5, -0)
			.curveTo(117.5,-5.3,110.1,-13.1).curveTo(106.3,-17.2,101,-22.4).curveTo(94.7,-31.3,90.8,-34.8).closePath();
			
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