From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 3/9] asm-generic: rename uaccess.h to uaccess-unaligned.h
Date: Thu, 30 Apr 2009 20:56:31 +0200
Message-ID: <20090430185716.784575576@arndb.de>
References: <20090430185628.866082445@arndb.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56049 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759859AbZD3TC4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 Apr 2009 15:02:56 -0400
Content-Disposition: inline; filename=0003-asm-generic-rename-uaccess.h-to-uaccess-unaligned.h.patch
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>

The asm-generic/uaccess.h file is only implementing
unaligned accesses. Rename it to uaccess-unaligned.h
so we can replace it with a generic uaccess.h for
all NOMMU architectures.

Signed-off-by: Remis Lima Baima <remis.developer@googlemail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/parisc/include/asm/uaccess.h                  |    2 +-
 arch/sparc/include/asm/uaccess_64.h                |    2 +-
 .../asm-generic/{uaccess.h => uaccess-unaligned.h} |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename include/asm-generic/{uaccess.h => uaccess-unaligned.h} (82%)

diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index cd4c0b2..7cf799d 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -7,7 +7,7 @@
 #include <asm/page.h>
 #include <asm/system.h>
 #include <asm/cache.h>
-#include <asm-generic/uaccess.h>
+#include <asm-generic/uaccess-unaligned.h>
 
 #define VERIFY_READ 0
 #define VERIFY_WRITE 1
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index c64e767..a38c032 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -12,7 +12,7 @@
 #include <asm/asi.h>
 #include <asm/system.h>
 #include <asm/spitfire.h>
-#include <asm-generic/uaccess.h>
+#include <asm-generic/uaccess-unaligned.h>
 #endif
 
 #ifndef __ASSEMBLY__
diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess-unaligned.h
similarity index 82%
rename from include/asm-generic/uaccess.h
rename to include/asm-generic/uaccess-unaligned.h
index 549cb3a..67deb89 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess-unaligned.h
@@ -1,5 +1,5 @@
-#ifndef _ASM_GENERIC_UACCESS_H_
-#define _ASM_GENERIC_UACCESS_H_
+#ifndef __ASM_GENERIC_UACCESS_UNALIGNED_H
+#define __ASM_GENERIC_UACCESS_UNALIGNED_H
 
 /*
  * This macro should be used instead of __get_user() when accessing
@@ -23,4 +23,4 @@
 	__copy_to_user((ptr), &__x, sizeof(*(ptr))) ? -EFAULT : 0;	\
 })
 
-#endif /* _ASM_GENERIC_UACCESS_H */
+#endif /* __ASM_GENERIC_UACCESS_UNALIGNED_H */
-- 
1.5.6.3

-- 
