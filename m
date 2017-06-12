From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 24/27] xtensa: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:27:18 +0900
Message-ID: <1497238041-7011-25-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-xtensa@linux-xtensa.org, Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>
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

 arch/xtensa/include/asm/Kbuild      |  9 ---------
 arch/xtensa/include/uapi/asm/Kbuild | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index cc23e9ecc6bb..0b408dc2366e 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -1,20 +1,15 @@
-generic-y += bitsperlong.h
 generic-y += bug.h
 generic-y += clkdev.h
 generic-y += div64.h
 generic-y += dma-contiguous.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += extable.h
-generic-y += fcntl.h
 generic-y += hardirq.h
-generic-y += ioctl.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
-generic-y += kvm_para.h
 generic-y += linkage.h
 generic-y += local.h
 generic-y += local64.h
@@ -22,12 +17,8 @@ generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
 generic-y += percpu.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += rwsem.h
 generic-y += sections.h
-generic-y += siginfo.h
-generic-y += statfs.h
-generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
 generic-y += word-at-a-time.h
diff --git a/arch/xtensa/include/uapi/asm/Kbuild b/arch/xtensa/include/uapi/asm/Kbuild
index b15bf6bc0e94..a5bcdfb890f1 100644
--- a/arch/xtensa/include/uapi/asm/Kbuild
+++ b/arch/xtensa/include/uapi/asm/Kbuild
@@ -1,2 +1,12 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
+
+generic-y += bitsperlong.h
+generic-y += errno.h
+generic-y += fcntl.h
+generic-y += ioctl.h
+generic-y += kvm_para.h
+generic-y += resource.h
+generic-y += siginfo.h
+generic-y += statfs.h
+generic-y += termios.h
-- 
2.7.4
