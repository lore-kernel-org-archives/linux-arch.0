Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60712 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBZLVo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 06:21:44 -0500
Date: Tue, 26 Feb 2019 12:21:33 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226112133.GG32534@hirez.programming.kicks-ass.net>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226104551.GF32534@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190226112133.0xnwg4wcX0ndgphcucj5HprOJqIGeljGkFjkNP3Uyis@z>

On Tue, Feb 26, 2019 at 11:45:51AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 26, 2019 at 10:30:09AM +0100, Peter Zijlstra wrote:
> > On Mon, Feb 25, 2019 at 09:55:17AM -0800, Paul E. McKenney wrote:
> > > But if you know of any code in the Linux kernel that needs to compare
> > > pointers, one of which might be in the process of being freed, please
> > > do point me at it.
> > 
> > I'm having the utmost difficulty of understanding why that would be a
> > problem. It's just a value. Freeing memory does not affect the actual
> > memory or any pointers to it.
> > 
> > *confusion*
> > 
> > None of this makes any kind of sense.
> 
> I found and started to read:
> 
>   www.open-std.org/jtc1/sc22/wg14/www/docs/n2311.pdf
> 
> and that's all massive bong-hits. That's utterly insane.
> 
> Even the proposed semantics are crazy; they include UB and are therefore
> broken on principle. But also; the provenance ID has words like:
> "allocated storage duration", how is that well defined in the context of
> concurrent execution?
> 
> Also, isn't the kernel filled with inter-object pointer arithmetic?
> 
> PNVI also looks like something that simply cannot work; how are we at
> compile time supposed to know the active (concurrent modified) heap
> layout. What is a 'live' object?

Also; we need to find a GCC person to find/give us a knob to kill this
entire class of nonsense. This is just horrible broken shit:


~/tmp# gcc -O2 -fno-strict-aliasing  -o ptr ptr.c ; ./ptr
p=0x5635dd3d5034 q=0x5635dd3d5034
x=1 y=2 *p=11 *q=2
~/tmp# cat ptr.c
#include <stdio.h>
#include <string.h>
int y = 2, x = 1;
int main (int argc, char **argv) {
	int *p = &x + argc;
	int *q = &y;
	printf("p=%p q=%p\n", p, q);
	if (!memcmp(&p, &q, sizeof(p))) {
		*p = 11;
		printf("x=%d y=%d *p=%d *q=%d\n", x, y, *p, *q);
	}
}
