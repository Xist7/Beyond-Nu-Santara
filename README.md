# Beyond Nu-Santara

Game 2D platformer action vertical side-scroll untuk PC, dibuat dengan **Godot 4.7** oleh **KODIGA Std** (Teknik Informatika ITERA).

## Sinopsis

Tahun galaxy 1596, planet ke-8 **Headlanger** mulai menginvasi seluruh planet di tata surya Kodiga. Tahun 1940, giliran planet **Santara** yang jatuh. Para pejuangnya diasingkan ke planet Bimu, dan sebagian dilempar ke dalam laut.

**Nu (Navara Ucup)**, seorang pejuang muda Santara, terlempar ke dasar laut Bimu lalu tiba-tiba mendapatkan kekuatan baru. Dengan kekuatan itu, Nu naik dari dasar laut menuju luar angkasa untuk merebut kembali tanah airnya.

## Gambaran Game

| | |
|---|---|
| Genre | Platformer, action |
| Tampilan | 2D, vertical side-scroll |
| Platform | PC |
| Engine | Godot (GDScript) |
| Pemain | 1 orang (single player) |
| Target | Remaja dan dewasa |
| Inspirasi | Doodle Jump, Pou Sky Hop, Growtopia |

Pemain melompat naik dari platform ke platform melewati jebakan dan musuh kecil sampai ke puncak stage. Di stage tertentu, puncaknya berupa boss arena. Ada 5 stage dengan latar yang makin tinggi (dasar laut, permukaan, atmosfer, luar angkasa, Planet Santara), dan tiap latar diberi sentuhan khas Nusantara.

## Kontrol

| Aksi | Tombol |
|---|---|
| Gerak kiri / kanan | `A` / `D` atau panah kiri / kanan |
| Lompat | `W` / `Space` |
| Turun menembus platform | `S` / panah bawah |
| Tembak energi (lurus ke arah hadap) | Klik kiri mouse |

## Fitur Utama

- **Manajemen energi**: setiap tembakan memakai bar energi, dengan jeda 2 detik per tembakan. Pemain bisa menyerang, tapi harus hemat energi.
- **Boss bertingkat**: AI boss memakai state machine dengan beberapa fase serangan:
  1. Menembakkan peluru menyebar.
  2. Melompat dan menghantam lantai sampai keluar gelombang kejut (saat HP boss di bawah 50%).
  3. Serangan pamungkas yang berbeda di tiap stage.
- **Blessing dan Upgrade Shop**: mengalahkan boss memberi Blessing, yang bisa dibelanjakan di antara stage untuk upgrade HP, damage, energi, atau defense. Upgrade-nya permanen.
- **Checkpoint hanya di awal stage**: kalau mati, stage diulang dari awal.

## Sistem

- **Health**: HP berkurang kalau kena musuh, peluru musuh, atau trap. HP terisi penuh setelah mengalahkan boss, dan musuh kecil bisa menjatuhkan item pemulih HP.
- **Feedback**: karakter berkedip merah dan terdorong mundur saat kena serangan, dan bar energi berkedip saat energi habis. Ada partikel debu saat melompat dan kilatan cahaya saat menembak.
- **Menang**: di stage 1–4, capai puncak stage atau kalahkan boss-nya. Di stage 5, kalahkan Final Boss untuk mendapat good ending dan credit.
- **Kalah**: di stage 1–4, pilih respawn (stage diulang dari awal) atau kembali ke main menu. Di stage 5, kalah melawan boss berarti bad ending.

## Daftar Stage

| Stage | Isi |
|---|---|
| 1 | Trap dan 5–10 musuh kecil (HP 20, damage 4). Selesai saat mencapai puncak. |
| 2 | 15–25 musuh tipe 1, lalu melawan boss di puncak. |
| 3 | 10 musuh tipe 1 dan 20 musuh tipe 2 (stat +5), lalu miniboss. Muncul portal biru setelah menang. |
| 4 | Sekitar 100 musuh tipe 2, lalu boss. Muncul portal merah menuju final stage. |
| 5 | Percakapan dengan NPC, lalu Final Boss yang bisa memanggil sampai 4 musuh tipe 0. Ada good ending dan bad ending. |

## Alur Game

```
Main Menu (Play / Setting / Exit)
  -> Stage 1 -> Stage 2 (Boss) -> Upgrade Shop
  -> Stage 3 -> Stage 4 (Boss) -> Upgrade Shop
  -> Stage 5 (Final Boss) -> Good Ending / Bad Ending -> Credit
```

Menu pause berisi Resume, Setting, dan Exit. Menu setting berisi slider volume.

## Struktur Project

```
asset/    sprite, tile, audio
scene/    scene Godot (game.tscn, player.tscn, boss_1.tscn)
script/   script GDScript (player.gd)
```

Scene utama: `scene/game.tscn`. Buka `project.godot` di Godot 4.7 lalu tekan **F5** untuk menjalankan game.

## Tim

| Nama | Peran |
|---|---|
| Galih Sigit Satrio | Game Designer |
| Kenzie Sahasika Tariana | Art Director |
| Wafi Ziqra Maulana | Sound Engineer |
| Christopher Leon Saputra | Programmer |
