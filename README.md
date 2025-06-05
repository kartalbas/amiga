# Old Amiga Assembler Source Codes

This repository contains various Amiga assembler source code projects. To execute these programs, please compile them with an old Seka assembler.

## Project Structure

### 9_FONT_D
Font-related source code and resources for graphics applications.
- `assembly-code.S`: Main font assembly source
- `FONT`: Font resource data
- `HYPER_SC`: Hypertext screen-related code
- `SOUND`: Sound effects or music data

### BOMBO
Game-related resources and source code for tank/shooter game.
- `BOMBO1.S`: Main source file
- `CHARSET`: Character set data
- `DRIVE_SO`: Disk drive sound or functionality
- `MAUER`, `MAUER.IFF`: Wall assets (IFF = Interchange File Format)
- `MAUS`, `MAUS.IFF`: Mouse/cursor assets
- `PANZER`, `PANZER.IFF`: Tank graphics
- `SCHUESSE`, `SCHUESSE.IFF`: Shot/bullet graphics
- `SHOOT_SO`: Shooting sound effects
- `SOUND`: Additional sound data

### HOPPER_D
Platform game or "hopper" style game project.
- `AMIGA`: Amiga-specific code
- `assembly-code.S`: Main source file
- `FONT`: Font resource data
- `HOPPER_D`: Main game data
- `HOPPER.STA`: Game state or statistics file
- `SOUND`: Sound effects or music data

### HORTEN_D
Graphics-focused demo for demoing Amiga 500 at Horten warehouse
- `assembly-code.S`: Main source file
- `GRAPHICS`: Graphics resources
- `HORTEN_D`: Main component data
- `HORTEN.FON`: Custom font file
- `SOUND`: Sound resources

### PRIMITIV
Basic/primitive graphics demo
- `assembly-code.S`: Source file for primitive operations
- `BloodMoneySnd`: Sound data possibly from/similar to the Amiga game "Blood Money"

### QUELLE_D
Graphics-focused demo for demoing Amiga 500 at Quelle warehouse
- `assembly-code.S`: Main source file
- `QUELLE_D`: Main data

### SPACE_SC
Space-themed demo.
- `assembly-code.S`: Main source file
- `FONT`: Font data specific to this component

## Development

These files were written for the Amiga platform in assembly language. The `.S` files are assembly source code files that need to be compiled with the Seka assembler.

## Notes

- IFF files (.IFF) are Amiga's standard format for graphics, audio, and other media
- Files without extensions are typically binary data, executables, or resource files
