# Komang Yogananda Mahaputra Wisna - 05111740000114

## Tugas ETS Basis Data Terdistribusi <!-- omit in toc -->

- [Komang Yogananda Mahaputra Wisna - 05111740000114](#komang-yogananda-mahaputra-wisna---05111740000114)
  - [1. Desain dan implementasi infrastruktur](#1-desain-dan-implementasi-infrastruktur)
    - [A. Desain infrastruktur basis data terdistribusi + load balancing](#a-desain-infrastruktur-basis-data-terdistribusi--load-balancing)

## 1. Desain dan implementasi infrastruktur 

### A. Desain infrastruktur basis data terdistribusi + load balancing

Infrastruktur basis data yang digunakan adalah MySQL Group Replication dengan 3 MySQL server. Masing - masing server berperan sebagai Master (Multi Master). 3 MySQL server terkoneksi dengan sebuah Proxy SQL yang berperan sebagai load balancer. WebServer langsung terhubung dengan Proxy SQL. Aplikasi berupa aplikasi web.

Diagram Infrastrutur dapat dilihat pada gambar berikut:

![Diagram](gambar.png)

**Spesifikasi Infrastruktur**
    
| Server | OS | RAM | IP |
| ------------ | ------------- | ------------ | ------------- |
| MySQL Server  | ubuntu 16.04 | 512 MB | 192.168.17.114 |
| MySQL Server  | ubuntu 16.04 | 512 MB | 192.168.17.115 |
| MySQL Server  | ubuntu 16.04 | 512 MB | 192.168.17.116 |
| Proxy SQL  | ubuntu 16.04 | 512 MB | 192.168.17.117 |
| Webserver  | ubuntu 16.04 | 512 MB | 192.168.17.118 |

