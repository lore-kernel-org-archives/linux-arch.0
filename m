From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Date: Fri, 9 Oct 2015 13:13:28 +0200
Message-ID: <20151009111328.GA3816@twins.programming.kicks-ass.net>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:54046 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbbJILNi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2015 07:13:38 -0400
Content-Disposition: inline
In-Reply-To: <20151009094039.GD26278@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

On Fri, Oct 09, 2015 at 10:40:39AM +0100, Will Deacon wrote:
> 
> >  - RELEASE -> ACQUIRE _chains_ (on shared variables) preserve causality,
> >    (because each link is fully ordered) but are not transitive.
> 
> Yup, and that's the same for UNLOCK -> LOCK, too.

Agreed, except RELEASE/ACQUIRE is more RCpc than UNLOCK/LOCK.

IFF we can get UNLOCK/LOCK as RCsc the chains are strongly transitive,
unlike the RELEASE/ACQUIRE chains, which will be weakly so.
