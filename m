From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 18/27] openrisc: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:27:12 +0900
Message-ID: <1497238041-7011-19-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, linux-kernel@vger.kernel.org
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

 arch/openrisc/include/asm/Kbuild      | 28 ----------------------------
 arch/openrisc/include/uapi/asm/Kbuild | 29 +++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/openrisc/include/asm/Kbuild b/arch/openrisc/include/asm/Kbuild
index fdbcf0bf44a4..5e209fcd9a54 100644
--- a/arch/openrisc/include/asm/Kbuild
+++ b/arch/openrisc/include/asm/Kbuild
@@ -1,6 +1,4 @@
-generic-y += auxvec.h
 generic-y += barrier.h
-generic-y += bitsperlong.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += cacheflush.h
@@ -11,56 +9,30 @@ generic-y += device.h
 generic-y += div64.h
 generic-y += dma.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += fb.h
-generic-y += fcntl.h
 generic-y += ftrace.h
 generic-y += hardirq.h
 generic-y += hw_irq.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
-generic-y += kvm_para.h
 generic-y += local.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mman.h
 generic-y += module.h
-generic-y += msgbuf.h
 generic-y += pci.h
 generic-y += percpu.h
-generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += sections.h
 generic-y += segment.h
-generic-y += sembuf.h
-generic-y += setup.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += siginfo.h
-generic-y += signal.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += stat.h
-generic-y += statfs.h
 generic-y += string.h
-generic-y += swab.h
 generic-y += switch_to.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += types.h
-generic-y += ucontext.h
 generic-y += user.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
diff --git a/arch/openrisc/include/uapi/asm/Kbuild b/arch/openrisc/include/uapi/asm/Kbuild
index b15bf6bc0e94..62286dbeb904 100644
--- a/arch/openrisc/include/uapi/asm/Kbuild
+++ b/arch/openrisc/include/uapi/asm/Kbuild
@@ -1,2 +1,31 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
+
+generic-y += auxvec.h
+generic-y += bitsperlong.h
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += kvm_para.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += setup.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
+generic-y += siginfo.h
+generic-y += signal.h
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
