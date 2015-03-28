package modules.meantime.events{
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;

	public class MeantimeOverFilterEvent extends Event
	{
		public static const FILTER_CLICK:String = "meantime_overall_filter_click";
		public var state_filter:String = "";
		public var state_field:int;
		public function MeantimeOverFilterEvent(type:String,state_filter:String,state_field:int)
		{
			super(type,true,false);
			this.state_filter = state_filter;
			this.state_field = state_field;
		}
		
		override public function clone():Event{
			return new MeantimeOverFilterEvent(type,state_filter,state_field);
		}
	}
}