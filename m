Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41510 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752669AbeDHQbc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Apr 2018 12:31:32 -0400
Received: by mail-wr0-f196.google.com with SMTP id s12so6148958wrc.8
        for <linux-arch@vger.kernel.org>; Sun, 08 Apr 2018 09:31:32 -0700 (PDT)
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: [RFC PATCH v2 3/6] Documentation/features/core: Add arch support status files for 'cBPF-JIT' and 'eBPF-JIT'
Date: Sun,  8 Apr 2018 18:30:24 +0200
Message-ID: <1523205027-31786-4-git-send-email-andrea.parri@amarulasolutions.com>
In-Reply-To: <1523205027-31786-1-git-send-email-andrea.parri@amarulasolutions.com>
References: <1523205027-31786-1-git-send-email-andrea.parri@amarulasolutions.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, paulmck@linux.vnet.ibm.com, Andrea Parri <andrea.parri@amarulasolutions.com>
Message-ID: <20180408163024.h1GarZp2cH0vvB4SLeFKEa1HQu2X1ldcrWh3A2llZz8@z>

Commit 6077776b5908e split 'HAVE_BPF_JIT' into cBPF and eBPF variant.
Adds arch support status files for the new variants, and removes the
status file corresponding to 'HAVE_BPT_JIT'. The new status matrices
were auto-generated using the script 'features-refresh.sh'.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 .../features/core/BPF-JIT/arch-support.txt         | 33 ----------------------
 .../features/core/cBPF-JIT/arch-support.txt        | 33 ++++++++++++++++++++++
 .../features/core/eBPF-JIT/arch-support.txt        | 33 ++++++++++++++++++++++
 3 files changed, 66 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/features/core/BPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/cBPF-JIT/arch-support.txt
 create mode 100644 Documentation/features/core/eBPF-JIT/arch-support.txt

diff --git a/Documentation/features/core/BPF-JIT/arch-support.txt b/Documentation/features/core/BPF-JIT/arch-support.txt
deleted file mode 100644
index d277f971ccd6b..0000000000000
--- a/Documentation/features/core/BPF-JIT/arch-support.txt
+++ /dev/null
@@ -1,33 +0,0 @@
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
-    |       nds32: | TODO |
-    |       nios2: | TODO |
-    |    openrisc: | TODO |
-    |      parisc: | TODO |
-    |     powerpc: |  ok  |
-    |       riscv: | TODO |
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
index 0000000000000..90459cdde3143
--- /dev/null
+++ b/Documentation/features/core/cBPF-JIT/arch-support.txt
@@ -0,0 +1,33 @@
+#
+# Feature name:          cBPF-JIT
+#         Kconfig:       HAVE_CBPF_JIT
+#         description:   arch supports cBPF JIT optimizations
+#
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
+    |       nds32: | TODO |
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
new file mode 100644
index 0000000000000..c90a0382fe667
--- /dev/null
+++ b/Documentation/features/core/eBPF-JIT/arch-support.txt
@@ -0,0 +1,33 @@
+#
+# Feature name:          eBPF-JIT
+#         Kconfig:       HAVE_EBPF_JIT
+#         description:   arch supports eBPF JIT optimizations
+#
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
+    |       nds32: | TODO |
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
-- 
2.7.4
