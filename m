Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726654AbfCFRZp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Mar 2019 12:25:45 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x26HPeZJ046955
        for <linux-arch@vger.kernel.org>; Wed, 6 Mar 2019 12:25:44 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r2jca0kn9-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 06 Mar 2019 12:25:38 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 6 Mar 2019 17:24:52 -0000
Date: Wed, 6 Mar 2019 09:24:53 -0800
From: "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Reply-To: paulmck@linux.ibm.com
References: <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
 <20190226150450.GW32477@hirez.programming.kicks-ass.net>
 <ab631777-7cbd-4658-fb99-05d60ec5a1ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab631777-7cbd-4658-fb99-05d60ec5a1ea@gmail.com>
Message-ID: <20190306172453.GE13351@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Borislav Petkov <bp@alien8.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190306172453.dqYI462Kx_27BEjuQBqvuGsK70Dk6UB0l7aV25s_6oU@z>

On Thu, Mar 07, 2019 at 12:46:05AM +0900, Akira Yokosawa wrote:
> On Tue, 26 Feb 2019 16:04:50 +0100, Peter Zijlstra wrote:
> > On Tue, Feb 26, 2019 at 06:28:45AM -0800, Paul E. McKenney wrote:
> > 
> >> Yes, this all is a bit on the insane side from a kernel viewpoint.
> >> But the paper you found does not impose this; it has instead been there
> >> for about 20 years, back before C and C++ admitted to the existence
> >> of concurrency.  But of course compilers are getting more aggressive,
> >> and yes, some of the problems show up in single-threaded code.
> > 
> > But that paper is from last year!! It has Peter Sewell on, I'm sure he's
> > heard of concurrency.
> > 
> >> The usual response is "then cast the pointers to intptr_t!" but of
> >> course that breaks type checking.
> > 
> > I tried laundering the pointer through intptr_t, but I can't seem to
> > unbreak it.
> > 
> > 
> > root@ivb-ep:~/tmp# gcc-8 -O2 -fno-strict-aliasing  -o ptr ptr.c ; ./ptr
> > p=0x55aacdc80034 q=0x55aacdc80034
> > x=1 y=2 *p=11 *q=2
> > root@ivb-ep:~/tmp# cat ptr.c
> > #include <stdio.h>
> > #include <string.h>
> > #include <stdint.h>
> > int y = 2, x = 1;
> > int main (int argc, char **argv) {
> > 	intptr_t P = (intptr_t)&x;
> > 	intptr_t Q = (intptr_t)&y;
> > 	P += sizeof(int);
> > 	int *q = &y;
> > 	printf("p=%p q=%p\n", (int*)P, (int*)Q);
> > 	if (P == Q) {
> > 		int *p = (int *)P;
> > 		*p = 11;
> > 		printf("x=%d y=%d *p=%d *q=%d\n", x, y, *p, *q);
> > 	}
> > }
> > 
> 
> So, I'm looking at the macro RELOC_HIDE() defined in include/linux/compiler-gcc.h.
> 
> It says:
> 
> --------
> /*
>  * This macro obfuscates arithmetic on a variable address so that gcc
>  * shouldn't recognize the original var, and make assumptions about it.
>  *
>  * This is needed because the C standard makes it undefined to do
>  * pointer arithmetic on "objects" outside their boundaries and the
>  * gcc optimizers assume this is the case. In particular they
>  * assume such arithmetic does not wrap.
>  *
>    [...]
>  */
> #define RELOC_HIDE(ptr, off)						\
> ({									\
> 	unsigned long __ptr;						\
> 	__asm__ ("" : "=r"(__ptr) : "0"(ptr));				\
> 	(typeof(ptr)) (__ptr + (off));					\
> })
> --------
> 
> Looks like this macro has existed ever since the origin of Linus' git repo.
> 
> And the optimization "bug" discussed in this thread can be suppressed by
> this macro.
> 
> For example,
> 
> $ gcc -O2 -o reloc_hide reloc_hide.c; ./reloc_hide
> x=1 y=11 *p=11 *q=11
> $ cat reloc_hide.c
> #include <stdio.h>
> #include <stdint.h>
> 
> #define RELOC_HIDE(ptr, off)						\
> ({									\
> 	uintptr_t __ptr;						\
> 	__asm__ ("" : "=r"(__ptr) : "0"(ptr));				\
> 	(typeof(ptr)) (__ptr + (off));					\
> })
> 
> int y = 2, x = 1;
> int main (int argc, char **argv) {
> 	int *p = RELOC_HIDE(&x, sizeof(*p));
> 	int *q = RELOC_HIDE(&y, 0);
> 	if (p == q) {
> 		*p = 11;
> 		printf("x=%d y=%d *p=%d *q=%d\n", x, y, *p, *q);
> 	}
> }
> 
> Note that "uintptr_t" is used in this version of RELOC_HIDE() for user-land
> code.
> 
> Am I the only one who was not aware of this gcc-specific macro?

I have seen it before, but had forgotten it.  ;-)

But people on the committee seem to agree that inline assembly should
"launder" pointers, along with atomic and volatile accesses.  The case
of revalidating pointers fetched during a previous critical section for
a given lock is very much in play, but then again, we don't have any
known good use cases identified.

							Thanx, Paul
