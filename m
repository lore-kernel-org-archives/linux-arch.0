Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-12.nifty.com ([210.131.2.79]:59182 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfCRJJI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Mar 2019 05:09:08 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2] KVM: export <linux/kvm_para.h> and <asm/kvm_para.h> iif KVM is supported
Date: Mon, 18 Mar 2019 18:08:12 +0900
Message-Id: <1552900092-14294-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=8F=AB=ADm=8F=AB=A1=8F=AB=DA?= <rkrcmar@redhat.com>, kvm@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Joerg Roedel <joro@8bytes.org>, Christoffer Dall <christoffer.dall@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, James Morse <james.morse@arm.com>, kvm-ppc@vger.kernel.org, James Hogan <jhogan@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

I do not see any consistency about headers_install of <linux/kvm_para.h>
and <asm/kvm_para.h>.

According to my analysis of Linux 5.1-rc1, there are 3 groups:

 [1] Both <linux/kvm_para.h> and <asm/kvm_para.h> are exported

    alpha, arm, hexagon, mips, powerpc, s390, sparc, x86

 [2] <asm/kvm_para.h> is exported, but <linux/kvm_para.h> is not

    arc, arm64, c6x, h8300, ia64, m68k, microblaze, nios2, openrisc,
    parisc, sh, unicore32, xtensa

 [3] Neither <linux/kvm_para.h> nor <asm/kvm_para.h> is exported

    csky, nds32, riscv

This does not match to the actual KVM support. At least, [2] is
half-baked.

Nor do arch maintainers look like they care about this. For example,
commit 0add53713b1c ("microblaze: Add missing kvm_para.h to Kbuild")
exported <asm/kvm_para.h> to user-space in order to fix an in-kernel
build error.

We have two ways to make this consistent:

 [A] export both <linux/kvm_para.h> and <asm/kvm_para.h> for all
     architectures, irrespective of the KVM support

 [B] Match the header export of <linux/kvm_para.h> and <asm/kvm_para.h>
     to the KVM support

My first attempt was [A] because the code looks cleaner, but Paolo
suggested [B].

So, this commit goes with [B].

For most architectures, <asm/kvm_para.h> was moved to the kernel-space.
I changed include/uapi/linux/Kbuild so that it checks generated
asm/kvm_para.h as well as check-in ones.

After this commit, there will be two groups:

 [1] Both <linux/kvm_para.h> and <asm/kvm_para.h> are exported

    arm, arm64, mips, powerpc, s390, x86

 [2] Neither <linux/kvm_para.h> nor <asm/kvm_para.h> is exported

    alpha, arc, c6x, csky, h8300, hexagon, ia64, m68k, microblaze,
    nds32, nios2, openrisc, parisc, riscv, sh, sparc, unicore32, xtensa

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---

Changes in v2:
 - Fix build error for mips and s390
 - Rebase on top of v5.1-rc1
 - Correct my anylisis of v5.1-rc1

 arch/alpha/include/asm/Kbuild            | 1 +
 arch/alpha/include/uapi/asm/kvm_para.h   | 2 --
 arch/arc/include/asm/Kbuild              | 1 +
 arch/arc/include/uapi/asm/Kbuild         | 1 -
 arch/arm/include/uapi/asm/Kbuild         | 1 +
 arch/arm/include/uapi/asm/kvm_para.h     | 2 --
 arch/c6x/include/asm/Kbuild              | 1 +
 arch/c6x/include/uapi/asm/Kbuild         | 1 -
 arch/h8300/include/asm/Kbuild            | 1 +
 arch/h8300/include/uapi/asm/Kbuild       | 1 -
 arch/hexagon/include/asm/Kbuild          | 1 +
 arch/hexagon/include/uapi/asm/kvm_para.h | 2 --
 arch/ia64/include/asm/Kbuild             | 1 +
 arch/ia64/include/uapi/asm/Kbuild        | 1 -
 arch/m68k/include/asm/Kbuild             | 1 +
 arch/m68k/include/uapi/asm/Kbuild        | 1 -
 arch/microblaze/include/asm/Kbuild       | 1 +
 arch/microblaze/include/uapi/asm/Kbuild  | 1 -
 arch/nios2/include/asm/Kbuild            | 1 +
 arch/nios2/include/uapi/asm/Kbuild       | 1 -
 arch/openrisc/include/asm/Kbuild         | 1 +
 arch/openrisc/include/uapi/asm/Kbuild    | 1 -
 arch/parisc/include/asm/Kbuild           | 1 +
 arch/parisc/include/uapi/asm/Kbuild      | 1 -
 arch/sh/include/asm/Kbuild               | 1 +
 arch/sh/include/uapi/asm/Kbuild          | 1 -
 arch/sparc/include/asm/Kbuild            | 1 +
 arch/sparc/include/uapi/asm/kvm_para.h   | 2 --
 arch/unicore32/include/asm/Kbuild        | 1 +
 arch/unicore32/include/uapi/asm/Kbuild   | 1 -
 arch/xtensa/include/asm/Kbuild           | 1 +
 arch/xtensa/include/uapi/asm/Kbuild      | 1 -
 include/uapi/linux/Kbuild                | 2 ++
 33 files changed, 18 insertions(+), 20 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/arm/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/hexagon/include/uapi/asm/kvm_para.h
 delete mode 100644 arch/sparc/include/uapi/asm/kvm_para.h

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index dc0ab28..70b7833 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += exec.h
 generic-y += export.h
 generic-y += fb.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += preempt.h
diff --git a/arch/alpha/include/uapi/asm/kvm_para.h b/arch/alpha/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/alpha/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index b41f888..decc306 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -11,6 +11,7 @@ generic-y += hardirq.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/arc/include/uapi/asm/Kbuild b/arch/arc/include/uapi/asm/Kbuild
index 755bb11..1c72f04 100644
--- a/arch/arc/include/uapi/asm/Kbuild
+++ b/arch/arc/include/uapi/asm/Kbuild
@@ -1,2 +1 @@
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 23b4464..ce85731 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -3,3 +3,4 @@
 generated-y += unistd-common.h
 generated-y += unistd-oabi.h
 generated-y += unistd-eabi.h
+generic-y += kvm_para.h
diff --git a/arch/arm/include/uapi/asm/kvm_para.h b/arch/arm/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/arm/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 63b4a17..249c9f6 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -19,6 +19,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 755bb11..1c72f04 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,2 +1 @@
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 848acb1..ffda689 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -23,6 +23,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index 755bb11..1c72f04 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,2 +1 @@
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index b25fd42..d046e8c 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -19,6 +19,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/hexagon/include/uapi/asm/kvm_para.h b/arch/hexagon/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/hexagon/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 43e21fe..11f1916 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -2,6 +2,7 @@ generated-y += syscall_table.h
 generic-y += compat.h
 generic-y += exec.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += preempt.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index 20018cb..62a9522 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -1,2 +1 @@
 generated-y += unistd_64.h
-generic-y += kvm_para.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 95f8f63..2c359d9 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 8a7ad40..7417847 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -1,2 +1 @@
 generated-y += unistd_32.h
-generic-y += kvm_para.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 791cc8d5..1a8285c 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -17,6 +17,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index 3ce84fb..13f5963 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,3 +1,2 @@
 generated-y += unistd_32.h
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 8fde4fa..88a667d 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -23,6 +23,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
index 755bb11..1c72f04 100644
--- a/arch/nios2/include/uapi/asm/Kbuild
+++ b/arch/nios2/include/uapi/asm/Kbuild
@@ -1,2 +1 @@
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 5a73e29..22aa971 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index 755bb11..1c72f04 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,2 +1 @@
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 6f49e77..9bcd0c9 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -11,6 +11,7 @@ generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/parisc/include/uapi/asm/Kbuild b/arch/parisc/include/uapi/asm/Kbuild
index 22fdbd0..2bd5b39 100644
--- a/arch/parisc/include/uapi/asm/Kbuild
+++ b/arch/parisc/include/uapi/asm/Kbuild
@@ -1,3 +1,2 @@
 generated-y += unistd_32.h
 generated-y += unistd_64.h
-generic-y += kvm_para.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index a6ef3fe..7bf2cb6 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index ecfbd40..b8812c7 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
 
 generated-y += unistd_32.h
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index b82f64e..a22cfd5 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += exec.h
 generic-y += export.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
+generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
diff --git a/arch/sparc/include/uapi/asm/kvm_para.h b/arch/sparc/include/uapi/asm/kvm_para.h
deleted file mode 100644
index baacc49..0000000
--- a/arch/sparc/include/uapi/asm/kvm_para.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#include <asm-generic/kvm_para.h>
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 1d1544b..d77d953 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -18,6 +18,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/unicore32/include/uapi/asm/Kbuild b/arch/unicore32/include/uapi/asm/Kbuild
index 755bb11..1c72f04 100644
--- a/arch/unicore32/include/uapi/asm/Kbuild
+++ b/arch/unicore32/include/uapi/asm/Kbuild
@@ -1,2 +1 @@
-generic-y += kvm_para.h
 generic-y += ucontext.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 8b90466..d632108 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -15,6 +15,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
+generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index 8a7ad40..7417847 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,2 +1 @@
 generated-y += unistd_32.h
-generic-y += kvm_para.h
diff --git a/include/uapi/linux/Kbuild b/include/uapi/linux/Kbuild
index 5f24b50..059dc2b 100644
--- a/include/uapi/linux/Kbuild
+++ b/include/uapi/linux/Kbuild
@@ -7,5 +7,7 @@ no-export-headers += kvm.h
 endif
 
 ifeq ($(wildcard $(srctree)/arch/$(SRCARCH)/include/uapi/asm/kvm_para.h),)
+ifeq ($(wildcard $(objtree)/arch/$(SRCARCH)/include/generated/uapi/asm/kvm_para.h),)
 no-export-headers += kvm_para.h
 endif
+endif
-- 
2.7.4
