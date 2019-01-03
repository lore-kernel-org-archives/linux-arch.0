From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/5] arch: remove stale comments "UAPI Header export list"
Date: Thu,  3 Jan 2019 10:10:37 +0900
Message-ID: <1546477840-14278-2-git-send-email-yamada.masahiro@socionext.com>
References: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546477840-14278-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, Masahiro Yamada <yamada.masahiro@socionext.com>
List-Id: linux-arch.vger.kernel.org

These comments are leftovers of commit fcc8487d477a ("uapi: export all
headers under uapi directories").

Prior to that commit, exported headers must be explicitly added to
header-y. Now, all headers under the uapi/ directories are exported.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2: None

 arch/alpha/include/uapi/asm/Kbuild      | 1 -
 arch/arc/include/uapi/asm/Kbuild        | 1 -
 arch/arm/include/uapi/asm/Kbuild        | 1 -
 arch/arm64/include/uapi/asm/Kbuild      | 1 -
 arch/c6x/include/uapi/asm/Kbuild        | 1 -
 arch/h8300/include/uapi/asm/Kbuild      | 1 -
 arch/hexagon/include/uapi/asm/Kbuild    | 1 -
 arch/ia64/include/uapi/asm/Kbuild       | 1 -
 arch/m68k/include/uapi/asm/Kbuild       | 1 -
 arch/microblaze/include/uapi/asm/Kbuild | 1 -
 arch/mips/include/uapi/asm/Kbuild       | 1 -
 arch/nds32/include/uapi/asm/Kbuild      | 1 -
 arch/nios2/include/uapi/asm/Kbuild      | 1 -
 arch/openrisc/include/uapi/asm/Kbuild   | 1 -
 arch/parisc/include/uapi/asm/Kbuild     | 1 -
 arch/powerpc/include/uapi/asm/Kbuild    | 1 -
 arch/riscv/include/uapi/asm/Kbuild      | 1 -
 arch/s390/include/uapi/asm/Kbuild       | 1 -
 arch/sh/include/uapi/asm/Kbuild         | 1 -
 arch/sparc/include/uapi/asm/Kbuild      | 1 -
 arch/unicore32/include/uapi/asm/Kbuild  | 1 -
 arch/x86/include/uapi/asm/Kbuild        | 1 -
 arch/xtensa/include/uapi/asm/Kbuild     | 1 -
 include/uapi/linux/Kbuild               | 2 --
 24 files changed, 25 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/Kbuild b/arch/alpha/include/uapi/asm/Kbuild
index 6a3a0ce..50dea7f 100644
--- a/arch/alpha/include/uapi/asm/Kbuild
+++ b/arch/alpha/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 170b5db..42ac23e 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 4d1cc18..393fe32 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd-common.h
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 6c5adf4..eb43543 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += errno.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 26644e1..633f386 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 2f65f78..c1a994e 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/hexagon/include/uapi/asm/Kbuild b/arch/hexagon/include/uapi/asm/Kbuild
index 41a176d..bcc65a2 100644
--- a/arch/hexagon/include/uapi/asm/Kbuild
+++ b/arch/hexagon/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index ccce0ea..3536c78 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_64.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index b645291..2d75dbc 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index b6656d9..c95da41 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/mips/include/uapi/asm/Kbuild b/arch/mips/include/uapi/asm/Kbuild
index ed4bd03..215d808 100644
--- a/arch/mips/include/uapi/asm/Kbuild
+++ b/arch/mips/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_n32.h
diff --git a/arch/nds32/include/uapi/asm/Kbuild b/arch/nds32/include/uapi/asm/Kbuild
index 40be972..ddd2a28 100644
--- a/arch/nds32/include/uapi/asm/Kbuild
+++ b/arch/nds32/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index 13a3d77..37bec5d 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 130c16c..bb850fa 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index d31b426..99c0c73 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/powerpc/include/uapi/asm/Kbuild b/arch/powerpc/include/uapi/asm/Kbuild
index 8ab8ba1..6e7574e 100644
--- a/arch/powerpc/include/uapi/asm/Kbuild
+++ b/arch/powerpc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/riscv/include/uapi/asm/Kbuild b/arch/riscv/include/uapi/asm/Kbuild
index 5511b99..5945a59 100644
--- a/arch/riscv/include/uapi/asm/Kbuild
+++ b/arch/riscv/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += setup.h
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index dc38a90..89b4582 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index dcb9354..7ef099e 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/sparc/include/uapi/asm/Kbuild b/arch/sparc/include/uapi/asm/Kbuild
index ae72977..7064bfb 100644
--- a/arch/sparc/include/uapi/asm/Kbuild
+++ b/arch/sparc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 8611ef9..3620f6a 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index 3226816..d15343a 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += bpf_perf_event.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index f95cad3..3ae1bbd 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
-# UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index ca2787d..5f24b50 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -1,5 +1,3 @@
-# UAPI Header export list
-
 ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/uapi/asm/a.out.h),)
 no-export-headers += a.out.h
 endif
-- 
2.7.4
