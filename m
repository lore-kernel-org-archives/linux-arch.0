From: Igor Stoppa <igor.stoppa@gmail.com>
Subject: [PATCH v2] asm-generic: bug: unify hints for BUG_ON()
Date: Sat,  8 Sep 2018 07:59:28 +0300
Message-ID: <20180908045928.26201-1-igor.stoppa@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

If BUG_ON() is used instead of BUG(), it means that probably the
preferred outcome is to not BUG(), therefore the condition tested should
be unlikely().

However, when CONFIG_PROFILE_ANNOTATED_BRANCHES is enabled, the hint is
disabled, to avoid generating false-positive warnings caused by
-Wmaybe-uninitialized.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/asm-generic/bug.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 20561a60db9c..b91273c36baf 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -58,8 +58,12 @@ struct bug_entry {
 #endif
 
 #ifndef HAVE_ARCH_BUG_ON
+#ifdef CONFIG_PROFILE_ANNOTATED_BRANCHES
+#define BUG_ON(condition) do { if (condition) BUG(); } while (0)
+#else
 #define BUG_ON(condition) do { if (unlikely(condition)) BUG(); } while (0)
 #endif
+#endif
 
 #ifdef __WARN_FLAGS
 #define __WARN_TAINT(taint)		__WARN_FLAGS(BUGFLAG_TAINT(taint))
@@ -183,7 +187,11 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
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
