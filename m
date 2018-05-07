From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v3 2/6] Documentation/features: Refresh the arch support status files in place
Date: Mon,  7 May 2018 12:43:39 +0200
Message-ID: <1525689823-3340-3-git-send-email-andrea.parri@amarulasolutions.com>
References: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525689823-3340-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, paulmck@linux.vnet.ibm.com, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-arch.vger.kernel.org

Now that the script 'features-refresh.sh' is available, uses this script
to refresh all the arch-support.txt files in place.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 Documentation/features/core/BPF-JIT/arch-support.txt           |  2 ++
 .../features/core/generic-idle-thread/arch-support.txt         |  4 +++-
 Documentation/features/core/jump-labels/arch-support.txt       |  2 ++
 Documentation/features/core/tracehook/arch-support.txt         |  2 ++
 Documentation/features/debug/KASAN/arch-support.txt            |  4 +++-
 Documentation/features/debug/gcov-profile-all/arch-support.txt |  2 ++
 Documentation/features/debug/kgdb/arch-support.txt             |  4 +++-
 .../features/debug/kprobes-on-ftrace/arch-support.txt          |  2 ++
 Documentation/features/debug/kprobes/arch-support.txt          |  4 +++-
 Documentation/features/debug/kretprobes/arch-support.txt       |  4 +++-
 Documentation/features/debug/optprobes/arch-support.txt        |  4 +++-
 Documentation/features/debug/stackprotector/arch-support.txt   |  2 ++
 Documentation/features/debug/uprobes/arch-support.txt          |  6 ++++--
 .../features/debug/user-ret-profiler/arch-support.txt          |  2 ++
 Documentation/features/io/dma-api-debug/arch-support.txt       |  2 ++
 Documentation/features/io/dma-contiguous/arch-support.txt      |  4 +++-
 Documentation/features/io/sg-chain/arch-support.txt            |  2 ++
 Documentation/features/lib/strncasecmp/arch-support.txt        |  2 ++
 Documentation/features/locking/cmpxchg-local/arch-support.txt  |  4 +++-
 Documentation/features/locking/lockdep/arch-support.txt        |  4 +++-
 Documentation/features/locking/queued-rwlocks/arch-support.txt | 10 ++++++----
 .../features/locking/queued-spinlocks/arch-support.txt         |  8 +++++---
 .../features/locking/rwsem-optimized/arch-support.txt          |  2 ++
 Documentation/features/perf/kprobes-event/arch-support.txt     |  6 ++++--
 Documentation/features/perf/perf-regs/arch-support.txt         |  4 +++-
 Documentation/features/perf/perf-stackdump/arch-support.txt    |  4 +++-
 .../features/sched/membarrier-sync-core/arch-support.txt       |  2 ++
 Documentation/features/sched/numa-balancing/arch-support.txt   |  6 ++++--
 Documentation/features/seccomp/seccomp-filter/arch-support.txt |  6 ++++--
 .../features/time/arch-tick-broadcast/arch-support.txt         |  4 +++-
 Documentation/features/time/clockevents/arch-support.txt       |  4 +++-
 Documentation/features/time/context-tracking/arch-support.txt  |  2 ++
 Documentation/features/time/irq-time-acct/arch-support.txt     |  4 +++-
 .../features/time/modern-timekeeping/arch-support.txt          |  2 ++
 Documentation/features/time/virt-cpuacct/arch-support.txt      |  2 ++
 Documentation/features/vm/ELF-ASLR/arch-support.txt            |  4 +++-
 Documentation/features/vm/PG_uncached/arch-support.txt         |  2 ++
 Documentation/features/vm/THP/arch-support.txt                 |  2 ++
 Documentation/features/vm/TLB/arch-support.txt                 |  2 ++
 Documentation/features/vm/huge-vmap/arch-support.txt           |  2 ++
 Documentation/features/vm/ioremap_prot/arch-support.txt        |  2 ++
 Documentation/features/vm/numa-memblock/arch-support.txt       |  4 +++-
 Documentation/features/vm/pte_special/arch-support.txt         |  2 ++
 43 files changed, 117 insertions(+), 31 deletions(-)

diff --git a/Documentation/features/core/BPF-JIT/arch-support.txt b/Documentation/features/core/BPF-JIT/arch-support.txt
index 0b96b4e1e7d4a..d277f971ccd6b 100644
--- a/Documentation/features/core/BPF-JIT/arch-support.txt
+++ b/Documentation/features/core/BPF-JIT/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index 372a2b18a6172..0ef6acdb991c7 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
-    |    openrisc: | TODO |
+    |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
index ad97217b003ba..27cbd63abfd28 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index 36ee7bef5d189..f44c274e40ede 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index f5c99fa576d33..282ecc8ea1da4 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -17,15 +17,17 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
-    |         x86: |  ok  | 64-bit only
+    |         x86: |  ok  |
     |      xtensa: |  ok  |
     -----------------------
diff --git a/Documentation/features/debug/gcov-profile-all/arch-support.txt b/Documentation/features/debug/gcov-profile-all/arch-support.txt
index 5170a9934843e..01b2b3004e0ad 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 13b6e994ae1fc..3b4dff22329fb 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -11,16 +11,18 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |       h8300: | TODO |
+    |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: |  ok  |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 419bb38820e7c..7e963d0ae6461 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 52b3ace0a030a..4ada027faf169 100644
--- a/Documentation/features/debug/kprobes/arch-support.txt
+++ b/Documentation/features/debug/kprobes/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: |  ok  |
     |         arm: |  ok  |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 180d244195185..044e13fcca5d9 100644
--- a/Documentation/features/debug/kretprobes/arch-support.txt
+++ b/Documentation/features/debug/kretprobes/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: |  ok  |
     |         arm: |  ok  |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index 0a1241f45e41d..dce7669c918f3 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/debug/stackprotector/arch-support.txt b/Documentation/features/debug/stackprotector/arch-support.txt
index 5700195723834..74b89a9c8b3a3 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: |  ok  |
     |       sparc: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 0b8d922eb799e..1a3f9d3229bfe 100644
--- a/Documentation/features/debug/uprobes/arch-support.txt
+++ b/Documentation/features/debug/uprobes/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: |  ok  |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
@@ -17,13 +17,15 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
-    |       sparc: | TODO |
+    |       sparc: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/debug/user-ret-profiler/arch-support.txt b/Documentation/features/debug/user-ret-profiler/arch-support.txt
index 13852ae62e9e1..1d78d1069a5fd 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/io/dma-api-debug/arch-support.txt b/Documentation/features/io/dma-api-debug/arch-support.txt
index e438ed675623b..dd2806de9b8b3 100644
--- a/Documentation/features/io/dma-api-debug/arch-support.txt
+++ b/Documentation/features/io/dma-api-debug/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 47f64a433df00..30c072d2b67ca 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -17,11 +17,13 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
-    |        s390: | TODO |
+    |       riscv: |  ok  |
+    |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
     |          um: | TODO |
diff --git a/Documentation/features/io/sg-chain/arch-support.txt b/Documentation/features/io/sg-chain/arch-support.txt
index 07f357fadbff6..6554f0372c3fc 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/lib/strncasecmp/arch-support.txt b/Documentation/features/lib/strncasecmp/arch-support.txt
index 4f3a6a0e4e683..6148f42c3d902 100644
--- a/Documentation/features/lib/strncasecmp/arch-support.txt
+++ b/Documentation/features/lib/strncasecmp/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 482a0b09d1f89..51704a2dc8d17 100644
--- a/Documentation/features/locking/cmpxchg-local/arch-support.txt
+++ b/Documentation/features/locking/cmpxchg-local/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index bb35c5ba62866..bd39c5edd4607 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
+    |       nds32: |  ok  |
     |       nios2: | TODO |
-    |    openrisc: | TODO |
+    |    openrisc: |  ok  |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/locking/queued-rwlocks/arch-support.txt b/Documentation/features/locking/queued-rwlocks/arch-support.txt
index 627e9a6b2db98..da7aff3bee0b3 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -9,21 +9,23 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |
     |     hexagon: | TODO |
     |        ia64: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
-    |        mips: | TODO |
+    |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
-    |    openrisc: | TODO |
+    |    openrisc: |  ok  |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
-    |       sparc: | TODO |
+    |       sparc: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/locking/queued-spinlocks/arch-support.txt b/Documentation/features/locking/queued-spinlocks/arch-support.txt
index 9edda216cdfbf..478e9101322c4 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -16,14 +16,16 @@
     |        ia64: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
-    |        mips: | TODO |
+    |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
-    |    openrisc: | TODO |
+    |    openrisc: |  ok  |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
-    |       sparc: | TODO |
+    |       sparc: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/locking/rwsem-optimized/arch-support.txt b/Documentation/features/locking/rwsem-optimized/arch-support.txt
index 8d9afb10b16e7..8afe24ffa3ab4 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index d01239ee34b34..7331402d18872 100644
--- a/Documentation/features/perf/kprobes-event/arch-support.txt
+++ b/Documentation/features/perf/kprobes-event/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: |  ok  |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |         c6x: | TODO |
     |       h8300: | TODO |
     |     hexagon: |  ok  |
@@ -17,13 +17,15 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: |  ok  |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
-    |       sparc: | TODO |
+    |       sparc: |  ok  |
     |          um: | TODO |
     |   unicore32: | TODO |
     |         x86: |  ok  |
diff --git a/Documentation/features/perf/perf-regs/arch-support.txt b/Documentation/features/perf/perf-regs/arch-support.txt
index 458faba5311ab..53feeee6cdad9 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -17,11 +17,13 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |        s390: | TODO |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
     |          um: | TODO |
diff --git a/Documentation/features/perf/perf-stackdump/arch-support.txt b/Documentation/features/perf/perf-stackdump/arch-support.txt
index 545d01c69c88f..16164348e0ea3 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -17,11 +17,13 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |        s390: | TODO |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
     |          um: | TODO |
diff --git a/Documentation/features/sched/membarrier-sync-core/arch-support.txt b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
index 85a6c9d4571ce..dbdf629077037 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -40,10 +40,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 3475088638726..c68bb2c2cb626 100644
--- a/Documentation/features/sched/numa-balancing/arch-support.txt
+++ b/Documentation/features/sched/numa-balancing/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: |  ..  |
     |         arm: |  ..  |
-    |       arm64: |  ..  |
+    |       arm64: |  ok  |
     |         c6x: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
@@ -17,11 +17,13 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: |  ..  |
     |     powerpc: |  ok  |
-    |        s390: |  ..  |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
     |          sh: |  ..  |
     |       sparc: | TODO |
     |          um: |  ..  |
diff --git a/Documentation/features/seccomp/seccomp-filter/arch-support.txt b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
index e4fad58a05e51..d4271b493b419 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: | TODO |
+    |      parisc: |  ok  |
+    |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/time/arch-tick-broadcast/arch-support.txt b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
index 8052904b25fc7..83d9e68462bbf 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -17,12 +17,14 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
-    |          sh: | TODO |
+    |          sh: |  ok  |
     |       sparc: | TODO |
     |          um: | TODO |
     |   unicore32: | TODO |
diff --git a/Documentation/features/time/clockevents/arch-support.txt b/Documentation/features/time/clockevents/arch-support.txt
index 7c76b946297e9..3d4908fce6da8 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: |  ok  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
+    |       nds32: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/time/context-tracking/arch-support.txt b/Documentation/features/time/context-tracking/arch-support.txt
index 9433b3e523b39..c29974afffaa5 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 212dde0b578c8..8d73c463ec27a 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ..  |
-    |     powerpc: |  ..  |
+    |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ..  |
     |          sh: | TODO |
     |       sparc: |  ..  |
diff --git a/Documentation/features/time/modern-timekeeping/arch-support.txt b/Documentation/features/time/modern-timekeeping/arch-support.txt
index 4074028f72f72..e7c6ea6b8fb32 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
+    |       nds32: |  ok  |
     |       nios2: |  ok  |
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index a394d8820517b..4646457461cf8 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 082f93d5b40ed..1f71d090ff2c8 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
-    |      parisc: | TODO |
+    |      parisc: |  ok  |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/PG_uncached/arch-support.txt b/Documentation/features/vm/PG_uncached/arch-support.txt
index 605e0abb756d8..fbd5aa463b0a1 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index 7a8eb0bd5ca84..5d7ecc378f29e 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ..  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index 35fb99b2b3ea1..f7af9678eb660 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: |  ..  |
     |  microblaze: |  ..  |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index ed8b943ad8fc8..d0713ccc7117e 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 589947bdf0a8a..8527601a3739d 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: |  ok  |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
index 8b8bea0318a0d..1a988052cd24a 100644
--- a/Documentation/features/vm/numa-memblock/arch-support.txt
+++ b/Documentation/features/vm/numa-memblock/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: |  ..  |
     |         arm: |  ..  |
-    |       arm64: |  ..  |
+    |       arm64: |  ok  |
     |         c6x: |  ..  |
     |       h8300: |  ..  |
     |     hexagon: |  ..  |
@@ -17,10 +17,12 @@
     |        m68k: |  ..  |
     |  microblaze: |  ok  |
     |        mips: |  ok  |
+    |       nds32: | TODO |
     |       nios2: |  ..  |
     |    openrisc: |  ..  |
     |      parisc: |  ..  |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 055004f467d2c..6a608a6dcf71d 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -17,10 +17,12 @@
     |        m68k: | TODO |
     |  microblaze: | TODO |
     |        mips: | TODO |
+    |       nds32: | TODO |
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-- 
2.7.4
