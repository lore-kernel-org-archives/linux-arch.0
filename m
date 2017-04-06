From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Thu, 6 Apr 2017 12:41:52 -0700
Message-ID: <CA+55aFzvRiVx3dvXaQUpYwoHq0DnrV9RPXWnqSeb9b80DFosHA@mail.gmail.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com> <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com> <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com> <20170406141352.GF18204@arm.com>
 <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
 <20170406163651.hj7apd63uxupgdb3@hirez.programming.kicks-ass.net>
 <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com> <20170406192342.GC3093@worktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f42.google.com ([209.85.214.42]:38697 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752035AbdDFTly (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2017 15:41:54 -0400
In-Reply-To: <20170406192342.GC3093@worktop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>, David Miller <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>

On Thu, Apr 6, 2017 at 12:23 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Something like so then. According to the SDM mwait is a no-op if we do
> not execute monitor first. So this variant should get the first
> iteration without expensive instructions.

No, the problem is that we *would* have executed a prior monitor that
could still be pending - from a previous invocation of
smp_cond_load_acquire().

Especially with spinlocks, these things can very much happen back-to-back.

And it would be pending with a different address (the previous
spinlock) that might not have changed since then (and might not be
changing), so now we might actually be pausing in mwait waiting for
that *other* thing to change.

So it would probably need to do something complicated like

  #define smp_cond_load_acquire(ptr, cond_expr)                         \
  ({                                                                    \
        typeof(ptr) __PTR = (ptr);                                      \
        typeof(*ptr) VAL;                                               \
        do {                                                            \
                VAL = READ_ONCE(*__PTR);                                \
                if (cond_expr)                                          \
                        break;                                          \
                for (;;) {                                              \
                        ___monitor(__PTR, 0, 0);                        \
                        VAL = READ_ONCE(*__PTR);                        \
                        if (cond_expr) break;                           \
                        ___mwait(0xf0 /* C0 */, 0);                     \
                }                                                       \
        } while (0)                                                     \
        smp_acquire__after_ctrl_dep();                                  \
        VAL;                                                            \
  })

which might just generate nasty enough code to not be worth it.

I dunno

             Linus
