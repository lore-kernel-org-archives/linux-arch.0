From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 0/8] Add generic support for relaxed atomics
Date: Fri, 7 Aug 2015 17:29:27 +0100
Message-ID: <20150807162927.GD8726@arm.com>
References: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
 <20150807151303.GM16853@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43488 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161003AbbHGQ31 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 7 Aug 2015 12:29:27 -0400
Content-Disposition: inline
In-Reply-To: <20150807151303.GM16853@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "mingo@kernel.org" <mingo@kernel.org>

On Fri, Aug 07, 2015 at 04:13:03PM +0100, Peter Zijlstra wrote:
> On Thu, Aug 06, 2015 at 05:54:36PM +0100, Will Deacon wrote:
> > The series adds support for a family of relaxed atomics to the kernel.
> > More specifically:
> > 
> >   - acquire/release/relaxed flavours of xchg, cmpxchg and {add,sub}_return
> >   - atomic_read_acquire
> >   - atomic_set_release
> > 
> > This came out of a separate patch series porting the (barrier-heavy)
> > qrwlock code to arm64. Rather than have arch-specific hooks littered
> > around the place, it makes more sense to define a core set of relaxed
> > atomics that can be used regardless of architecture.
> > 
> > Changes since v4 are:
> > 
> >   * Drop the ret_t macro parameter in favour of typeof tricks (Peter Z)
> > 
> >   * Add a missing acquire to the qrwlock code, as it was based on a
> >     previous patch that I posted (Waiman Long)
> > 
> > Build tested on ARM, arm64, PowerPC and x86.
> 
> Queued it. There was a wee conflict with the atomic_{and,or,xor} bits
> for the ARM patch, but that was quickly sorted.

Great, thanks Peter! I'll port arm64 over for 4.4 (there's way too much
fun being had in asm/atomic.h right now).

> Does we want a Documentation/ update to reflect all this shiny new
> stuff?

Possibly. atomic_ops or memory-barriers?

Will
