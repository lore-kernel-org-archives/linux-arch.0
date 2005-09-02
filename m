Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <4317F2FE.8030109@yahoo.com.au>
Date: Fri, 02 Sep 2005 16:36:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: [Fwd: [PATCH 2.6.13] lockless pagecache 2/7]
Content-Type: multipart/mixed;
 boundary="------------080906010104040907090506"
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

This is a multi-part message in MIME format.
--------------080906010104040907090506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Forwarded to linux-arch for comments.

It would be preferable if replies could go to the lkml
thread, but either way is fine.

Thanks,
Nick

-------- Original Message --------
Subject: [PATCH 2.6.13] lockless pagecache 2/7
Date: Fri, 02 Sep 2005 16:29:10 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Linux Memory Management <linux-mm@kvack.org>,	linux-kernel <linux-kernel@vger.kernel.org>
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>

2/7
Implement atomic_cmpxchg for i386 and ppc64. Is there any
architecture that won't be able to implement such an operation?


--------------080906010104040907090506
Content-Type: text/plain;
 name="atomic_cmpxchg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="atomic_cmpxchg.patch"

Introduce an atomic_cmpxchg operation. Implement this for i386 and ppc64.

Signed-off-by: Nick Piggin <npiggin@suse.de>

Index: linux-2.6/include/asm-i386/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-i386/atomic.h
+++ linux-2.6/include/asm-i386/atomic.h
@@ -215,6 +215,8 @@ static __inline__ int atomic_sub_return(
 	return atomic_add_return(-i,v);
 }
 
+#define atomic_cmpxchg(v, old, new)	((int)cmpxchg(&((v)->counter), old, new))
+
 #define atomic_inc_return(v)  (atomic_add_return(1,v))
 #define atomic_dec_return(v)  (atomic_sub_return(1,v))
 
Index: linux-2.6/include/asm-ppc64/atomic.h
===================================================================
--- linux-2.6.orig/include/asm-ppc64/atomic.h
+++ linux-2.6/include/asm-ppc64/atomic.h
@@ -162,6 +162,8 @@ static __inline__ int atomic_dec_return(
 	return t;
 }
 
+#define atomic_cmpxchg(v, o, n)	((int)cmpxchg(&((v)->counter), (o), (n)))
+
 #define atomic_sub_and_test(a, v)	(atomic_sub_return((a), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_dec_return((v)) == 0)
 


--------------080906010104040907090506--
Send instant messages to your online friends http://au.messenger.yahoo.com 
