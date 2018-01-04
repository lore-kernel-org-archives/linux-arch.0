From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH] asm/generic: introduce if_nospec and nospec_barrier
Date: Thu, 4 Jan 2018 14:20:49 -0800
Message-ID: <CA+55aFwRh++2cyfi1ZXnWCwGv=kuSjft-RcSCDW89T5g=0RB2Q@mail.gmail.com>
References: <20180103223827.39601-1-mark.rutland@arm.com> <151502463248.33513.5960736946233335087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CA+55aFzSYExr33w849=3o+2XGr9pUKpFucc5p-kKbEy20VVLPA@mail.gmail.com>
 <20180104010754.22ca6a74@alans-desktop> <CAPcyv4ge14OPyfoQvXHLyXwqX7cjWvm4DouUOc=WrNo1Lr9Qyw@mail.gmail.com>
 <alpine.DEB.2.20.1801040728140.2148@hadrien> <CAPcyv4gLcC7vsxLUCEJdEvDRf4AhgF0x1fpTEcH7AOe=kuNfoQ@mail.gmail.com>
 <20180104192648.GA10427@amd> <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f181.google.com ([209.85.223.181]:42272 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752550AbeADWUv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Jan 2018 17:20:51 -0500
In-Reply-To: <CAPcyv4g0ZEP_LuXwsf1rJGaG65UHn5sj=DMyMdCnzKD9T-vnyg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, Julia Lawall <julia.lawall@lip6.fr>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg KH <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Elena Reshetova <elena.reshetova@intel.com>, Alan Cox <alan@linux.intel.com>, Dan Carpenter <dan.carpenter@oracle.com>

On Thu, Jan 4, 2018 at 1:43 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> As far as I understand the presence of array2[val] discloses more
> information, but in terms of the cpu taking an action that it is
> observable in the cache that's already occurred when "val =
> array[attacker_controlled_index];" is speculated. Lets err on the side
> of caution and shut down all the observable actions that are already
> explicitly gated by an input validation check. In other words, a low
> bandwidth information leak is still a leak.

I do think that the change to __fcheck_files() is interesting, because
that one is potentially rather performance-sensitive.

And the data access speculation annotations we presumably won't be
able to get rid of eventually with newer hardware, so to some degree
this is a bigger deal than the random hacks that affect _current_
hardware but hopefully hw designers will fix in the future.

That does make me think that we should strive to perhaps use the same
model that the BPF people are looking at: making the address
generation part of the computation, rather than using a barrier. I'm
not sure how expensive lfence is, but from every single time ever in
the history of man, barriers have been a bad idea. Which makes me
suspect that lfence is a bad idea too.

If one common pattern is going to be bounces checking array accesses
like this, then we probably should strive to turn

    if (index < bound)
       val = array[index];

into making sure we actually have that data dependency on the address
instead. Whether that is done with a "select" instruction or by using
an "and" with -1/0 is then a small detail.

I wonder if we can make the interface be something really straightforward:

 - specify a special

        array_access(array, index, max)

    operation, and say that the access is guaranteed to not
speculatively access outside the array, and return 0 (of the type
"array entry") if outside the range.

 - further specify that it's safe as READ_ONCE() and/or RCU access
(and only defined for native data types)

That would turn that existing __fcheck_files() from

        if (fd < fdt->max_fds)
                return rcu_dereference_raw(fdt->fd[fd]);
        return NULL;

into just

        return array_access(fdt->fd, fd, ft->max_fds);

and the *implementation* might be architecture-specific, but one
particular implementation would be something like simply

#define array_access(base, idx, max) ({                         \
        union { typeof(base[0]) _val; unsigned long _bit; } __u;\
        unsigned long _i = (idx);                               \
        unsigned long _m = (max);                               \
        unsigned long _mask = _i < _m ? ~0 : 0;                 \
        OPTIMIZER_HIDE_VAR(_mask);                              \
        __u._val = base[_i & _mask];                            \
        __u._bit &= _mask;                                      \
        __u._val; })

(Ok, the above is not exhaustively tested, but you get the idea, and
gcc doesn't seem to mess it up *too* badly).

No barriers anywhere, except for the compiler barrier to make sure the
compiler doesn't see how it all depends on that comparison, and
actually uses two "and" instructions to fix the address and the data.

How slow is lfence? Maybe it's not slow, but the above looks like it
*might* be better..

                     Linus
