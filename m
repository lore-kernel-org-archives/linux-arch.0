From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: avoid ARCH_MMAP_RND_BITS for NOMMU
Date: Fri, 27 Nov 2015 15:04:03 +0100
Message-ID: <2874133.c4GDUf0t6t@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:49688 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbbK0OEb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Nov 2015 09:04:31 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Daniel Cashman <dcashman@google.com>, linux-arch@vger.kernel.org

ARM kernels with MMU disabled fail to build because of CONFIG_ARCH_MMAP_RND_BITS:

kernel/built-in.o:(.data+0x754): undefined reference to `mmap_rnd_bits'
kernel/built-in.o:(.data+0x76c): undefined reference to `mmap_rnd_bits_min'
kernel/built-in.o:(.data+0x770): undefined reference to `mmap_rnd_bits_max'

This changes the newly added line to only select this allow for
MMU-enabled kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 14570b3fd31a ("arm: mm: support ARCH_MMAP_RND_BITS")
---
Found on yesterday's linux-next with ARM randconfig. The commit that
introduced this is currently in Andrew's tree.

If you don't already have a fix, please either apply this patch on top,
or fold it into the original patch.

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b64f64d124c4..5a0957e3ea36 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -34,7 +34,7 @@ config ARM
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
 	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
-	select HAVE_ARCH_MMAP_RND_BITS
+	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_SECCOMP_FILTER if (AEABI && !OABI_COMPAT)
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_BPF_JIT
