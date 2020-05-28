From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Thu, 28 May 2020 18:00:47 -0400
Message-ID: <20200528220047.GB211369@google.com>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
 <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436730AbgE1WAv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 28 May 2020 18:00:51 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB75DC08C5C6
        for <linux-arch@vger.kernel.org>; Thu, 28 May 2020 15:00:50 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id w3so456374qkb.6
        for <linux-arch@vger.kernel.org>; Thu, 28 May 2020 15:00:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20200525172154.GZ2869@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andriin@fb.com>, Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>

On Mon, May 25, 2020 at 10:21:54AM -0700, Paul E. McKenney wrote:
> On Mon, May 25, 2020 at 07:02:57PM +0200, Peter Zijlstra wrote:
> > On Mon, May 25, 2020 at 08:47:30AM -0700, Paul E. McKenney wrote:
> > > On Mon, May 25, 2020 at 01:25:21PM +0200, Peter Zijlstra wrote:
> > 
> > > > That is; how can you use a spinlock on the producer side at all?
> > > 
> > > So even trylock is now forbidden in NMI handlers?  If so, why?
> > 
> > The litmus tests don't have trylock.
> 
> Fair point.
> 
> > But you made me look at the actual patch:
> > 
> > +static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
> > +{
> > +	unsigned long cons_pos, prod_pos, new_prod_pos, flags;
> > +	u32 len, pg_off;
> > +	struct bpf_ringbuf_hdr *hdr;
> > +
> > +	if (unlikely(size > RINGBUF_MAX_RECORD_SZ))
> > +		return NULL;
> > +
> > +	len = round_up(size + BPF_RINGBUF_HDR_SZ, 8);
> > +	cons_pos = smp_load_acquire(&rb->consumer_pos);
> > +
> > +	if (in_nmi()) {
> > +		if (!spin_trylock_irqsave(&rb->spinlock, flags))
> > +			return NULL;
> > +	} else {
> > +		spin_lock_irqsave(&rb->spinlock, flags);
> > +	}
> > 
> > And that is of course utter crap. That's like saying you don't care
> > about your NMI data.
> 
> Almost.  It is really saying that -if- there is sufficient lock
> contention, printk()s will be lost.  Just as they always have been if
> there is more printk() volume than can be accommodated.

Any idea why this choice of locking-based ring buffer implementation in BPF?
The ftrace ring buffer can support NMI interruptions as well for writes.

Also, is it possible for BPF to reuse the ftrace ring buffer implementation
or does it not meet the requirements?

thanks,

 - Joel
