From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 4/4] bpf: inhibit speculated out-of-bounds pointers
Date: Thu, 4 Jan 2018 00:45:29 +0100
Message-ID: <20180103234529.GA32035@hirez.programming.kicks-ass.net>
References: <20180103223827.39601-1-mark.rutland@arm.com>
 <20180103223827.39601-5-mark.rutland@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180103223827.39601-5-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 03, 2018 at 10:38:27PM +0000, Mark Rutland wrote:
> Under speculation, CPUs may mis-predict branches in bounds checks. Thus,
> memory accesses under a bounds check may be speculated even if the
> bounds check fails, providing a primitive for building a side channel.
> 
> The EBPF map code has a number of such bounds-checks accesses in
> map_lookup_elem implementations. This patch modifies these to use the
> nospec helpers to inhibit such side channels.
> 
> The JITted lookup_elem implementations remain potentially vulnerable,
> and are disabled (with JITted code falling back to the C
> implementations).

Since this is now public, let me re-iterate that I don't particularly
like this approach. If you have to kill the JIT, could we please keep
that in the arch JIT implementation?
