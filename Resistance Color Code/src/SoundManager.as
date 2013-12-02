package  
{
	import flash.media.Sound;
	/**
	 * 次の音源を使っています。
	 * 音の葉っぱ～効果音・ジングル・BGMのフリー音素材集～
	 * http://www.geocities.jp/spacheeg/
	 * ...
	 * @author umhr
	 */
	public class SoundManager 
	{
		private static var _instance:SoundManager;
		public function SoundManager(block:Block){init();};
		public static function getInstance():SoundManager{
			if ( _instance == null ) {_instance = new SoundManager(new Block());};
			return _instance;
		}
		
		static public const OK:String = "ok";
		static public const NG:String = "ng";
		static public const NEXT:String = "next";
		static public const SCORE:String = "score";
		static public const START:String = "start";
		
		private var _isOn:Boolean = true;
		private var _ok:Sound;
		private var _ng:Sound;
		private var _next:Sound;
		private var _score:Sound;
		private var _start:Sound;
		
		private function init():void
		{
			_ok = new seikai();
			_ng = new dame();
			_next = new pin1b();
			_score = new kira();
			_start = new ect1d();
		}
		
		public function play(type:String):void {
			if(_isOn){
				(this["_" + type] as Sound).play(0);
			}
		}
		
		public function get isOn():Boolean 
		{
			return _isOn;
		}
		
		public function set isOn(value:Boolean):void 
		{
			_isOn = value;
		}
		
		
		
	}
	
}
class Block { };