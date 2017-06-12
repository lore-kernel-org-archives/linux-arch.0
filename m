From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 14/27] m68k: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:27:08 +0900
Message-ID: <1497238041-7011-15-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), all (and only) headers under uapi directories are
exported, but asm-generic wrappers are still exceptions.

scripts/Makefile.headersinst still need to deal with old-kbuild-file
for headers listed in arch/*/include/asm/Kbuild, but actually exported.

As the last work to finish de-coupling the uapi from kernel headers,
move generic-y of exported headers to uapi/asm/Kbuild.

For m68k, "generic-y += termios.h" is doubled in asm/Kbuild and
uapi/asm/Kbuild.  So, the one in the former can be simply removed.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/m68k/include/asm/Kbuild      | 12 ------------
 arch/m68k/include/uapi/asm/Kbuild | 11 +++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 82005d2ff717..2e547df53344 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,37 +1,25 @@
 generic-y += barrier.h
-generic-y += bitsperlong.h
 generic-y += clkdev.h
 generic-y += device.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += extable.h
 generic-y += futex.h
 generic-y += hw_irq.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
 generic-y += kmap_types.h
-generic-y += kvm_para.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += mm-arch-hooks.h
-generic-y += mman.h
 generic-y += percpu.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += sections.h
-generic-y += shmparam.h
-generic-y += siginfo.h
 generic-y += spinlock.h
-generic-y += statfs.h
-generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
 generic-y += kprobes.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 64368077235a..3717b64a620d 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -2,10 +2,21 @@
 include include/uapi/asm-generic/Kbuild.asm
 
 generic-y += auxvec.h
+generic-y += bitsperlong.h
+generic-y += errno.h
+generic-y += ioctl.h
+generic-y += ipcbuf.h
+generic-y += kvm_para.h
+generic-y += mman.h
 generic-y += msgbuf.h
+generic-y += resource.h
 generic-y += sembuf.h
 generic-y += shmbuf.h
+generic-y += shmparam.h
+generic-y += siginfo.h
 generic-y += socket.h
 generic-y += sockios.h
+generic-y += statfs.h
 generic-y += termbits.h
 generic-y += termios.h
+generic-y += types.h
-- 
2.7.4
