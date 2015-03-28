package views
{
	/* *
	* 组件说明：弹出框：（表格组件）
	* 组件参数：
	* 作者：孙山虎
	* 日期：2012年12月29日
	* */

	import events.ExportEvent;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.system.Capabilities;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.controls.AdvancedDataGrid;
	import mx.core.FlexGlobals;
	import mx.core.IVisualElement;
	
	import skins.popWinStyle;
	
	import spark.components.Group;
	import spark.components.TitleWindow;
	
	public class PopupTitleWin extends TitleWindow
	{
		private var dataGridChanged:Boolean=false;
		private var titleValueChanged:Boolean=false;
		
		[Bindable]
		private var titleValue:String="详细信息";
		private var content:Group=new Group();
		public function PopupTitleWin()
		{
			super();
			init();
		}
		private function init():void{
			this.removeAllElements();
			this.title = titleValue;    
			//this.addEventListener(CloseEvent.CLOSE,function closeEV():void{PopUpManager.removePopUp(this);});
			//this.doubleClickEnabled=true;
			//this.addEventListener(MouseEvent.DOUBLE_CLICK,function closeEV2():void{PopUpManager.removePopUp(this);});
			this.setStyle("skinClass",skins.popWinStyle);
			this.minWidth=900;
			this.minHeight=500;
			//this.width=Capabilities.screenResolutionX-60;
			//this.height=Capabilities.screenResolutionY-160;
			//this.height=Application.application.stage.stageHeight-60;
			//this.width=Application.application.stage.stageWidth-60;
			this.height=FlexGlobals.topLevelApplication.stage.stageHeight-60;
			this.width=FlexGlobals.topLevelApplication.stage.stageWidth-60;
			
			//titleWindow.addChild(dataGrid);  
			if(content!=null){
			this.addElement(content);
			}
		}
		
		
		private var _dataSource:ArrayCollection= new ArrayCollection();
		private var _dataSourceConf:ArrayCollection=new ArrayCollection();
		import com.as3xls.xls.Cell; 
		import com.as3xls.xls.Sheet; 
		import com.as3xls.xls.ExcelFile; 
		private var fileReference:FileReference; 
		private var xls:Class; 
		private var sheet:Sheet; 
		[Bindable] 
		private var fields:Array = new Array(); 
		private function fileReference_Cancel(event:Event):void 
		{ 
			fileReference = null; 
		} 
		private function DoExoprt(event:ExportEvent):void{
			exportToExcel();
		}
		public function exportToExcel():void 
		{ 
			sheet = new Sheet(); 
			var rowCount:int = dataSource.length; 
			sheet.resize(rowCount + 1,dataSourceConf.length); 
			
			var i:int = 0; 
			for each (var field:Object in dataSourceConf){ 
				fields.push(field.dataField.toString()); 
				sheet.setCell(0,i,field.headerText.toString()); 
				i++; 
			} 
			
			for(var r:int=0; r < rowCount; r++) 
			{ 
				var record:Object = dataSource.getItemAt(r); 
				/*insert record starting from row no 2 else 
				headers will be overwritten*/ 
				insertRecordInSheet(r+1,sheet,record); 
			} 
			var xls:ExcelFile = new ExcelFile(); 
			xls.sheets.addItem(sheet); 
			
			var bytes: ByteArray = xls.saveToByteArray(); 
			var fr:FileReference = new FileReference(); 
			var filename:String=titleValue;
			filename=CommFunction.replaceAll(filename,'\\','');
			filename=CommFunction.replaceAll(filename,'/','');
			filename=CommFunction.replaceAll(filename,'->','');
			fr.save(bytes,filename+"_.xls");   
		} 
		
		private function insertRecordInSheet(row:int,sheet:Sheet,record:Object):void 
		{ 
			var colCount:int = dataSourceConf.length; 
			
			var resetFirstCol:Boolean=false;
			if(colCount>0){
				if(dataSourceConf.getItemAt(0).headerText.toString()=="序号"){
					resetFirstCol=true;
				}
			}
			
			for(var c:int; c < colCount; c++) 
			{ 
				var i:int = 0; 
				for each(var field:String in fields){ 
					for each (var value:String in record){ 
						var value2:String=(resetFirstCol&&i==0)?String(row):value;
						if (value!=null && record[field]!=null && record[field].toString() == value) 
							sheet.setCell(row,i,value2); 
					} 
					i++; 
				} 
			} 
		} 

		public function get TitleValue():String
		{
			return titleValue;
		}
		public function set TitleValue(value:String):void
		{
			titleValueChanged=true;
			titleValue = value;
			invalidateProperties();
		}
	
		public function get Content():Group
		{
			return content;
		}
		public function set Content(value:Group):void
		{
			dataGridChanged=true;
			content = value;
			invalidateProperties();
		}	
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (dataGridChanged)
			{
				dataGridChanged = false;
				init();
				//invalidateDisplayList();  // invalidate in case the titles 				
			}

			if (titleValueChanged){
				titleValueChanged=false;
				this.title=titleValue;
			}
		}

		[Bindable]
		public function get dataSource():ArrayCollection
		{
			return _dataSource;
		}

		public function set dataSource(value:ArrayCollection):void
		{
			_dataSource = value;
		}

		[Bindable]
		public function get dataSourceConf():ArrayCollection
		{
			return _dataSourceConf;
		}

		public function set dataSourceConf(value:ArrayCollection):void
		{
			_dataSourceConf = value;
		}


	}
}