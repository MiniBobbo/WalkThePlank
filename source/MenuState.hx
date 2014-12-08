package ;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import inputhelper.InputHelper;

/**
 * ...
 * @author Dave
 */
class MenuState extends FlxSubState
{

	var bg:FlxSprite;
	public function new(BGColor:Int=FlxColor.TRANSPARENT) 
	{
		super(BGColor);
		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = .5;
		add(bg);
		
		
		
	}
	
	
	override public function update():Void 
	{
		super.update();
		InputHelper.updateKeys();
		if (InputHelper.isButtonJustPressed("kick"))
		this.close();
	}
}