From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 1/2] arm64: mm: Use READ_ONCE/WRITE_ONCE when
 accessing page tables
Date: Thu, 28 Sep 2017 09:45:35 +0100
Message-ID: <20170928084535.GA19060@arm.com>
References: <1506527369-19535-1-git-send-email-will.deacon@arm.com>
 <1506527369-19535-2-git-send-email-will.deacon@arm.com>
 <20170928083801.m6rb4frbbgzgam2o@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53682 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752102AbdI1IpW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 28 Sep 2017 04:45:22 -0400
Content-Disposition: inline
In-Reply-To: <20170928083801.m6rb4frbbgzgam2o@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: paulmck@linux.vnet.ibm.com, kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org, ynorov@caviumnetworks.com, rruigrok@codeaurora.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com

On Thu, Sep 28, 2017 at 10:38:01AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 27, 2017 at 04:49:28PM +0100, Will Deacon wrote:
> > In many cases, page tables can be accessed concurrently by either another
> > CPU (due to things like fast gup) or by the hardware page table walker
> > itself, which may set access/dirty bits. In such cases, it is important
> > to use READ_ONCE/WRITE_ONCE when accessing page table entries so that
> > entries cannot be torn, merged or subject to apparent loss of coherence.
> 
> In fact, we should use lockless_dereference() for many of them. Yes
> Alpha is the only one that cares about the difference between that and
> READ_ONCE() and they do have the extra barrier, but if we're going to do
> this, we might as well do it 'right' :-)

I know this sounds daft, but I think one of the big reasons why
lockless_dereference() doesn't get an awful lot of use is because it's
such a mouthful! Why don't we just move the smp_read_barrier_depends()
into READ_ONCE? Would anybody actually care about the potential impact on
Alpha (which, frankly, is treading on thin ice given the low adoption of
lockless_dereference())?

> Also, a very long standing item on my TODO list is to see how much of it
> we can unify across the various architectures, because there's a giant
> amount of boiler plate involved with all this.

Yeah, I'd be happy to help with that as a separate series. I already tripped
over 5 or 6 page table walkers in arch/arm64/ alone :(

Will
