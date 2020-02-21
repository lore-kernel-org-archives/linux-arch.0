Return-Path: <SRS0=0XgO=4J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45608 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728895AbgBUNuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 08:50:44 -0500
Message-ID: <20200221134216.747377168@infradead.org>
Date: Fri, 21 Feb 2020 14:34:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 25/27] lib/bsearch: Provide __always_inline variant
References: <20200221133416.777099322@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, rostedt@goodmis.org
Cc: peterz@infradead.org, mingo@kernel.org, joel@joelfernandes.org, gregkh@linuxfoundation.org, gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com, frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Message-ID: <20200221133441.c_KJuytLSmxIhDbQtrLpfZBrEJ5qltLklhrfYDdVl_o@z>

For code that needs the ultimate performance (it can inline the @cmp
function too) or simply needs to avoid calling external functions for
whatever reason, provide an __always_inline variant of bsearch().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/alternative.c |    9 ++++-----
 include/linux/bsearch.h       |   26 ++++++++++++++++++++++++--
 lib/bsearch.c                 |   22 ++--------------------
 3 files changed, 30 insertions(+), 27 deletions(-)

--- a/include/linux/bsearch.h
+++ b/include/linux/bsearch.h
@@ -4,7 +4,29 @@
 
 #include <linux/types.h>
 
-void *bsearch(const void *key, const void *base, size_t num, size_t size,
-	      cmp_func_t cmp);
+static __always_inline
+void *__bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
+{
+	const char *pivot;
+	int result;
+
+	while (num > 0) {
+		pivot = base + (num >> 1) * size;
+		result = cmp(key, pivot);
+
+		if (result == 0)
+			return (void *)pivot;
+
+		if (result > 0) {
+			base = pivot + size;
+			num--;
+		}
+		num >>= 1;
+	}
+
+	return NULL;
+}
+
+extern void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp);
 
 #endif /* _LINUX_BSEARCH_H */
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -28,27 +28,9 @@
  * the key and elements in the array are of the same type, you can use
  * the same comparison function for both sort() and bsearch().
  */
-void *bsearch(const void *key, const void *base, size_t num, size_t size,
-	      cmp_func_t cmp)
+void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
 {
-	const char *pivot;
-	int result;
-
-	while (num > 0) {
-		pivot = base + (num >> 1) * size;
-		result = cmp(key, pivot);
-
-		if (result == 0)
-			return (void *)pivot;
-
-		if (result > 0) {
-			base = pivot + size;
-			num--;
-		}
-		num >>= 1;
-	}
-
-	return NULL;
+	return __bsearch(key, base, num, size, cmp);
 }
 EXPORT_SYMBOL(bsearch);
 NOKPROBE_SYMBOL(bsearch);
