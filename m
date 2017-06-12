From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 08/27] c6x: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:27:02 +0900
Message-ID: <1497238041-7011-9-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, linux-c6x-dev@linux-c6x.org
List-Id: linux-arch.vger.kernel.org

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), all (and only) headers under uapi directories are
exported, but asm-generic wrappers are still exceptions.

scripts/Makefile.headersinst still need to deal with old-kbuild-file
for headers listed in arch/*/include/asm/Kbuild, but actually exported.

As the last work to finish de-coupling the uapi from kernel headers,
move generic-y of exported headers to uapi/asm/Kbuild.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/c6x/include/asm/Kbuild      | 27 ---------------------------
 arch/c6x/include/uapi/asm/Kbuild | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/arch/c6x/include/asm/Kbuild b/arch/c6x/include/asm/Kbuild
index f0eaf0475e7e..7c971e182b35 100644
--- a/arch/c6x/include/asm/Kbuild
+++ b/arch/c6x/include/asm/Kbuild
@@ -1,8 +1,5 @@
-
 generic-y += atomic.h
-generic-y += auxvec.h
 generic-y += barrier.h
-generic-y += bitsperlong.h
 generic-y += bugs.h
 generic-y += clkdev.h
 generic-y += current.h
@@ -10,17 +7,12 @@ generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += fb.h
-generic-y += fcntl.h
 generic-y += futex.h
 generic-y += hw_irq.h
 generic-y += io.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
@@ -28,36 +20,17 @@ generic-y += kmap_types.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mman.h
 generic-y += mmu.h
 generic-y += mmu_context.h
-generic-y += msgbuf.h
-generic-y += param.h
 generic-y += pci.h
 generic-y += percpu.h
 generic-y += pgalloc.h
-generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += segment.h
-generic-y += sembuf.h
 generic-y += serial.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += tlbflush.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += types.h
-generic-y += ucontext.h
 generic-y += user.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
diff --git a/arch/c6x/include/uapi/asm/Kbuild b/arch/c6x/include/uapi/asm/Kbuild
index 13a97aa2285f..67ee896a76a7 100644
--- a/arch/c6x/include/uapi/asm/Kbuild
+++ b/arch/c6x/include/uapi/asm/Kbuild
@@ -1,4 +1,30 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += auxvec.h
+generic-y += bitsperlong.h
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
 generic-y += kvm_para.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
+generic-y += siginfo.h
+generic-y += signal.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += types.h
+generic-y += ucontext.h
-- 
2.7.4
