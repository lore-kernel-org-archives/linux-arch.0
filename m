From: David Howells <dhowells@redhat.com>
Subject: [PATCH 6/7] AFS: Use new core assertion macros
Date: Wed, 12 Oct 2011 17:48:08 +0100
Message-ID: <20111012164808.539.44475.stgit@warthog.procyon.org.uk>
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

Make AFS use the new core assertion macros in place of its own.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/afs/internal.h |   90 +----------------------------------------------------
 1 files changed, 2 insertions(+), 88 deletions(-)

diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index d2b0888..36989c0 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -20,6 +20,8 @@
 #include <linux/sched.h>
 #include <linux/fscache.h>
 #include <linux/backing-dev.h>
+#define ENABLE_ASSERTIONS
+#include <linux/assert.h>
 
 #include "afs.h"
 #include "afs_vl.h"
@@ -800,91 +802,3 @@ do {							\
 #define _leave(FMT,...)	no_printk("<== %s()"FMT"",__func__ ,##__VA_ARGS__)
 #define _debug(FMT,...)	no_printk("    "FMT ,##__VA_ARGS__)
 #endif
-
-/*
- * debug assertion checking
- */
-#if 1 // defined(__KDEBUGALL)
-
-#define ASSERT(X)						\
-do {								\
-	if (unlikely(!(X))) {					\
-		printk(KERN_ERR "\n");				\
-		printk(KERN_ERR "AFS: Assertion failed\n");	\
-		BUG();						\
-	}							\
-} while(0)
-
-#define ASSERTCMP(X, OP, Y)						\
-do {									\
-	if (unlikely(!((X) OP (Y)))) {					\
-		printk(KERN_ERR "\n");					\
-		printk(KERN_ERR "AFS: Assertion failed\n");		\
-		printk(KERN_ERR "%lu " #OP " %lu is false\n",		\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		printk(KERN_ERR "0x%lx " #OP " 0x%lx is false\n",	\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		BUG();							\
-	}								\
-} while(0)
-
-#define ASSERTRANGE(L, OP1, N, OP2, H)					\
-do {									\
-	if (unlikely(!((L) OP1 (N)) || !((N) OP2 (H)))) {		\
-		printk(KERN_ERR "\n");					\
-		printk(KERN_ERR "AFS: Assertion failed\n");		\
-		printk(KERN_ERR "%lu "#OP1" %lu "#OP2" %lu is false\n",	\
-		       (unsigned long)(L), (unsigned long)(N),		\
-		       (unsigned long)(H));				\
-		printk(KERN_ERR "0x%lx "#OP1" 0x%lx "#OP2" 0x%lx is false\n", \
-		       (unsigned long)(L), (unsigned long)(N),		\
-		       (unsigned long)(H));				\
-		BUG();							\
-	}								\
-} while(0)
-
-#define ASSERTIF(C, X)						\
-do {								\
-	if (unlikely((C) && !(X))) {				\
-		printk(KERN_ERR "\n");				\
-		printk(KERN_ERR "AFS: Assertion failed\n");	\
-		BUG();						\
-	}							\
-} while(0)
-
-#define ASSERTIFCMP(C, X, OP, Y)					\
-do {									\
-	if (unlikely((C) && !((X) OP (Y)))) {				\
-		printk(KERN_ERR "\n");					\
-		printk(KERN_ERR "AFS: Assertion failed\n");		\
-		printk(KERN_ERR "%lu " #OP " %lu is false\n",		\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		printk(KERN_ERR "0x%lx " #OP " 0x%lx is false\n",	\
-		       (unsigned long)(X), (unsigned long)(Y));		\
-		BUG();							\
-	}								\
-} while(0)
-
-#else
-
-#define ASSERT(X)				\
-do {						\
-} while(0)
-
-#define ASSERTCMP(X, OP, Y)			\
-do {						\
-} while(0)
-
-#define ASSERTRANGE(L, OP1, N, OP2, H)		\
-do {						\
-} while(0)
-
-#define ASSERTIF(C, X)				\
-do {						\
-} while(0)
-
-#define ASSERTIFCMP(C, X, OP, Y)		\
-do {						\
-} while(0)
-
-#endif /* __KDEBUGALL */
