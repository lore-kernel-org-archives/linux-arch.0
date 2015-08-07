From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 0/8] Add generic support for relaxed atomics
Date: Fri, 7 Aug 2015 17:13:03 +0200
Message-ID: <20150807151303.GM16853@twins.programming.kicks-ass.net>
References: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:51068 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbbHGPNI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Aug 2015 11:13:08 -0400
Content-Disposition: inline
In-Reply-To: <1438880084-18856-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, Waiman.Long@hp.com, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com, mingo@kernel.org

On Thu, Aug 06, 2015 at 05:54:36PM +0100, Will Deacon wrote:
> Hi all,

> The series adds support for a family of relaxed atomics to the kernel.
> More specifically:
> 
>   - acquire/release/relaxed flavours of xchg, cmpxchg and {add,sub}_return
>   - atomic_read_acquire
>   - atomic_set_release
> 
> This came out of a separate patch series porting the (barrier-heavy)
> qrwlock code to arm64. Rather than have arch-specific hooks littered
> around the place, it makes more sense to define a core set of relaxed
> atomics that can be used regardless of architecture.
> 
> Changes since v4 are:
> 
>   * Drop the ret_t macro parameter in favour of typeof tricks (Peter Z)
> 
>   * Add a missing acquire to the qrwlock code, as it was based on a
>     previous patch that I posted (Waiman Long)
> 
> Build tested on ARM, arm64, PowerPC and x86.

Queued it. There was a wee conflict with the atomic_{and,or,xor} bits
for the ARM patch, but that was quickly sorted.

Does we want a Documentation/ update to reflect all this shiny new
stuff?
