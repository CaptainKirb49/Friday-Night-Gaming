local countDownsToBlock = 2;
function onStartCountdown()
    if countDownsToBlock > 0 and isStoryMode and not seenCutscene then --Block the first 2 countdowns
        setProperty('inCutscene', true);
        if countDownsToBlock == 2 then
            startVideo('LokiStart');
            seenCutscene = false;
        elseif countDownsToBlock == 1 then
            runTimer('startDialogue', 0.8);
            seenCutscene = true;
        end
        countDownsToBlock = countDownsToBlock - 2;
        return Function_Stop;
    end
    return Function_Continue;
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'startDialogue' then
        print("Trying to start dialogue...");
        startDialogue('machine-dialogue', 'dialogueCalm');
        print("dialogue ended");
    end
end