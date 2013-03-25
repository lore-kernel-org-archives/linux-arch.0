From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Turn off -Wmaybe-uninitialized when building with -Os
Date: Mon, 25 Mar 2013 15:44:55 +0000
Message-ID: <201303251544.55765.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59255 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758502Ab3CYPqA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Mar 2013 11:46:00 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Michal Marek <mmarek@suse.cz>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

gcc-4.7 and higher add a lot of false positive warnings about
potential uses of uninitialized warnings, but only when optimizing
for size (-Os). This is the default when building allyesconfig,
which turns on CONFIG_CC_OPTIMIZE_FOR_SIZE.

In order to avoid getting a lot of patches that initialize such
variables and accidentally hide real errors along the way, let's
just turn off this warning on the respective gcc versions
when building with size optimizations. The -Wmaybe-uninitialized
option was introduced in the same gcc version (4.7) that is now
causing the false positives, so there is no effect on older compilers.

A side effect is that when building with CONFIG_CC_OPTIMIZE_FOR_SIZE,
we might now see /fewer/ warnings about possibly uninitialized
warnings than with -O2, but that is still much better than seeing
warnings known to be bogus.

Building v3.9-rc3 allmodconfig shows how the number of false
positives is reduced:

74	x86-linux-gcc-4.7 -Os
12	x86-linux-gcc-4.7 -O2
 1	x86-linux-gcc-4.7 -Os -Wno-maybe-uninitialized
 8	arm-linux-gcc-4.6 -Os
 8	arm-linux-gcc-4.6 -Os
50	arm-linux-gcc-4.7 -Os
 8	arm-linux-gcc-4.7 -O2
 0	arm-linux-gcc-4.7 -Os -Wno-maybe-uninitialized
33	arm-linux-gcc-4.8 -Os
13	arm-linux-gcc-4.8 -O2
 0	arm-linux-gcc-4.8 -Os -Wno-maybe-uninitialized

The 8 to 13 warnings that are now hidden compared to the -O2 output
seem to all be false positives as well. The total number of
all other warnings I see is (independent of optimization level)

24	x86-linux-gcc-4.7
19	arm-linux-gcc-4.6
17	arm-linux-gcc-4.7
16	arm-linux-gcc-4.8

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
diff --git a/Makefile b/Makefile
index 22113a7..d8e3f36 100644
--- a/Makefile
+++ b/Makefile
@@ -570,7 +570,7 @@ endif # $(dot-config)
 all: vmlinux
 
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-KBUILD_CFLAGS	+= -Os
+KBUILD_CFLAGS	+= -Os $(call cc-disable-warning,maybe-uninitialized,)
 else
 KBUILD_CFLAGS	+= -O2
 endif
