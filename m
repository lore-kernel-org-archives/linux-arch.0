Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:35970 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfBZLaS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Feb 2019 06:30:18 -0500
Date: Tue, 26 Feb 2019 12:30:08 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226113008.GI32534@hirez.programming.kicks-ass.net>
References: <20190220092604.GD32494@hirez.programming.kicks-ass.net>
 <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226112521.GH32534@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190226113008.4_ZG9V-j15UxesqCOM95_x2WjQJQnlBgO1wo3DapsR8@z>

On Tue, Feb 26, 2019 at 12:25:21PM +0100, Peter Zijlstra wrote:
> On Tue, Feb 26, 2019 at 12:21:33PM +0100, Peter Zijlstra wrote:
> 
> > Also; we need to find a GCC person to find/give us a knob to kill this
> > entire class of nonsense. This is just horrible broken shit:
> > 
> > 
> > ~/tmp# gcc -O2 -fno-strict-aliasing  -o ptr ptr.c ; ./ptr
> > p=0x5635dd3d5034 q=0x5635dd3d5034
> > x=1 y=2 *p=11 *q=2
> > ~/tmp# cat ptr.c
> > #include <stdio.h>
> > #include <string.h>
> > int y = 2, x = 1;
> > int main (int argc, char **argv) {
> > 	int *p = &x + argc;
> 
> damn; wrong version; that should've been: s/argc/1/
> same result though.

Note that gcc (as used above) was:

  gcc (Debian 7.3.0-3) 7.3.0

When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
still broken.

  gcc-8 (Debian 8.2.0-21) 8.2.0
  gcc (Debian 7.3.0-3) 7.3.0
  gcc-6 (Debian 6.4.0-12) 6.4.0 20180123
  gcc-5 (Debian 5.5.0-8) 5.5.0 20171010
  gcc-4.6 (Debian 4.6.3-14) 4.6.3

all generate the exact same broken crap with the '+ 1' variant.

> > 	int *q = &y;
> > 	printf("p=%p q=%p\n", p, q);
> > 	if (!memcmp(&p, &q, sizeof(p))) {
> > 		*p = 11;
> > 		printf("x=%d y=%d *p=%d *q=%d\n", x, y, *p, *q);
> > 	}
> > }
