package views
{
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;

	public class CustomColor
	{
		//线图颜色备份1:Array=[0x90923a,0x926e3a,0x923a3a,0x752f74,0x5a4825,0x3a6e92,0x62752f,0x2f4075,0x40752f,0x573481];
		//柱图颜色备份1:Array=[0x0099ff,0x7800ff,0xcc00cc,0xff0000,0xff9900,0xffff00,0x00cc00,0x33cc00,0x996600,0x0033cc];
		
		//柱状图2：0x0099ff,0xcc00cc,0xff9900,0x99cc00,0xff0000,0x7800ff,0x33cc00,0x996600,0x0033cc,0xffff00
		//线条图2：0xffff00,0xff0000,0x33cc00,0x7800ff,0x996600,0x0033cc,0xff9900,0xcc00cc,0x99cc00,0x0099ff
		
		//饼图颜色数组(原色备份）
		//private static var pColor:Array=[0x0099ff,0xcc00cc,0xff9900,0x99cc00,0xff0000,0x7800ff,0x33cc00,0x996600,0x0033cc,0xffff00];
		//private static var pColor2:Array=[0x0099ff,0x0099ff,0xcc00cc,0xff9900,0x99cc00,0xff0000,0x7800ff,0x33cc00,0x996600,0x0033cc,0xffff00];
		//柱图颜色数组
		//private static var cColor:Array=[0x0099ff,0xcc00cc,0xff9900,0x99cc00,0xff0000,0x7800ff,0x33cc00,0x996600,0x0033cc,0xffff00];
		//线图颜色数组
		//private static var lColor:Array=[0xffff00,0xff0000,0x33cc00,0x7800ff,0x996600,0x0033cc,0xff9900,0xcc00cc,0x99cc00,0x0099ff];
		//条形图颜色数组
		//private static var bColor:Array=[0x0099ff,0xcc00cc,0xff9900,0x99cc00,0xff0000,0x7800ff,0x33cc00,0x996600,0x0033cc,0xffff00];
		
		//饼图颜色数组
		//private static var pColor:Array=[0xdde6e7,0xd6dd96,0xfdec8f,0xd4b1bf,0xfecca8,0xa0cec8,0xa0cec8,0xbdc296,0xe1d292,0xdbccd5];
		//private static var pColor2:Array=[0xdde6e7,0xdde6e7,0xd6dd96,0xfdec8f,0xd4b1bf,0xfecca8,0xa0cec8,0xa0cec8,0xbdc296,0xe1d292,0xdbccd5];
		private static var pColor:Array=[0x006da7,0x42952f,0xffb100,0xd17d86,0xabab31,0xd81e00,0x796791,0xb59842,0x975fde,0x7bab00];
		private static var pColor2:Array=[0x006da7,0x006da7,0x42952f,0xffb100,0xd17d86,0xabab31,0xd81e00,0x796791,0xb59842,0x975fde,0x7bab00];
		//柱图颜色数组
		private static var cColor:Array=[0x6ca0bf,0xa8841d,0x5e7a03,0xa86031,0x096365,0x8f2e2e,0x5f3062,0x3d5a1a,0x7b7507,0x035d8d];
		//线图颜色数组
		private static var lColor:Array=[0xd81e00,0xd17d86,0x006da7,0x42952f,0xabab31,0x796791,0xb59842,0xffb100,0x975fde,0x7bab00];
		//条形图颜色数组
		private static var bColor:Array=[0x99809e,0xcba12f,0xa84d2b,0x7b9821,0x83999e,0x9b4745,0x776688,0xae683b,0x4796be,0x577137];
		
		
		//统计图背景颜色
		private static var borderStrokeColor:uint=0x666666;
		private static var minorTickStrokeColor:uint=0x666666;
		private static var tickStrokeColor:uint=0x666666;
		private static var axisStrokeColor:uint=0x666666;
		
		//饼图相关颜色
		private static var calloutsColor:uint=0x666666;
		private static var radialColor:uint=0x666666;
		private static var pieborderColor:uint=0x666666;

		public static function get PColor():Array{return pColor;}
		public static function get PColor2():Array{return pColor2;}
		public static function get CColor():Array{return cColor;}
		public static function get LColor():Array{return lColor;}
		public static function get BColor():Array{return bColor;}

		public static function get PSolidColor():Array{
			var res:Array=new Array();
			for each (var item:uint in pColor) {   
				res.push(new SolidColor(item,1));		
			}  			
			return res;
		}
		public static function get PSolidColor2():Array{
			var res:Array=new Array();
			for each (var item:uint in pColor2) {   
				res.push(new SolidColor(item,1));		
			}  			
			return res;
		}
		public static function get CSolidColor():Array{
			var res:Array=new Array();
			for each (var item:uint in cColor) {   
				res.push(new SolidColor(item,1));		
			}  			
			return res;
		}
		public static function get LSolidColor():Array{
			var res:Array=new Array();
			for each (var item:uint in lColor) {   
				res.push(new SolidColor(item,1));		
			}  			
			return res;
		}	
		public static function get BSolidColor():Array{
			var res:Array=new Array();
			for each (var item:uint in bColor) {   
				res.push(new SolidColor(item,1));		
			}  			
			return res;
		}	
		
		public static function get PSolidColorStroke():Array{
			var res:Array=new Array();
			for each (var item:uint in pColor) {   
				res.push(new SolidColorStroke(item,1,1));		
			}  			
			return res;
		}
		public static function get PSolidColorStroke2():Array{
			var res:Array=new Array();
			for each (var item:uint in pColor2) {   
				res.push(new SolidColorStroke(item,1,1));		
			}  			
			return res;
		}
		public static function get CSolidColorStroke():Array{
			var res:Array=new Array();
			for each (var item:uint in cColor) {   
				res.push(new SolidColorStroke(item,1,1));		
			}  			
			return res;
		}
		public static function get LSolidColorStroke():Array{
			var res:Array=new Array();
			for each (var item:uint in lColor) {   
				res.push(new SolidColorStroke(item,2,1));		
			}  			
			return res;
		}
		public static function get BSolidColorStroke():Array{
			var res:Array=new Array();
			for each (var item:uint in bColor) {   
				res.push(new SolidColorStroke(item,2,1));		
			}  			
			return res;
		}
		

		public static function get BorderSolidColorStroke():SolidColorStroke{
				return new SolidColorStroke(borderStrokeColor,1,1);		

		}
		public static function get MinorTickSolidColorStroke():SolidColorStroke{
			return new SolidColorStroke(minorTickStrokeColor,1,1);		
			
		}
		public static function get TickSolidColorStroke():SolidColorStroke{
			return new SolidColorStroke(tickStrokeColor,1,1);		
			
		}
		public static function get AxisSolidColorStroke():SolidColorStroke{
			return new SolidColorStroke(axisStrokeColor,1,1);		
			
		}
		
		

		
		public static function get CalloutsSolidColorStroke():SolidColorStroke{
			return new SolidColorStroke(calloutsColor,2,.8);		
			
		}
		public static function get RadialSolidColorStroke():SolidColorStroke{
			return new SolidColorStroke(radialColor,1,.3);		
			
		}
		public static function get PieborderSolidColorStroke():SolidColorStroke{
			return new SolidColorStroke(pieborderColor,2,.5);		
			
		}
		
		
		public function CustomColor()
		{
		}
	}
}