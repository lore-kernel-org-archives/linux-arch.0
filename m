Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <4325965A.2010608@yahoo.com.au>
Date: Tue, 13 Sep 2005 00:53:14 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: [PATCH 2/3][RFC] atomic_cmpxchg, atomic_inc_not_zero
References: <432595D5.1090502@yahoo.com.au>
In-Reply-To: <432595D5.1090502@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------090601040002030503090006"
To: Dipankar Sarma <dipankar@in.ibm.com>, linux-arch@vger.kernel.org, Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090601040002030503090006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

2/3 is a sample atomic_inc_not_zero for ppc64 implemented with
atomic_cmpxchg. I couldn't be bothered to go through the motions
without a first round of comments...

Ideally, ppc64 will implement this with ll/sc instructions and
hopefully shave a cycle or so. But anyone who can implement
atomic_cmpxchg can implement atomic_inc_not_zero as demonstrated.

-- 
SUSE Labs, Novell Inc.


--------------090601040002030503090006
Content-Type: text/plain;
 name="atomic_inc_not_zero.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic_inc_not_zero.patch"

Index: linux-2.6/include/asm-ppc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/atomic.h
+++ linux-2.6/include/asm-ppc64/atomic.h
@@ -164,6 +164,23 @@ static __inline__ int atomic_dec_return(
 
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
+/**
+ * atomic_inc_not_zero - increment if not zero
+ * @v: pointer of type atomic_t
+ *
+ * Atomically increments @v by 1, so long as it was not 0.
+ * Returns non-zero on successful increment and zero otherwise.
+ */
+#define atomic_inc_not_zero(v)					\
+({								\
+	int c, old;						\
+	c = atomic_read(v);					\
+	while (c && (old = atomic_cmpxchg((v), c, c + 1)) != c)	\
+		c = old;					\
+	c;							\
+})
+
+
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
 

--------------090601040002030503090006--
Send instant messages to your online friends http://au.messenger.yahoo.com 
