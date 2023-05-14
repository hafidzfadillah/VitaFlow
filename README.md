# VitaFlow


![alt text](https://github.com/hafidzfadillah/VitaFlow/blob/main/assets/images/appIcon.png?raw=true)


## Codespace - Orion Team
- Yoga ramadhan (Hustler)
- Muhammad Tegar Akmal (Hipster)
- Muhammad Hafidz Fadillah  (Hacker)

## Problem

Sebelum berkenalan dengan produk kami  mari kita lihat cerita Agus. Agus adalah seorang karyawan di PT Astri yang bekerja 10-12 jam sehari. Dia tidak memiliki waktu untuk mengatur pola hidupnya dan sering memilih makanan sembarangan, mengabaikan kesehatannya. Suatu ketika, dia terkena TBC dan harus cuti dengan waktu yang lama. Setelah sembuh, dia ingin berubah dan mencoba menjalani pola hidup sehat, tetapi mengalami beberapa masalah:

- Agus kekurangan waktu untuk menjaga pola hidup sehat karena kesibukannya di perusahaan.
- Agus kesulitan memilih makanan sehat dan bergizi karena kurang pengetahuan mengenai        kebutuhan gizi tubuhnya.
- Agus merasa konsultasi dengan ahli gizi atau pelatih pribadi terlalu mahal dan tidakpraktis untuk diakses.
- Agus bingung mulai dari mana jika ingin memulai pola hidup sehat.

## Solution 

Berdasarkan permasalahan Agus, kami merancang beberapa solusi untuk membantunya menjaga pola hidup sehat dengan lebih mudah dan efektif, antara lain:
- Menyediakan fitur-fitur yang dapat disesuaikan dengan jadwal pengguna, seperti rencana latihan terpersonalisasi dan reminder yang membantu Agus menjaga pola hidup sehat
- Menyediakan program rekomendasi makanan sehat dan fitur jurnal makanan dengan penghitung kalori untuk memantau asupan nutrisi harian Agus.
- Membuat sebuah fitur AI yang dapat menjadi media konsultasi dan pendamping pribadi bagi agus ketika menjalani programnya
- Membuat aplikasi dengan ux dan flow yang mudah dimengerti oleh agus dengan cara membuat seperti task harian , dengan itu agus tidak kebingunan mulai dari mana


## Product
Untuk menjawab masalah tersebut Tim Orion membawakan sebuah aplikasi mobile bernama "Vitaflow".Sesuai dengan unsur namanya Flow , kita membuat aplikasi vitaflow dengan ux dan alur aplikasi yang mudah dimengerti oleh user

### Presentasi Video

Berikut adalah link presentasi video Vitaflow



### Features

- Vita survey : Saat pengguna sudah mendaftar maka terdapat beberapa pertanyaan yang harus di isi oleh user agar vitaflow bisa memprediksi program apa yang cocok dengan kondisi pengguna
- Visi mission : Setalah pengguna mendapatkan program yang cocok maka terdapat beberapa misi yang harus dikerjakan pengguna , dimaksudkan agar pengguna tidak bingung apa yang harus dilakukan untuk mencapai tujuan user.

- Vita catat Asupan makan : Fitur ini memungkinkan pengguna untuk mencatat asupan makanan mereka secara harian. Pengguna dapat mencatat jenis makanan yang dikonsumsi pada pagi , siang atau malam hari. terdapat 2 cara user bisa catat asupan makanan
   - Catat aktivitas manual : Pengguna mmelakukan input manual dengan cara mencari makanan yang sudah dimakan pada aplikasi vitafloow
   - Scan Makanan : pengguna tidak perlu repot repot mencari nama makanan , dengan fitur ini tinggal photo makanan , maka akan keluar makanan yang discan
- Catat aktivitas minum :  Fitur ini membantu pengguna dalam mencatat dan mengingatkan pengguna untuk konsumsi air putih mereka secara rutin
- Cata aktivitas olahraga : Pengguna dapat mencatat aktivitas olahraga apa saja yang sudah di lakukan, metode  input olahraga terdapat
   - Catat aktivitas manual : Pengguna melakukan pencarian olahraga yang sudah dilakukan pada aplikasi vita 
   - Exercise plan dan olahraga interaktif : Khusus pengguna premium , terdapat fitur tambahan exercise plan yang dimna vitaflow sudah mengelompokan olahraga yang cocok dengan user dan user bisa mengikuti olahraga dengan interaktif karena terdapat video cara melakukan gerakan , timer dan play dan next gerakan olahraga
   - Vita coach AI : Fitur ini sudah include pada exercise plan , dimana jika user tidak yakin gerakan benar maka kita terdapat fitur yang bisa koreksi gerakan olahraga .
- Catat berat badan terakhir : agar pengguna bisa melihat progress hari dari hari , maka  pengguna bisa mencatat berat badan terakhir pengguna
- Catat detak jantung
- Catat aktivitas lari 
- Vita coach   : bot yang berguna sebagai asisten pengguna , dapat menanyakan seputar kesehata , nutrisi , saran , olahraga ,dll 
- Vita coach plus : bagi user premium terdpaat beberapa fitur tambahan : meminta rekap progress pegguna , set reminder ,  membuat meal plan. 
- Vita premium  : tedapat beberapa fitur yang mengharuskan upgrade ke premium seperti exercise plan , vita coach plus , 
- Pembayaran otomatis  : vitaflow sudah support pembayaran otomatis untuk pembelian vita premium
- Vita credit : bagi free user  terdapat batasan untuk menanyakan ke vita coach   , free user mendapatkan 2600 cedit yang dapat dipakai  , jika habis maka tidak bisa menggunakan vita coach.jika user premium  vita credit menjadi tidak terbatas -


   





## Tech

Untuk membangun Vitaflow kita menggunakan  beberapa teknologi  seperti : 

-  Flutter  - Untuk membuat aplikasi vitaflow
- Laravel  - Sebagai backend vitaflow
- Redis - cache database agar aplikasi vitaflow  makin ngebut
- Alibaba object storage - Untuk handle penyimpanan kita menggunakan layanan albiaba
- Tensorflow - Digunakan untuk fitur scan makanan dan vita coach (mendeteksi gerakan olahraga)
- Provider  - State management kita menggunakan provider 


## Screenshot 
![alt text](https://github.com/hafidzfadillah/VitaFlow/blob/main/assets/images/all_ss4.jpg?raw=true)

## Installation 

Untuk sekarang aplikasi kita hanya bisa di install di Android os :

Link Doownload APK :  https://tinyurl.com/vita-flow

LINK FIGMA (DESAIN) : https://www.figma.com/file/hHwD2Oym5aBIS3pSxCE4Dk/VitaFlow?type=design&node-id=621%3A2769&t=mGhlRRQnr1o7tiIw-1

LINK REPO BACKEND : https://github.com/tegar97/vitaflow-api

Jika ingin skip Register , bisa menggunakan akun berikut
email : yogi@gmail.com
password : tegar123


## Note

- Data Nutrisi makanan tidak akurat
- Data  kalori terbakar pada olahraga hanya estimasi 
- VITABOT Command :
   - reminder : SET Pengigat olahraga , makan , dll 
   - meal plan : GENERATE Rekoomendasi makan
- Cara memakai fitur vita coach / deteksi gerakan -> ke catatan olahraga -> mulai olahraga terencana -> pada bagian list gerakan klik icon ? 
-

## License

MIT

**Free Software, Hell Yeah!**




