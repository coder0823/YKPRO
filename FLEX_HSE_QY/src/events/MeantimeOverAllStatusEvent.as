package events
{
	import flash.events.Event;
	
	public class MeantimeOverAllStatusEvent extends Event
	{
		public static const STATUS_CLICK:String = "meantime_overall_status_click";
		public var data:Object = "";
		public var statusStr:String = "";
		public function MeantimeOverAllStatusEvent(type:String, data:Object,statusStr:String)
		{
			super(type,true,false);
			this.data = data;
			this.statusStr = statusStr;
		}
		
		override public function clone():Event{
			return new MeantimeOverAllStatusEvent(type,data,statusStr);
		}
	}
}