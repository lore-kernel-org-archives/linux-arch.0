From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 16/28] microblaze: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 10 Jul 2017 03:32:48 +0900
Message-ID: <1499625180-8067-17-git-send-email-yamada.masahiro@socionext.com>
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

For microblaze, "generic-y += siginfo.h" is doubled in asm/Kbuild and
uapi/asm/Kbuild.  So, the one in the former can be simply removed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/microblaze/include/asm/Kbuild      | 25 -------------------------
 arch/microblaze/include/uapi/asm/Kbuild | 25 ++++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 83a4ef3a2495..9d66f7793841 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -1,22 +1,15 @@
-
 generic-y += barrier.h
 generic-y += bitops.h
-generic-y += bitsperlong.h
 generic-y += bug.h
 generic-y += bugs.h
 generic-y += clkdev.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += fb.h
-generic-y += fcntl.h
 generic-y += hardirq.h
-generic-y += ioctl.h
-generic-y += ioctls.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
@@ -27,31 +20,13 @@ generic-y += local.h
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
-generic-y += swab.h
 generic-y += syscalls.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += ucontext.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/microblaze/include/uapi/asm/Kbuild b/arch/microblaze/include/uapi/asm/Kbuild
index cb6784f4a427..e77a596f3f1e 100644
--- a/arch/microblaze/include/uapi/asm/Kbuild
+++ b/arch/microblaze/include/uapi/asm/Kbuild
@@ -1,5 +1,28 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
-generic-y += types.h
+generic-y += bitsperlong.h
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += ioctls.h
+generic-y += ipcbuf.h
+generic-y += mman.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += poll.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
+generic-y += shmparam.h
 generic-y += siginfo.h
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
