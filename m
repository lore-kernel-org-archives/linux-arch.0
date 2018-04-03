From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [PATCH 2/3] Documentation/features/core: Add arch support status files for 'cBPF-JIT' and 'eBPF-JIT'
Date: Tue,  3 Apr 2018 18:55:50 +0200
Message-ID: <1522774551-9503-3-git-send-email-andrea.parri@amarulasolutions.com>
References: <1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1522774551-9503-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, Andrea Parri <andrea.parri@amarulasolutions.com>
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
---
 .../features/core/BPF-JIT/arch-support.txt         | 31 ----------------------
 .../features/core/cBPF-JIT/arch-support.txt        |  5 ++++
 .../features/core/eBPF-JIT/arch-support.txt        |  5 ++++
 3 files changed, 10 insertions(+), 31 deletions(-)
 delete mode 100644 Documentation/features/core/BPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/cBPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/eBPF-JIT/arch-support.txt

diff --git a/Documentation/features/core/BPF-JIT/arch-support.txt b/Documentation/features/core/BPF-JIT/arch-support.txt
deleted file mode 100644
index 0b96b4e1e7d4a..0000000000000
--- a/Documentation/features/core/BPF-JIT/arch-support.txt
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-# Feature name:          BPF-JIT
-#         Kconfig:       HAVE_BPF_JIT
-#         description:   arch supports BPF JIT optimizations
-#
-    -----------------------
-    |         arch |status|
-    -----------------------
-    |       alpha: | TODO |
-    |         arc: | TODO |
-    |         arm: |  ok  |
-    |       arm64: |  ok  |
-    |         c6x: | TODO |
-    |       h8300: | TODO |
-    |     hexagon: | TODO |
-    |        ia64: | TODO |
-    |        m68k: | TODO |
-    |  microblaze: | TODO |
-    |        mips: |  ok  |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: |  ok  |
-    |        s390: |  ok  |
-    |          sh: | TODO |
-    |       sparc: |  ok  |
-    |          um: | TODO |
-    |   unicore32: | TODO |
-    |         x86: |  ok  |
-    |      xtensa: | TODO |
-    -----------------------
diff --git a/Documentation/features/core/cBPF-JIT/arch-support.txt b/Documentation/features/core/cBPF-JIT/arch-support.txt
new file mode 100644
index 0000000000000..2ae2a7106e67d
--- /dev/null
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -0,0 +1,5 @@
+#
+# Feature name:          cBPF-JIT
+#         Kconfig:       HAVE_CBPF_JIT
+#         description:   arch supports cBPF JIT optimizations
+#
diff --git a/Documentation/features/core/eBPF-JIT/arch-support.txt b/Documentation/features/core/eBPF-JIT/arch-support.txt
new file mode 100644
index 0000000000000..c8b0b458b9cec
--- /dev/null
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -0,0 +1,5 @@
+#
+# Feature name:          eBPF-JIT
+#         Kconfig:       HAVE_EBPF_JIT
+#         description:   arch supports eBPF JIT optimizations
+#
-- 
2.7.4
