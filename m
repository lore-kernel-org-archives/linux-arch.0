Return-Path: <SRS0=IHIJ=AU=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgGIIb2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jul 2020 04:31:28 -0400
Date: Thu, 9 Jul 2020 10:31:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Message-ID: <20200709083113.GI597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <20200708084106.GE597537@hirez.programming.kicks-ass.net>
 <a9834278-25bf-90e9-10f2-cd10e5407ff6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9834278-25bf-90e9-10f2-cd10e5407ff6@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
Message-ID: <20200709083113.3QR0XdD3nqUikHHEvbF8GgwVQHa7B8LBTcS2gRlUdOY@z>

On Wed, Jul 08, 2020 at 07:54:34PM -0400, Waiman Long wrote:
> On 7/8/20 4:41 AM, Peter Zijlstra wrote:
> > On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
> > > Yes, powerpc could certainly get more performance out of the slow
> > > paths, and then there are a few parameters to tune.
> > Can you clarify? The slow path is already in use on ARM64 which is weak,
> > so I doubt there's superfluous serialization present. And Will spend a
> > fair amount of time on making that thing guarantee forward progressm, so
> > there just isn't too much room to play.
> > 
> > > We don't have a good alternate patching for function calls yet, but
> > > that would be something to do for native vs pv.
> > Going by your jump_label implementation, support for static_call should
> > be fairly straight forward too, no?
> > 
> >    https://lkml.kernel.org/r/20200624153024.794671356@infradead.org
> > 
> Speaking of static_call, I am also looking forward to it. Do you have an
> idea when that will be merged?

0day had one crash on the last round, I think Steve send a fix for that
last night and I'll go look at it.

That said, the last posting got 0 feedback, so either everybody is
really happy with it, or not interested. So let us know in the thread,
with some review feedback.

Once I get through enough of the inbox to actually find the fix and test
it, I'll also update the thread, and maybe threaten to merge it if
everybody stays silent :-)
