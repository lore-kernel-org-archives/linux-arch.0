From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 10/28] h8300: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 10 Jul 2017 03:32:42 +0900
Message-ID: <1499625180-8067-11-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), all (and only) headers under uapi directories are
exported, but asm-generic wrappers are still exceptions.

To complete de-coupling the uapi from kernel headers, move generic-y
of exported headers to uapi/asm/Kbuild.

With this change, "make headers_install" will just need to parse
uapi/asm/Kbuild to build up exported headers.

Also, move "generic-y += kprobes.h" and "generic-y += trace_clock.h"
in order to keep the entries sorted.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/h8300/include/asm/Kbuild      | 30 ++----------------------------
 arch/h8300/include/uapi/asm/Kbuild | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index 99c824608a31..bc077491d299 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -1,5 +1,4 @@
 generic-y += asm-offsets.h
-generic-y += auxvec.h
 generic-y += barrier.h
 generic-y += bugs.h
 generic-y += cacheflush.h
@@ -11,66 +10,41 @@ generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += fb.h
-generic-y += fcntl.h
 generic-y += ftrace.h
 generic-y += futex.h
 generic-y += hardirq.h
 generic-y += hash.h
 generic-y += hw_irq.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
-generic-y += kvm_para.h
+generic-y += kprobes.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mman.h
 generic-y += mmu.h
 generic-y += mmu_context.h
 generic-y += module.h
-generic-y += msgbuf.h
-generic-y += param.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += pgalloc.h
-generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += scatterlist.h
 generic-y += sections.h
-generic-y += sembuf.h
 generic-y += serial.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
 generic-y += sizes.h
-generic-y += socket.h
-generic-y += sockios.h
 generic-y += spinlock.h
-generic-y += stat.h
-generic-y += statfs.h
-generic-y += swab.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += timex.h
 generic-y += tlbflush.h
-generic-y += trace_clock.h
 generic-y += topology.h
-generic-y += types.h
-generic-y += ucontext.h
+generic-y += trace_clock.h
 generic-y += unaligned.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
-generic-y += kprobes.h
diff --git a/arch/h8300/include/uapi/asm/Kbuild b/arch/h8300/include/uapi/asm/Kbuild
index b55fc2ae1e8c..187aed820e71 100644
--- a/arch/h8300/include/uapi/asm/Kbuild
+++ b/arch/h8300/include/uapi/asm/Kbuild
@@ -1,4 +1,30 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += auxvec.h
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += kvm_para.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += setup.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
 generic-y += siginfo.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += stat.h
+generic-y += statfs.h
+generic-y += swab.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += types.h
+generic-y += ucontext.h
-- 
2.7.4
