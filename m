Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out-183.synserver.de ([212.40.185.183]:1044 "EHLO
	smtp-out-183.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab2KAKaq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2012 06:30:46 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] xtensa: Use generic asm/mmu.h for nommu
Date: Thu,  1 Nov 2012 11:24:27 +0100
Message-ID: <1351765467-29244-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1351765467-29244-1-git-send-email-lars@metafoo.de>
References: <1351765467-29244-1-git-send-email-lars@metafoo.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Salter <msalter@redhat.com>, Aurelien Jacquiot <a-jacquiot@ti.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <20121101102427.OEW0zA5_BL1H5JA57tSPKkFMQsud5hOtz3PCvRIDy3M@z>

The nommu portion of mmu.h of the extensa platform is basically the same as the
asm-generic mmu.h. So use it instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---
Note, due to lack of toolchain, etc this patch is completely untested.
---
 arch/xtensa/include/asm/mmu.h   |    2 +-
 arch/xtensa/include/asm/nommu.h |    3 ---
 2 files changed, 1 insertions(+), 4 deletions(-)
 delete mode 100644 arch/xtensa/include/asm/nommu.h

diff --git a/arch/xtensa/include/asm/mmu.h b/arch/xtensa/include/asm/mmu.h
index 04890d6..8554b2c 100644
--- a/arch/xtensa/include/asm/mmu.h
+++ b/arch/xtensa/include/asm/mmu.h
@@ -12,7 +12,7 @@
 #define _XTENSA_MMU_H
 
 #ifndef CONFIG_MMU
-#include <asm/nommu.h>
+#include <asm-generic/mmu.h>
 #else
 
 /* Default "unsigned long" context */
diff --git a/arch/xtensa/include/asm/nommu.h b/arch/xtensa/include/asm/nommu.h
deleted file mode 100644
index dce2c43..0000000
--- a/arch/xtensa/include/asm/nommu.h
+++ /dev/null
@@ -1,3 +0,0 @@
-typedef struct {
-	unsigned long end_brk;
-} mm_context_t;
-- 
1.7.2.5

