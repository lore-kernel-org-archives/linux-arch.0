From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 14/28] m68k: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 10 Jul 2017 03:32:46 +0900
Message-ID: <1499625180-8067-15-git-send-email-yamada.masahiro@socionext.com>
References: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-08.nifty.com ([210.131.2.75]:45816 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbdGISdY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 9 Jul 2017 14:33:24 -0400
In-Reply-To: <1499625180-8067-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), all (and only) headers under uapi directories are
exported, but asm-generic wrappers are still exceptions.

To complete de-coupling the uapi from kernel headers, move generic-y
of exported headers to uapi/asm/Kbuild.

With this change, "make headers_install" will just need to parse
uapi/asm/Kbuild to build up exported headers.

For m68k, "generic-y += termios.h" is doubled in asm/Kbuild and
uapi/asm/Kbuild.  So, the one in the former can be simply removed.

Also, move "generic-y += kprobes.h" up in order to keep the entries
sorted.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---

 arch/m68k/include/asm/Kbuild      | 13 +------------
 arch/m68k/include/uapi/asm/Kbuild | 10 ++++++++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/m68k/include/asm/Kbuild b/arch/m68k/include/asm/Kbuild
index 5ecf4e47b2e2..59d6d0d38f67 100644
--- a/arch/m68k/include/asm/Kbuild
+++ b/arch/m68k/include/asm/Kbuild
@@ -1,36 +1,25 @@
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
+generic-y += kprobes.h
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
 generic-y += spinlock.h
-generic-y += statfs.h
-generic-y += termios.h
 generic-y += topology.h
 generic-y += trace_clock.h
-generic-y += types.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
-generic-y += kprobes.h
diff --git a/arch/m68k/include/uapi/asm/Kbuild b/arch/m68k/include/uapi/asm/Kbuild
index 68b45cc87e2c..3717b64a620d 100644
--- a/arch/m68k/include/uapi/asm/Kbuild
+++ b/arch/m68k/include/uapi/asm/Kbuild
@@ -2,11 +2,21 @@
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
 generic-y += siginfo.h
 generic-y += socket.h
 generic-y += sockios.h
+generic-y += statfs.h
 generic-y += termbits.h
 generic-y += termios.h
+generic-y += types.h
-- 
2.7.4
