package as_class
{
	import flash.display.DisplayObject;
	import flash.events.ContextMenuEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	import mx.printing.FlexPrintJob;
	import mx.printing.FlexPrintJobScaleType;
	
	import spark.components.Application;
	import spark.components.HGroup;

	public class Menu_as
	{
		static public var Instance:Menu_as=new Menu_as();
		
		public function Menu_as()
		{
		}
		
		public function add_menu(app:DisplayObject,view:IUIComponent):ContextMenu{  
			var contextMenu_caidan : ContextMenu = new ContextMenu();
			contextMenu_caidan.hideBuiltInItems();
//			contextMenu_caidan.builtInItems.print = true;
			var contextMenuItem:ContextMenuItem = new ContextMenuItem("关闭本窗口");
			var contextMenuItem_print:ContextMenuItem = new ContextMenuItem("打印页面");
			var contextMenuItem_out:ContextMenuItem = new ContextMenuItem("导出图片");
			contextMenu_caidan.customItems.push(contextMenuItem);
			contextMenu_caidan.customItems.push(contextMenuItem_print);
			contextMenu_caidan.customItems.push(contextMenuItem_out);
			
			contextMenuItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(event : ContextMenuEvent) : void{
				navigateToURL(new URLRequest("javascript:window.close()"), "_self");
			});
			
			contextMenuItem_print.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(event_out:ContextMenuEvent):void{
				var printJob:FlexPrintJob = new FlexPrintJob();  
				printJob.printAsBitmap = false;  
				if (printJob.start()){  
//					view.height=printJob.pageHeight;  
//					view.width=printJob.pageWidth;  
					printJob.addObject(view);  
					printJob.send();  
				}
			});
			
			contextMenuItem_out.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, function(event_out:ContextMenuEvent):void{
				out_image(app);
			});
			return contextMenu_caidan;
		}
		
		public function out_image(d:DisplayObject):void{
//			var d:DisplayObject=DisplayObject(this);
			Image_as.Instance.exportChart(d);
			
		}
			
	}
}