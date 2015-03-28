package views
{
	
	import flash.display.Graphics;

	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.charts.chartClasses.GraphicsUtilities;
	import mx.controls.Text;
	import mx.graphics.IFill;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	
	import skins.GaugeSkin;
	

	import spark.components.Label;
	import spark.components.SkinnableContainer;

	import spark.primitives.Path;

	public class Gauge extends SkinnableContainer
	{
		public function Gauge()
		{
			super();
			//在构造函数中，声明属性的初始值和样式
			this.setStyle("skinClass",GaugeSkin);
		}
		[SkinPart(required="true")]
		public var ticks:SkinnableContainer;
		[SkinPart(required="true")]
		public var tickValues:SkinnableContainer;
		[SkinPart(required="true")]
		public var alerts:SkinnableContainer;
		[SkinPart(required="true")]
		public var pointer:Path;
		[SkinPart(required="false")]
		public var gaugeUnit:Label;
		
		//指针角度
		[Bindable]
		public var pointerAngle:Number=-30;
		private var _value:Number=0;
		[Bindable]
		public function set value(v:Number):void{
			this._value = v;
			
			pointerAngle = v/100*240-30;
			invalidateProperties();
		}
		public function get value():Number{
			return this._value;
		}
		
		private var _gaugeUnitText:String = " ";
		[Bindable]
		public function set gaugeUnitText(v:String):void{
			_gaugeUnitText = v;
		}
		public function get gaugeUnitText():String{
			return _gaugeUnitText;
		}
		
		override protected function partAdded(partName:String, instance:Object):void{
			if(instance == tickValues){
				generateLabels();
				label = new Text();
				valueLabel = new Label();
				valueLabel.setStyle("fontSize",16);
				valueLabel.width = 100;
				valueLabel.setStyle("textAlign","center");
				
				this.tickValues.addElement(valueLabel);
				this.valueLabel.text = _value+"";
			}
		}
		override protected function commitProperties():void{
			this.valueLabel.text = this.value+"";
			this.radius = width/2;
		}
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			generateTicks();
			positionScaleLabels();
//			drawAlerts(alerts.graphics, -31,80, 0xFF9500, 1, 200);
//			drawAlerts(alerts.graphics, 50,80, 0xE400EA, 1, 200);
//			drawAlerts(alerts.graphics, 130,81, 0xD00000, 1, 200);
			drawAlerts(alerts.graphics, -31,80, 0xE6413A, 1, 200);
			drawAlerts(alerts.graphics, 50,80, 0xFACF0C, 1, 200);
			drawAlerts(alerts.graphics, 130,81, 0x4BB648, 1, 200);
		}
		//生成刻度值
		private var labels:Array = new Array();
		private function generateLabels():void
		{
			if(labels != null)
			{
				for(var j:int = 0;j < labels.length;j++)
				{
					if(this.contains(labels[j]))
					{
						this.removeChild(labels[j]);
					}
				}
				//delete all labels
				labels.splice(0,labels.length);
			}
			for(var i:int = 0;i < graduations.length; i++)
			{
				var tf:Text = new Text();
				//tf.antiAliasType = AntiAliasType.ADVANCED;
				//tf.autoSize = TextFieldAutoSize.LEFT;
				tf.text = graduations[i]; 
				tf.setStyle("color",0xFFFFFF);
				tf.selectable = false; 
				labels.push(tf);
				tickValues.addElementAt(tf,0);
			}
		}
		//定位延展的Labels
		//是否在表盘内部显示刻度值
		private var scaleInside:Boolean = true;
		private var scaleGap:Number = 10;
		private var label:Text;
		private var valueLabel:Label;
		private function positionScaleLabels():void
		{
			//radian:弧度 		sweep:弧度范围
			var sweep:Number = radianTo - radianFrom;
			//主刻度之间空白所拥有的弧度范围
			var gradRadian:Number = sweep / (graduations.length - 1); 
			//主刻度线的长度
			var matl:Number =  10;
			//主刻度线外部边缘到 表盘边框的距离
			var ti:Number = 0;
			//radius:半径	scaleInside:是否在表盘内部显示刻度值		scaleGap:刻度值距离刻度内部端点的距离
			//var labelRadius:Number = radius - ti - (scaleInside?(matl + scaleGap):-scaleGap);
			var labelRadius:Number = 67;
			//计算每个刻度值的坐标
			for(var i:int = 0;i<labels.length;i++)
			{
				var radian:Number = radianFrom + (i * gradRadian);
//				labels[i].x = Math.sin(radian) * labelRadius + centerx - (labels[i].width/2) - ((scaleInside?1:-1) * (Math.sin(radian) * (labels[i].width/2))); 
//				labels[i].y = -Math.cos(radian) * labelRadius + centery - labels[i].height/2 + ((scaleInside?1:-1) * (Math.cos(radian) * (labels[i].height/2)));
				labels[i].x = Math.sin(radian) * labelRadius + 90 - (labels[i].width/2) - ((scaleInside?1:-1) * (Math.sin(radian) * (labels[i].width/2))); 
				labels[i].y = -Math.cos(radian) * labelRadius +90 - labels[i].height/2 + ((scaleInside?1:-1) * (Math.cos(radian) * (labels[i].height/2)));
			}
			
			label.x = centerx - label.width/2;
			label.y = centery - label.height;
			
			valueLabel.setStyle("color",0xFFFFFF);
			valueLabel.x = centerx - valueLabel.width/2;
			valueLabel.y = centery + 40;
		}
		//画刻度线的方法
		private var radianFrom:Number = -121 * 0.017453292;
		private var radianTo:Number = 121 * 0.017453292;
		private var graduations:Array = [0,20,40,60,80,100];
		private var centerx:Number = 99.5;
		private var centery:Number = 99.5;
		private var showHalfTicks:Boolean = true;
		private var showQuarterTicks:Boolean = true;
		public var radius:Number = 100;
		private function generateTicks():void
		{
			//radian:弧度 		sweep:弧度范围
			var sweep:Number = radianTo - radianFrom;
			//主刻度之间空白所拥有的弧度范围
			var gradRadian:Number = sweep / (graduations.length - 1);
			//主刻度线的长度
			var matl:Number =  10;
			//小刻度线的长度
			var mitl:Number =  7;
			//主刻度线的宽度
			var matt:Number = 2;
			//小刻度线的宽度
			var mitt:Number = 1;
			//刻度线的颜色
			var tc:uint = 0xFFFFFF;
			//主刻度线外部边缘到 表盘边框的距离
			var ti:Number = 10;
			ticks.graphics.lineStyle(2,0xffffff,1);
			for(var i:int = 0;i < graduations.length; i++)
			{
				//主刻度线
				ticks.graphics.lineStyle(matt,tc,1);
				ticks.graphics.moveTo(Math.sin(radianFrom + (i * gradRadian)) * (radius - ti - matl) + centerx,-Math.cos(radianFrom + (i * gradRadian)) * (radius - ti - matl) + centery);
				ticks.graphics.lineTo(Math.sin(radianFrom + (i * gradRadian)) * (radius - ti) + centerx,-Math.cos(radianFrom + (i * gradRadian)) * (radius - ti) + centery);
				//1/2刻度线
				ticks.graphics.lineStyle(mitt,tc,1);
				if(showHalfTicks && i != (graduations.length - 1))
				{   
					ticks.graphics.moveTo(Math.sin(radianFrom + (i * gradRadian) + (gradRadian/2)) * (radius - ti - matl) + centerx,-Math.cos(radianFrom + (i * gradRadian) + (gradRadian/2)) * (radius - ti - matl) + centery);
					ticks.graphics.lineTo(Math.sin(radianFrom + (i * gradRadian) + (gradRadian/2)) * (radius - ti - (matl - mitl)) + centerx,-Math.cos(radianFrom + (i * gradRadian) + (gradRadian/2)) * (radius - ti - (matl - mitl)) + centery);    
				}
				//1/4刻度线
				if(showQuarterTicks && i != (graduations.length - 1))
				{
					ticks.graphics.moveTo(Math.sin(radianFrom + (i * gradRadian) + (gradRadian/4)) * (radius - ti - matl) + centerx,-Math.cos(radianFrom + (i * gradRadian) + (gradRadian/4)) * (radius - ti - matl) + centery);
					ticks.graphics.lineTo(Math.sin(radianFrom + (i * gradRadian) + (gradRadian/4)) * (radius - ti - (matl - mitl)) + centerx,-Math.cos(radianFrom + (i * gradRadian) + (gradRadian/4)) * (radius - ti - (matl - mitl)) + centery);
					
					ticks.graphics.moveTo(Math.sin(radianFrom + (i * gradRadian) + (3*gradRadian/4)) * (radius - ti - matl) + centerx,-Math.cos(radianFrom + (i * gradRadian) + (3*gradRadian/4)) * (radius - ti - matl) + centery);
					ticks.graphics.lineTo(Math.sin(radianFrom + (i * gradRadian) + (3*gradRadian/4)) * (radius - ti - (matl - mitl)) + centerx,-Math.cos(radianFrom + (i * gradRadian) + (3*gradRadian/4)) * (radius - ti - (matl - mitl)) + centery);
				}
			}
		}
		/**
		 * angleStart:起始角度
		 * angleBy:圆心角
		 * color:填充颜色
		 * alpha:透明度
		 * diameter:圆的直径
		 **/
		public function drawAlerts(g:Graphics, angleStart:Number,angleBy:Number, color:Number, alpha:Number, diameter:Number):void {
			const SHADOW_INSET:Number = 0;
			//原点坐标
			var fCenterX:Number=diameter/2;
			var fCenterY:Number=diameter/2;
			//圆的半径
			var fRadius:Number=diameter/2;
			
			if(isNaN(fRadius)) return;
			//外部圆弧半径
			var outerRadius:Number = fRadius*0.92;
			//内部圆弧半径
			var innerRadius:Number = fRadius*0.8;
			//原点
			var origin:Point = new Point();
			//设置原点坐标
			origin.x=99.5;
			origin.y=99.5;
			//圆心角对应的弧度(1度=π/180弧度)
			var angle:Number = (angleBy) * Math.PI/180; //in radians
			//起始角对应的弧度(1度=π/180弧度)
			var startAngle:Number = angleStart * Math.PI/180; //in radians
			//笔触颜色
			var stroke:SolidColorStroke = new SolidColorStroke();
			stroke.alpha=0;
			stroke.weight=1;
			stroke.color=0xFFFFFF;
			//stroke.alpha=alpha;
			
			if (stroke && !isNaN(stroke.weight))
				outerRadius -= Math.max(stroke.weight/2,SHADOW_INSET);
			else
				outerRadius -= SHADOW_INSET;
			
			//在圆弧最边缘处画一个矩形
			var rc:Rectangle = new Rectangle(origin.x - outerRadius,
				origin.y - outerRadius,
				2 * outerRadius, 2 * outerRadius);
			//定义填充颜色
			var sc:SolidColor=new SolidColor(color);
			sc.alpha=alpha;
			var fill:IFill = sc;
			
			//外弧的起始点
			var startPt:Point = new Point(
				origin.x + Math.cos(startAngle) * outerRadius,
				origin.y - Math.sin(startAngle) * outerRadius);
			//外弧的结束点
			var endPt:Point = new Point(
				origin.x + Math.cos(startAngle + angle) * outerRadius,
				origin.y - Math.sin(startAngle + angle) * outerRadius);
			
			g.moveTo(endPt.x, endPt.y);
			fill.begin(g,rc, null);
			
			
			GraphicsUtilities.setLineStyle(g, stroke);
			
			if (innerRadius == 0)
			{
				g.lineTo(origin.x, origin.y);
				g.lineTo(startPt.x, startPt.y);
			}
			else
			{
				var innerStart:Point = new Point(
					origin.x + Math.cos(startAngle + angle) * innerRadius,
					origin.y - Math.sin(startAngle + angle) * innerRadius);
				
				g.lineTo(innerStart.x, innerStart.y);			
				
				//GraphicsUtilities.setLineStyle(g, stroke);
				GraphicsUtilities.drawArc(g, origin.x, origin.y,
					startAngle + angle, -angle,
					innerRadius, innerRadius, true);
				
				//GraphicsUtilities.setLineStyle(g, stroke);
				g.lineTo(startPt.x, startPt.y);
			}
			
			
			GraphicsUtilities.drawArc(g, origin.x, origin.y,
				startAngle, angle,
				outerRadius, outerRadius, true);
			
			fill.end(g);
		}
	}
}