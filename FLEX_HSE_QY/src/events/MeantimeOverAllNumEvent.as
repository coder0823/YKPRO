package events
{
	import flash.events.Event;
	
	public class MeantimeOverAllNumEvent extends Event
	{
		public static const NUM_CLICK:String = "meantime_overall_num_click";
		public var data:Object = "";
		public var statusStr:String = "";
		public function MeantimeOverAllNumEvent(type:String, data:Object,statusStr:String)
		{
			super(type,true,false);
			this.data = data;
			this.statusStr = statusStr;
		}
		
		override public function clone():Event{
			return new MeantimeOverAllNumEvent(type,data,statusStr);
		}
	}
}

