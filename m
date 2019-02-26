Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:39452 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfBZLiX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 26 Feb 2019 06:38:23 -0500
Date: Tue, 26 Feb 2019 12:38:13 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190226113813.GA14753@zn.tnic>
References: <20190220131456.GA3215@andrea>
 <20190220132714.GI32494@hirez.programming.kicks-ass.net>
 <20190222112128.GA7213@andrea>
 <20190222130014.GY32494@hirez.programming.kicks-ass.net>
 <20190225175517.GK4072@linux.ibm.com>
 <20190226093009.GS32477@hirez.programming.kicks-ass.net>
 <20190226104551.GF32534@hirez.programming.kicks-ass.net>
 <20190226112133.GG32534@hirez.programming.kicks-ass.net>
 <20190226112521.GH32534@hirez.programming.kicks-ass.net>
 <20190226113008.GI32534@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190226113008.GI32534@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will.deacon@arm.com>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190226113813.bVraUVvIxnIh9Bm6SlJnbc5WvWnKVeAO6nOAVqzs6cE@z>

On Tue, Feb 26, 2019 at 12:30:08PM +0100, Peter Zijlstra wrote:
> When I used the argc variant, gcc-8 'works', but with s/argc/1/ it is
> still broken.

As requested on IRC:

$ gcc --version
gcc (SUSE Linux) 4.8.5
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

$ cat ptr.c
#include <stdio.h>
#include <string.h>
int y = 2, x = 1;
int main (int argc, char **argv) {
        int *p = &x + 1;
        int *q = &y;
        printf("p=%p q=%p\n", p, q);
        if (!memcmp(&p, &q, sizeof(p))) {
                *p = 11;
                printf("x=%d y=%d *p=%d *q=%d\n", x, y, *p, *q);

$ gcc -O2 -fno-strict-aliasing  -o ptr ptr.c ; ./ptr
p=0x601044 q=0x601044
x=1 y=2 *p=11 *q=2

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
