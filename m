From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 3/3] Documentation/features: Refresh and auto-generate the arch support status files in place
Date: Tue,  3 Apr 2018 18:55:51 +0200
Message-ID: <1522774551-9503-4-git-send-email-andrea.parri@amarulasolutions.com>
References: <1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 .../features/core/cBPF-JIT/arch-support.txt        | 27 ++++++++++++++++++++++
 .../features/core/eBPF-JIT/arch-support.txt        | 27 ++++++++++++++++++++++
 .../core/generic-idle-thread/arch-support.txt      |  3 ++-
 .../features/core/jump-labels/arch-support.txt     |  1 +
 .../features/core/tracehook/arch-support.txt       |  1 +
 .../features/debug/KASAN/arch-support.txt          |  3 ++-
 .../debug/gcov-profile-all/arch-support.txt        |  1 +
 Documentation/features/debug/kgdb/arch-support.txt |  3 ++-
 .../debug/kprobes-on-ftrace/arch-support.txt       |  1 +
 .../features/debug/kprobes/arch-support.txt        |  3 ++-
 .../features/debug/kretprobes/arch-support.txt     |  3 ++-
 .../features/debug/optprobes/arch-support.txt      |  3 ++-
 .../features/debug/stackprotector/arch-support.txt |  1 +
 .../features/debug/uprobes/arch-support.txt        |  5 ++--
 .../debug/user-ret-profiler/arch-support.txt       |  1 +
 .../features/io/dma-api-debug/arch-support.txt     |  1 +
 .../features/io/dma-contiguous/arch-support.txt    |  3 ++-
 .../features/io/sg-chain/arch-support.txt          |  1 +
 .../features/lib/strncasecmp/arch-support.txt      |  1 +
 .../locking/cmpxchg-local/arch-support.txt         |  3 ++-
 .../features/locking/lockdep/arch-support.txt      |  3 ++-
 .../locking/queued-rwlocks/arch-support.txt        |  9 ++++----
 .../locking/queued-spinlocks/arch-support.txt      |  7 +++---
 .../locking/rwsem-optimized/arch-support.txt       |  1 +
 .../features/perf/kprobes-event/arch-support.txt   |  5 ++--
 .../features/perf/perf-regs/arch-support.txt       |  3 ++-
 .../features/perf/perf-stackdump/arch-support.txt  |  3 ++-
 .../sched/membarrier-sync-core/arch-support.txt    |  1 +
 .../features/sched/numa-balancing/arch-support.txt |  5 ++--
 .../seccomp/seccomp-filter/arch-support.txt        |  5 ++--
 .../time/arch-tick-broadcast/arch-support.txt      |  3 ++-
 .../features/time/clockevents/arch-support.txt     |  3 ++-
 .../time/context-tracking/arch-support.txt         |  1 +
 .../features/time/irq-time-acct/arch-support.txt   |  3 ++-
 .../time/modern-timekeeping/arch-support.txt       |  1 +
 .../features/time/virt-cpuacct/arch-support.txt    |  1 +
 .../features/vm/ELF-ASLR/arch-support.txt          |  3 ++-
 .../features/vm/PG_uncached/arch-support.txt       |  1 +
 Documentation/features/vm/THP/arch-support.txt     |  1 +
 Documentation/features/vm/TLB/arch-support.txt     |  1 +
 .../features/vm/huge-vmap/arch-support.txt         |  1 +
 .../features/vm/ioremap_prot/arch-support.txt      |  1 +
 .../features/vm/numa-memblock/arch-support.txt     |  3 ++-
 .../features/vm/pte_special/arch-support.txt       |  1 +
 44 files changed, 127 insertions(+), 31 deletions(-)

diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
index 2ae2a7106e67d..6b829e27c268a 100644
--- a/Documentation/features/core/cBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -3,3 +3,30 @@
 #         Kconfig:       HAVE_CBPF_JIT
 #         description:   arch supports cBPF JIT optimizations
 #
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: | TODO |
+    |       arm64: | TODO |
+    |         c6x: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: | TODO |
+    |        mips: |  ok  |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: |  ok  |
+    |       riscv: | TODO |
+    |        s390: | TODO |
+    |          sh: | TODO |
+    |       sparc: |  ok  |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: | TODO |
+    |      xtensa: | TODO |
+    -----------------------
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
index c8b0b458b9cec..4a4ab34ee293a 100644
--- a/Documentation/features/core/eBPF-JIT/arch-support.txt
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -3,3 +3,30 @@
 #         Kconfig:       HAVE_EBPF_JIT
 #         description:   arch supports eBPF JIT optimizations
 #
+    -----------------------
+    |         arch |status|
+    -----------------------
+    |       alpha: | TODO |
+    |         arc: | TODO |
+    |         arm: |  ok  |
+    |       arm64: |  ok  |
+    |         c6x: | TODO |
+    |       h8300: | TODO |
+    |     hexagon: | TODO |
+    |        ia64: | TODO |
+    |        m68k: | TODO |
+    |  microblaze: | TODO |
+    |        mips: |  ok  |
+    |       nios2: | TODO |
+    |    openrisc: | TODO |
+    |      parisc: | TODO |
+    |     powerpc: |  ok  |
+    |       riscv: | TODO |
+    |        s390: |  ok  |
+    |          sh: | TODO |
+    |       sparc: |  ok  |
+    |          um: | TODO |
+    |   unicore32: | TODO |
+    |         x86: |  ok  |
+    |      xtensa: | TODO |
+    -----------------------
diff --git a/Documentation/features/core/generic-idle-thread/arch-support.txt b/Documentation/features/core/generic-idle-thread/arch-support.txt
index 372a2b18a6172..261073013df90 100644
--- a/Documentation/features/core/generic-idle-thread/arch-support.txt
+++ b/Documentation/features/core/generic-idle-thread/arch-support.txt
@@ -18,9 +18,10 @@
     |  microblaze: | TODO |
     |        mips: |  ok  |
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
index ad97217b003ba..33c032ccccf5e 100644
--- a/Documentation/features/core/jump-labels/arch-support.txt
+++ b/Documentation/features/core/jump-labels/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/core/tracehook/arch-support.txt b/Documentation/features/core/tracehook/arch-support.txt
index 36ee7bef5d189..7e91aaec8025a 100644
--- a/Documentation/features/core/tracehook/arch-support.txt
+++ b/Documentation/features/core/tracehook/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/debug/KASAN/arch-support.txt b/Documentation/features/debug/KASAN/arch-support.txt
index f5c99fa576d33..f1192fc5c47eb 100644
--- a/Documentation/features/debug/KASAN/arch-support.txt
+++ b/Documentation/features/debug/KASAN/arch-support.txt
@@ -21,11 +21,12 @@
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
index 5170a9934843e..40847b7b8b12a 100644
--- a/Documentation/features/debug/gcov-profile-all/arch-support.txt
+++ b/Documentation/features/debug/gcov-profile-all/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: | TODO |
diff --git a/Documentation/features/debug/kgdb/arch-support.txt b/Documentation/features/debug/kgdb/arch-support.txt
index 13b6e994ae1fc..b99e64d513ec0 100644
--- a/Documentation/features/debug/kgdb/arch-support.txt
+++ b/Documentation/features/debug/kgdb/arch-support.txt
@@ -11,7 +11,7 @@
     |         arm: |  ok  |
     |       arm64: |  ok  |
     |         c6x: | TODO |
-    |       h8300: | TODO |
+    |       h8300: |  ok  |
     |     hexagon: |  ok  |
     |        ia64: | TODO |
     |        m68k: | TODO |
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index 419bb38820e7c..266ea31c6fcdf 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/debug/kprobes/arch-support.txt b/Documentation/features/debug/kprobes/arch-support.txt
index 52b3ace0a030a..e60b0d0d25cf6 100644
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
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/debug/kretprobes/arch-support.txt b/Documentation/features/debug/kretprobes/arch-support.txt
index 180d244195185..1f326a1769cb9 100644
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
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/debug/optprobes/arch-support.txt b/Documentation/features/debug/optprobes/arch-support.txt
index 0a1241f45e41d..a844637b957ce 100644
--- a/Documentation/features/debug/optprobes/arch-support.txt
+++ b/Documentation/features/debug/optprobes/arch-support.txt
@@ -20,7 +20,8 @@
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
index 5700195723834..ca3bd7dd4e7f0 100644
--- a/Documentation/features/debug/stackprotector/arch-support.txt
+++ b/Documentation/features/debug/stackprotector/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: |  ok  |
     |       sparc: | TODO |
diff --git a/Documentation/features/debug/uprobes/arch-support.txt b/Documentation/features/debug/uprobes/arch-support.txt
index 0b8d922eb799e..ac47048fcb95e 100644
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
@@ -21,9 +21,10 @@
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
index 13852ae62e9e1..6c0f85b2a8a6e 100644
--- a/Documentation/features/debug/user-ret-profiler/arch-support.txt
+++ b/Documentation/features/debug/user-ret-profiler/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/io/dma-api-debug/arch-support.txt b/Documentation/features/io/dma-api-debug/arch-support.txt
index e438ed675623b..7e4510d7d4893 100644
--- a/Documentation/features/io/dma-api-debug/arch-support.txt
+++ b/Documentation/features/io/dma-api-debug/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt b/Documentation/features/io/dma-contiguous/arch-support.txt
index 47f64a433df00..f6bbced1c8f78 100644
--- a/Documentation/features/io/dma-contiguous/arch-support.txt
+++ b/Documentation/features/io/dma-contiguous/arch-support.txt
@@ -21,7 +21,8 @@
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
index 07f357fadbff6..d2732887e0ad3 100644
--- a/Documentation/features/io/sg-chain/arch-support.txt
+++ b/Documentation/features/io/sg-chain/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/lib/strncasecmp/arch-support.txt b/Documentation/features/lib/strncasecmp/arch-support.txt
index 4f3a6a0e4e683..d7a1dd8072514 100644
--- a/Documentation/features/lib/strncasecmp/arch-support.txt
+++ b/Documentation/features/lib/strncasecmp/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/locking/cmpxchg-local/arch-support.txt b/Documentation/features/locking/cmpxchg-local/arch-support.txt
index 482a0b09d1f89..c2e9979292a80 100644
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
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/locking/lockdep/arch-support.txt b/Documentation/features/locking/lockdep/arch-support.txt
index bb35c5ba62866..23f772a875aa5 100644
--- a/Documentation/features/locking/lockdep/arch-support.txt
+++ b/Documentation/features/locking/lockdep/arch-support.txt
@@ -18,9 +18,10 @@
     |  microblaze: |  ok  |
     |        mips: |  ok  |
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
index 627e9a6b2db98..2f0a42570f83f 100644
--- a/Documentation/features/locking/queued-rwlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-rwlocks/arch-support.txt
@@ -9,21 +9,22 @@
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
index 9edda216cdfbf..10794bd0e331a 100644
--- a/Documentation/features/locking/queued-spinlocks/arch-support.txt
+++ b/Documentation/features/locking/queued-spinlocks/arch-support.txt
@@ -16,14 +16,15 @@
     |        ia64: | TODO |
     |        m68k: | TODO |
     |  microblaze: | TODO |
-    |        mips: | TODO |
+    |        mips: |  ok  |
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
index 8d9afb10b16e7..c1e98011a653f 100644
--- a/Documentation/features/locking/rwsem-optimized/arch-support.txt
+++ b/Documentation/features/locking/rwsem-optimized/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/perf/kprobes-event/arch-support.txt b/Documentation/features/perf/kprobes-event/arch-support.txt
index d01239ee34b34..c327af0f5c992 100644
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
@@ -21,9 +21,10 @@
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
index 458faba5311ab..122445ba72974 100644
--- a/Documentation/features/perf/perf-regs/arch-support.txt
+++ b/Documentation/features/perf/perf-regs/arch-support.txt
@@ -21,7 +21,8 @@
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
index 545d01c69c88f..4c16b01b13003 100644
--- a/Documentation/features/perf/perf-stackdump/arch-support.txt
+++ b/Documentation/features/perf/perf-stackdump/arch-support.txt
@@ -21,7 +21,8 @@
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
index 85a6c9d4571ce..4cf907ce2329b 100644
--- a/Documentation/features/sched/membarrier-sync-core/arch-support.txt
+++ b/Documentation/features/sched/membarrier-sync-core/arch-support.txt
@@ -44,6 +44,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/sched/numa-balancing/arch-support.txt b/Documentation/features/sched/numa-balancing/arch-support.txt
index 3475088638726..f5a2472bc577f 100644
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
@@ -21,7 +21,8 @@
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
index e4fad58a05e51..732d66f68c36a 100644
--- a/Documentation/features/seccomp/seccomp-filter/arch-support.txt
+++ b/Documentation/features/seccomp/seccomp-filter/arch-support.txt
@@ -19,8 +19,9 @@
     |        mips: |  ok  |
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
index 8052904b25fc7..fd5deea32759b 100644
--- a/Documentation/features/time/arch-tick-broadcast/arch-support.txt
+++ b/Documentation/features/time/arch-tick-broadcast/arch-support.txt
@@ -21,8 +21,9 @@
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
index 7c76b946297e9..96d773c42077a 100644
--- a/Documentation/features/time/clockevents/arch-support.txt
+++ b/Documentation/features/time/clockevents/arch-support.txt
@@ -19,8 +19,9 @@
     |        mips: |  ok  |
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
index 9433b3e523b39..28aa805d61c19 100644
--- a/Documentation/features/time/context-tracking/arch-support.txt
+++ b/Documentation/features/time/context-tracking/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/time/irq-time-acct/arch-support.txt b/Documentation/features/time/irq-time-acct/arch-support.txt
index 212dde0b578c8..a12dc62a63ac4 100644
--- a/Documentation/features/time/irq-time-acct/arch-support.txt
+++ b/Documentation/features/time/irq-time-acct/arch-support.txt
@@ -20,7 +20,8 @@
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
index 4074028f72f72..4e5e48cc6c1cd 100644
--- a/Documentation/features/time/modern-timekeeping/arch-support.txt
+++ b/Documentation/features/time/modern-timekeeping/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: |  ok  |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index a394d8820517b..b82e517295d55 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: |  ok  |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: |  ok  |
diff --git a/Documentation/features/vm/ELF-ASLR/arch-support.txt b/Documentation/features/vm/ELF-ASLR/arch-support.txt
index 082f93d5b40ed..413229bedf398 100644
--- a/Documentation/features/vm/ELF-ASLR/arch-support.txt
+++ b/Documentation/features/vm/ELF-ASLR/arch-support.txt
@@ -19,8 +19,9 @@
     |        mips: |  ok  |
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
index 605e0abb756d8..137064e8815e6 100644
--- a/Documentation/features/vm/PG_uncached/arch-support.txt
+++ b/Documentation/features/vm/PG_uncached/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/THP/arch-support.txt b/Documentation/features/vm/THP/arch-support.txt
index 7a8eb0bd5ca84..9f3d4ce8fe820 100644
--- a/Documentation/features/vm/THP/arch-support.txt
+++ b/Documentation/features/vm/THP/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: |  ..  |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ..  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/vm/TLB/arch-support.txt b/Documentation/features/vm/TLB/arch-support.txt
index 35fb99b2b3ea1..d5fd9c773e6c8 100644
--- a/Documentation/features/vm/TLB/arch-support.txt
+++ b/Documentation/features/vm/TLB/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: |  ..  |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/huge-vmap/arch-support.txt b/Documentation/features/vm/huge-vmap/arch-support.txt
index ed8b943ad8fc8..bc7ff7b2169d4 100644
--- a/Documentation/features/vm/huge-vmap/arch-support.txt
+++ b/Documentation/features/vm/huge-vmap/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: | TODO |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/ioremap_prot/arch-support.txt b/Documentation/features/vm/ioremap_prot/arch-support.txt
index 589947bdf0a8a..7ceb532c7ae51 100644
--- a/Documentation/features/vm/ioremap_prot/arch-support.txt
+++ b/Documentation/features/vm/ioremap_prot/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: | TODO |
     |          sh: |  ok  |
     |       sparc: | TODO |
diff --git a/Documentation/features/vm/numa-memblock/arch-support.txt b/Documentation/features/vm/numa-memblock/arch-support.txt
index 8b8bea0318a0d..c9f9ad44540a8 100644
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
@@ -21,6 +21,7 @@
     |    openrisc: |  ..  |
     |      parisc: |  ..  |
     |     powerpc: |  ok  |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
diff --git a/Documentation/features/vm/pte_special/arch-support.txt b/Documentation/features/vm/pte_special/arch-support.txt
index 055004f467d2c..6e7a00f5bc0ee 100644
--- a/Documentation/features/vm/pte_special/arch-support.txt
+++ b/Documentation/features/vm/pte_special/arch-support.txt
@@ -21,6 +21,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
+    |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: |  ok  |
     |       sparc: |  ok  |
-- 
2.7.4
