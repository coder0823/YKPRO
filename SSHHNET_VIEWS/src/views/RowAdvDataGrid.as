package views
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;	
	import mx.controls.AdvancedDataGrid;
	import mx.collections.ArrayCollection;
	import mx.core.FlexShape;
	import mx.rpc.events.AbstractEvent; 

	public class RowAdvDataGrid extends AdvancedDataGrid 
	{ 
		private var _rowColorFunction:Function; 
		public function RowAdvDataGrid() 
		{ 
			super(); 
		} 
		public function set rowColorFunction(f:Function):void 
		{ 
			this._rowColorFunction = f; 
		} 
		public function get rowColorFunction():Function 
		{ 
			return this._rowColorFunction; 
		} 
		override protected function drawRowBackground(s:Sprite,rowIndex:int,y:Number, height:Number, color:uint, dataIndex:int):void 
		{ 
			if(this.rowColorFunction != null ){ 				
				if( dataIndex < this.dataProvider.length ){ 
					var item:Object = this.dataProvider.getItemAt(dataIndex); 
					color = this.rowColorFunction.call(this, item, color); 
				} 
			}            
			super.drawRowBackground(s, rowIndex, y, height, color, dataIndex); 
		} 
	} 
}
