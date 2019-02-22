Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39094 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVSum (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 22 Feb 2019 13:50:42 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [RFC PATCH 02/20] arch: Use asm-generic header for asm/mmiowb.h
Date: Fri, 22 Feb 2019 18:50:08 +0000
Message-ID: <20190222185026.10973-3-will.deacon@arm.com>
In-Reply-To: <20190222185026.10973-1-will.deacon@arm.com>
References: <20190222185026.10973-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, Andrea Parri <andrea.parri@amarulasolutions.com>, Palmer Dabbelt <palmer@sifive.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, Linus Torvalds <torvalds@linux-foundation.org>, "Maciej W. Rozycki" <macro@linux-mips.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Tony Luck <tony.luck@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>
Message-ID: <20190222185008.5lAFWxzjW6_TYgbpV7RbvmHqXzF56drwFM1yJmHDM84@z>

Hook up asm-generic/mmiowb.h to Kbuild for all architectures so that we
can subsequently include asm/mmiowb.h from core code.

Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/alpha/include/asm/Kbuild      | 1 +
 arch/arc/include/asm/Kbuild        | 1 +
 arch/arm/include/asm/Kbuild        | 1 +
 arch/arm64/include/asm/Kbuild      | 1 +
 arch/c6x/include/asm/Kbuild        | 1 +
 arch/csky/include/asm/Kbuild       | 1 +
 arch/h8300/include/asm/Kbuild      | 1 +
 arch/hexagon/include/asm/Kbuild    | 1 +
 arch/ia64/include/asm/Kbuild       | 1 +
 arch/m68k/include/asm/Kbuild       | 1 +
 arch/microblaze/include/asm/Kbuild | 1 +
 arch/mips/include/asm/Kbuild       | 1 +
 arch/nds32/include/asm/Kbuild      | 1 +
 arch/nios2/include/asm/Kbuild      | 1 +
 arch/openrisc/include/asm/Kbuild   | 1 +
 arch/parisc/include/asm/Kbuild     | 1 +
 arch/powerpc/include/asm/Kbuild    | 1 +
 arch/riscv/include/asm/Kbuild      | 1 +
 arch/s390/include/asm/Kbuild       | 1 +
 arch/sh/include/asm/Kbuild         | 1 +
 arch/sparc/include/asm/Kbuild      | 1 +
 arch/um/include/asm/Kbuild         | 1 +
 arch/unicore32/include/asm/Kbuild  | 1 +
 arch/xtensa/include/asm/Kbuild     | 1 +
 24 files changed, 24 insertions(+)

diff --git a/arch/alpha/include/asm/Kbuild b/arch/alpha/include/asm/Kbuild
index dc0ab28baca1..2b4b2fe715bb 100644
--- a/arch/alpha/include/asm/Kbuild
+++ b/arch/alpha/include/asm/Kbuild
@@ -8,6 +8,7 @@ generic-y += fb.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += preempt.h
 generic-y += sections.h
 generic-y += trace_clock.h
diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
index caa270261521..138f564afc74 100644
--- a/arch/arc/include/asm/Kbuild
+++ b/arch/arc/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 1d66db9c9db5..ee6d155ca372 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -9,6 +9,7 @@ generic-y += kdebug.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += msi.h
 generic-y += parport.h
 generic-y += preempt.h
diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index 1e17ea5c372b..3dae4fd028cf 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += msi.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index 63b4a1705182..fda53087eabc 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -22,6 +22,7 @@ generic-y += kprobes.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += mmu.h
 generic-y += mmu_context.h
 generic-y += pci.h
diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 2a0abe8f2a35..95f4e550db8a 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -28,6 +28,7 @@ generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += module.h
 generic-y += mutex.h
 generic-y += pci.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 961c1dc064e1..86ad35d93861 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -29,6 +29,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += mmu.h
 generic-y += mmu_context.h
 generic-y += module.h
diff --git a/arch/hexagon/include/asm/Kbuild b/arch/hexagon/include/asm/Kbuild
index b25fd42aa0f4..ff9134a01a13 100644
--- a/arch/hexagon/include/asm/Kbuild
+++ b/arch/hexagon/include/asm/Kbuild
@@ -23,6 +23,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/ia64/include/asm/Kbuild b/arch/ia64/include/asm/Kbuild
index 43e21fe3499c..3273d7aedfa0 100644
--- a/arch/ia64/include/asm/Kbuild
+++ b/arch/ia64/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += exec.h
 generic-y += irq_work.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += preempt.h
 generic-y += trace_clock.h
 generic-y += vtime.h
diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 95f8f631c4df..2add40f9fdef 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -17,6 +17,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += sections.h
diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 791cc8d54d0a..a1138bb6c5df 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -22,6 +22,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index f15d5db5dd67..5653b1e47dd0 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += msi.h
 generic-y += parport.h
 generic-y += percpu.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 64ceff7ab99b..688b6ed26227 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -31,6 +31,7 @@ generic-y += limits.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += parport.h
 generic-y += pci.h
 generic-y += percpu.h
diff --git a/arch/nios2/include/asm/Kbuild b/arch/nios2/include/asm/Kbuild
index 8fde4fa2c34f..139357327a77 100644
--- a/arch/nios2/include/asm/Kbuild
+++ b/arch/nios2/include/asm/Kbuild
@@ -26,6 +26,7 @@ generic-y += kprobes.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += module.h
 generic-y += pci.h
 generic-y += percpu.h
diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index 1f04844b6b82..a2883689039a 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -24,6 +24,7 @@ generic-y += kprobes.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += module.h
 generic-y += pci.h
 generic-y += percpu.h
diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index 0b1e354c8c24..eb8b20f95751 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -16,6 +16,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += seccomp.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index 77ff7fb24823..57bd1f6660f4 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -8,6 +8,7 @@ generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
+generic-y += mmiowb.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += vtime.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index cccd12cf27d4..221cd2ec78a4 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -21,6 +21,7 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += mutex.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index e3239772887a..68ac5b05c125 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += preempt.h
 generic-y += rwsem.h
 generic-y += trace_clock.h
diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index a6ef3fee5f85..e3f6926c4b86 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index b82f64e28f55..b29a4551a8f2 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -14,6 +14,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += module.h
 generic-y += msi.h
 generic-y += preempt.h
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 00bcbe2326d9..b506ad06aefc 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -16,6 +16,7 @@ generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += param.h
 generic-y += pci.h
 generic-y += percpu.h
diff --git a/arch/unicore32/include/asm/Kbuild b/arch/unicore32/include/asm/Kbuild
index 1d1544b6ca74..288ccd741ff2 100644
--- a/arch/unicore32/include/asm/Kbuild
+++ b/arch/unicore32/include/asm/Kbuild
@@ -21,6 +21,7 @@ generic-y += kprobes.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += module.h
 generic-y += parport.h
 generic-y += percpu.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index e255683cd520..e5bb2514ade0 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -20,6 +20,7 @@ generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
+generic-y += mmiowb.h
 generic-y += param.h
 generic-y += percpu.h
 generic-y += preempt.h
-- 
2.11.0
