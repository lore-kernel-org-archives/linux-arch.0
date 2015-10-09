Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59618 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758060AbbJIL0C (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2015 07:26:02 -0400
Date: Fri, 9 Oct 2015 13:25:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151009112554.GB3816@twins.programming.kicks-ass.net>
References: <1444215568-24732-1-git-send-email-will.deacon@arm.com>
 <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008125937.GH16807@arm.com>
 <20151008221716.GF3910@linux.vnet.ibm.com>
 <20151009095129.GF26278@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151009095129.GF26278@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>, Anton Blanchard <anton@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20151009112554.c29Fb4Jzd-1KAYD6EJc8nhqFm395WL31hd0DwCMxNmI@z>

On Fri, Oct 09, 2015 at 10:51:29AM +0100, Will Deacon wrote:
> > The corresponding litmus tests are below.
> 
> How do people feel about including these in memory-barriers.txt? I find
> them considerably easier to read than our current kernel code + list of
> possible orderings + wall of text, but there's a good chance that my
> brain has been corrupted from staring at this stuff for too long.

Your brain is corrupt (but then, so probably is mine, just differently
so).

I've not yet mastered the knack of reading those things; then again, I
suspect its not too hard, just not something I've had the time to play
with.
