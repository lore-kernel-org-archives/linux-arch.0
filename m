From: David Howells <dhowells@redhat.com>
Subject: [PATCH 2/3] Adjust the comment on get_order() to describe the size==0
	case [ver #2]
Date: Sat, 17 Apr 2010 15:07:06 +0100
Message-ID: <20100417140706.15855.78347.stgit@warthog.procyon.org.uk>
References: <20100417140701.15855.26978.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43066 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842Ab0DQOH1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 17 Apr 2010 10:07:27 -0400
In-Reply-To: <20100417140701.15855.26978.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@osdl.org, mingo@elte.hu, tglx@linutronix.de, matthew@wil.cx, arjan@infradead.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>

Adjust the comment on get_order() to note that the result of passing a size of
0 results in an undefined value.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/getorder.h |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/include/asm-generic/getorder.h b/include/asm-generic/getorder.h
index 67e7245..76e9687 100644
--- a/include/asm-generic/getorder.h
+++ b/include/asm-generic/getorder.h
@@ -5,7 +5,28 @@
 
 #include <linux/compiler.h>
 
-/* Pure 2^n version of get_order */
+/**
+ * get_order - Determine the allocation order of a memory size
+ * @size: The size for which to get the order
+ *
+ * Determine the allocation order of a particular sized block of memory.  This
+ * is on a logarithmic scale, where:
+ *
+ *	0 -> 2^0 * PAGE_SIZE and below
+ *	1 -> 2^1 * PAGE_SIZE to 2^0 * PAGE_SIZE + 1
+ *	2 -> 2^2 * PAGE_SIZE to 2^1 * PAGE_SIZE + 1
+ *	3 -> 2^3 * PAGE_SIZE to 2^2 * PAGE_SIZE + 1
+ *	4 -> 2^4 * PAGE_SIZE to 2^3 * PAGE_SIZE + 1
+ *	...
+ *
+ * The order returned is used to find the smallest allocation granule required
+ * to hold an object of the specified size.
+ *
+ * The result is undefined if the size is 0.
+ *
+ * This function may be used to initialise variables with compile time
+ * evaluations of constants.
+ */
 static inline __attribute_const__ int get_order(unsigned long size)
 {
 	int order;
