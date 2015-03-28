package views
{
	/* *
	* 组件说明：弹出框：（表格组件）
	* 组件参数：
	* 作者：孙山虎
	* 日期：2012年12月29日
	* */
	
	import com.google.code.flexiframe.IFrame;
	
	import flash.system.Capabilities;
	
	import mx.core.FlexGlobals;
	
	import spark.components.TitleWindow;
	
	import skins.popWinStyle;
	
	public class PopupTitleWinIframe extends TitleWindow
	{
		private var dataGridChanged:Boolean=false;
		private var titleValueChanged:Boolean=false;

		[Bindable]
		private var titleValue:String="详细信息";
		private var iframe:IFrame=new IFrame();
		public function PopupTitleWinIframe()
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
			if(iframe!=null){
				this.addElement(iframe);
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
		
		public function get UrlSource():String
		{
			return iframe.source;
		}
		public function set UrlSource(value:String):void
		{
			dataGridChanged=true;
			iframe.source = value;
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
	}
}