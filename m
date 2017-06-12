Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conuserg-09.nifty.com ([210.131.2.76]:16941 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752389AbdFLD3U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 11 Jun 2017 23:29:20 -0400
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 05/27] ARM: move generic-y of exported headers to uapi/asm/Kbuild
Date: Mon, 12 Jun 2017 12:26:59 +0900
Message-ID: <1497238041-7011-6-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
References: <1497238041-7011-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20170612032659.R8-S3F0-ruALwbtpD3fIpPMw_mCHnUtOUa9wtrXhCYg@z>

Since commit fcc8487d477a ("uapi: export all headers under uapi
directories"), all (and only) headers under uapi directories are
exported, but asm-generic wrappers are still exceptions.

scripts/Makefile.headersinst still need to deal with old-kbuild-file
for headers listed in arch/*/include/asm/Kbuild, but actually exported.

As the last work to finish de-coupling the uapi from kernel headers,
move generic-y of exported headers to uapi/asm/Kbuild.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/include/asm/Kbuild      | 17 -----------------
 arch/arm/include/uapi/asm/Kbuild | 16 ++++++++++++++++
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
index 3a36d99ff836..721ab5ecfb9b 100644
--- a/arch/arm/include/asm/Kbuild
+++ b/arch/arm/include/asm/Kbuild
@@ -1,40 +1,23 @@
-
-
-generic-y += bitsperlong.h
 generic-y += clkdev.h
 generic-y += current.h
 generic-y += early_ioremap.h
 generic-y += emergency-restart.h
-generic-y += errno.h
 generic-y += exec.h
 generic-y += extable.h
-generic-y += ioctl.h
-generic-y += ipcbuf.h
 generic-y += irq_regs.h
 generic-y += kdebug.h
 generic-y += local.h
 generic-y += local64.h
 generic-y += mm-arch-hooks.h
-generic-y += msgbuf.h
 generic-y += msi.h
-generic-y += param.h
 generic-y += parport.h
-generic-y += poll.h
 generic-y += preempt.h
-generic-y += resource.h
 generic-y += rwsem.h
 generic-y += seccomp.h
 generic-y += segment.h
-generic-y += sembuf.h
 generic-y += serial.h
-generic-y += shmbuf.h
-generic-y += siginfo.h
 generic-y += simd.h
 generic-y += sizes.h
-generic-y += socket.h
-generic-y += sockios.h
-generic-y += termbits.h
-generic-y += termios.h
 generic-y += timex.h
 generic-y += trace_clock.h
 generic-y += unaligned.h
diff --git a/arch/arm/include/uapi/asm/Kbuild b/arch/arm/include/uapi/asm/Kbuild
index 607f702c2d62..b531c2786f27 100644
--- a/arch/arm/include/uapi/asm/Kbuild
+++ b/arch/arm/include/uapi/asm/Kbuild
@@ -1,6 +1,22 @@
 # UAPI Header export list
 include include/uapi/asm-generic/Kbuild.asm
 
+generic-y += bitsperlong.h
+generic-y += errno.h
+generic-y += ioctl.h
+generic-y += ipcbuf.h
+generic-y += msgbuf.h
+generic-y += param.h
+generic-y += poll.h
+generic-y += resource.h
+generic-y += sembuf.h
+generic-y += shmbuf.h
+generic-y += siginfo.h
+generic-y += socket.h
+generic-y += sockios.h
+generic-y += termbits.h
+generic-y += termios.h
+
 genhdr-y += unistd-common.h
 genhdr-y += unistd-oabi.h
 genhdr-y += unistd-eabi.h
-- 
2.7.4
