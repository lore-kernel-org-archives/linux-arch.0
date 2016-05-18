From: David Howells <dhowells@redhat.com>
Subject: [RFC PATCH 01/15] cmpxchg_local() is not signed-value safe,
 so fix generic atomics
Date: Wed, 18 May 2016 16:10:45 +0100
Message-ID: <146358424513.8596.16888168996359637266.stgit@warthog.procyon.org.uk>
References: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <146358423711.8596.9104061348359986393.stgit@warthog.procyon.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: x86@kernel.org, will.deacon@arm.com, linux-kernel@vger.kernel.org, dhowells@redhat.com, ramana.radhakrishnan@arm.com, paulmck@linux.vnet.ibm.com, dwmw2@infradead.org
List-Id: linux-arch.vger.kernel.org

cmpxchg_local() is not signed-value safe because on a 64-bit machine signed
int arguments to it may be sign-extended to signed long _before_ begin cast
to unsigned long.  This potentially causes comparisons to fail when dealing
with negative values.

Fix the generic atomic functions that are implemented in terms of cmpxchg()
to cast their arguments to unsigned int before calling cmpxchg().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/asm-generic/atomic.h |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/atomic.h b/include/asm-generic/atomic.h
index 74f1a3704d7a..e6c71c52edfe 100644
--- a/include/asm-generic/atomic.h
+++ b/include/asm-generic/atomic.h
@@ -37,28 +37,33 @@
 
 #ifdef CONFIG_SMP
 
-/* we can build all atomic primitives from cmpxchg */
+/*
+ * We can build all atomic primitives from cmpxchg(), but we have to beware of
+ * implicit casting of signed int parameters to signed long and thence to
+ * unsigned long on a 64-bit machine if we don't explicitly cast to unsigned
+ * int.
+ */
 
 #define ATOMIC_OP(op, c_op)						\
 static inline void atomic_##op(int i, atomic_t *v)			\
 {									\
-	int c, old;							\
+	unsigned int c, old;						\
 									\
 	c = v->counter;							\
-	while ((old = cmpxchg(&v->counter, c, c c_op i)) != c)		\
+	while ((old = cmpxchg(&v->counter, c, c c_op (unsigned int)i)) != c) \
 		c = old;						\
 }
 
 #define ATOMIC_OP_RETURN(op, c_op)					\
 static inline int atomic_##op##_return(int i, atomic_t *v)		\
 {									\
-	int c, old;							\
+	unsigned int c, old;						\
 									\
 	c = v->counter;							\
-	while ((old = cmpxchg(&v->counter, c, c c_op i)) != c)		\
+	while ((old = cmpxchg(&v->counter, c, c c_op (unsigned int)i)) != c) \
 		c = old;						\
 									\
-	return c c_op i;						\
+	return c c_op (unsigned int)i;					\
 }
 
 #else
