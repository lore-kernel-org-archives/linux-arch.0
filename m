From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Fri, 29 May 2020 22:53:31 +0200
Message-ID: <20200529205331.GV2483@worktop.programming.kicks-ass.net>
References: <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525112521.GD317569@hirez.programming.kicks-ass.net>
 <20200525154730.GW2869@paulmck-ThinkPad-P72>
 <20200525170257.GA325280@hirez.programming.kicks-ass.net>
 <20200525172154.GZ2869@paulmck-ThinkPad-P72>
 <20200528220047.GB211369@google.com>
 <20200528221659.GS2483@worktop.programming.kicks-ass.net>
 <CAEf4BzYf6jjrStc08R1bDASFyEdKj6vYg_MOaipUJ3vbdqNrSg@mail.gmail.com>
 <20200529123626.GL706495@hirez.programming.kicks-ass.net>
 <CAEf4Bzb9D1jTdmUzopc35qmFopaW-UfvLO9ohFsFsBuLVm0ZCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE2Uxs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 16:53:48 -0400
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb9D1jTdmUzopc35qmFopaW-UfvLO9ohFsFsBuLVm0ZCw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>, "Paul E. McKenney" <paulmck@kernel.org>, Andrii Nakryiko <andriin@fb.com>, Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com, will@kernel.org, Boqun Feng <boqun.feng@gmail.com>, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, Akira Yokosawa <akiyks@gmail.com>, dlustig@nvidia.com, open list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Fri, May 29, 2020 at 01:01:51PM -0700, Andrii Nakryiko wrote:

> > question though; why are you using xchg() for the commit? Isn't that
> > more expensive than it should be?
> >
> > That is, why isn't that:
> >
> >   smp_store_release(&hdr->len, new_len);
> >
> > ? Or are you needing the smp_mb() for the store->load ordering for the
> > ->consumer_pos load? That really needs a comment.
> 
> Yeah, smp_store_release() is not strong enough, this memory barrier is
> necessary. And yeah, I'll follow up with some more comments, that's
> been what Joel requested as well.

Ok, great.

> > I think you can get rid of the smp_load_acquire() there, you're ordering
> > a load->store and could rely on the branch to do that:
> >
> >         cons_pos = READ_ONCE(&rb->consumer_pos) & rb->mask;
> >         if ((flags & BPF_RB_FORCE_WAKEUP) || (cons_pos == rec_pos && !(flags &BPF_RB_NO_WAKEUP))
> >                 irq_work_queue(&rq->work);
> >
> > should be a control dependency.
> 
> Could be. I tried to keep consistent
> smp_load_acquire/smp_store_release usage to keep it simpler. It might
> not be the absolutely minimal amount of ordering that would still be
> correct. We might be able to tweak and tune this without changing
> correctness.

We can even rely on the irq_work_queue() being an atomic, but sure, get
it all working and correct first before you wreck it ;-)
