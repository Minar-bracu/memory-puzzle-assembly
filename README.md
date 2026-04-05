# 🧠 Memory Puzzle Game

A classic card-matching memory puzzle game written entirely in **8086 Assembly Language**.

![Assembly](https://img.shields.io/badge/Language-8086%20Assembly-blue)
![Platform](https://img.shields.io/badge/Platform-emu8086-green)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

## 📖 Description

This is a console-based memory puzzle game where players flip cards to find matching pairs. The game features multiple difficulty levels, a loading screen with progress bar, and keeps track of remaining attempts.

## ✨ Features

- **3 Difficulty Levels:**
  - 🟢 Easy: 2x3 Grid (3 pairs)
  - 🟡 Medium: 3x4 Grid (6 pairs)  
  - 🔴 Hard: 3x6 Grid (9 pairs)

- **Modern UI:**
  - Box-drawn borders and menus
  - Loading progress bar with percentage
  - Cursor highlighting for current position

- **Game Mechanics:**
  - Limited attempts system
  - Wrap-around navigation
  - Win/Lose conditions with replay option

## 🎮 Controls

| Key | Action |
|-----|--------|
| `W` | Move Up |
| `S` | Move Down |
| `A` | Move Left |
| `D` | Move Right |
| `Any other key` | Select Card |

## 🛠️ How to Run

### Using emu8086 (Recommended)

1. Download and install [emu8086](https://emu8086-microprocessor-emulator.en.softonic.com/)
2. Open emu8086
3. Click **File → Open** and select `project.asm`
4. Click **Emulate** (or press F5)
5. In the emulator window, click **Run**

### Alternative: DOSBox + MASM

1. Install [DOSBox](https://www.dosbox.com/download.php?main=1)
2. Install MASM/TASM assembler
3. Assemble and run:
   ```
   masm project.asm
   link project.obj
   project.exe
   ```

## 📸 Screenshots

### Title Screen
```
                        ╔══════════════════════════════╗
                        ║                              ║
                        ║    MEMORY PUZZLE GAME        ║
                        ║                              ║
                        ╚══════════════════════════════╝
```

### Difficulty Menu
```
                        ╔══════════════════════════════╗
                        ║                              ║
                        ║  [1] EASY   - 2x3 Grid       ║
                        ║  [2] MEDIUM - 3x4 Grid       ║
                        ║  [3] HARD   - 3x6 Grid       ║
                        ║                              ║
                        ║  Select difficulty: _        ║
                        ╚══════════════════════════════╝
```

### Loading Screen
```
                        ╔══════════════════════════════╗
                        ║  Generating puzzle...        ║
                        ╚══════════════════════════════╝
                              45%
                              [█████████░░░░░░░░░░░]
```

### Gameplay (Medium - 3x4 Grid)
```
  ♣ ♣ ♣ ♣
  ♣ 2 ♣ ♣
  ♣ ♣ ♣ ♣

  ATTEMPTS: 3
```
*Cards are hidden (♣) until flipped. Matched pairs stay revealed.*

### Win Screen
```
                        ╔══════════════════════════════╗
                        ║                              ║
                        ║         YOU WIN!             ║
                        ║                              ║
                        ║    Press any key...          ║
                        ╚══════════════════════════════╝
```

### Game Over Screen
```
                        ╔══════════════════════════════╗
                        ║                              ║
                        ║       GAME OVER!             ║
                        ║                              ║
                        ║    Press any key...          ║
                        ╚══════════════════════════════╝
```

## 🧩 Technical Highlights

- **Pure 8086 Assembly** - No high-level language dependencies
- **BIOS/DOS Interrupts:**
  - INT 10h - Video services (cursor, screen)
  - INT 21h - DOS services (input, output)
  - INT 15h - System services (delay)
  - INT 1Ah - Time services (random seed)
- **Custom UI** - Box-drawing characters for modern look
- **Modular Design** - Reusable procedures for common operations

## 📁 Project Structure

```
├── project.asm      # Main source code
├── README.md        # This file
└── .gitignore       # Git ignore file
```

## 🎓 What I Learned

- Low-level programming and memory management
- Hardware interrupt handling
- Game state machine implementation
- User input processing in real-time
- Display manipulation without graphics libraries

## 👤 Author

**Minar**

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

⭐ If you found this project interesting, consider giving it a star!
