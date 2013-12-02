package  
{
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author umhr
	 */
	public class Rank extends Sprite 
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
			//addRank();
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
			tf.height = circle.height+4;
			tf.x = 2;
			tf.y = 0;
			tf.cacheAsBitmap = true;
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
			resistor.x = 60;
			resistor.y = 11;
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
				textFormat.color = 0xFFFFFF;
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
	
}