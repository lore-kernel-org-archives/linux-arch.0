Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:59581 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab3COO42 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 15 Mar 2013 10:56:28 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Fwd: [PATCH] Turn off -Wmaybe-uninitialized when building with -Os
Date: Fri, 15 Mar 2013 14:55:38 +0000
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201303151455.38917.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, inux-kernel@vger.kernel.org
Message-ID: <20130315145538.q45o7TXJj3cDMKiIC980HCaZFxmvrR0FzW9JNipKtrw@z>

I forgot to put the linux-kbuild list on Cc, that is probably the
best place to discuss this patch.

----------  Forwarded Message  ----------

Subject: [PATCH] Turn off -Wmaybe-uninitialized when building with -Os
Date: Thursday 14 March 2013
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

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

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: stable@vger.kernel.org
--
I'd like to merge this for 3.9 and also for the stable kernels,
if people agree this is a good idea.

diff --git a/Makefile b/Makefile
index 10fb6c7..caea2d1 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-arch" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

-------------------------------------------------------
