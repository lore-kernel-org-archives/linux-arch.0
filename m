Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:53506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfBZPFL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 10:05:11 -0500
Date: Tue, 26 Feb 2019 16:04:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226150450.GW32477@hirez.programming.kicks-ass.net>
References: <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
 <20190226113813.GA14753@zn.tnic>
 <20190226134906.GG32494@hirez.programming.kicks-ass.net>
 <20190226142845.GK4072@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226142845.GK4072@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Borislav Petkov <bp@alien8.de>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190226150450.3AlMVRZPoAJs7KTtxujxY6ZHZ3kVdJEca9yBVPhRk4U@z>

On Tue, Feb 26, 2019 at 06:28:45AM -0800, Paul E. McKenney wrote:

> Yes, this all is a bit on the insane side from a kernel viewpoint.
> But the paper you found does not impose this; it has instead been there
> for about 20 years, back before C and C++ admitted to the existence
> of concurrency.  But of course compilers are getting more aggressive,
> and yes, some of the problems show up in single-threaded code.

But that paper is from last year!! It has Peter Sewell on, I'm sure he's
heard of concurrency.

> The usual response is "then cast the pointers to intptr_t!" but of
> course that breaks type checking.

I tried laundering the pointer through intptr_t, but I can't seem to
unbreak it.


root@ivb-ep:~/tmp# gcc-8 -O2 -fno-strict-aliasing  -o ptr ptr.c ; ./ptr
p=0x55aacdc80034 q=0x55aacdc80034
x=1 y=2 *p=11 *q=2
root@ivb-ep:~/tmp# cat ptr.c
#include <stdio.h>
#include <string.h>
#include <stdint.h>
int y = 2, x = 1;
int main (int argc, char **argv) {
	intptr_t P = (intptr_t)&x;
	intptr_t Q = (intptr_t)&y;
	P += sizeof(int);
	int *q = &y;
	printf("p=%p q=%p\n", (int*)P, (int*)Q);
	if (P == Q) {
		int *p = (int *)P;
		*p = 11;
		printf("x=%d y=%d *p=%d *q=%d\n", x, y, *p, *q);
	}
}
