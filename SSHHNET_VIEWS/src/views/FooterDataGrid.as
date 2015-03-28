package views
{
import flash.display.Sprite;
import mx.controls.DataGrid;
public class FooterDataGrid extends DataGrid
{

	private var _rowColorFunction:Function; 
	public function FooterDataGrid() 
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

    protected var footer:FooterDataGridFooter;

	protected var footerHeight:int = 22;

    override protected function createChildren():void
    {
        super.createChildren();

        if (!footer)
        {
            footer = new FooterDataGridFooter();
            footer.styleName = this;
            addChild(footer);
        }
    }

    override protected function adjustListContent(unscaledWidth:Number = -1,
                                       unscaledHeight:Number = -1):void
    {
		super.adjustListContent(unscaledWidth, unscaledHeight);

		//桑栓 2015.2.5日 堆以下三段代码做出调整  
//		listContent.setActualSize(listContent.width, listContent.height - footerHeight+3);
//		footer.setActualSize(listContent.width, footerHeight);
//		footer.move(listContent.x, listContent.y + listContent.height - 3);
		
		
		listContent.setActualSize(listContent.width, listContent.height - footerHeight+1);
		footer.setActualSize(listContent.width, footerHeight);
		footer.move(listContent.x, listContent.y + listContent.heightExcludingOffsets - 1);
		
		
		
		footer.setStyle("backgroundColor",0x357EC1);
	}

	override public function invalidateDisplayList():void
	{
		super.invalidateDisplayList();
		if (footer)
			footer.invalidateDisplayList();
	}
}

}