Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:44512 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265237AbUEMWvH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 May 2004 18:51:07 -0400
Date: Thu, 13 May 2004 15:52:48 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: atomic ops for a VM fix
Message-Id: <20040513155248.4534f833.akpm@osdl.org>
In-Reply-To: <16547.63434.35149.755394@napali.hpl.hp.com>
References: <20040513133526.0e5efed3.akpm@osdl.org>
	<20040514015222.A1569@den.park.msu.ru>
	<16547.63434.35149.755394@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: davidm@hpl.hp.com
Cc: davidm@napali.hpl.hp.com, ink@jurassic.park.msu.ru, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Fri, 14 May 2004 01:52:22 +0400, Ivan Kokshaysky <ink@jurassic.park.msu.ru> said:
> 
>   Ivan> It seems atomic_inc_and_test() is missing on alpha.
> 
>   Ivan> +#define atomic_inc_and_test(v) (atomic_add_return(1, (v)) == 0)
> 
> And I seem to have gotten the ia64-version wrong (it tests for != 0).
> I'll fix that now.

Neato.


From: David Mosberger <davidm@napali.hpl.hp.com>


---

 25-akpm/include/asm-ia64/atomic.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-ia64/atomic.h~ia64-atomic_inc_and_test-fix include/asm-ia64/atomic.h
--- 25/include/asm-ia64/atomic.h~ia64-atomic_inc_and_test-fix	Thu May 13 15:49:32 2004
+++ 25-akpm/include/asm-ia64/atomic.h	Thu May 13 15:49:32 2004
@@ -159,7 +159,7 @@ atomic64_add_negative (__s64 i, atomic64
 
 #define atomic_sub_and_test(i,v)	(atomic_sub_return((i), (v)) == 0)
 #define atomic_dec_and_test(v)		(atomic_sub_return(1, (v)) == 0)
-#define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) != 0)
+#define atomic_inc_and_test(v)		(atomic_add_return(1, (v)) == 0)
 #define atomic64_sub_and_test(i,v)	(atomic64_sub_return((i), (v)) == 0)
 #define atomic64_dec_and_test(v)	(atomic64_sub_return(1, (v)) == 0)
 #define atomic64_inc_and_test(v)	(atomic64_add_return(1, (v)) != 0)

_

> Can someone say with certainty whether the s390 version is also
> wrong?
> 

Either s390's atomic_inc_and_test() is wrong, or their atomic_inc_return()
is wrong.  I think the former.


David Mosberger <davidm@napali.hpl.hp.com>


---

 25-akpm/include/asm-s390/atomic.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN include/asm-s390/atomic.h~s390-atomic_inc_and_test-fix include/asm-s390/atomic.h
--- 25/include/asm-s390/atomic.h~s390-atomic_inc_and_test-fix	Thu May 13 15:50:46 2004
+++ 25-akpm/include/asm-s390/atomic.h	Thu May 13 15:50:50 2004
@@ -72,7 +72,7 @@ static __inline__ int atomic_inc_return(
 
 static __inline__ int atomic_inc_and_test(volatile atomic_t * v)
 {
-	return __CS_LOOP(v, 1, "ar") != 0;
+	return __CS_LOOP(v, 1, "ar") == 0;
 }
 static __inline__ void atomic_dec(volatile atomic_t * v)
 {

_
