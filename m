Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:34703 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729891AbfDBJIm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 2 Apr 2019 05:08:42 -0400
Message-ID: <cbd5b58e286d891cded00eb46f279d0e9d86f819.1554195798.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1554195798.git.christophe.leroy@c-s.fr>
References: <cover.1554195798.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/9] Add capability to prepend the command line
Date: Tue,  2 Apr 2019 09:08:40 +0000 (UTC)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, danielwa@cisco.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
Message-ID: <20190402090840.Zv3ts-4tHkLLX_-wuEtGOZC49DCDr_i5JCFX6TQYXPM@z>

This patchs adds an option of prepend a text to the command
line instead of appending it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 include/linux/cmdline.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/cmdline.h b/include/linux/cmdline.h
index afcc00d7628d..5caf3724c1ab 100644
--- a/include/linux/cmdline.h
+++ b/include/linux/cmdline.h
@@ -3,7 +3,7 @@
 #define _LINUX_CMDLINE_H
 
 /*
- * This function will append a builtin command line to the command
+ * This function will append or prepend a builtin command line to the command
  * line provided by the bootloader. Kconfig options can be used to alter
  * the behavior of this builtin command line.
  * @dest: The destination of the final appended/prepended string.
@@ -22,6 +22,9 @@ static __always_inline void cmdline_build(char *dest, const char *src, size_t le
 		strlcat(dest, CONFIG_CMDLINE, length);
 		return;
 	}
+
+	if (IS_ENABLED(CONFIG_CMDLINE_PREPEND) && sizeof(CONFIG_CMDLINE) > 1)
+		strlcat(dest, CONFIG_CMDLINE " ", length);
 #endif
 	if (dest != src)
 		strlcat(dest, src, length);
-- 
2.13.3
