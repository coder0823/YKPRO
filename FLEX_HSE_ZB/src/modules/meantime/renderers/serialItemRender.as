package modules.meantime.renderers
{
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;
	import mx.controls.Label;
	
	import views.RowAdvDataGrid;
	
	public class serialItemRender extends Label
	{
		public function serialItemRender()
		{
			super();
		}
        override public function set data(value:Object):void{
			if(value){
				if(value.corpName=="合计"){
					super.data=value;
					this.text="";
				}
				else{
					super.data=value;
					if(this.owner && this.owner is RowAdvDataGrid){
						var objCollection:Object=RowAdvDataGrid(this.owner).dataProvider;
						var snumber:int=0;
						if(value && objCollection){
							snumber=objCollection.getItemIndex(value);
						}
						this.text=String(snumber);
					}
				}
			}
			
           
        }
        override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void{
           super.updateDisplayList(unscaledWidth,unscaledHeight);
           
        }
	}
}