From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Tue, 4 Apr 2017 09:50:01 +1000
Message-ID: <20170404095001.664718b8@roar.ozlabs.ibm.com>
References: <20170403081328.30266-1-npiggin@gmail.com>
        <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34496 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751384AbdDCXuU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Apr 2017 19:50:20 -0400
In-Reply-To: <CA+55aFx92vOh28CWp5zid8RzbM=5pO0Or51zS4D8M97L=69hHA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>

On Mon, 3 Apr 2017 08:31:30 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Apr 3, 2017 at 1:13 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > The loops have some restrictions on what can be used, but they are
> > intended to be small and simple so it's not generally a problem:
> >  - Don't use cpu_relax.
> >  - Don't use return or goto.
> >  - Don't use sleeping or spinning primitives.  
> 
> So you're supposed to "break" out of the loop if you want to exit
> early? Or what?

Yes, break (I put that as a comment somewhere).

> One of the issues is that with a do-while/until loop, at least the way
> you've coded it, it's always done at least once.
> 
> Which means that people will have to code the condition as
> 
>     if (cond) {
>         .. fast case..
>         return;
>     }
> 
>     spin_do {
>        ...
>     } spin_until (cond);
>     .. slow case ..
> 
> because "cpu_relax()" itself can be slightly slow.
> 
> And the way you've done it, even if there's a "break" in the loop, the
> cpu_relax() is still done (because it's done at the top).
> 
> So quite frankly, I think "while(cond) ()" semantics would be better
> than "do { } while (cond)".
> 
> Now, a lot of loops *are* of the kind where we've already handled the
> fast case earlier, so by the time we get into the loop we really are
> waiting for the condition to become true (but we knew it started out
> false). But not all.

Yeah that's a good point, I see what you mean. The important cases I've
been looked at (e.g., mutex spinning, bit spinlock, idle loops) are the
slowpath cases. But this would need to be explicit in the API so fastpaths
don't use it.

> Doing a quick
> 
>     git grep -2 cpu_relax
> 
> for existing users of cpu_relax() does imply that most of the current
> users are very much of the "cpu_relax() at the _end_ of the loop
> tests" type.
> 
> So I don't know. I think the interface sucks.

It's a bit clunky.

> What is it that POWER _actually_ wants? Not the loop - the
> "cpu_relax()" kind of thing. Can we abstract *that* better?

POWER does not have an instruction like pause. We can only set current
thread priority, and current implementations do something like allocate
issue cycles to threads based on relative priorities. So there should
be at least one or two issue cycles at low priority, but ideally we
would not be changing priority in the busy-wait loop because it can
impact other threads in the core.

I couldn't think of a good way to improve cpu_relax. Our (open source)
firmware has a cpu_relax, and it puts a bunch of nops between low and
normal priority instructions so we get some fetch cycles at low prio.
That isn't ideal though.

If you have any ideas, I'd be open to them.

I had a secondary motive for defining it as a loop, and that was using
branch hints or even asm goto to arrange the loop and exit branch
nicely. E.g., if we static predict loop exits, then we don't take a
branch miss as first thing when condition changes. This is a second
order concern though.

Thanks,
Nick
