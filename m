Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50735 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1VJk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Aug 2019 17:09:40 -0400
From: Denis Efremov <efremov@linux.com>
Subject: [PATCH] asm-generic: add unlikely to default BUG_ON(x)
Date: Thu, 29 Aug 2019 00:09:34 +0300
Message-ID: <20190828210934.17711-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
Message-ID: <20190828210934.BvX3WLwrD6iv-k0hII5sDv2KICQIitwVBQHBNgzgeuU@z>

Add unlikely to default BUG_ON(x) in !CONFIG_BUG. It makes
the define consistent with BUG_ON(x) in CONFIG_BUG.

Signed-off-by: Denis Efremov <efremov@linux.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-arch@vger.kernel.org>
---
 include/asm-generic/bug.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index aa6c093d9ce9..7357a3c942a0 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -185,7 +185,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
-#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-- 
2.21.0
