Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbfBTJ5J (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 20 Feb 2019 04:57:09 -0500
Date: Wed, 20 Feb 2019 09:57:00 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH] tools/memory-model: Remove (dep ; rfi) from ppo
Message-ID: <20190220095659.GA17578@brain-police>
References: <1550617057-4911-1-git-send-email-andrea.parri@amarulasolutions.com>
 <20190220020117.GD11787@linux.ibm.com>
 <20190220092604.GD32494@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220092604.GD32494@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>
Message-ID: <20190220095700.RFOl0Lg7AGKuBk-159RvFmbeh21V2rbh1G5gXi8tUgw@z>

On Wed, Feb 20, 2019 at 10:26:04AM +0100, Peter Zijlstra wrote:
> On Tue, Feb 19, 2019 at 06:01:17PM -0800, Paul E. McKenney wrote:
> > On Tue, Feb 19, 2019 at 11:57:37PM +0100, Andrea Parri wrote:
> > > Remove this subtle (and, AFAICT, unused) ordering: we can add it back,
> > > if necessary, but let us not encourage people to rely on this thing.
> > > 
> > > For example, the following "exists" clause can be satisfied with this
> > > change:
> > > 
> > > C dep-rfi
> > > 
> > > { }
> > > 
> > > P0(int *x, int *y)
> > > {
> > > 	WRITE_ONCE(*x, 1);
> > > 	smp_store_release(y, 1);
> > > }
> > > 
> > > P1(int *x, int *y, int *z)
> > > {
> > > 	int r0;
> > > 	int r1;
> > > 	int r2;
> > > 
> > > 	r0 = READ_ONCE(*y);
> > > 	WRITE_ONCE(*z, r0);
> > > 	r1 = smp_load_acquire(z);
> > > 	r2 = READ_ONCE(*x);
> > > }
> > > 
> > > exists (1:r0=1 /\ 1:r2=0)
> > 
> > Any objections?  If I don't hear any in a couple days, I will apply this.
> 
> IIUC you cannot build hardware that allows the above, so why would we
> allow it?

Agreed. Maybe the intention was to make the dependency between the read of
*y and the write of *z on P1 a control dependency instead? That's certainly
allowed on arm64.

Will
