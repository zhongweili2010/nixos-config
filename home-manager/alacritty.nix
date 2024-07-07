{ config, pkgs, ... }:

{

  alacrittyConfig = {
    enable = true;
    settings = {
      env = {
        TERM = "screen-256color";
      };
      window = {
        opacity = 0.75;
        dynamic_title=true;
        dimensions = {
          columns = 0;
          lines = 0;
        };
        padding={
          x=2;
          y=2;
        };
        decorations="full";
      };
      colors={
        draw_bold_text_with_bright_colors=true;
      };
      font={
        normal={
          family="Fira Code";
          style="Retina";
        };
        bold={
          family="Fira Code";
          style="Bold";
        };
        italic={
          family="Fira Code";
          style="Italic";
        };
        size=12.0;
        offset={
          x=0;
          y=0;
        };
        glyph_offset={
          x=0;
          y=0;
        };
      };
      debug.render_timer=false;

      selection={
        semantic_escape_chars=",?`|:\"' ()[]{}<>";
        save_to_clipboard=true;
      };

    };
  };
}


# # Base16 Default Dark 256 - alacritty color config
# # Chris Kempson (http://chriskempson.com)
# colors:
#   # Default colors
#   primary:
#     background: '0x181818'
#     foreground: '0xd8d8d8'

#   # Colors the cursor will use if `custom_cursor_colors` is true
#   cursor:
#     text: '0x181818'
#     cursor: '0xd8d8d8'
#     style: Block
#     unfocused_hollow: true

#   # Normal colors
#   normal:
#     black:   '0x181818'
#     red:     '0xab4642'
#     green:   '0xa1b56c'
#     yellow:  '0xf7ca88'
#     blue:    '0x7cafc2'
#     magenta: '0xba8baf'
#     cyan:    '0x86c1b9'
#     white:   '0xd8d8d8'

#   # Bright colors
#   bright:
#     black:   '0x585858'
#     red:     '0xab4642'
#     green:   '0xa1b56c'
#     yellow:  '0xf7ca88'
#     blue:    '0x7cafc2'
#     magenta: '0xba8baf'
#     cyan:    '0x86c1b9'
#     white:   '0xd8d8d8'

# bell:
#   animation: EaseOutExpo
#   duration: 0
