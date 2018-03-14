From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 13/16] Documentation: arch-support: remove obsolete architectures
Date: Wed, 14 Mar 2018 15:51:41 +0100
Message-ID: <20180314145141.2029742-1-arnd@arndb.de>
References: <20180314143529.1456168-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180314143529.1456168-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

A number of architecture ports are obsolete and getting dropped,
so we no longer want to track the respective features.

We already removed the lines for metag and mn10300, this does
the same edits for all the others.

For the remaining 21 architectures, this shows how many are known
to implement each given feature:

19 time/modern-timekeeping/arch-support.txt
19 time/clockevents/arch-support.txt
15 core/tracehook/arch-support.txt
14 core/generic-idle-thread/arch-support.txt
13 locking/lockdep/arch-support.txt
12 io/dma-api-debug/arch-support.txt
11 debug/kgdb/arch-support.txt
10 time/virt-cpuacct/arch-support.txt
 9 debug/kretprobes/arch-support.txt
 9 debug/kprobes/arch-support.txt
 8 vm/THP/arch-support.txt
 8 vm/pte_special/arch-support.txt
 8 vm/numa-memblock/arch-support.txt
 8 io/sg-chain/arch-support.txt
 7 perf/kprobes-event/arch-support.txt
 7 locking/rwsem-optimized/arch-support.txt
 7 debug/gcov-profile-all/arch-support.txt
 7 core/jump-labels/arch-support.txt
 7 core/BPF-JIT/arch-support.txt
 6 vm/ELF-ASLR/arch-support.txt
 6 time/context-tracking/arch-support.txt
 6 seccomp/seccomp-filter/arch-support.txt
 6 debug/stackprotector/arch-support.txt
 5 time/irq-time-acct/arch-support.txt
 5 io/dma-contiguous/arch-support.txt
 5 debug/uprobes/arch-support.txt
 4 vm/ioremap_prot/arch-support.txt
 4 time/arch-tick-broadcast/arch-support.txt
 4 perf/perf-stackdump/arch-support.txt
 4 perf/perf-regs/arch-support.txt
 3 debug/KASAN/arch-support.txt
 2 vm/PG_uncached/arch-support.txt
 2 vm/huge-vmap/arch-support.txt
 2 sched/numa-balancing/arch-support.txt
 2 sched/membarrier-sync-core/arch-support.txt
 2 locking/cmpxchg-local/arch-support.txt
 2 debug/optprobes/arch-support.txt
 2 debug/kprobes-on-ftrace/arch-support.txt
 1 vm/TLB/arch-support.txt
 1 locking/queued-spinlocks/arch-support.txt
 1 locking/queued-rwlocks/arch-support.txt
 1 debug/user-ret-profiler/arch-support.txt
 0 lib/strncasecmp/arch-support.txt

Note that the list does not include riscv or nds32 yet, these still
need to be added.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/admin-guide/README.rst                               | 4 ++--
 Documentation/features/core/BPF-JIT/arch-support.txt               | 6 ------
 Documentation/features/core/generic-idle-thread/arch-support.txt   | 6 ------
 Documentation/features/core/jump-labels/arch-support.txt           | 6 ------
 Documentation/features/core/tracehook/arch-support.txt             | 6 ------
 Documentation/features/debug/KASAN/arch-support.txt                | 6 ------
 Documentation/features/debug/gcov-profile-all/arch-support.txt     | 6 ------
 Documentation/features/debug/kgdb/arch-support.txt                 | 6 ------
 Documentation/features/debug/kprobes-on-ftrace/arch-support.txt    | 6 ------
 Documentation/features/debug/kprobes/arch-support.txt              | 6 ------
 Documentation/features/debug/kretprobes/arch-support.txt           | 6 ------
 Documentation/features/debug/optprobes/arch-support.txt            | 6 ------
 Documentation/features/debug/stackprotector/arch-support.txt       | 6 ------
 Documentation/features/debug/uprobes/arch-support.txt              | 6 ------
 Documentation/features/debug/user-ret-profiler/arch-support.txt    | 6 ------
 Documentation/features/io/dma-api-debug/arch-support.txt           | 6 ------
 Documentation/features/io/dma-contiguous/arch-support.txt          | 6 ------
 Documentation/features/io/sg-chain/arch-support.txt                | 6 ------
 Documentation/features/lib/strncasecmp/arch-support.txt            | 6 ------
 Documentation/features/locking/cmpxchg-local/arch-support.txt      | 6 ------
 Documentation/features/locking/lockdep/arch-support.txt            | 6 ------
 Documentation/features/locking/queued-rwlocks/arch-support.txt     | 6 ------
 Documentation/features/locking/queued-spinlocks/arch-support.txt   | 6 ------
 Documentation/features/locking/rwsem-optimized/arch-support.txt    | 6 ------
 Documentation/features/perf/kprobes-event/arch-support.txt         | 6 ------
 Documentation/features/perf/perf-regs/arch-support.txt             | 6 ------
 Documentation/features/perf/perf-stackdump/arch-support.txt        | 6 ------
 Documentation/features/sched/membarrier-sync-core/arch-support.txt | 6 ------
 Documentation/features/sched/numa-balancing/arch-support.txt       | 6 ------
 Documentation/features/seccomp/seccomp-filter/arch-support.txt     | 6 ------
 Documentation/features/time/arch-tick-broadcast/arch-support.txt   | 6 ------
 Documentation/features/time/clockevents/arch-support.txt           | 6 ------
 Documentation/features/time/context-tracking/arch-support.txt      | 6 ------
 Documentation/features/time/irq-time-acct/arch-support.txt         | 6 ------
 Documentation/features/time/modern-timekeeping/arch-support.txt    | 6 ------
 Documentation/features/time/virt-cpuacct/arch-support.txt          | 6 ------
 Documentation/features/vm/ELF-ASLR/arch-support.txt                | 6 ------
 Documentation/features/vm/PG_uncached/arch-support.txt             | 6 ------
 Documentation/features/vm/THP/arch-support.txt                     | 6 ------
 Documentation/features/vm/TLB/arch-support.txt                     | 6 ------
 Documentation/features/vm/huge-vmap/arch-support.txt               | 6 ------
 Documentation/features/vm/ioremap_prot/arch-support.txt            | 6 ------
 Documentation/features/vm/numa-memblock/arch-support.txt           | 6 ------
 Documentation/features/vm/pte_special/arch-support.txt             | 6 ------
 44 files changed, 2 insertions(+), 260 deletions(-)

diff --git a/Documentation/admin-guide/README.rst b/Documentation/admin-guide/README.rst
index af5a437198d0..155372b3b57f 100644
--- a/Documentation/admin-guide/README.rst
+++ b/Documentation/admin-guide/README.rst
@@ -26,8 +26,8 @@ On what hardware does it run?
   Although originally developed first for 32-bit x86-based PCs (386 or higher),
   today Linux also runs on (at least) the Compaq Alpha AXP, Sun SPARC and
   UltraSPARC, Motorola 68000, PowerPC, PowerPC64, ARM, Hitachi SuperH, Cell,
-  IBM S/390, MIPS, HP PA-RISC, Intel IA-64, DEC VAX, AMD x86-64, AXIS CRIS,
-  Xtensa, Tilera TILE, ARC and Renesas M32R architectures.
+  IBM S/390, MIPS, HP PA-RISC, Intel IA-64, DEC VAX, AMD x86-64 Xtensa, and
+  ARC architectures.
 
   Linux is easily portable to most general-purpose 32- or 64-bit architectures
   as long as they have a paged memory management unit (PMMU) and a port of the
diff --git a/Documentation/features/core/BPF-JIT/arch-support.txt b/Documentation/features/core/BPF-JIT/arch-support.txt
index 544eb1dd5fe1..0b96b4e1e7d4 100644
--- a/Documentation/features/core/BPF-JIT/arch-support.txt
+++ b/Documentation/features/core/BPF-JIT/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index c7f8626faca2..372a2b18a617 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index 647b0ab5a78d..ad97217b003b 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index c95ba6d79cee..36ee7bef5d18 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: |  ok  |
-    |        cris: | TODO |
-    |         frv: |  ok  |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index fbb5afe45848..f5c99fa576d3 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  | 64-bit only
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index a35c5057585b..5170a9934843 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index afb31a2505cb..13b6e994ae1f 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 4144979bc022..419bb38820e7 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 7ec1a185e713..52b3ace0a030 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index fa9009c08b1f..180d24419518 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index 38adefbe2edf..0a1241f45e41 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 2965ae0ca139..570019572383 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 5da0bc2e7e1e..0b8d922eb799 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index a45ced203f32..13852ae62e9e 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/io/dma-api-debug/arch-support.txt b/Documentation/features/io/dma-api-debug/arch-support.txt
index 411ec941e46c..e438ed675623 100644
--- a/Documentation/features/io/dma-api-debug/arch-support.txt
+++ b/Documentation/features/io/dma-api-debug/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: |  ok  |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 3b65953a96a9..47f64a433df0 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index 65e9368c69a7..07f357fadbff 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/lib/strncasecmp/arch-support.txt b/Documentation/features/lib/strncasecmp/arch-support.txt
index cee48bd07b08..4f3a6a0e4e68 100644
--- a/Documentation/features/lib/strncasecmp/arch-support.txt
+++ b/Documentation/features/lib/strncasecmp/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index a83465dc0db5..482a0b09d1f8 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index e5d51c585a90..bb35c5ba6286 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: |  ok  |
     |   unicore32: |  ok  |
     |         x86: |  ok  |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 5cae3a63a44e..627e9a6b2db9 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index cb227de0bbf9..9edda216cdfb 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
index ee70c9c52627..8d9afb10b16e 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index 52f54e64e993..d01239ee34b3 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: | TODO |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index e4294aed38bf..458faba5311a 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index b12117a9aa4d..545d01c69c88 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 0f419ecfbce6..85a6c9d4571c 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -33,14 +33,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -49,10 +45,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 045418673368..347508863872 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ..  |
     |         arm: |  ..  |
     |       arm64: |  ..  |
-    |    blackfin: |  ..  |
     |         c6x: |  ..  |
-    |        cris: |  ..  |
-    |         frv: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: | TODO |
-    |        m32r: |  ..  |
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: |  ..  |
     |     powerpc: |  ok  |
     |        s390: |  ..  |
-    |       score: |  ..  |
     |          sh: |  ..  |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: |  ..  |
     |   unicore32: |  ..  |
     |         x86: |  ok  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index c08a330e51d2..e4fad58a05e5 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: |  ok  |
     |          um: |  ok  |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index da91b576ede8..8052904b25fc 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index d76322a76668..7c76b946297e 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ok  |
     |         c6x: |  ok  |
-    |        cris: |  ok  |
-    |         frv: | TODO |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: |  ok  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: |  ok  |
     |   unicore32: |  ok  |
     |         x86: |  ok  |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 09582d171c84..9433b3e523b3 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 5df0285b6fc4..212dde0b578c 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ..  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: |  ..  |
     |     powerpc: |  ..  |
     |        s390: |  ..  |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: |  ..  |
-    |        tile: |  ..  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
index 0f8c7e4084b0..4074028f72f7 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: |  ok  |
-    |        cris: | TODO |
-    |         frv: |  ok  |
     |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: |  ok  |
     |   unicore32: |  ok  |
     |         x86: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index c0af0a37444d..a394d8820517 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 72c3124ffd1f..082f93d5b40e 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index 46c62a1d7dda..605e0abb756d 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index eaace2054bb4..7a8eb0bd5ca8 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: |  ..  |
     |         c6x: |  ..  |
-    |        cris: |  ..  |
-    |         frv: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: | TODO |
-    |        m32r: |  ..  |
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: |  ..  |
     |          sh: |  ..  |
     |       sparc: |  ok  |
-    |        tile: | TODO |
     |          um: |  ..  |
     |   unicore32: |  ..  |
     |         x86: |  ok  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index b1088eaaff3f..35fb99b2b3ea 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: |  ..  |
-    |        cris: |  ..  |
-    |         frv: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: |  ..  |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: |  ..  |
     |   unicore32: |  ..  |
     |         x86: |  ok  |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index 6e4e5295ee2a..ed8b943ad8fc 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: | TODO |
     |         arm: | TODO |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: | TODO |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 185e0654389f..589947bdf0a8 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: | TODO |
     |       arm64: | TODO |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: | TODO |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: | TODO |
-    |        tile: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
index de7f891fb2a8..8b8bea0318a0 100644
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ b/Documentation/features/vm/numa-memblock/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ..  |
     |         arm: |  ..  |
     |       arm64: |  ..  |
-    |    blackfin: |  ..  |
     |         c6x: |  ..  |
-    |        cris: |  ..  |
-    |         frv: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
     |        ia64: |  ok  |
-    |        m32r: | TODO |
     |        m68k: |  ..  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
@@ -26,10 +22,8 @@
     |      parisc: |  ..  |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: | TODO |
     |          um: |  ..  |
     |   unicore32: |  ..  |
     |         x86: |  ok  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 8587fe975fea..055004f467d2 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -10,14 +10,10 @@
     |         arc: |  ok  |
     |         arm: |  ok  |
     |       arm64: |  ok  |
-    |    blackfin: | TODO |
     |         c6x: | TODO |
-    |        cris: | TODO |
-    |         frv: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
-    |        m32r: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
@@ -26,10 +22,8 @@
     |      parisc: | TODO |
     |     powerpc: |  ok  |
     |        s390: |  ok  |
-    |       score: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-    |        tile: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
-- 
2.9.0
