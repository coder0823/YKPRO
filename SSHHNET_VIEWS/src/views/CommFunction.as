package views
{
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import mx.charts.ChartItem;
	import mx.charts.series.items.PieSeriesItem;
	import mx.graphics.GradientEntry;
	import mx.graphics.IFill;
	import mx.graphics.LinearGradient;
	import mx.graphics.RadialGradient;
	import mx.graphics.SolidColor;

	public class CommFunction
	{
		private static var GradientColor:uint=0xffffff;
		private static var GradientColorStep:Number=5;//获取GradientColor和系统颜色之间的颜色，确定分几步
		private static var GradientColorIndex:Number=3;//获取GradientColor和系统颜色之间的颜色，获取其中的第几个颜色
		public function CommFunction()
		{
		}
		
		//获取2色间的渐变色使用方法：只需调用generateTransitionalColor方法，例如：
		//var c1:uint=0xFF0000; 
		//var c2:uint=0x000000; 
		//var colors:Array=ColorGradient.generateTransitionalColor(c1,c2,10);
		//返回 c1与c2之间的10步渐变色
		
		/**    
		 * replaceAll    
		 * @param source:String 源数据    
		 * @param find:String 替换对象    
		 * @param replacement:Sring 替换内容    
		 * @return String    
		 * **/    
		public static function replaceAll( source:String, find:String, replacement:String ):String{     
			return source.split( find ).join( replacement );     
		}  
		
		/**  
		 * 柱状图的fillFunction绑定 渐变颜色，:  
		 * 参数，要渐变的颜色
		 */  
		public static function colFillFun(color:uint):Function{
			return function (item:ChartItem, index:Number):mx.graphics.IFill{
				var color2:uint=generateTransitionalColor(GradientColor,color,GradientColorStep)[GradientColorIndex];//获取2个颜色中间的颜色			
				var _fill:LinearGradient=new LinearGradient();
				var _e1:GradientEntry=new GradientEntry(color);
				var _e2:GradientEntry=new GradientEntry(color2);
				var _e3:GradientEntry=new GradientEntry(color);
				var _e4:GradientEntry=new GradientEntry(color2);
				var _entries:Array=[_e1,_e2,_e3,_e4];
				_fill.entries=_entries;
				return _fill
			}
		}
		
		/**  
		 * 条形图的fillFunction绑定 渐变颜色，:  
		 * 参数，要渐变的颜色
		 */  
		public static function barFillFun(color:uint):Function{
			return function (item:ChartItem, index:Number):mx.graphics.IFill{
				var color2:uint=generateTransitionalColor(GradientColor,color,GradientColorStep)[GradientColorIndex];//获取2个颜色中间的颜色	
				var _fill:LinearGradient=new LinearGradient();
				var _e1:GradientEntry=new GradientEntry(color);
				var _e2:GradientEntry=new GradientEntry(color2);
				var _e3:GradientEntry=new GradientEntry(color);
				var _e4:GradientEntry=new GradientEntry(color2);
				var _entries:Array=[_e1,_e2,_e3,_e4];
				_fill.entries=_entries;
				_fill.rotation=90;
				return _fill
			}
		}
		
		/**  
		 * 条形图的fillFunction绑定 渐变颜色，:  
		 * 参数，要渐变的颜色
		 */  
		public static function barFillFun2(color:uint):LinearGradient{
			var color2:uint=generateTransitionalColor(GradientColor,color,GradientColorStep)[GradientColorIndex];//获取2个颜色中间的颜色	
			var _fill:LinearGradient=new LinearGradient();
			var _e1:GradientEntry=new GradientEntry(color);
			var _e2:GradientEntry=new GradientEntry(color2);
			var _e3:GradientEntry=new GradientEntry(color);
			var _e4:GradientEntry=new GradientEntry(color2);
			var _entries:Array=[_e1,_e2,_e3,_e4];
			_fill.entries=_entries;
			_fill.rotation=90;
			return _fill
		}
		
		/**  
		 * 饼形图的fillFunction绑定 渐变颜色，:  
		 * 参数，要渐变的颜色
		 */ 
		public static function pieFillFun(solidColor:Array):Function{
			return function (item:ChartItem, index:Number):mx.graphics.IFill{
				var color:uint=solidColor.length>index?SolidColor(solidColor[index]).color:0x999999;
				var color2:uint=generateTransitionalColor(GradientColor,color,GradientColorStep)[GradientColorIndex];//获取2个颜色中间的颜色	
				var _fill:RadialGradient=new RadialGradient();
				var _e1:GradientEntry=new GradientEntry(color2);
				var _e2:GradientEntry=new GradientEntry(color);
				var _entries:Array=[_e1,_e2];
				_fill.entries=_entries;
				return _fill
			}
		}
		
		//测试
		public static function pieSeries_fillFunc(item:ChartItem, index:Number):IFill {
			var curItem:PieSeriesItem = PieSeriesItem(item);
			/* Convert to a number between 0 and 1. */
			var pct:Number = curItem.percentValue / 100;
			return new SolidColor(0x0000FF * pct, 1.0);
		}
		
		
		/**  
		 * 输入一个颜色,将它拆成三个部分:  
		 * 红色,绿色和蓝色  
		 */  
		public static function retrieveRGBComponent( color:uint ):Array   
		{   
			var r:Number = color >> 16;   
			var g:Number = (color >> 8) & 0xff;   
			var b:Number = color & 0xff;   
			
			return [r, g, b];   
		}   
		/**  
		 * 红色,绿色和蓝色三色组合  
		 */  
		public static function generateFromRGBComponent( rgb:Array ):int  
		{   
			if( rgb == null || rgb.length != 3 ||    
				rgb[0] < 0 || rgb[0] > 255 ||   
				rgb[1] < 0 || rgb[1] > 255 ||   
				rgb[2] < 0 || rgb[2] > 255 )   
				return 0xFFFFFF;   
			return rgb[0] << 16 | rgb[1] << 8 | rgb[2];   
		}   
		
		/**  
		 * color1是浅色,color2是深色,实现渐变  
		 * steps是指在多大的区域中渐变,  
		 */  
		public static function generateTransitionalColor( color1:uint, color2:uint, steps:int):Array   
		{   
			if( steps < 3 )   
				return [];   
			
			var color1RGB:Array = retrieveRGBComponent( color1 );   
			var color2RGB:Array = retrieveRGBComponent( color2 );   
			
			var colors:Array = [];   
			colors.push( color1 );   
			//steps = steps - 2;   
			
			var redDiff:Number = color2RGB[0] - color1RGB[0];   
			var greenDiff:Number = color2RGB[1] - color1RGB[1];   
			var blueDiff:Number = color2RGB[2] - color1RGB[2];   
			for( var i:int = 1; i < steps - 1; i++)   
			{   
				var tmpRGB:Array = [   
					color1RGB[0] + redDiff * i / steps,   
					color1RGB[1] + greenDiff * i / steps,   
					color1RGB[2] + blueDiff * i / steps   
				];   
				colors.push( generateFromRGBComponent( tmpRGB ) );   
			}   
			colors.push( color2 );   
			
			return colors;
		}  
		
		
	}
}