# nvim
Feel free to copy. Use at own risk.

Using Lazy package manager. Leader is space. Git integrated.

## Installasjonsguide

Dette er en enkel guide for å sette opp denne Neovim-konfigurasjonen på et nytt system.

### 1. Forutsetninger

Før du begynner, sørg for at du har følgende programvare installert:

*   **Neovim** (versjon 0.8 eller nyere)
*   **Git**
*   **En C-kompilator**, som `gcc` eller `build-essential`. Dette er nødvendig for å bygge enkelte plugins.
    *   På Debian/Ubuntu: `sudo apt update && sudo apt install build-essential`
    *   På Arch Linux: `sudo pacman -S base-devel`
    *   På Fedora: `sudo dnf groupinstall "Development Tools"`
    *   På macOS: `xcode-select --install`
*   **(Anbefalt) En [Nerd Font](https://www.nerdfonts.com/font-downloads)** for å vise ikoner korrekt.

### 2. Klon konfigurasjonen

Klone dette repositoryet til `~/.config/nvim`. Pass på å slette eller flytte en eventuell eksisterende `nvim`-mappe først.

```bash
git clone https://github.com/ditt-brukernavn/ditt-repo.git ~/.config/nvim
```

*(Bytt ut `https://github.com/ditt-brukernavn/ditt-repo.git` med den faktiske URL-en til ditt repository.)*

### 3. Start Neovim

Åpne Neovim:

```bash
nvim
```

Første gang du starter, vil plugin-behandleren `lazy.nvim` automatisk laste ned og installere alle plugins som er definert i konfigurasjonen. Dette kan ta et par minutter. Når prosessen er ferdig, er du klar til å kode!