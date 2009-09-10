From: Roland McGrath <roland@redhat.com>
Subject: [PATCH 1/2] UNREACHABLE() macro
Date: Wed,  9 Sep 2009 19:00:31 -0700 (PDT)
Message-ID: <20090910020031.87DC68BF6E@magilla.sf.frob.com>
References: <20090910015923.8FB628AE5F@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1-old.redhat.com ([66.187.233.31]:41003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754077AbZIJCFk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 9 Sep 2009 22:05:40 -0400
In-Reply-To: Roland McGrath's message of  Wednesday, 9 September 2009 18:59:23 -0700 <20090910015923.8FB628AE5F@magilla.sf.frob.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jakub Jelinek <jakub@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

This adds the UNREACHABLE() macro to <linux/compiler.h>.  The latest
GCC has __builtin_unreachable(), which makes it generate better code
(i.e. omit some unreachable instructions).

Signed-off-by: Roland McGrath <roland@redhat.com>
CC: Jakub Jelinek <jakub@redhat.com>
---
 include/linux/compiler-gcc4.h |   13 +++++++++++++
 include/linux/compiler.h      |    9 +++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/include/linux/compiler-gcc4.h b/include/linux/compiler-gcc4.h
index 450fa59..320a9ad 100644
--- a/include/linux/compiler-gcc4.h
+++ b/include/linux/compiler-gcc4.h
@@ -37,3 +37,16 @@
 #define __cold			__attribute__((__cold__))
 
 #endif
+
+/*
+ * __builtin_unreachable is available in GCC 4.5+ and
+ * also in Fedora/Red Hat GCC 4.4.1-10+.
+ */
+#if (__GNUC_MINOR__ > 4					\
+     || (__GNUC_MINOR__ == 4				\
+	 && defined __GNUC_RH_RELEASE__			\
+	 && (__GNUC_PATCHLEVEL__ > 1			\
+	     || (__GNUC_PATCHLEVEL__ == 1		\
+		 && __GNUC_RH_RELEASE__ >= 10))))
+#define UNREACHABLE()		__builtin_unreachable()
+#endif
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 04fb513..e3dc896 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -256,6 +256,15 @@ void ftrace_likely_update(struct ftrace_branch_data *f, int val, int expect);
 #define __cold
 #endif
 
+/*
+ * Tell the compiler following code is unreachable and should disappear.
+ * If nothing else, just make it obvious to avoid warnings about missing
+ * return or whatnot.  Some compilers define a way to optimize it better.
+ */
+#ifndef UNREACHABLE
+#define UNREACHABLE() for (;;)
+#endif
+
 /* Simple shorthand for a section definition */
 #ifndef __section
 # define __section(S) __attribute__ ((__section__(#S)))
