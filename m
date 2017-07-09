From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 23/28] tile: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 10 Jul 2017 03:32:55 +0900
Message-ID: <1499625180-8067-24-git-send-email-yamada.masahiro@socionext.com>
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

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/tile/include/asm/Kbuild      | 19 -------------------
 arch/tile/include/uapi/asm/Kbuild | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/tile/include/asm/Kbuild b/arch/tile/include/asm/Kbuild
index 16f0b08c8ce9..d28d2b8932c7 100644
--- a/arch/tile/include/asm/Kbuild
+++ b/arch/tile/include/asm/Kbuild
@@ -2,37 +2,18 @@ generic-y += bug.h
 generic-y += bugs.h
 generic-y += clkdev.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += fb.h
-generic-y += fcntl.h
 generic-y += hw_irq.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += msgbuf.h
-generic-y += param.h
 generic-y += parport.h
-generic-y += poll.h
-generic-y += posix_types.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += seccomp.h
-generic-y += sembuf.h
 generic-y += serial.h
-generic-y += shmbuf.h
-generic-y += shmparam.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += statfs.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += xor.h
diff --git a/arch/tile/include/uapi/asm/Kbuild b/arch/tile/include/uapi/asm/Kbuild
index 0c74c3c5ebfa..5711de0a1b5e 100644
--- a/arch/tile/include/uapi/asm/Kbuild
+++ b/arch/tile/include/uapi/asm/Kbuild
@@ -1,4 +1,23 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += poll.h
+generic-y += posix_types.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += statfs.h
+generic-y += termbits.h
+generic-y += termios.h
+generic-y += types.h
 generic-y += ucontext.h
-- 
2.7.4

