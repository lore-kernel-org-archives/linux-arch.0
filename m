Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-12.nifty.com ([210.131.2.79]:65307 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbfBDD6I (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 3 Feb 2019 22:58:08 -0500
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] KVM: export <linux/kvm_para.h> and <asm/kvm_para.h> for all architectures
Date: Mon,  4 Feb 2019 12:55:16 +0900
Message-Id: <1549252517-23834-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=8F=AB=ADm=8F=AB=A1=8F=AB=DA?= <rkrcmar@redhat.com>, kvm@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Palmer Dabbelt <palmer@sifive.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, Sam Ravnborg <sam@ravnborg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

I do not see any consistency about headers_install of <linux/kvm_para.h>
and <asm/kvm_para.h>.

According to my analysis of Linux 5.0-rc5, there are 3 groups:

 [1] Both <linux/kvm_para.h> and <asm/kvm_para.h> are exported

    alpha, arm, hexagon, mips, powerpc, s390, sparc, x86

 [2] <asm/kvm_para.h> is exported, but <linux/kvm_para.h> is not

    arc, arm64, c6x, h8300, ia64, m68k, microblaze, nios2, openrisc

 [3] Neither <linux/kvm_para.h> nor <asm/kvm_para.h> is exported

    csky, nds32, riscv

This does not match to the actual KVM support. At least, [2] looks
like a half-way house to me.

Nor do arch maintainers look like they care about this. For example,
commit 0add53713b1c ("microblaze: Add missing kvm_para.h to Kbuild")
exported <asm/kvm_para.h> to user-space in order to fix an in-kernel
build error.

We have two ways to fix this inconsistency:

 [A] export both <linux/kvm_para.h> and <asm/kvm_para.h> for all
     architectures, irrespective of the KVM support

 [B] Match the header export of <linux/kvm_para.h> and <asm/kvm_para.h>
     to the KVM support

This commit adopts [A].

Remove 'no-export-headers' from include/uapi/linux/Kbuild to export
<linux/kvm_para.h> for all architectures.

Add 'mandatory-y' to include/uapi/asm-generic/Kbuild.asm to export
<asm/kvm_para.h> for all architectures. If arch does not have specific
implementation, a wrapper file to <asm-generic/kvm_para.h> is
automatically generated, and exported.

include/uapi/asm-generic/kvm_para.h is just a empty file. I cleaned
up empty <asm/kvm_para.h> stubs.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

If you prefer [B] (or you have a better idea),
please suggest.

 

 arch/alpha/include/uapi/asm/kvm_para.h   | 2 --
 arch/arc/include/uapi/asm/Kbuild         | 1 -
 arch/arm/include/uapi/asm/kvm_para.h     | 2 --
 arch/arm64/include/uapi/asm/Kbuild       | 2 --
 arch/c6x/include/uapi/asm/Kbuild         | 1 -
 arch/csky/include/asm/Kbuild             | 1 -
 arch/h8300/include/uapi/asm/Kbuild       | 1 -
 arch/hexagon/include/uapi/asm/kvm_para.h | 2 --
 arch/ia64/include/uapi/asm/Kbuild        | 1 -
 arch/m68k/include/uapi/asm/Kbuild        | 1 -
 arch/microblaze/include/uapi/asm/Kbuild  | 1 -
 arch/mips/include/uapi/asm/kvm_para.h    | 5 -----
 arch/nds32/include/asm/Kbuild            | 1 -
 arch/nios2/include/uapi/asm/Kbuild       | 1 -
 arch/openrisc/include/uapi/asm/Kbuild    | 1 -
 arch/parisc/include/uapi/asm/Kbuild      | 1 -
 arch/riscv/include/asm/Kbuild            | 1 -
 arch/s390/include/uapi/asm/kvm_para.h    | 8 --------
 arch/sh/include/uapi/asm/Kbuild          | 1 -
 arch/sparc/include/uapi/asm/kvm_para.h   | 2 --
 arch/unicore32/include/uapi/asm/Kbuild   | 1 -
 arch/xtensa/include/uapi/asm/Kbuild      | 1 -
 include/uapi/asm-generic/Kbuild.asm      | 1 +
 include/uapi/linux/Kbuild                | 4 ----
 24 files changed, 1 insertion(+), 42 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/arm/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/hexagon/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/mips/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/s390/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/sparc/include/uapi/asm/kvm_para.h

diff --git a/arch/alpha/include/uapi/asm/kvm_para.h b/arch/alpha/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/alpha/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/arm/include/uapi/asm/kvm_para.h b/arch/arm/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/arm/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 87eea29..75f3651 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -1,4 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
 include include/uapi/asm-generic/Kbuild.asm
-
-generic-y += kvm_para.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 2a0abe8..aa2edd3 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -23,7 +23,6 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
-generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/uapi/asm/kvm_para.h b/arch/hexagon/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/hexagon/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index 5b819e5..1d5c4aa 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_64.h
-generic-y += kvm_para.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 960bf1e..439f515 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += kvm_para.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 97823ec..3f03cf6 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/mips/include/uapi/asm/kvm_para.h b/arch/mips/include/uapi/asm/kvm_para.h
deleted file mode 100644
index 7e16d7c..0000000
--- a/arch/mips/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifndef _UAPI_ASM_MIPS_KVM_PARA_H
-#define _UAPI_ASM_MIPS_KVM_PARA_H
-
-
-#endif /* _UAPI_ASM_MIPS_KVM_PARA_H */
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 64ceff7..419f312 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -26,7 +26,6 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
-generic-y += kvm_para.h
 generic-y += limits.h
 generic-y += local.h
 generic-y += local64.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index c54353d..214a39a 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -2,4 +2,3 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generated-y += unistd_64.h
-generic-y += kvm_para.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index cccd12c..6811466 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -17,7 +17,6 @@ generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
-generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/s390/include/uapi/asm/kvm_para.h b/arch/s390/include/uapi/asm/kvm_para.h
deleted file mode 100644
index b9ab584..0000000
--- a/arch/s390/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- * User API definitions for paravirtual devices on s390
- *
- * Copyright IBM Corp. 2008
- *
- *    Author(s): Christian Borntraeger <borntraeger@de.ibm.com>
- */
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index eaa30bc..0ec45ff 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -2,5 +2,4 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/sparc/include/uapi/asm/kvm_para.h b/arch/sparc/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/sparc/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 0febf1a..c1b06dc 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index 960bf1e..439f515 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,4 +1,3 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
-generic-y += kvm_para.h
diff --git a/include/uapi/asm-generic/Kbuild.asm b/include/uapi/asm-generic/Kbuild.asm
index 355c4ac..8103ee6 100644
--- a/include/uapi/asm-generic/Kbuild.asm
+++ b/include/uapi/asm-generic/Kbuild.asm
@@ -10,6 +10,7 @@ mandatory-y += fcntl.h
 mandatory-y += ioctl.h
 mandatory-y += ioctls.h
 mandatory-y += ipcbuf.h
+mandatory-y += kvm_para.h
 mandatory-y += mman.h
 mandatory-y += msgbuf.h
 mandatory-y += param.h
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index 5f24b50..f4f5702 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -5,7 +5,3 @@ endif
 ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/uapi/asm/kvm.h),)
 no-export-headers += kvm.h
 endif
-
-ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/uapi/asm/kvm_para.h),)
-no-export-headers += kvm_para.h
-endif
-- 
2.7.4
