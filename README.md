## Toward a more useful keyboard

Steve Losh's [Modern Space Cadet][modern-space-cadet] is an inspiration.
It opened my eyes to the fact that there's a more useful keyboard hidden inside the vanilla QWERTY package that most of us have tolerated for all these years.
This repo represents my nascent quest to unleash that more useful keyboard.

At first, this might sound no different than the typical Emacs/Vim/\<Every-Other-Editor> tweakfest.
But it is.
I'm not talking about honing my editor-of-choice.
I'm not talking about pimping out my shell.
I want a more useful keyboard _everywhere_.
Whether I'm in my editor, in the terminal, in the browser, or in Keynote,
I want a more useful keyboard.

And ideally, I want the _same_ (more useful) keyboard in every app.
Ubiquitous keyboarding.
Muscle memory.
[Don't make me think][don't-make-me-think].

How do I go to the beginning of the line in this app?
The same way I go to the beginning of the line in _every_ app!
Don't make me think.

How do I go to the top of the file/screen/page in this app?
The same way I...
Well, you get the point.

## More useful (for me)

> **cus·tom·ize** (_verb_): to modify or build according to individual or personal specifications or preference [[dictionary.com][customize]]

Any customization is, by definition, personal.
While I find that these customizations yield a more-useful keyboard for me, they might not feel like a win for you.

## Features

- [Access **control** and **escape** on the home row](#a-more-useful-caps-lock-key)
- [Navigate (up/down/left/right) via the home row](#super-duper-mode)
- [Navigate to previous/next word via the home row](#super-duper-mode)
- [Arrange windows via the home row](#window-layout-mode)
- [Enable other commonly-used actions on or near the home row](#miscellaneous-goodness)
- [Format text as Markdown](#markdown-mode)
- [Launch commonly-used apps via global keyboard shortcuts](#hyper-key-for-quickly-launching-apps)
- [And more...](#miscellaneous-goodness)

### A more useful caps lock key

By repurposing the anachronistic **caps lock** key, we can make **control** and **escape** accessible via the home row.

- Tap **caps lock** for **escape**
- Hold **caps lock** for **control**

📣 Shout-out to [@arbelt](https://github.com/arbelt) and [@jasoncodes](https://github.com/jasoncodes) for [the implementation](https://github.com/jasonrudolph/keyboard/commit/01a7a5bd8a1e521756d1ec34769119ead5eee0b3). ⚡️🍻🌟

### Window Layout Mode

Quickly arrange and resize windows in common configurations, using keyboard shortcuts that are on or near the home row.

Use **control** + **s** to turn on Window Layout Mode. Then, use any shortcut below to make windows do your bidding. For example, to send the window left, hit **control** + **s**, and then hit **h**.

- Use **h** to send window left (left half of screen)
- Use **j** to send window down (bottom half of screen)
- Use **k** to send window up (top half of screen)
- Use **l** to send window right (right half of screen)
- Use **i** to send window to upper left quarter of screen
- Use **o** to send window to upper right quarter of screen
- Use **,** to send window to lower left quarter of screen
- Use **.** to send window to lower right quarter of screen
- Use **space** to send window to center of screen
- Use **enter** to resize window to fill the screen
- Use **n** to send window to the next monitor
- Use **←** to send window to the monitor on the left (if there is one)
- Use **→** to send window to the monitor on the right (if there is one)
- Use **control** + **s** to exit Window Layout Mode without moving any windows

[<img src="https://cloud.githubusercontent.com/assets/2988/22397114/715cc12e-e538-11e6-9dcd-b3447af0d9dd.png" alt="Window Layout Mode Keybindings (1)" width="400"/>](https://cloud.githubusercontent.com/assets/2988/22397114/715cc12e-e538-11e6-9dcd-b3447af0d9dd.png) [<img src="https://cloud.githubusercontent.com/assets/2988/22397111/45672fe6-e538-11e6-905d-5b0234e290bb.png" alt="Window Layout Mode Keybindings (2)" width="400"/>](https://cloud.githubusercontent.com/assets/2988/22397111/45672fe6-e538-11e6-905d-5b0234e290bb.png)

### Hyper key for quickly launching apps

macOS doesn't have a native **hyper** key. But thanks to Karabiner-Elements, we can [create our own](karabiner/karabiner.json).

In this setup, we'll use the **right option** key as our **hyper** key. With a new modifier key defined, we open a whole world of possibilities. I find it especially useful for providing global shortcuts for launching apps:

- **hyper** + **b** to open Google Chrome ("B" for "Browser")
- **hyper** + **f** to open Finder ("F" for "Finder")
- **hyper** + **g** to open [Mailplane](http://mailplaneapp.com/) ("G" for "Gmail")
- **hyper** + **t** to open [iTerm2](https://www.iterm2.com/) ("T" for "Terminal")
- **hyper** + **w** to open [WhatsApp](https://www.whatsapp.com/) ("W" for "WhatsApp")

Edit [`hammerspoon/hyper.lua`](hammerspoon/hyper.lua) to configure shortcuts to launch your most commonly-used apps.

### Miscellaneous goodness

- Use **control** + **h**/**j**/**k**/**l** to move left/down/up/right by one pane in iTerm2
- Use **control** + **u** to delete to the start of the line
- Use **control** + **;** to delete to the end of the line
- Use **option** + **h**/**l** to delete the previous/next word

## Dependencies

This setup is honed and tested with the following dependencies.

- macOS Sierra, 10.12
- [Karabiner-Elements 0.90.92][karabiner]
- [Hammerspoon 0.9.52][hammerspoon]

## Installation

1. Grab the bits

    ```sh
    git clone https://github.com/jasonrudolph/keyboard.git ~/.keyboard

    cd ~/.keyboard

    script/setup
    ```

2. Enable accessibility to allow Hammerspoon to do its thing [[screenshot]](screenshots/accessibility-permissions-for-hammerspoon.png)

## TODO

- Add [#13](https://github.com/jasonrudolph/keyboard/pull/13) to [features](#features):
    - Hold option for push-to-talk/push-to-mute
    - Double-tap option to mute/unmute microphone

[customize]: http://dictionary.reference.com/browse/customize
[don't-make-me-think]: http://en.wikipedia.org/wiki/Don't_Make_Me_Think
[karabiner]: https://github.com/tekezo/Karabiner-Elements
[hammerspoon]: http://www.hammerspoon.org
[hammerspoon-releases]: https://github.com/Hammerspoon/hammerspoon/releases
[modern-space-cadet]: http://stevelosh.com/blog/2012/10/a-modern-space-cadet
[modern-space-cadet-key-repeat]: http://stevelosh.com/blog/2012/10/a-modern-space-cadet/#controlescape
