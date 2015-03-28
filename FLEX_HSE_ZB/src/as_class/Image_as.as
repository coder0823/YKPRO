package as_class
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.net.FileReference;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.graphics.codec.PNGEncoder;  
	
	public class Image_as
	{
		static public var Instance:Image_as=new Image_as();
		public function Image_as()
		{
		}
		
		public function exportChart(d:DisplayObject):void{  
			
			var dt:DisplayObject = d;  
			var bmpData:BitmapData = new BitmapData(d.width,d.height,true,0x00ffffff);    
			bmpData.draw(d);
			
			var fr:Object = new FileReference();  
			if(fr.hasOwnProperty("save"))
			{  
				var encoder:PNGEncoder = new PNGEncoder();  
				var data:ByteArray = encoder.encode(bmpData);  
				fr.save(data,'仪表盘.png');  
			}
			else
			{  
				Alert.show("当前flash player版本不支持此功能,请安装10.0.0以上版本！","提示");  
				
			}  
			
		}
	}
}

