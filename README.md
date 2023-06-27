# Bass Study - Bahamut Lagoon

This a repository for study of Snes assembly language and techniques to program using the Bass assembler. It contains the source code of the game Bahamut Lagoon translation, for the Super Nintendo Entertainment System (SNES), made by Byuu (Near) and ported to the custom [Bass v18](https://github.com/Dgdiniz/bass) with LSP support.

# How to Use

- Install [Bass v18 with LSP support](https://github.com/Dgdiniz/bass). At least version 18.1.2 is required.
- Install the [Bass Vscode extension](https://github.com/Dgdiniz/bass_vscode).
- Clone this repository and copy the Bahamut Lagoon ***japanese*** rom to the ***rom*** folder with the name ***bahamut-jp.sfc***.
- Open the folder in Vscode. Now you have syntax highlighting and diagnostics for the assembly.
- You can generate an english Rom with the command ***"bass main.asm"*** in the terminal if you want to test some changes. The rom will be generated in the ***rom*** folder with the name ***bahamut-en.sfc***.

This is for study purposes only. If you want to translate the game, please use the original [Byuu's repository](https://github.com/higan-emu/bahamut-lagoon-translation-kit) that uses the original Bass assembler v17 and has the translations tools. 