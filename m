Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728099AbfAJLy4 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jan 2019 06:54:56 -0500
From: guoren@kernel.org
Subject: [PATCH] csky: fixup compile error with CPU 810.
Date: Thu, 10 Jan 2019 19:54:47 +0800
Message-ID: <1547121287-12824-1-git-send-email-guoren@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, guoren@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190110115447.8aQPnhHs_yWtXFSOr7GYUiunn8DPQdKVyE7jfo7uqwg@z>

From: Guo Ren <ren_guo@c-sky.com>

This bug is from commit f553aa1c13cb:
  "csky: fixup relocation error with 807 & 860".

I forgot to compile with 810 for that patch.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
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
