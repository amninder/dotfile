import os
import pdb


# source: https://gist.github.com/epeli/1125049
# Sometimes when you do something funky, you may lose your terminal echo. This
# should restore it when spanwning new pdb.
termios_fd = sys.stdin.fileno()
termios_echo = termios.tcgetattr(termios_fd)
termios_echo[3] = termios_echo[3] | termios.ECHO
termios_result = termios.tcsetattr(termios_fd, termios.TCSADRAIN, termios_echo)


class Config(pdb.DefaultConfig):
    """config options for pdb++"""

    # bg = 'light'
    highlight = True
    prompt = "-> "
    editor = 'vi'
    current_line_color = "48;5;18"
    sticky_by_default = True
    use_terminal256formatter = True
    filename_color = pdb.Color.yellow

    def __init__(self):
        # readline.parse_and_bind('set convert-meta on')
        # readline.parse_and_bind('Meta-/: complete')

        try:
            from pygments.formatters import terminal, token
            import pdb
            self.filename_color = pdb.Color.lightgray
        except ImportError:
            pass
        else:
            self.colorscheme = terminal.TERMINAL_COLORS.copy()
            self.colorscheme.update({
                terminal.Keyword: ('darkred', 'red'),
                terminal.Number: ('darkyellow', 'yellow'),
                terminal.String: ('brown', 'green'),
                terminal.Name.Function: ('darkgreen', 'blue'),
                terminal.Name.Namespace: ('teal', 'turquoise'),
            })

    def setup(self, pdb):
        # make 'l' an alias to 'linglist'
        if 'libedit' in readline.__doc__:
            readline.parse_and_bind('bind ^I rl_complete')
        else:
            readline.parse_and_bind('tab: complete')
        Pdb = pdb.__class__
        Pdb.do_l = Pdb.do_longlist
        Pdb.do_st = Pdb.do_sticky
