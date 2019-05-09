Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-07.nifty.com ([210.131.2.74]:20772 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfEIIBS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 May 2019 04:01:18 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] arch: remove dangling asm-generic wrappers
Date: Thu,  9 May 2019 16:59:34 +0900
Message-ID: <20190509075934.12185-1-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Greentime Hu <green.hu@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Vincent Chen <deanbo422@gmail.com>, Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, Max Filippov <jcmvbkbc@gmail.com>, Albert Ou <aou@eecs.berkeley.edu>
Message-ID: <20190509075934.S8wAO0ClrYkL8hxGisW2XRCpZr6lituYn3TFxiilXBs@z>

These generic-y defines do not have the corresponding generic header
in include/asm-generic/, so they are definitely invalid.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/csky/include/asm/Kbuild   | 4 ----
 arch/h8300/include/asm/Kbuild  | 1 -
 arch/nds32/include/asm/Kbuild  | 3 ---
 arch/riscv/include/asm/Kbuild  | 4 ----
 arch/xtensa/include/asm/Kbuild | 1 -
 5 files changed, 13 deletions(-)

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index a9b63efef416..c1a6c0f31150 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -1,6 +1,5 @@
 generic-y += asm-offsets.h
 generic-y += bugs.h
-generic-y += clkdev.h
 generic-y += compat.h
 generic-y += current.h
 generic-y += delay.h
@@ -29,15 +28,12 @@ generic-y += local64.h
 generic-y += mm-arch-hooks.h
 generic-y += mmiowb.h
 generic-y += module.h
-generic-y += mutex.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += qrwlock.h
-generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += serial.h
-generic-y += shm.h
 generic-y += timex.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 123d8f54be4a..63e5ab115e3c 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -38,7 +38,6 @@ generic-y += pci.h
 generic-y += percpu.h
 generic-y += pgalloc.h
 generic-y += preempt.h
-generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += serial.h
 generic-y += shmparam.h
diff --git a/arch/nds32/include/asm/Kbuild b/arch/nds32/include/asm/Kbuild
index 5bd2b4ee951f..6897045e7be5 100644
--- a/arch/nds32/include/asm/Kbuild
+++ b/arch/nds32/include/asm/Kbuild
@@ -4,10 +4,8 @@ generic-y += bitops.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += checksum.h
-generic-y += clkdev.h
 generic-y += cmpxchg.h
 generic-y += compat.h
-generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
@@ -26,7 +24,6 @@ generic-y += kdebug.h
 generic-y += kmap_types.h
 generic-y += kprobes.h
 generic-y += kvm_para.h
-generic-y += limits.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index cccd12cf27d4..f86d68dabaf0 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -1,7 +1,6 @@
 generic-y += bugs.h
 generic-y += checksum.h
 generic-y += compat.h
-generic-y += cputime.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
@@ -11,7 +10,6 @@ generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += fb.h
 generic-y += hardirq.h
-generic-y += hash.h
 generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
@@ -21,10 +19,8 @@ generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
-generic-y += mutex.h
 generic-y += percpu.h
 generic-y += preempt.h
-generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += serial.h
 generic-y += shmparam.h
diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index 35f83c4bf239..f1686d919178 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -27,7 +27,6 @@ generic-y += preempt.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += sections.h
-generic-y += socket.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += vga.h
-- 
2.17.1
