From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 04/27] arm64: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:26:58 +0900
Message-ID: <1497238041-7011-5-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), all (and only) headers under uapi directories are
exported, but asm-generic wrappers are still exceptions.

scripts/Makefile.headersinst still need to deal with old-kbuild-file
for headers listed in arch/*/include/asm/Kbuild, but actually exported.

As the last work to finish de-coupling the uapi from kernel headers,
move generic-y of exported headers to uapi/asm/Kbuild.

For arm64, "generic-y += kvm_para.h" is doubled in asm/Kbuild and
uapi/asm/Kbuild.  So, the one in the former can be simply removed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/include/asm/Kbuild      | 17 -----------------
 arch/arm64/include/uapi/asm/Kbuild | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index a7a97a608033..f81c7b685fc6 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -6,41 +6,24 @@ generic-y += dma.h
 generic-y += dma-contiguous.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += hw_irq.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
-generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mman.h
-generic-y += msgbuf.h
 generic-y += msi.h
-generic-y += poll.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += rwsem.h
 generic-y += segment.h
-generic-y += sembuf.h
 generic-y += serial.h
 generic-y += set_memory.h
-generic-y += shmbuf.h
 generic-y += simd.h
 generic-y += sizes.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += swab.h
 generic-y += switch_to.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += unaligned.h
 generic-y += user.h
 generic-y += vga.h
diff --git a/arch/arm64/include/uapi/asm/Kbuild b/arch/arm64/include/uapi/asm/Kbuild
index 13a97aa2285f..fc28bd95c6d3 100644
--- a/arch/arm64/include/uapi/asm/Kbuild
+++ b/arch/arm64/include/uapi/asm/Kbuild
@@ -1,4 +1,20 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += errno.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
 generic-y += kvm_para.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += poll.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += swab.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += types.h
-- 
2.7.4
