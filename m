Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-12.nifty.com ([210.131.2.79]:65084 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfCQCCB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Mar 2019 22:02:01 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] kbuild: warn redundant generic-y
Date: Sun, 17 Mar 2019 11:01:08 +0900
Message-Id: <1552788069-26557-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>

The generic-y is redundant under the following condition:

 - arch has its own implementation

 - the same header is added to generated-y

 - the same header is added to mandatory-y

If a redundant generic-y is found, the warning like follows is displayed:

  scripts/Makefile.asm-generic:20: redundant generic-y found in arch/arm/include/asm/Kbuild: timex.h

I fixed up arch Kbuild files found by this.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/Kbuild         | 1 -
 arch/h8300/include/asm/Kbuild       | 1 -
 arch/ia64/include/uapi/asm/Kbuild   | 1 -
 arch/openrisc/include/asm/Kbuild    | 2 --
 arch/parisc/include/asm/Kbuild      | 2 --
 arch/powerpc/include/asm/Kbuild     | 1 -
 arch/s390/include/asm/Kbuild        | 1 -
 arch/s390/include/uapi/asm/Kbuild   | 1 -
 arch/x86/include/uapi/asm/Kbuild    | 1 -
 arch/xtensa/include/asm/Kbuild      | 1 -
 arch/xtensa/include/uapi/asm/Kbuild | 1 -
 scripts/Makefile.asm-generic        | 6 ++++++
 12 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 1d66db9..a8a4eb7 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -18,7 +18,6 @@ generic-y += segment.h
 generic-y += serial.h
 generic-y += simd.h
 generic-y += sizes.h
-generic-y += timex.h
 generic-y += trace_clock.h
 
 generated-y += mach-types.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 961c1dc..3e7c8ec 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -17,7 +17,6 @@ generic-y += fb.h
 generic-y += ftrace.h
 generic-y += futex.h
 generic-y += hardirq.h
-generic-y += hash.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
diff --git a/arch/ia64/include/uapi/asm/Kbuild b/arch/ia64/include/uapi/asm/Kbuild
index b71c5f7..5b819e5 100644
--- a/arch/ia64/include/uapi/asm/Kbuild
+++ b/arch/ia64/include/uapi/asm/Kbuild
@@ -2,4 +2,3 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_64.h
 generic-y += kvm_para.h
-generic-y += socket.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 1f04844b..5a73e29 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -15,7 +15,6 @@ generic-y += fb.h
 generic-y += ftrace.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
-generic-y += irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
@@ -35,7 +34,6 @@ generic-y += qrwlock.h
 generic-y += sections.h
 generic-y += segment.h
 generic-y += shmparam.h
-generic-y += string.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 0b1e354..6f49e77 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -1,7 +1,6 @@
 generated-y += syscall_table_32.h
 generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
-generic-y += barrier.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
@@ -20,7 +19,6 @@ generic-y += percpu.h
 generic-y += preempt.h
 generic-y += seccomp.h
 generic-y += segment.h
-generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += user.h
 generic-y += vga.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 77ff7fb..a0c132b 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -5,7 +5,6 @@ generated-y += syscall_table_spu.h
 generic-y += div64.h
 generic-y += export.h
 generic-y += irq_regs.h
-generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += preempt.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index e323977..12d77cb 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -20,7 +20,6 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
diff --git a/arch/s390/include/uapi/asm/Kbuild b/arch/s390/include/uapi/asm/Kbuild
index 6b0f30b..da3e0d4 100644
--- a/arch/s390/include/uapi/asm/Kbuild
+++ b/arch/s390/include/uapi/asm/Kbuild
@@ -3,4 +3,3 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generated-y += unistd_64.h
-generic-y += socket.h
diff --git a/arch/x86/include/uapi/asm/Kbuild b/arch/x86/include/uapi/asm/Kbuild
index efe701b..f6648e9 100644
--- a/arch/x86/include/uapi/asm/Kbuild
+++ b/arch/x86/include/uapi/asm/Kbuild
@@ -3,4 +3,3 @@ include include/uapi/asm-generic/Kbuild.asm
 generated-y += unistd_32.h
 generated-y += unistd_64.h
 generated-y += unistd_x32.h
-generic-y += socket.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index d939e13..42b6cb3 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -15,7 +15,6 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
-generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index 6b43e50..960bf1e 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -2,4 +2,3 @@ include include/uapi/asm-generic/Kbuild.asm
 
 generated-y += unistd_32.h
 generic-y += kvm_para.h
-generic-y += socket.h
diff --git a/scripts/Makefile.asm-generic b/scripts/Makefile.asm-generic
index a62d282..c7d2b7a 100644
--- a/scripts/Makefile.asm-generic
+++ b/scripts/Makefile.asm-generic
@@ -14,6 +14,12 @@ src := $(subst /generated,,$(obj))
 
 include scripts/Kbuild.include
 
+redundant := $(filter $(mandatory-y) $(generated-y), $(generic-y))
+redundant += $(foreach f, $(generic-y), $(if $(wildcard $(srctree)/$(src)/$(f)),$(f)))
+redundant := $(sort $(redundant))
+$(if $(redundant),\
+	$(warning redundant generic-y found in $(src)/Kbuild: $(redundant)))
+
 # If arch does not implement mandatory headers, fallback to asm-generic ones.
 mandatory-y := $(filter-out $(generated-y), $(mandatory-y))
 generic-y   += $(foreach f, $(mandatory-y), $(if $(wildcard $(srctree)/$(src)/$(f)),,$(f)))
-- 
2.7.4
