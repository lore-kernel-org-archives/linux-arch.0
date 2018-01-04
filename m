From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 4/4] bpf: inhibit speculated out-of-bounds pointers
Date: Thu, 4 Jan 2018 10:59:58 +0000
Message-ID: <20180104105958.vls2zxbxscqr46bm@salmiak>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <20180103223827.39601-5-mark.rutland@arm.com>
 <20180103234529.GA32035@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59178 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752159AbeADLAF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Jan 2018 06:00:05 -0500
Content-Disposition: inline
In-Reply-To: <20180103234529.GA32035@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Thu, Jan 04, 2018 at 12:45:29AM +0100, Peter Zijlstra wrote:
> On Wed, Jan 03, 2018 at 10:38:27PM +0000, Mark Rutland wrote:
> > Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
> > memory accesses under a bounds check may be speculated even if the
> > bounds check fails, providing a primitive for building a side channel.
> > 
> > The EBPF map code has a number of such bounds-checks accesses in
> > map_lookup_elem implementations. This patch modifies these to use the
> > nospec helpers to inhibit such side channels.
> > 
> > The JITted lookup_elem implementations remain potentially vulnerable,
> > and are disabled (with JITted code falling back to the C
> > implementations).
> 
> Since this is now public, let me re-iterate that I don't particularly
> like this approach. If you have to kill the JIT, could we please keep
> that in the arch JIT implementation?

Hopefully, killing the JIT is a temporary bodge. I agree that we want the arch
backends to JIT safe sequences somehow; I just haven't figured out exactly what
we need to do to make that happen.

Thanks,
Mark.
