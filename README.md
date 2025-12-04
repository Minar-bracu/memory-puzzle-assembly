# 🧠 Memory Puzzle Game

A classic card-matching memory puzzle game written entirely in **8086 Assembly Language**.

![Assembly](https://img.shields.io/badge/Language-8086%20Assembly-blue)
![Platform](https://img.shields.io/badge/Platform-DOS%2FDOSBox-green)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)

## 📖 Description

This is a console-based memory puzzle game where players flip cards to find matching pairs. The game features multiple difficulty levels, a loading screen with progress bar, and keeps track of remaining attempts.

## ✨ Features

- **3 Difficulty Levels:**
  - 🟢 Easy: 2x2 grid (2 pairs)
  - 🟡 Medium: 3x3 grid (6 pairs)  
  - 🔴 Hard: 3x6 grid (10 pairs)

- **Visual Feedback:**
  - Loading progress bar with percentage
  - Cursor highlighting for current position
  - Card flip animations

- **Game Mechanics:**
  - Limited attempts system
  - Wrap-around navigation (move off edge to appear on opposite side)
  - Win/Lose conditions with replay option

## 🎮 Controls

| Key | Action |
|-----|--------|
| `W` | Move Up |
| `S` | Move Down |
| `A` | Move Left |
| `D` | Move Right |
| `Space/Enter` | Select Card |

## 🛠️ How to Run

### Prerequisites
- [DOSBox](https://www.dosbox.com/download.php?main=1) or similar DOS emulator
- [MASM/TASM](http://www.dvteclipse.com/Community/forums/topic.asp?TOPIC_ID=353) assembler (optional, for building from source)

### Running the Game

1. **Using DOSBox:**
   ```
   mount c c:\path\to\game\folder
   c:
   project.exe
   ```

2. **Building from Source:**
   ```
   masm project.asm
   link project.obj
   project.exe
   ```

## 📸 Screenshots

<!-- Add screenshots here after capturing them from DOSBox -->
```
GENERATING PUZZLE...
45%
[█████████░░░░░░░░░░░]
```

```
┌─────────────────────┐
│  ░  ░  ░  ░  ░  ░   │
│  ░  ░  ░  ░  ░  ░   │
│  ░  ░  ░  ░  ░  ░   │
│                     │
│  ATTEMPTS: 3        │
└─────────────────────┘
```

## 🧩 Technical Highlights

- **Pure 8086 Assembly** - No high-level language dependencies
- **BIOS Interrupts** - Direct hardware interaction (INT 10h, INT 21h, INT 15h, INT 1Ah)
- **Random Number Generation** - Using system clock ticks for randomization
- **Efficient Memory Usage** - Optimized data structures and register usage
- **Modular Design** - Reusable procedures for common operations

## 📁 Project Structure

```
├── project.asm      # Main source code
├── README.md        # This file
└── .gitignore       # Git ignore file
```

## 🎓 Learning Outcomes

This project demonstrates:
- Low-level programming concepts
- Memory and register management
- Hardware interrupt handling
- Game state machine implementation
- User input processing
- Display manipulation without graphics libraries

## 👤 Author

**Sayed**

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

⭐ If you found this project interesting, please consider giving it a star!
