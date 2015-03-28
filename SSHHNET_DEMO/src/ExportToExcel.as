package
{
	import com.as3xls.xls.ExcelFile;    
	import com.as3xls.xls.Sheet;  
	import flash.errors.IllegalOperationError;    
	import flash.net.FileReference;    
	import flash.utils.ByteArray;        
	import mx.collections.ArrayCollection;    
	import mx.collections.ICollectionView;    
	import mx.collections.IViewCursor;    
	import mx.collections.XMLListCollection;    
	import mx.controls.AdvancedDataGrid; 
	
	public final class ExportToExcel
	{
		public function ExportToExcel()
		{
			super();
		}
		
		static public function dataGridExporter(dg:AdvancedDataGrid, defaultName:String):void       
		{   if (dg == null || dg.dataProvider == null || defaultName == null || defaultName == "")
			return;                    
			var cols:Number = 0;          
			var colsValues:Array = [];          
			var cantCols:Number = dg.columnCount;          
			var fieldT:String;          
			var headerT:String;                    // armo el listado de headers y variables para cada columna          
			for ( ; cols < cantCols; cols++)          
			{             
				headerT = (dg.columns[cols] as Object).headerText            
				fieldT = (dg.columns[cols] as Object).dataField;             
				if ( fieldT == null || fieldT == "" || headerT == null || headerT == "")                
					continue;              
				colsValues.push({header:headerT,value:fieldT});
			}                    
			if ( colsValues.length == 0 )             
				return;                       
			ExportToExcel.export(dg.dataProvider, colsValues, defaultName);       
		}        
		static public function export(obj:Object, colsValues:Array, defautlName:String):void       
		{          
			var _dp:ICollectionView = ExportToExcel.getDataProviderCollection(obj);          
			if ( _dp == null )             
				return;                    
			var rows:Number = 0;          
			var cols:Number = 0;          
			var cantCols:Number = colsValues.length;          
			var sheet:Sheet = new Sheet();          
			sheet.resize(_dp.length, colsValues.length);                    
			for ( ; cols < cantCols; cols++)          
			{             
				sheet.setCell(rows, cols, colsValues[cols].header);          
			}                    
			cols = 0;          
			rows++;          
			var cursor:IViewCursor = _dp.createCursor();          
			while ( !cursor.afterLast )          
			{             
				for (cols = 0 ; cols < cantCols; cols++)             
				{                
					if ( (cursor.current as Object).hasOwnProperty(colsValues[cols].value) )                      
						sheet.setCell(rows, cols, (cursor.current as Object)[colsValues[cols].value]);             
				}                          
				rows++;             
				cursor.moveNext();          
			}                    
			var xls:ExcelFile = new ExcelFile();          
			xls.sheets.addItem(sheet);          
			var bytes:ByteArray = xls.saveToByteArray();                    
			var fr:FileReference = new FileReference();          
			fr.save(bytes, defautlName);       
		} 
		static private function getDataProviderCollection(obj:Object):ICollectionView       
		{          
			if ( (obj is Number && isNaN(obj as Number)) || (!(obj is Number) && obj == null))          
			{             
				return null;          
			}          
			else if ( obj is ICollectionView )          
			{             
				return obj as ICollectionView;          
			}          
			else if ( obj is Array )          
			{             
				return new ArrayCollection(obj as Array);          
			}          
			else if ( obj is XMLList )          
			{             
				return new XMLListCollection(obj as XMLList);          
			}          
			else if ( obj is XML )          
			{             
				var col:XMLListCollection = new XMLListCollection();             
				col.addItem(obj);             
				return col;          
			}          
			else if ( obj is Object )          
			{             
				return new ArrayCollection([obj]);          
			}          
			else          
			{             
				return null;          
			}       
		} 
		
		
		
		
		
		
		
		
	}
}