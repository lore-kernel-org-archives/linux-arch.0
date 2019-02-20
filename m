Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55228 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBTNou (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Feb 2019 08:44:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so6714827wmh.4
        for <linux-arch@vger.kernel.org>; Wed, 20 Feb 2019 05:44:47 -0800 (PST)
Date: Wed, 20 Feb 2019 14:44:33 +0100
From: Andrea Parri <andrea.parri@amarulasolutions.com>
Subject: Re: [PATCH v3 1/7] dump_stack: Support adding to the dump stack arch
 description
Message-ID: <20190220134433.GA4932@andrea>
References: <20190207124635.3885-1-mpe@ellerman.id.au>
 <20190211125035.GA1562@andrea>
 <20190211143859.dd2lkccxod3f2fwn@pathway.suse.cz>
 <20190219233925.GA5648@andrea>
 <87va1e7pw2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87va1e7pw2.fsf@concordia.ellerman.id.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Petr Mladek <pmladek@suse.com>, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, tj@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, dyoung@redhat.com, sergey.senozhatsky@gmail.com, Steven Rostedt <rostedt@goodmis.org>
Message-ID: <20190220134433.TT3_fpOPgLMHn8Pwn0HYNZoMOOEdfJ-y01LFgfDUMQs@z>

> >> > > +		 * Order the stores above in vsnprintf() vs the store of the
> >> > > +		 * space below which joins the two strings. Note this doesn't
> >> > > +		 * make the code truly race free because there is no barrier on
> >> > > +		 * the read side. ie. Another CPU might load the uninitialised
> >> > > +		 * tail of the buffer first and then the space below (rather
> >> > > +		 * than the NULL that was there previously), and so print the
> >> > > +		 * uninitialised tail. But the whole string lives in BSS so in
> >> > > +		 * practice it should just see NULLs.
> >> > 
> >> > The comment doesn't say _why_ we need to order these stores: IOW, what
> >> > will or can go wrong without this order?  This isn't clear to me.
> >> >
> >> > Another good practice when adding smp_*-constructs (as discussed, e.g.,
> >> > at KS'18) is to indicate the matching construct/synch. mechanism.
> >> 
> >> Yes, one barrier without a counter-part is suspicious.
> >
> > As is this silence...,
> >
> > Michael, what happened to this patch? did you submit a new version?
> 
> No, I'm just busy, it's the merge window next week :)

Got it.


> 
> I thought the comment was pretty clear, if the stores are observed out
> of order we might print the uninitialised tail.
> 
> And the barrier on the read side would need to be in printk somewhere,
> which is obviously unpleasant.

Indeed.


> 
> >> If the parallel access is really needed then we could define the
> >> current length as atomic_t and use:
> >> 
> >> 	+ atomic_cmpxchg() to reserve the space for the string
> >> 	+ %*s to limit the printed length
> >> 
> >> In the worst case, we would print an incomplete string.
> >> See below for a sample code.
> >
> > Seems worth exploring, IMO; but I'd like to first hear _clear about
> > the _intended semantics (before digging into alternatives)...
> 
> It is not my intention to support concurrent updates of the string. The
> idea is you setup the string early in boot.

Understood, thanks for the clarification.


> 
> The concern with a concurrent reader is simply that the string is dumped
> in the panic path, and you never really know when you're going to panic.
> Even if you only write to the string before doing SMP bringup you might
> still have another CPU go rogue and panic before then.
> 
> But I probably should have just not added the barrier, it's over
> paranoid and will almost certainly never matter in practice.

Oh, well, I can only echo you: if you don't care about the stores being
_observed_ out of order, you could simply remove the barrier; if you do
care, then you need "more paranoid" on the readers side.  ;-)

  Andrea


> 
> cheers
