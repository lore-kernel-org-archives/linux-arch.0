From: Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PATCH v12 05/21] asm-generic: Add common asm-offsets.h
Date: Mon, 11 May 2015 15:26:24 +0900
Message-ID: <1431325600-12333-6-git-send-email-ysato@users.sourceforge.jp>
References: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431325600-12333-1-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
List-Id: linux-arch.vger.kernel.org

All architecture use same asm-offsets.h
So it generic header.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/asm-offsets.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 include/asm-generic/asm-offsets.h

diff --git a/include/asm-generic/asm-offsets.h b/include/asm-generic/asm-offsets.h
new file mode 100644
index 0000000..d370ee3
--- /dev/null
+++ b/include/asm-generic/asm-offsets.h
@@ -0,0 +1 @@
+#include <generated/asm-offsets.h>
-- 
2.1.4
