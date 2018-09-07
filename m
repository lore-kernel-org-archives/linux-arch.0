From: Igor Stoppa <igor.stoppa@gmail.com>
Subject: [PATCH] asm-generic: bug: add unlikely() to BUG_ON()
Date: Fri,  7 Sep 2018 22:21:19 +0300
Message-ID: <20180907192119.4931-1-igor.stoppa@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Add a hint to the compiler.
If BUG_ON() is used instead of BUG(), it means that probably the
preferred outcome is to not BUG().

The optimization is disabled, in case CONFIG_PROFILE_ANNOTATED_BRANCHES
is turned on.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/asm-generic/bug.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..bf47584eab2a 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -183,7 +183,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
+#ifdef CONFIG_PROFILE_ANNOTATED_BRANCHES
 #define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#else
+#define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
+#endif
 #endif
 
 #ifndef HAVE_ARCH_WARN_ON
-- 
2.17.1
