package modules.meantime.events{
	import flash.events.Event;
	public class MeantimeOverAllStatusEvent_byStage extends Event
	{
		public static const STATUS_CLICK:String = "meantime_overall_status_click_byStage";
		public var data:Object = "";
		public var statusStr:String = "";
		public var before_stage:String = "";
		public function MeantimeOverAllStatusEvent_byStage(type:String, data:Object,statusStr:String,before_stage:String)
		{
			super(type,true,false);
			this.data = data;
			this.statusStr = statusStr;
			this.before_stage = before_stage;
		}
		
		override public function clone():Event{
			return new MeantimeOverAllStatusEvent_byStage(type,data,statusStr,before_stage);
		}
	}
}