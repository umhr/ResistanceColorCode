package  
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	/**
	 * ...
	 * @author umhr
	 */
	public class ChainShape extends Shape 
	{
		
		public function ChainShape() 
		{
		}
		
		public function beginBitmapFill(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false):ChainShape {
			graphics.beginBitmapFill(bitmap, matrix, repeat, smooth);
			return this;
		}
		
		public function beginFill(color:uint, alpha:Number = 1):ChainShape {
			graphics.beginFill(color, alpha);
			return this;
		}
		
		public function lineTo(x:Number, y:Number):ChainShape {
			graphics.lineTo(x, y);
			return this;
		}
		
		public function moveTo(x:Number, y:Number):ChainShape {
			graphics.moveTo(x, y);
			return this;
		}
		
		public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):ChainShape {
			graphics.curveTo(controlX, controlY, anchorX, anchorY);
			return this;
		}
		
		public function closePath():ChainShape {
			graphics.endFill();
			return this;
		}
		
		public function clear():ChainShape {
			graphics.clear();
			return this;
		}
	}

}