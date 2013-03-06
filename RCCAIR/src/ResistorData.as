package  
{
	
	/**
	 * ...
	 * @author umhr
	 */
	public class ResistorData 
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
	
}