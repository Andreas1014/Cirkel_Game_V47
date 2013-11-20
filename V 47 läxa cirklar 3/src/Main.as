package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author Andreas Sjöstrand
	 */
	public class Main extends Sprite 
	{
		
		private const radius:int = 30;
		private var circles:Vector.<Sprite> = new Vector.<Sprite>();
		private var redCirkle:Vector.<Sprite> = new Vector.<Sprite>();
		private var score:int = 0;
		private var t:TextField = new TextField();
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			t.x = stage.stageWidth - (t.width - 50);   //stage pos
			addChild(t);
			
			for (var i:int = 0; i < 19; i++)   //skapar 19 cirklar
			{
				var s:Sprite = new Sprite();
				s.graphics.beginFill(Math.random() * 0xFFFFFF);
				s.graphics.drawCircle(0, 0, radius);
				s.graphics.endFill();
				setRandomPos(s);
				stage.addChild(s);
				s.addEventListener(MouseEvent.CLICK, cirkleClick);
				circles.push(s);
				s.buttonMode = true;
			}									
			
			killAll();   //lägger döds cirkel på stage
			stage.addEventListener(KeyboardEvent.KEY_DOWN, spacePress);     //event listener för restart
		}
		
		private function spacePress(e:KeyboardEvent):void    //reset game
		{
			if (e.keyCode == Keyboard.SPACE)
			{
				score = 0;
				t.text = score.toString();
				for each (var circle:Sprite in circles) 
				{
					circle.visible = true;
					setRandomPos(circle);
				}
				
				for each (var redCirk:Sprite in redCirkle) 
				{
					redCirk.visible = true;
					setRandomPos(redCirk);
				}
			}
		}
		
		private function cirkleClick(e:Event):void    //tar bort cirkel + 1 score
		{
			e.target.visible = false;
			score ++;
			t.text = "score: " + score.toString();
		}
		
		private function setRandomPos(s:Sprite):void    //random pos
		{
			s.x = radius + Math.random() * (stage.stageWidth-s.width-radius);
			s.y = radius + Math.random() * (stage.stageHeight-s.height-radius);
		}
		
		private function killAll():void     //ritar death cirkel
		{
			var sk:Sprite = new Sprite();
			sk.graphics.beginFill(Math.random() * 0xFFFFFF);
			sk.graphics.drawCircle(0, 0, radius);
			sk.graphics.endFill();
			setRandomPos(sk);
			addChild(sk);
			redCirkle.push(sk);
			sk.buttonMode = true;
			sk.addEventListener(MouseEvent.CLICK, deathCirkle);
		}
		
		private function deathCirkle(e:MouseEvent):void    //tar bort death cirkel when pressed
		{
			for each (var circle:Sprite in circles) 
			{
				circle.visible = false;
				e.target.visible = false;
			}
		}
	}
	
}







