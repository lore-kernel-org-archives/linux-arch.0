From: David Howells <dhowells@redhat.com>
Subject: [PATCH 5/7] CacheFiles: Use new core assertion macros
Date: Wed, 12 Oct 2011 17:47:58 +0100
Message-ID: <20111012164758.539.36637.stgit@warthog.procyon.org.uk>
References: <20111012164717.539.44368.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20111012164717.539.44368.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Make CacheFiles use the new core assertion macros in place of its own.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/internal.h |   53 ++--------------------------------------------
 1 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4938251..0b99c9e 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -14,6 +14,8 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/security.h>
+#define ENABLE_ASSERTIONS
+#include <linux/assert.h>
 
 struct cachefiles_cache;
 struct cachefiles_object;
@@ -303,54 +305,3 @@ do {							\
 #define _leave(FMT, ...) no_printk("<== %s()"FMT"", __func__, ##__VA_ARGS__)
 #define _debug(FMT, ...) no_printk(FMT, ##__VA_ARGS__)
 #endif
-
-#if 1 /* defined(__KDEBUGALL) */
-
-#define ASSERT(X)							\
-do {									\
-	if (unlikely(!(X))) {						\
-		printk(KERN_ERR "\n");					\
-		printk(KERN_ERR "CacheFiles: Assertion failed\n");	\
-		BUG();							\
-	}								\
-} while (0)
-
-#define ASSERTCMP(X, OP, Y)						\
-do {									\
-	if (unlikely(!((X) OP (Y)))) {					\
-		printk(KERN_ERR "\n");					\
-		printk(KERN_ERR "CacheFiles: Assertion failed\n");	\
-		printk(KERN_ERR "%lx " #OP " %lx is false\n",		\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		BUG();							\
-	}								\
-} while (0)
-
-#define ASSERTIF(C, X)							\
-do {									\
-	if (unlikely((C) && !(X))) {					\
-		printk(KERN_ERR "\n");					\
-		printk(KERN_ERR "CacheFiles: Assertion failed\n");	\
-		BUG();							\
-	}								\
-} while (0)
-
-#define ASSERTIFCMP(C, X, OP, Y)					\
-do {									\
-	if (unlikely((C) && !((X) OP (Y)))) {				\
-		printk(KERN_ERR "\n");					\
-		printk(KERN_ERR "CacheFiles: Assertion failed\n");	\
-		printk(KERN_ERR "%lx " #OP " %lx is false\n",		\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		BUG();							\
-	}								\
-} while (0)
-
-#else
-
-#define ASSERT(X)			do {} while (0)
-#define ASSERTCMP(X, OP, Y)		do {} while (0)
-#define ASSERTIF(C, X)			do {} while (0)
-#define ASSERTIFCMP(C, X, OP, Y)	do {} while (0)
-
-#endif
