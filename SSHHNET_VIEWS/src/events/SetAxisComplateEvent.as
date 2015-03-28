package events
{
	import flash.events.Event;
	
	public class SetAxisComplateEvent extends Event
	{
		public static const SetAxisComplate:String = "SetAxisComplate";
		
		public function SetAxisComplateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		private var leftAxisMaximum:Number=0;
		private var leftAxisMinimum:Number=0;
		private var rightAxisMaximum:Number=0;
		private var rightAxisMinimum:Number=0;
		
		public function get getLeftAxisMaximum():Number
		{
			return leftAxisMaximum;
		}
		public function set setLeftAxisMaximum(value:Number):void
		{
			leftAxisMaximum = value;
		}		
		public function get getLeftAxisMinimum():Number
		{
			return leftAxisMinimum;
		}
		public function set setLeftAxisMinimum(value:Number):void
		{
			leftAxisMinimum = value;
		}
		
		public function get getRightAxisMaximum():Number
		{
			return rightAxisMaximum;
		}
		public function set setRightAxisMaximum(value:Number):void
		{
			rightAxisMaximum = value;
		}
		
		public function get getRightAxisMinimum():Number
		{
			return rightAxisMinimum;
		}
		public function set setRightAxisMinimum(value:Number):void
		{
			rightAxisMinimum = value;
		}
		
		public override function clone():Event
		{
			var le:SetAxisComplateEvent = new SetAxisComplateEvent(type, bubbles, cancelable);
			le.leftAxisMaximum = leftAxisMaximum;
			le.leftAxisMinimum =leftAxisMinimum;
			le.rightAxisMaximum = rightAxisMaximum;
			le.rightAxisMinimum =rightAxisMinimum;
			return le;
		}
		
	}
}