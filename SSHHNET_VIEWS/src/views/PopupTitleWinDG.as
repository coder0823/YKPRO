package views
{
	/* *
	* 组件说明：弹出框：（表格组件）
	* 组件参数：
	* 作者：孙山虎
	* 日期：2012年12月29日
	* */
	import events.ExportEvent;
	import events.PopupEvent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.ClassFactory;
	import mx.core.FlexGlobals;
	import mx.core.IFactory;
	import mx.utils.ObjectUtil;
	
	import renderers.MyDGILinkRenderer;
	import renderers.MyDGILinkRenderer2;
	import renderers.MyDGIMoreRenderers;
	import renderers.MyDGIRenderer;
	
	import skins.popWinStyle;
	
	import spark.components.TitleWindow;
	
	[Event(name="PopupClick", type="events.PopupEvent")]
	[Event(name="PopupDoubleClick", type="myEvents.SampleEvent")]
	[Event(name="PopupItemClick", type="events.PopupEvent")]
	public class PopupTitleWinDG extends TitleWindow
	{
		private var dataSourceConfChanged:Boolean=false;
		private var dataSourceChanged:Boolean=false;
		private var dataSourceXMLChanged:Boolean=false;
		private var titleValueChanged:Boolean=false;
		
		public var IfXML:Boolean=false;
		public var IfShowFirstRecordBgColor:Boolean=false;
		public var IfShowFrontRecordColor:Boolean=false;
		public var IfShowBackRecordColor:Boolean=false;
		public var FrontRecordCount:Number=5;
		public var BackRecordCount:Number=5;
//		public var FirstRecordBgColor:uint=0xFFBF00;
		public var FirstRecordBgColor:uint=0xFEFF99;
		public var FrontRecordColor:uint=0x4BACC6;
		public var BackRecordColor:uint=0xD72124;
		
		private var _tw_width:Number = FlexGlobals.topLevelApplication.stage.stageWidth-300;
		private var _tw_height:Number = FlexGlobals.topLevelApplication.stage.stageHeight-60;
		
		private var _select_index:Number = -1;
		[Bindable]
		private var titleValue:String="详细信息";
		[Bindable]
		private var dataSourceConf:ArrayCollection=new ArrayCollection([
			{headerText:"级别",dataField:"label",width:"90",textAlign:"left",sortable:false,draggable:false,showdatatips:false,enableUrlLink:true},
			{headerText:"合格",dataField:"goodNumbers",width:"40",textAlign:"center",sortable:true,draggable:false,showdatatips:false},
			{headerText:"不合格",dataField:"badNumbers",width:"40",textAlign:"center",sortable:true,draggable:false,showdatatips:false,showText:false},
			{headerText:"小计",dataField:"contractorNumbers",width:"40",textAlign:"center",sortable:true,draggable:false,showdatatips:false},
		]);
		[Bindable]
		private var dataSourceXML:XMLListCollection;
		[Bindable]
		private var dataSource:ArrayCollection= new ArrayCollection([
			{label:"一级",goodNumbers:2,badNumbers:30,contractorNumbers:40,isSumBgColor:1,labelUrl:"http://www.baidu.com/"},
			{label:"二级",goodNumbers:2,badNumbers:30,contractorNumbers:40},
			{label:"三级",goodNumbers:2,badNumbers:30,contractorNumbers:40},
		]);
		private var itemLinkRenderer:IFactory = new ClassFactory(MyDGILinkRenderer);
		private var itemLinkRenderer2:IFactory = new ClassFactory(MyDGILinkRenderer2);
		private var _dataGrid:FooterDataGrid;
		public function PopupTitleWinDG()
		{
			super();
			init();
		}

		public function get dataGrid():FooterDataGrid
		{
			return _dataGrid;
		}

		public function set dataGrid(value:FooterDataGrid):void
		{
			_dataGrid = value;
		}

		public function get select_index():Number
		{
			return _select_index;
		}

		public function set select_index(value:Number):void
		{
			_select_index = value;
		}

		private function init():void{
			this.removeAllElements();
			this.title = titleValue;    
			//this.addEventListener(CloseEvent.CLOSE,function closeEV():void{PopUpManager.removePopUp(this);});
			//this.doubleClickEnabled=true;
			//this.addEventListener(MouseEvent.DOUBLE_CLICK,function closeEV2():void{PopUpManager.removePopUp(this);});
			this.setStyle("skinClass",skins.popWinStyle);

			this.minWidth=600;
			this.minHeight=500;
			this.width=tw_width;
			this.height=tw_height;
			//this.width=Capabilities.screenResolutionX-60;
			//this.height=Capabilities.screenResolutionY-160;
			//this.height=Application.application.stage.stageHeight-60;
			//this.width=Application.application.stage.stageWidth-60;
//			this.height=FlexGlobals.topLevelApplication.stage.stageHeight-60;
//			this.width=FlexGlobals.topLevelApplication.stage.stageWidth-350;
			
			if(dataSourceConf!=null)
			{
				dataGrid = new FooterDataGrid();
				
				dataGrid.variableRowHeight=true;
				
				/*******************************这里注释掉，事故事件模块点击之后会报错 fixed by sunyang@20150408****************************************/
//				dataGrid.addEventListener(MouseEvent.DOUBLE_CLICK,rowClickHandle);
//				dataGrid.addEventListener(MouseEvent.DOUBLE_CLICK,rowDoubleClickHandle);
//				dataGrid.doubleClickEnabled=true;
				/************************************************************************************************************************/
				
				dataGrid.percentWidth=100;
				dataGrid.percentHeight=100;
				var flag:Boolean = true;
//				if(IfShowFrontRecordColor){
//					dataGrid.setStyle("alternatingItemColors","#DBEEF3,#FFFFFF");
//				}

					if(dataSource.length>0){
//						dataGrid.selectedIndex = select_index;
//						dataGrid.verticalScrollPosition = select_index;
//						dataGrid.scrollToIndex(select_index);
//						dataGrid.verticalScrollPosition = select_index;
//						dataGrid.verticalScrollPosition = dataGrid.rowHeight*select_index;
//						dataGrid.ensureCellIsVisible
						var fromFlag2:int=0;
						if(IfShowFirstRecordBgColor&&dataSource.getItemAt(0).index==1){
							dataSource.getItemAt(0).isSumBgColor=1;
							dataSource.getItemAt(0).bgcolor=FirstRecordBgColor;
							dataSource.getItemAt(0).color=0x000000;
							fromFlag2++;
						}
						for(var j:int=fromFlag2;j<dataSource.length;j++){
							dataSource.getItemAt(j).isSumBgColor=0;
							dataSource.getItemAt(j).color=0x000000;
							if(IfShowFrontRecordColor&&j<(FrontRecordCount+fromFlag2)){
								dataSource.getItemAt(j).isSumBgColor=1;
								//dataSource.getItemAt(j).color=FrontRecordColor;//前五行
								if(flag){
									dataSource.getItemAt(j).bgcolor=0xB4E3F5;//0xD2F0FA;
									flag=false;
								}else{
									dataSource.getItemAt(j).bgcolor=0xC3E7F5;//0xE6F5FA;
									flag=true;
								}
							}
							else if(IfShowBackRecordColor&&j>(FrontRecordCount+fromFlag2-1)&&j>=(dataSource.length-BackRecordCount)){
								dataSource.getItemAt(j).isSumBgColor=1;
								//dataSource.getItemAt(j).color=BackRecordColor;//后五行
								if(flag){
									dataSource.getItemAt(j).bgcolor=0xFCC1C3;//0xFFDFE0;
									flag=false;
								}else{
									dataSource.getItemAt(j).bgcolor=0xFBCDCF//0xFFEEEE;
									flag=true;
								}
							}
							else if(IfShowFrontRecordColor){
								dataSource.getItemAt(j).bgcolor=0xffffff;
							}
						}
					}
					dataGrid.dataProvider = dataSource;
					
					/********************************************add by sunyang@20150403******************************************/
					if (select_index != -1)
					{
						var intervalId:uint = setTimeout(onStretchFun, 200);	//这里加个定时器,指定过了一定时间间隔后跳到指定选项
						
						function onStretchFun():void
						{
							clearTimeout(intervalId);
							
							dataGrid.selectedIndex = select_index;
							dataGrid.scrollToIndex(select_index);  
						}
					}
					/*************************************************************************************************************/
					
				var columns:Array = new Array();
				var colFoot:FooterDataGridColumn;
				var col:DataGridColumn;
				for(var k:int=0;k<dataSourceConf.length;k++){  
					var o:Object = dataSourceConf.getItemAt(k);  
					colFoot=new FooterDataGridColumn();
					col = new DataGridColumn();
					if(o["enableUrlLink"]&&o["enableUrlLink"]!=null&&Boolean(o["enableUrlLink"])){
						if(IfShowFrontRecordColor){
							colFoot.itemRenderer=itemLinkRenderer;
						}else{
							colFoot.itemRenderer=itemLinkRenderer2;
						}
						
					}else{
						colFoot.itemRenderer=new ClassFactory(renderers.MyDGIRenderer);
					}
					colFoot.sortable=o["sortable"]==null?false:Boolean(o["sortable"]);
					colFoot.draggable=o["draggable"]==null?false:Boolean(o["draggable"]);
					colFoot.headerText=o["headerText"]==null?"列"+k:o["headerText"].toString();
					colFoot.dataField=o["dataField"]==null?"field"+k:o["dataField"].toString();

					if(o["width"]){
						colFoot.width=o["width"].toString();
					}
					colFoot.setStyle("textAlign",o["textAlign"]==null?"center":o["textAlign"].toString());
//					colFoot.setStyle("textAlign","center");
					
					
					colFoot.dataTipField=o["dataField"]==null?"field"+k:o["dataField"].toString();
					colFoot.showDataTips=o["showdatatips"]==null?false:Boolean(o["showdatatips"]);
					
					//col.headerText=colFoot.headerText;
					col.dataField=colFoot.dataField;
					
					col.headerText="";
					if(o["footHeakerText"]){
						col.headerText=o["footHeakerText"];
					}

					if(o["showText"]!=null&&!Boolean(o["showText"])){
						colFoot.itemRenderer=new ClassFactory(renderers.MyDGIMoreRenderers);
					}
					if(o["headerText"]&&String(o["headerText"])=="序号"){
						colFoot.labelFunction=numFunction;
						colFoot.sortable=false;
//						colFoot.width=15;
						colFoot.width = 30;	//fixed by sunyang@20150327
						colFoot.setStyle("textAlign","center");
					}
					// pjy：企业列统一居中显示
					if(o["headerText"]&&String(o["headerText"])=="企业"){
						colFoot.setStyle("textAlign","center");
						colFoot.width=100;
					}
					
					if(o["sortByCustomField"]){
						colFoot.sortCompareFunction=sortCompareFunc(o["sortByCustomField"]);
					}
					if(o["footLblFunEnable"]!=null&&Boolean(o["footLblFunEnable"])){
						if(o["footLblFunType"]){
							var f0:String=o["dataField"]
							if(o["footLblFunCustomField"]){
								f0=o["footLblFunCustomField"]
							}
							switch(o["footLblFunType"]){
								case "sum":
									col.labelFunction=sumFunction(f0);
									break;
								case "avg":
									col.labelFunction=averageFunction(f0);
									//Alert.show(o["footLblFunField"]);
									break;
								case "avg1":
									if (!o["footLblFunCustomField"]) break;
									col.labelFunction=percentFunction(f0);
									break
									break;
								case "avg2":
									if (!o["footLblFunCustomField"]) break;
									col.labelFunction=average2Function(f0);
									break
								case "percent":
									if (!o["footLblFunCustomField"]) break;
									col.labelFunction=percentFunction(f0);
									break
								case "count":
									col.labelFunction=countFunction(f0);
									break;
							}
						}
					}
					colFoot.footerColumn=col;
					
					columns.push(colFoot);
				}  
				dataGrid.columns = columns;
				dataGrid.rowColorFunction=colorFunction;
				
			}
			//titleWindow.addChild(dataGrid);    
			//dataGrid.addEventListener(DataGridEvent.HEADER_RELEASE,doHeaderRelease);
			this.addElement(dataGrid);
			
			//var aa:Button=new Button();
			//aa.label="@";
			//aa.width=30;
			//aa.right=0;
			//aa.addEventListener(MouseEvent.CLICK,DoExoprt);
			//this.addElement(aa);
			
			this.addEventListener(events.ExportEvent.ExportClick,DoExoprt);
		}
		
		private function countFunction(field:String):Function  
		{  
			return function (column:DataGridColumn):String
			{
				var n:int = dataSource.length;
				return "" + n;
			}
		}  

		
		//计算底部合计值 footLblFunType=sum    footLblFunCustomField 选填
		private function sumFunction(field:String):Function  
		{  
			return function (column:DataGridColumn):String
			{
				var n:int = dataSource.length;
				var sum:Number = 0;
				for (var i:int = 0; i < n; i++)
				{
					sum += Number(dataSource.getItemAt(i)[column.dataField]);
				}
				return "" + sum;
			}
		}  
		
		//计算底部平均值 footLblFunType=avg     footLblFunCustomField 选填
		private function averageFunction(field:String):Function  
		{  
			return function (column:DataGridColumn):String
			{
				var n:int = dataSource.length;
				var avg:Number = 0;
				for (var i:int = 0; i < n; i++)
				{
					avg += Number(dataSource.getItemAt(i)[column.dataField]);
				}
				avg /= n;
				if(avg){
					return "" + avg.toFixed(2)+"%";
				}else{
					return "0";
				}
				
			}
		}  

		//计算底部A除以B footLblFunType=avg2   footLblFunCustomField 必填 (逗号分隔，“A,B”，A除以B)
		private function average2Function(field:String):Function  
		{  
			return function (column:DataGridColumn):String
			{
				var n:int = dataSource.length;
				var sum1:Number=0;
				var sum2:Number=0;
				var per:Number = 0;
				
				var arr:Array=field.split(',');
				if(arr&&arr.length>=2)
				{
					var f1:String=arr[0];
					var f2:String=arr[1];
					for (var i:int = 0; i < n; i++)
					{
						sum1 += Number(dataSource.getItemAt(i)[f1]);
						sum2 += Number(dataSource.getItemAt(i)[f2]);
					}
					per=(sum2==0)?0:sum1/sum2;
					
				}
				return per.toFixed(2);
			}
		}  
		//计算底部百分比 footLblFunType=percent   footLblFunCustomField 必填 (逗号分隔，“A,B”，A除以B)
		private function percentFunction(field:String):Function  
		{
			return function (column:DataGridColumn):String
			{
				var n:int = dataSource.length;
				var sum1:Number=0;
				var sum2:Number=0;
				var per:Number = 0;
				
				var arr:Array=field.split(',');
				if(arr&&arr.length>=2)
				{
					var f1:String=arr[0];
					var f2:String=arr[1];
					for (var i:int = 0; i < n; i++)
					{
						sum1 += Number(dataSource.getItemAt(i)[f1]);
						sum2 += Number(dataSource.getItemAt(i)[f2]);
					}
					per=(sum2==0)?0:sum1*100/sum2;
					
				}
				return per.toFixed(2)+"%";
			}
		}
		
		//处理序号
		private function numFunction(oItem:Object,iCol:int):String{   
			var iIndex:int = dataGrid.dataProvider.getItemIndex(oItem) ; 
			return String(iIndex+1);
		}
		
		/*
		private function labelFunction(item:Object, column:DataGridColumn):String{
			return "aaaa";
		}
		
		private function doHeaderRelease(evt:DataGridEvent):void {
			//var dg:DataGrid =RowDataGrid(evt.currentTarget);
			var column:DataGridColumn = DataGridColumn(evt.currentTarget.columns[evt.columnIndex]);
			RowDataGrid(evt.currentTarget).callLater(onCallLater, [column]);
		}
		private function onCallLater(column:DataGridColumn):void {
			var currColName:String=column.dataField;
			var currColSorDesc:String=column.sortDescending;
			
		}
		*/

		//自定排序 sortByCustomField
		private function sortCompareFunc(field:String):Function{  
			return function(obj1:Object, obj2:Object):int{  
				return ObjectUtil.numericCompare(obj1[field],obj2[field]);
			}  
		}  

		
 
		//自定义背景色
		private function colorFunction(item:Object, color:uint):uint{	
			if(item.isSumBgColor!=null&&item.isSumBgColor==1)
				color=item.bgcolor;
			else if(IfShowFrontRecordColor)
				color=0xffffff;
			return color;
		}	
		private function rowClickHandle(event:MouseEvent):void{
			var obj:Object=event.currentTarget.selectedItem;
			//Alert.show("obj："+obj.label);
			obj.displayName="数据行"+obj[0];//cSI.item.label;
			obj.seriesType="dataGridRow"
			var eventObj:PopupEvent = new PopupEvent(PopupEvent.PopupClick);  
			//这里一定跟上面[Event(name="PopupClick", ...)],使用的name相同，否则，派发的事件不会被接收到
			eventObj.hitDataItem = obj;
			dispatchEvent(eventObj);
		}
		private function rowDoubleClickHandle(event:MouseEvent):void{
			var obj:Object=event.currentTarget.selectedItem;
			//Alert.show("obj："+obj.label);
			obj.displayName="数据行"+obj[0];//cSI.item.label;
			obj.seriesType="dataGridRow"
			var eventObj:PopupEvent = new PopupEvent(PopupEvent.PopupDoubleClick);  
			//这里一定跟上面[Event(name="PopupClick", ...)],使用的name相同，否则，派发的事件不会被接收到
			eventObj.hitDataItem = obj;
			dispatchEvent(eventObj);
		}
		

		
		
		import com.as3xls.xls.Cell;
		import com.as3xls.xls.ExcelFile;
		import com.as3xls.xls.Sheet; 
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
		
		public function get DataSourceConf():ArrayCollection
		{
			return dataSourceConf;
		}
		public function set DataSourceConf(value:ArrayCollection):void
		{
			dataSourceConfChanged=true;
			dataSourceConf = value;
			invalidateProperties();
		}	
		public function get DataSource():ArrayCollection
		{
			return dataSource;
		}
		public function set DataSource(value:ArrayCollection):void
		{
			dataSourceChanged=true;
			dataSource = value;
			invalidateProperties();
		}	
		public function get DataSourceXML():XMLListCollection
		{
			return dataSourceXML;
		}
		public function set DataSourceXML(value:XMLListCollection):void
		{
			dataSourceXMLChanged=true;
			dataSourceXML = value;
			invalidateProperties();
		}	
		override protected function commitProperties():void
		{
			super.commitProperties();
			if (dataSourceChanged)
			{
				dataSourceChanged = false;
				init();
				//invalidateDisplayList();  // invalidate in case the titles 				
			}
			if (dataSourceXMLChanged)
			{
				dataSourceXMLChanged = false;
				init();
				//invalidateDisplayList();  // invalidate in case the titles 				
			}
			if (dataSourceConfChanged)
			{
				dataSourceConfChanged = false;
				init();
				//invalidateDisplayList();  // invalidate in case the titles 
				
			}
			if (titleValueChanged){
				titleValueChanged=false;
				this.title=titleValue;
			}
		}

		public function get tw_width():Number
		{
			return _tw_width;
		}

		public function set tw_width(value:Number):void
		{
			_tw_width = value;
		}

		public function get tw_height():Number
		{
			return _tw_height;
		}

		public function set tw_height(value:Number):void
		{
			_tw_height = value;
		}
		
		
		
		

		/********************************************************************************************
		 * 
		 * 修改：桑栓，日期2015.2.5日。 控制拖动范围 
		 * 
		 ********************************************************************************************/		
		
		/**
		 * 窗口左右最少暴露出来的宽度 
		 */		
		private var _offlx:int = 20;
		
		public function set offlx(v:int):void
		{
			this._offlx = v;
		}
		
		private var _offrx:int = 20;
		
		public function set offrx(v:int):void
		{
			this._offrx = v;
		}
		
		/**
		 * 重写Move方法，控制窗口移动范围，左右暴露出来至少是offlx offrx，上面不允许拖出窗口，下面最少漏出moveArea区域 
		 * 
		 * @param x
		 * @param y
		 * 
		 */		
		override public function move(x:Number, y:Number):void
		{
			
			if(x + this.width < this._offlx)
			{
				x = this._offlx - this.width  ;
			}
			
			if ( this.parent.width - x < this._offrx )
			{
				x = this.parent.width - this._offrx;
			}
			
			if(y < 0) 
			{
				y = 0;
			}
			
			
			if ( y - this.parent.height >= - this.moveArea.height )
			{
				y = this.parent.height - this.moveArea.height;
			}
			
			super.move(x,y);
		}

	}
}