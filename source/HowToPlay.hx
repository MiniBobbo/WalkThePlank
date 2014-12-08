package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;

/**
 * ...
 * @author Dave
 */
class HowToPlay extends FlxSubState
{

	
	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		var bg = new FlxSprite(0, 0); 
		bg.loadGraphicFromTexture(Reg.getTex(), false, "inst.png");
		add(bg);
	}
	
	override public function update():Void 
	{
		super.update();
		if (FlxG.mouse.justPressed)
		close();
	}
	
}