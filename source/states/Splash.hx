import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

class Splash extends FlxState
{
    var bobertLogo:FlxSprite;
    var titleText:FlxText;
    var whiteOverlay:FlxSprite;

    override public function create():Void
    {
        super.create();

        bobertLogo = new FlxSprite(0, 0).loadGraphic(Paths.image('bobert'));
        bobertLogo.screenCenter();
        bobertLogo.y -= 50;
        bobertLogo.scale.set(0.5, 0.5);
        add(bobertLogo);

        titleText = new FlxText(0, 0, 0, "Bobert Engine", 64);
        titleText.screenCenter();
        titleText.y += 150;
        add(titleText);

        whiteOverlay = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
        add(whiteOverlay);

        FlxG.sound.play(Paths.sound('confirmMenu'));

        FlxTween.tween(whiteOverlay, {alpha: 0}, 0.5, {
            onComplete: function(_) {
                new FlxTimer().start(2, function(_) {
                    FlxTween.tween(bobertLogo, {alpha: 0}, 1);
                    FlxTween.tween(titleText, {alpha: 0}, 1);
                    FlxTween.tween(FlxG.camera, {alpha: 0}, 1, {
                        onComplete: function(_) {
                            FlxG.switchState(new TitleState());
                        }
                    });
                });
            }
        });
    }
}
