package views
{
	import mx.controls.DataGrid; 
	import mx.controls.*; 
	import flash.display.Sprite; 

	public class RowDataGrid extends DataGrid 
	{ 
		private var _rowColorFunction:Function; 
		public function RowDataGrid() 
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
