From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 20/27] sh: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:27:14 +0900
Message-ID: <1497238041-7011-21-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
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

 arch/sh/include/asm/Kbuild      | 20 --------------------
 arch/sh/include/uapi/asm/Kbuild | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index cf2a75063b53..1a6f9c39feef 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,40 +1,20 @@
-
-generic-y += bitsperlong.h
 generic-y += clkdev.h
 generic-y += current.h
 generic-y += delay.h
 generic-y += div64.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
-generic-y += fcntl.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
-generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mman.h
-generic-y += msgbuf.h
-generic-y += param.h
 generic-y += parport.h
 generic-y += percpu.h
-generic-y += poll.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += rwsem.h
-generic-y += sembuf.h
 generic-y += serial.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
 generic-y += sizes.h
-generic-y += socket.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += trace_clock.h
-generic-y += ucontext.h
 generic-y += xor.h
diff --git a/arch/sh/include/uapi/asm/Kbuild b/arch/sh/include/uapi/asm/Kbuild
index b15bf6bc0e94..e28531333efa 100644
--- a/arch/sh/include/uapi/asm/Kbuild
+++ b/arch/sh/include/uapi/asm/Kbuild
@@ -1,2 +1,22 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
+
+generic-y += bitsperlong.h
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ipcbuf.h
+generic-y += kvm_para.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += poll.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
+generic-y += siginfo.h
+generic-y += socket.h
+generic-y += statfs.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += ucontext.h
-- 
2.7.4
