{ ... }:

{
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=kitty
  '';

  xdg.configFile."Thunar/uca.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <actions>
      <action>
        <icon>utilities-terminal</icon>
        <name>Open Terminal Here</name>
        <command>exo-open --working-directory %f --launch TerminalEmulator</command>
        <directories/>
      </action>
      <action>
        <icon>vscode</icon>
        <name>Open Folder in VS Code</name>
        <command>code --reuse-window %f</command>
        <directories/>
      </action>
    </actions>
  '';
}
