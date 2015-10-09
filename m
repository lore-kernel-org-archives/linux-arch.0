From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Fri, 9 Oct 2015 13:41:28 +0100
Message-ID: <20151009124127.GO26278@arm.com>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
 <20151009110246.GY3816@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38985 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432AbbJIMlb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 9 Oct 2015 08:41:31 -0400
Content-Disposition: inline
In-Reply-To: <20151009110246.GY3816@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On Fri, Oct 09, 2015 at 01:02:46PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2015 at 10:40:39AM +0100, Will Deacon wrote:
> > Stepping back a second, I believe that there are three cases:
> > 
> > 
> >  RELEASE X -> ACQUIRE Y (same CPU)
> >    * Needs a barrier on TSO architectures for full ordering
> 	+PPC
> 
> >  UNLOCK X -> LOCK Y (same CPU)
> >    * Needs a barrier on PPC for full ordering
> 
> 
> >  RELEASE X -> ACQUIRE X (different CPUs)
>     * Fully ordered everywhere...
>     * ... but needs a barrier on TSO + PPC to become a full barrier
> 
> >  UNLOCK X -> ACQUIRE X (different CPUs)
> 
> s/ACQUIRE/LOCK/ ?

Yes, sorry.

Will
