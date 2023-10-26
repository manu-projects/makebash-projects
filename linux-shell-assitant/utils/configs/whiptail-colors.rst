Whiptail dialog box colored
============================

The structure
-------------
The structure of the definitions is
``name=[fg],[bg][;|:|\n|\r|\t]name2=[fg],[bg]]...``

name can be
-----------

::

  root                  root fg, bg
  border                border fg, bg
  window                window fg, bg
  shadow                shadow fg, bg
  title                 title fg, bg
  button                button fg, bg
  actbutton             active button fg, bg
  checkbox              checkbox fg, bg
  actcheckbox           active checkbox fg, bg
  entry                 entry box fg, bg
  label                 label fg, bg
  listbox               listbox fg, bg
  actlistbox            active listbox fg, bg
  textbox               textbox fg, bg
  acttextbox            active textbox fg, bg
  helpline              help line
  roottext              root text
  emptyscale            scale full
  fullscale             scale empty
  disentry              disabled entry fg, bg
  compactbutton         compact button fg, bg
  actsellistbox         active & sel listbox
  sellistbox            selected listbox

bg and fg can be
-----------------

::

  color0  or black
  color1  or red
  color2  or green
  color3  or brown
  color4  or blue
  color5  or magenta
  color6  or cyan
  color7  or lightgray
  color8  or gray
  color9  or brightred
  color10 or brightgreen
  color11 or yellow
  color12 or brightblue
  color13 or brightmagenta
  color14 or brightcyan
  color15 or white

References
---------
- https://askubuntu.com/questions/776831/whiptail-change-background-color-dynamically-from-magenta/781062
- https://gist.github.com/ymkins/bb0885326f3e38850bc444d89291987a
