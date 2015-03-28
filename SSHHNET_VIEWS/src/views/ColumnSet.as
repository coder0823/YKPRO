package views
{
	import flash.utils.Dictionary;
	
	import mx.charts.HitData;
	import mx.charts.series.ColumnSeries;
	import mx.charts.series.ColumnSet;
	import mx.charts.series.items.ColumnSeriesItem;
	import mx.utils.StringUtil;

	public class ColumnSet extends mx.charts.series.ColumnSet
	{
		public function ColumnSet()
		{
			super();
		}

		override protected function formatDataTip(hd:HitData):String
		{
			return myDataTipFunction(hd);
		}
		
		private function myDataTipFunction(hitData:HitData):String
		{
			var itemsDictionary:Dictionary = new Dictionary();
			var total:Number = 0; 
			
			//hitData.item holds name value pair for each dataProvider row
			for(var property:Object in hitData.item){
				itemsDictionary[property] = hitData.item[property];
			}
			
			// Have to get instance of hitData.element (a ColumnSeries) to
			// access element.series.stacker.series which holds the yField values e.g. toys.
			// Somehow hitData.element.series.stacker is not accessible directly.
			
			var series:ColumnSeries = ColumnSeries(hitData.element);
			for( var key:Object in itemsDictionary){
				for( var i:int = 0; i < series.stacker.series.length; i++){
					if(series.stacker.series[i].yField == key.toString()){
						total += Number(itemsDictionary[key]);
					}
				}
			}
			
			var cSI:ColumnSeriesItem = hitData.chartItem as ColumnSeriesItem;
			var col:String = ColumnSeries(hitData.element).yField;
			var label:String=ColumnSeries(hitData.element).displayName;
			//return StringUtil.substitute("<b>{0}</b><br>{1}: {2}",label , col, cSI.item[col].toString());
			return StringUtil.substitute("<b>{0}:</b>{1}<br>总数:{2}",label , cSI.item[col].toString(),total.toString());
		}


		
	}
}