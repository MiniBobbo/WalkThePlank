package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxPoint;
import inputhelper.InputHelperMenuState;

/**
 * ...
 * @author Dave
 */
class MainMenuState extends FlxSubState
{

	
	var bg:FlxSprite;
	var mainIcon:FlxSprite;
	var b1:FlxSprite;
	var b2:FlxSprite;
	var b3:FlxSprite;
	
	
	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		
		
		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = .8;
		add(bg);
		
		mainIcon = new FlxSprite();
		mainIcon.loadGraphicFromTexture(Reg.getTex(), false, "MainMenu.png");
		mainIcon.centerOrigin();
		mainIcon.scale.set(.01, .01);
		FlxTween.tween(mainIcon.scale, { x:1, y:1 }, 1, {{ease:FlxEase.sineIn } } );
		add(mainIcon);
		
		b1= new FlxSprite(500,130);
		b1.loadGraphicFromTexture(Reg.getTex(), false, "button (1).png");
		b1.centerOrigin();
		b1.scale.set(.01, .01);
		FlxTween.tween(b1.scale, { x:1, y:1 }, .5, {ease:FlxEase.sineIn, startDelay:1 } );
		add(b1);
		b2= new FlxSprite(500,200);
		b2.loadGraphicFromTexture(Reg.getTex(), false, "button (2).png");
		b2.centerOrigin();
		b2.scale.set(.01, .01);
		FlxTween.tween(b2.scale, { x:1, y:1 }, .5, {ease:FlxEase.sineIn, startDelay:1.5  } );
		add(b2);
		b3= new FlxSprite(500,270);
		b3.loadGraphicFromTexture(Reg.getTex(), false, "button (3).png");
		b3.centerOrigin();
		b3.scale.set(.01, .01);
		FlxTween.tween(b3.scale, { x:1, y:1 }, .5, {ease:FlxEase.sineIn, startDelay:2}  );
		add(b3);
		
		
	}
	
	override public function update():Void 
	{
		super.update();
		if (FlxG.mouse.justPressed) {
			var p = FlxPoint.get(FlxG.mouse.x, FlxG.mouse.y);
			if (b1.overlapsPoint(p)) {
				close();
			} else if (b2.overlapsPoint(p)) {
				var is = new HowToPlay();
				openSubState(is);
				is = null;
			} else if (b3.overlapsPoint(p)) {
				var bs = new InputHelperMenuState();
				openSubState(bs);
				bs = null;
			}
			
			
			p.put();
			
		}
		
	}
}