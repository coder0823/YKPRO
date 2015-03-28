package views
{
	public class CustomVariable
	{
		//默认坐标轴标签旋转角度
		private static var chartLeftLabelRotation:Number=0;
		private static var chartRightLabelRotation:Number=0;
		private static var chartTopLabelRotation:Number=0;
		private static var chartBottomLabelRotation:Number=0;
		
		//最大值系数
		private static var chartLeftAxisMaxCoefficient:Number=1.2;
		private static var chartRightAxisMaxCoefficient:Number=1.2;
		private static var chartTopAxisMaxCoefficient:Number=1.2;
		private static var chartBottomAxisMaxCoefficient:Number=1.2;
		//最小值系数
		private static var chartLeftAxisMinCoefficient:Number=1.2;
		private static var chartRightAxisMinCoefficient:Number=1.2;
		private static var chartTopAxisMinCoefficient:Number=1.2;
		private static var chartBottomAxisMinCoefficient:Number=1.2;
		
		public static function get ChartLeftAxisMaxCoefficient():Number{return chartLeftAxisMaxCoefficient;}
		public static function get ChartRightAxisMaxCoefficient():Number{return chartRightAxisMaxCoefficient;}
		public static function get ChartTopAxisMaxCoefficient():Number{return chartTopAxisMaxCoefficient;}
		public static function get ChartBottomAxisMaxCoefficient():Number{return chartBottomAxisMaxCoefficient;}
		public static function get ChartLeftAxisMinCoefficient():Number{return chartLeftAxisMinCoefficient;}
		public static function get ChartRightAxisMinCoefficient():Number{return chartRightAxisMinCoefficient;}
		public static function get ChartTopAxisMinCoefficient():Number{return chartTopAxisMinCoefficient;}
		public static function get ChartBottomAxisMinCoefficient():Number{return chartBottomAxisMinCoefficient;}
		
		public static function get ChartLeftLabelRotation():Number{return chartLeftLabelRotation;}
		public static function get ChartRightLabelRotation():Number{return chartRightLabelRotation;}
		public static function get ChartTopLabelRotation():Number{return chartTopLabelRotation;}
		public static function get ChartBottomLabelRotation():Number{return chartBottomLabelRotation;}
	}
}