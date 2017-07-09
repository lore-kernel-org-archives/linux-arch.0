From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 09/28] cris: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 10 Jul 2017 03:32:41 +0900
Message-ID: <1499625180-8067-10-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kbuild-owner@vger.kernel.org
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

Also, move "generic-y += kprobes.h", "generic-y += emergency-restart.h"
up in order to keep the entries sorted.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/cris/include/asm/Kbuild      | 21 ++-------------------
 arch/cris/include/uapi/asm/Kbuild | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/cris/include/asm/Kbuild b/arch/cris/include/asm/Kbuild
index acc5781100c2..460349cb147f 100644
--- a/arch/cris/include/asm/Kbuild
+++ b/arch/cris/include/asm/Kbuild
@@ -1,48 +1,31 @@
 generic-y += atomic.h
-generic-y += auxvec.h
 generic-y += barrier.h
-generic-y += bitsperlong.h
 generic-y += clkdev.h
 generic-y += cmpxchg.h
 generic-y += current.h
 generic-y += device.h
 generic-y += div64.h
-generic-y += errno.h
+generic-y += emergency-restart.h
 generic-y += exec.h
 generic-y += extable.h
-generic-y += emergency-restart.h
-generic-y += fcntl.h
 generic-y += futex.h
 generic-y += hardirq.h
-generic-y += ioctl.h
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
 generic-y += module.h
-generic-y += msgbuf.h
 generic-y += percpu.h
-generic-y += poll.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += sections.h
-generic-y += sembuf.h
-generic-y += shmbuf.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += statfs.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
-generic-y += kprobes.h
diff --git a/arch/cris/include/uapi/asm/Kbuild b/arch/cris/include/uapi/asm/Kbuild
index b55fc2ae1e8c..3687b54bb18e 100644
--- a/arch/cris/include/uapi/asm/Kbuild
+++ b/arch/cris/include/uapi/asm/Kbuild
@@ -1,4 +1,21 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += auxvec.h
+generic-y += bitsperlong.h
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ipcbuf.h
+generic-y += kvm_para.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += poll.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
 generic-y += siginfo.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += statfs.h
+generic-y += types.h
-- 
2.7.4

