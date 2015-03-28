package views
{
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Shape;

import mx.controls.DataGrid;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.controls.dataGridClasses.DataGridListData;
import mx.controls.listClasses.IDropInListItemRenderer;
import mx.controls.listClasses.IListItemRenderer;
import mx.core.EdgeMetrics;
import mx.core.IFlexDisplayObject;
import mx.core.UIComponent;
import mx.core.mx_internal;
import mx.skins.Border;

import spark.primitives.Rect;

use namespace mx_internal;

public class FooterDataGridFooter extends UIComponent
{

	public function FooterDataGridFooter()
	{
		super();

	}

	protected var overlay:Shape;

	protected var dataGrid:DataGrid;

	/**
	 *  create the actual border here
	 */
	override protected function createChildren():void
	{
		dataGrid = parent as DataGrid;
		
		overlay = new Shape();
		addChild(overlay);
	}

	/**
	 *	lay it out
	 */
	override protected function updateDisplayList(w:Number, h:Number):void
	{
		overlay.graphics.clear();

		// destroy the old children
		while (numChildren > 1)
			removeChildAt(1);

		// make new ones
		var cols:Array = dataGrid.columns;
		var firstCol:int = dataGrid.horizontalScrollPosition;

		var colIndex:int = 0;
		var n:int = cols.length;
		var i:int = 0;
		while (colIndex < firstCol)
		{
			// find first visible column;
			if (cols[i++].visible)
				colIndex ++;
		}
		dataGrid.setStyle("horizontalGridLines","true");
		dataGrid.setStyle("rollOverColor","haloBlue");
//		dataGrid.setStyle("textAlign","center");
//		dataGrid.setStyle("headerBackgroundColor","red");
//		dataGrid.setStyle("headerBack");
//		advancedDataGrid.setStyle("horizontalGridLines","false");
		var vm:EdgeMetrics = dataGrid.viewMetrics;
        var lineCol:uint = dataGrid.getStyle("verticalGridLineColor");
        var vlines:Boolean = dataGrid.getStyle("verticalGridLines");
		overlay.graphics.lineStyle(1, lineCol);

		var xx:Number = 0;
		var yy:Number = 0;
		while (xx < w)
		{
			var col:DataGridColumn = cols[i++];

			if (col is FooterDataGridColumn)
			{
				var fdgc:FooterDataGridColumn = col as FooterDataGridColumn;
				fdgc.footerColumn.owner = fdgc.owner;
				var renderer:IListItemRenderer = (fdgc.footerColumn.itemRenderer) ? 
														fdgc.footerColumn.itemRenderer.newInstance() :
														dataGrid.itemRenderer.newInstance();
				renderer.styleName = fdgc.footerColumn;
				if (renderer is IDropInListItemRenderer)
				{
					IDropInListItemRenderer(renderer).listData = new DataGridListData((fdgc.footerColumn.labelFunction != null) ? fdgc.footerColumn.labelFunction(col) 
																						: fdgc.footerColumn.headerText, 
															fdgc.dataField, i - 1, null, 
															dataGrid, -1);
				}
				renderer.data = fdgc;
				renderer.styleName="datagridFooter";
				addChild(DisplayObject(renderer));
//				var uic:UIComponent = new UIComponent();
//				var mc:MovieClip=new MovieClip();
//				mc.graphics.beginFill(0xff9900,1);
//				mc.graphics.drawRect(100,100,100,200);
//				uic.addChild(mc);
//				addChild(uic);
				renderer.x = xx;
				renderer.y = yy;
				renderer.setActualSize(col.width - 1, dataGrid.rowHeight);
				if (vlines)
				{
					
					overlay.graphics.moveTo(xx + col.width, yy);
					overlay.graphics.lineTo(xx + col.width, h);
					overlay.graphics.drawRect(0,0,dataGrid.width-2,22);
					overlay.graphics.beginFill(0xff9900,1);
				}
			}
			xx += col.width;
		}
        lineCol = dataGrid.getStyle("horizontalGridLineColor");
        if (dataGrid.getStyle("horizontalGridLines"))
		{
			overlay.graphics.lineStyle(1, lineCol);
			overlay.graphics.moveTo(0, yy);
			overlay.graphics.lineTo(w, yy);
		}

		// draw separator at top of footer
        lineCol = dataGrid.getStyle("borderColor");
		overlay.graphics.lineStyle(1, lineCol);
		overlay.graphics.lineStyle(1, 0x357EC1);
		overlay.graphics.moveTo(0, 0);
		overlay.graphics.lineTo(w, 0);
	}

}

}