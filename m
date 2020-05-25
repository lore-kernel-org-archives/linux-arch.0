From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Mon, 25 May 2020 10:45:44 -0700
Message-ID: <20200525174544.GA21495@paulmck-ThinkPad-P72>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
 <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388621AbgEYRpo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 25 May 2020 13:45:44 -0400
Content-Disposition: inline
In-Reply-To: <20200525172154.GZ2869@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andriin@fb.com>, Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com, will@kernel.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>

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

s/printk()/BPF output/

One of those days...  :-/

							Thanx, Paul
