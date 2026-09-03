# Tmux prečice

Izvor: [tmuxcheatsheet.com](https://tmuxcheatsheet.com/)

Sve prečice koje počinju sa **prefix** pretpostavljaju da prvo pritisneš
prefix kombinaciju pa onda taster. Kod nas je prefix promenjen sa
podrazumevanog `Ctrl+b` na **`Ctrl+s`** (`linux/tmux/.tmux.conf`) — u
tabelama ispod je to već ubačeno kao "kod nas", ali svuda gde piše samo
"prefix" misli se na `Ctrl+s`.

> 🔧 = izmenjeno u odnosu na sajt/podrazumevani tmux
> 🆕 = ne postoji na sajtu, dodato samo kod nas

## Sesije

| Akcija | Podrazumevano | Kod nas |
| --- | --- | --- |
| Pokreni tmux | `tmux` | isto |
| Nova sesija | `tmux new-session` / `tmux new -s ime` | isto |
| Preimenuj sesiju | `prefix $` | isto |
| Otkači se od sesije | `prefix d` | isto |
| Prikaži sve sesije | `prefix s` | isto |
| Prethodna/sledeća sesija | `prefix (` / `prefix )` | isto |
| Pregled sesija i prozora | `prefix w` | isto |
| Ugasi sesiju | `tmux kill-session -t ime` | isto |
| Prefix taster | `Ctrl+b` | 🔧 `Ctrl+s` |
| Restauracija poslednje sesije pri startu | ne postoji | 🆕 automatski (`tmux-continuum`, `@continuum-restore on`) |
| Ručno snimi/restauriraj sesiju (panes, layout, programi) | ne postoji | 🆕 `prefix Ctrl+s` snimi / `prefix Ctrl+r` restauriraj (`tmux-resurrect`) |

## Prozori (windows)

| Akcija | Podrazumevano | Kod nas |
| --- | --- | --- |
| Novi prozor | `prefix c` | isto |
| Sledeći/prethodni prozor | `prefix n` / `prefix p` | isto |
| Skoči na prozor po broju | `prefix 0...9` | isto |
| Poslednji aktivni prozor | `prefix l` | isto |
| Preimenuj prozor | `prefix ,` | isto |
| Zatvori prozor | `prefix &` | isto |
| Numeracija prozora | kreće od `0` | 🔧 kreće od `1` (`base-index 1`) |
| Popuni "rupu" u numeraciji | ne dešava se samo | 🔧 automatski (`renumber-windows on`) |

## Paneli (panes)

| Akcija | Podrazumevano | Kod nas |
| --- | --- | --- |
| Podeli vertikalno (panel levo/desno) | `prefix %` | 🔧 `prefix v` |
| Podeli horizontalno (panel gore/dole) | `prefix "` | 🔧 `prefix -` |
| Pređi na prethodni panel | `prefix ;` | isto |
| Pređi na sledeći panel | `prefix o` | isto |
| Pomeranje između panela (levo/dole/gore/desno) | strelice: `prefix ←↓↑→` | 🔧 vim stil: `prefix h/j/k/l` (radi i kroz nvim panele preko `vim-tmux-navigator` plugina, bez prefixa) |
| Prikaži brojeve panela | `prefix q` | isto |
| Panel u novi prozor | `prefix !` | isto |
| Zatvori panel | `prefix x` | isto |
| Pun ekran za panel (zoom) | `prefix z` | isto |
| Ciklus rasporeda panela | `prefix Spacebar` | isto |
| Promena veličine panela | `prefix +` / `prefix -` | isto |
| Numeracija panela | kreće od `0` | 🔧 kreće od `1` (`pane-base-index 1`) |
| Miš (klik/skrol po panelima, resize) | isključen po defaultu | 🔧 uključen (`mouse on`) |

## Copy mode

| Akcija | Podrazumevano | Kod nas |
| --- | --- | --- |
| Uđi u copy mode | `prefix [` | isto |
| Izađi | `q` | isto |
| Gore/dole na sam vrh/dno | `g` / `G` | isto |
| Kretanje kursorom | strelice (emacs stil) | 🔧 vi stil: `h/j/k/l` (`mode-keys vi`) |
| Pretraga napred/nazad | `/` / `?` | isto |
| Sledeći/prethodni pogodak | `n` / `N` | isto |
| Počni selekciju | `Spacebar` | isto |
| Kopiraj selekciju | `Enter` | isto |
| Nalepi iz bafera | `prefix ]` | isto |

## Ostalo

| Akcija | Podrazumevano | Kod nas |
| --- | --- | --- |
| Komandni mod | `prefix :` | isto |
| Lista svih prečica | `prefix ?` | isto |
| Ponovo učitaj `.tmux.conf` | ne postoji | 🆕 `r` (bez prefixa!) |
| Status bar pozicija | dole | 🔧 gore (`status-position top`) |
| Status bar tema/boje | podrazumevana | 🔧 Catppuccin tema (`catppuccin/tmux`), providna pozadina (`status-style bg=default`) |

## Instalirani plugin-i (`tmux-plugins/tpm`)

- `catppuccin/tmux` — tema status bar-a
- `christoomey/vim-tmux-navigator` — `Ctrl+h/j/k/l` prelazak između nvim split-ova i tmux panela bez prefixa
- `tmux-plugins/tmux-resurrect` — ručno snimanje/restauracija sesije
- `tmux-plugins/tmux-continuum` — automatska restauracija sesije pri startu tmux-a

Instalacija/update plugin-a: `prefix I` (install), `prefix U` (update).
