package ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import inputhelper.InputHelper;

/**
 * ...
 * @author Dave
 */
class ResultState extends FlxSubState
{

	var bg:FlxSprite;
	
	var result:FlxText;
	
	var resultGraphic:FlxSprite;
	
	var retry:FlxText;
	var stats:FlxText;
	var next:FlxText;
	
	var elapsed:Float = 0;
	var delay = 2;
	
	
	
	public function new() 
	{
		super();
		bg = new FlxSprite();
		bg.makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.alpha = .8;
		add(bg);
		
		result = new FlxText(0, 200, 800, "", 90);
		result.setFormat(null, 90, 0xffffff, "center");
		stats = new FlxText(600, 500, 200, "Score: " + Reg.score + "\nGoal: " + Reg.goal + "\nMistakes: " + Reg.mistakes);
		stats.setFormat(null, 25, 0xffffff, "center");

		
		add(stats);
		
		if (Reg.mistakes < 3 && Reg.score >= Reg.goal)
		result.text = "Win";
		else
		result.text = "Loss";
		//add(result);
		
		resultGraphic = new FlxSprite();
		
		if(result.text == "Win")
		resultGraphic.loadGraphicFromTexture(Reg.getTex(), false, "passed.png");
		else
		resultGraphic.loadGraphicFromTexture(Reg.getTex(), false, "failed.png");
		
		resultGraphic.setPosition(FlxG.width / 2 - resultGraphic.width / 2, FlxG.height / 2 - resultGraphic.height / 2);
		resultGraphic.centerOrigin();
		resultGraphic.scale.set(.1, .1);
		FlxTween.tween(resultGraphic.scale, { x:1.3, y:1.3 }, .5, {ease:FlxEase.sineIn });
		add(resultGraphic);
		
		retry = new FlxText(0, 200, 0, "< Retry", 30);
		retry.kill();
		retry.color = FlxColor.YELLOW;
		next = new FlxText(680, 200, 0, "Next >", 30);
		next.kill();
		next.color = FlxColor.YELLOW;
		
		add(retry);
		add(next);
		
		
	}
	
	override public function update():Void 
	{
		elapsed += FlxG.elapsed;
		
		super.update();
		if (elapsed > delay) {
			if (result.text == "Win")
			next.revive();
			retry.revive();
			
			InputHelper.updateKeys();
			if (InputHelper.isButtonJustPressed("kick") && result.text == "Win") {
				Reg.levelNum++;
				if (Reg.levelNum > Reg.MAX_LEVEL )
				Reg.levelNum = 1;
				this.close();
			} else if (InputHelper.isButtonJustPressed("keep")) {
				this.close();
			}
		}
		
	}
	
}