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

## Panduan Git & GitHub untuk Tim

Bagian ini buat anggota tim yang belum terbiasa pakai Git. Ikuti urutannya, dan **jangan pernah push langsung ke `main`**.

### Aturan Emas

1. **Jangan push ke `main`.** Semua perubahan masuk lewat branch sendiri, lalu Pull Request (PR).
2. **Selalu `git fetch origin` + update dulu sebelum mulai ngoding.**
3. **Satu branch = satu fitur/tugas.** Jangan campur kerjaan beda-beda di satu branch.
4. **Commit kecil dan sering**, dengan pesan yang jelas.
5. **Jangan edit scene yang sama (`.tscn`) barengan** dengan orang lain. File scene Godot susah di-merge kalau bentrok, jadi kabarin di grup dulu kalau mau ngedit scene.

### Setup Pertama Kali (sekali saja)

1. Install [Git](https://git-scm.com/downloads).
2. Set nama dan email (pakai email akun GitHub):
   ```bash
   git config --global user.name "Nama Kamu"
   git config --global user.email "email@kamu.com"
   ```
3. Clone repo:
   ```bash
   git clone https://github.com/Xist7/Beyond-Nu-Santara.git
   cd Beyond-Nu-Santara
   ```
4. Minta owner repo nambahin kamu sebagai **collaborator** biar bisa push branch.

### Alur Kerja Harian

**1. Sebelum mulai ngoding: update `main` dulu**

```bash
git checkout main
git fetch origin
git pull origin main
```

`git fetch` ngambil info terbaru dari GitHub, `git pull` menggabungkan perubahan itu ke `main` lokal kamu.

**2. Buat branch baru untuk tugasmu**

```bash
git checkout -b nama-kamu/nama-fitur
```

Contoh nama branch: `galih/stage-2-layout`, `kenzie/sprite-boss`, `wafi/sfx-tembak`, `leon/boss-ai`.

Kalau branch-nya sudah ada (lanjut kerjaan kemarin):

```bash
git checkout nama-kamu/nama-fitur
git fetch origin
git merge origin/main      # biar branch kamu ikut update dengan main terbaru
```

**3. Ngoding / ngedit seperti biasa**, lalu cek apa saja yang berubah:

```bash
git status
```

**4. Commit perubahan**

```bash
git add .
git commit -m "Tambah animasi lompat player"
```

Tips pesan commit: tulis singkat apa yang dikerjakan, contoh `"Fix collision boss"`, `"Tambah sprite musuh tipe 2"`. Hindari pesan kayak `"update"` atau `"asdf"`.

**5. Push branch kamu ke GitHub**

```bash
git push -u origin nama-kamu/nama-fitur
```

`-u` cukup dipakai di push pertama. Selanjutnya cukup `git push`.

**6. Buka Pull Request (PR)**

1. Buka https://github.com/Xist7/Beyond-Nu-Santara.
2. Biasanya muncul tombol kuning **"Compare & pull request"**, klik. (Atau buka tab **Pull requests → New pull request**, pilih base `main` dan compare ke branch kamu.)
3. Isi judul dan jelaskan singkat apa yang diubah.
4. Klik **Create pull request**, lalu kabarin tim di grup.
5. Minimal satu orang lain cek dulu, baru di-**Merge**.

**7. Setelah PR di-merge**

```bash
git checkout main
git pull origin main
git branch -d nama-kamu/nama-fitur   # hapus branch lokal yang sudah selesai
```

Lalu mulai lagi dari langkah 1 untuk tugas berikutnya.

### Kapan Push, Kapan Pull?

| Situasi | Lakukan |
|---|---|
| Mau mulai ngoding | `git fetch origin` lalu `git pull origin main` (di `main`), baru bikin/pindah branch |
| Selesai satu bagian kerjaan (walau belum beres semua) | `commit`, lalu `push` ke branch sendiri, biar kerjaan aman di GitHub |
| Mau udahan ngoding hari ini | `commit` + `push` ke branch sendiri |
| Ada PR teman yang baru di-merge | `pull` `main`, lalu `git merge origin/main` di branch kamu |
| Fitur sudah selesai | Push, lalu buka PR ke `main` |

### Kalau Ada Conflict

Conflict terjadi kalau kamu dan teman ngedit bagian file yang sama. Git akan nandain filenya seperti ini:

```
<<<<<<< HEAD
kode versi kamu
=======
kode versi dari main
>>>>>>> origin/main
```

Cara beresin:

1. Buka file yang conflict (`git status` akan nunjukin filenya).
2. Pilih kode yang benar (atau gabungkan), lalu hapus tanda `<<<<<<<`, `=======`, `>>>>>>>`.
3. Simpan, lalu:
   ```bash
   git add .
   git commit -m "Resolve conflict dengan main"
   git push
   ```

Kalau conflict-nya di file `.tscn` dan bingung, **jangan asal pilih**. Tanya ke programmer dulu.

### Perintah Penting (Cheat Sheet)

| Perintah | Fungsi |
|---|---|
| `git status` | Lihat file apa saja yang berubah dan sedang di branch mana |
| `git branch` | Lihat daftar branch lokal (yang ada tanda `*` = branch aktif) |
| `git checkout nama-branch` | Pindah branch |
| `git checkout -b nama-branch` | Bikin branch baru dan langsung pindah ke situ |
| `git fetch origin` | Ambil info terbaru dari GitHub (tanpa mengubah file kamu) |
| `git pull origin main` | Ambil dan gabungkan perubahan terbaru `main` |
| `git merge origin/main` | Gabungkan `main` terbaru ke branch kamu |
| `git add .` | Siapkan semua perubahan untuk di-commit |
| `git commit -m "pesan"` | Simpan perubahan dengan pesan |
| `git push` | Kirim commit ke GitHub |
| `git log --oneline` | Lihat riwayat commit |
| `git restore nama-file` | Batalkan perubahan di file yang belum di-commit (hati-hati, hilang permanen) |

### Hal yang Jangan Dilakukan

- ❌ `git push origin main` atau commit langsung di branch `main`.
- ❌ `git push --force` (bisa ngehapus kerjaan orang lain).
- ❌ Mulai ngoding tanpa `fetch`/`pull` dulu.
- ❌ Ngedit file scene yang sama barengan tanpa koordinasi.
- ❌ Merge PR sendiri tanpa ada yang ngecek.

> Kalau bingung atau ada error aneh, **berhenti dulu dan tanya di grup**, jangan coba-coba perintah random. Lebih aman nanya daripada kerjaan hilang.

## Tim

| Nama | Peran |
|---|---|
| Galih Sigit Satrio | Game Designer |
| Kenzie Sahasika Tariana | Art Director |
| Wafi Ziqra Maulana | Sound Engineer |
| Christopher Leon Saputra | Programmer |
