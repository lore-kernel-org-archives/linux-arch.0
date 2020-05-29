From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: Some -serious- BPF-related litmus tests
Date: Fri, 29 May 2020 13:23:01 -0400
Message-ID: <20200529172301.GB196085@google.com>
References: <20200522003850.GA32698@paulmck-ThinkPad-P72>
 <20200522094407.GK325280@hirez.programming.kicks-ass.net>
 <20200522143201.GB32434@rowland.harvard.edu>
 <20200522174352.GJ2869@paulmck-ThinkPad-P72>
 <006e2bc6-7516-1584-3d8c-e253211c157e@fb.com>
 <20200525145325.GB2066@tardis>
 <CAEf4BzYCjbnU=cNyLnYRoZdMPKnBP4w8t+VRkXrC1GW-aFVkEA@mail.gmail.com>
 <20200528214823.GA211369@google.com>
 <CAEf4BzbzyA0mn7O-+x2peGa9WUuaGSi0+Gpyy-6t5iJwVLYf5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgE2RXG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 May 2020 13:23:06 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D362C08C5C8
        for <linux-arch@vger.kernel.org>; Fri, 29 May 2020 10:23:03 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f18so2940088qkh.1
        for <linux-arch@vger.kernel.org>; Fri, 29 May 2020 10:23:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAEf4BzbzyA0mn7O-+x2peGa9WUuaGSi0+Gpyy-6t5iJwVLYf5A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Andrii Nakryiko <andriin@fb.com>, "Paul E . McKenney" <paulmck@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Peter Zijlstra <peterz@infradead.org>, parri.andrea@gmail.com, will@kernel.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, Akira Yokosawa <akiyks@gmail.com>, dlustig@nvidia.com, open list <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Thu, May 28, 2020 at 09:38:35PM -0700, Andrii Nakryiko wrote:
> On Thu, May 28, 2020 at 2:48 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> >
> > On Mon, May 25, 2020 at 11:38:23AM -0700, Andrii Nakryiko wrote:
> > > On Mon, May 25, 2020 at 7:53 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> > > >
> > > > Hi Andrii,
> > > >
> > > > On Fri, May 22, 2020 at 12:38:21PM -0700, Andrii Nakryiko wrote:
> > > > > On 5/22/20 10:43 AM, Paul E. McKenney wrote:
> > > > > > On Fri, May 22, 2020 at 10:32:01AM -0400, Alan Stern wrote:
> > > > > > > On Fri, May 22, 2020 at 11:44:07AM +0200, Peter Zijlstra wrote:
> > > > > > > > On Thu, May 21, 2020 at 05:38:50PM -0700, Paul E. McKenney wrote:
> > > > > > > > > Hello!
> > > > > > > > >
> > > > > > > > > Just wanted to call your attention to some pretty cool and pretty serious
> > > > > > > > > litmus tests that Andrii did as part of his BPF ring-buffer work:
> > > > > > > > >
> > > > > > > > > https://lore.kernel.org/bpf/20200517195727.279322-3-andriin@fb.com/
> > > > > > > > >
> > > > > > > > > Thoughts?
> > > > > > > >
> > > > > > > > I find:
> > > > > > > >
> > > > > > > >         smp_wmb()
> > > > > > > >         smp_store_release()
> > > > > > > >
> > > > > > > > a _very_ weird construct. What is that supposed to even do?
> > > > > > >
> > > > > > > Indeed, it looks like one or the other of those is redundant (depending
> > > > > > > on the context).
> > > > > >
> > > > > > Probably.  Peter instead asked what it was supposed to even do.  ;-)
> > > > >
> > > > > I agree, I think smp_wmb() is redundant here. Can't remember why I thought
> > > > > that it's necessary, this algorithm went through a bunch of iterations,
> > > > > starting as completely lockless, also using READ_ONCE/WRITE_ONCE at some
> > > > > point, and settling on smp_read_acquire/smp_store_release, eventually. Maybe
> > > > > there was some reason, but might be that I was just over-cautious. See reply
> > > > > on patch thread as well ([0]).
> > > > >
> > > > >   [0] https://lore.kernel.org/bpf/CAEf4Bza26AbRMtWcoD5+TFhnmnU6p5YJ8zO+SoAJCDtp1jVhcQ@mail.gmail.com/
> > > > >
> > > >
> > > > While we are at it, could you explain a bit on why you use
> > > > smp_store_release() on consumer_pos? I ask because IIUC, consumer_pos is
> > > > only updated at consumer side, and there is no other write at consumer
> > > > side that we want to order with the write to consumer_pos. So I fail
> > > > to find why smp_store_release() is necessary.
> > > >
> > > > I did the following modification on litmus tests, and I didn't see
> > > > different results (on States) between two versions of litmus tests.
> > > >
> > >
> > > This is needed to ensure that producer can reliably detect whether it
> > > needs to trigger poll notification.
> >
> > Boqun's question is on the consumer side though. Are you saying that on the
> > consumer side, the loads prior to the smp_store_release() on the consumer
> > side should have been seen by the consumer?  You are already using
> > smp_load_acquire() so that should be satisified already because the
> > smp_load_acquire() makes sure that the smp_load_acquire()'s happens before
> > any future loads and stores.
> 
> Consumer is reading two things: producer_pos and each record's length
> header, and writes consumer_pos. I re-read this paragraph many times,
> but I'm still a bit confused on what exactly you are trying to say.

This is what I was saying in the other thread. I think you missed that
comment. If you are adding litmus documentation, at least it should be clear
what memory ordering is being verified. Both me and Boqun tried to remove a
memory barrier each and the test still passes. So what exactly are you
verifying from a memory consistency standpoint? I know you have those various
rFail things and conditions - but I am assuming the goal here is to verify
memory consistency as well. Or are we just throwing enough memory barriers at
the problem to make sure the test passes, without understanding exactly what
ordering is needed?

> Can you please specify in each case release()/acquire() of which
> variable you are talking about?

I don't want to speculate and confuse the thread more. I am afraid the burden
of specifying what the various release/acquire orders is on the author of the
code introducing the memory barriers ;-). That is, IMHO you should probably add
code comments in the test about why a certain memory barrier is needed.

That said, I need to do more diligence and read the actual BPF ring buffer
code to understand what you're modeling. I will try to make time to do that.

thanks!

 - Joel
