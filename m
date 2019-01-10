From: guoren@kernel.org
Subject: [PATCH V2] csky: fixup compile error with CPU 810.
Date: Thu, 10 Jan 2019 20:28:39 +0800
Message-ID: <1547123319-15224-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: torvalds@linux-foundation.org, arnd@arndb.de, guoren@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

This bug is from commit f553aa1c13cb:
  "csky: fixup relocation error with 807 & 860".

I forgot to compile with 810 for that patch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/csky/kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
index 0b028ee..b5ad7d9 100644
--- a/arch/csky/kernel/module.c
+++ b/arch/csky/kernel/module.c
@@ -28,7 +28,7 @@
 
 static void jsri_2_lrw_jsr(uint32_t *location)
 {
-	uint16_t location_tmp = (uint16_t *)location;
+	uint16_t *location_tmp = (uint16_t *)location;
 
 	if (IS_BSR32(*location_tmp, *(location_tmp + 1)))
 		return;
-- 
2.7.4
