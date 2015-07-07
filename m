From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/4] locking/qrwlock: Use direct MCS lock/unlock in
 slowpath
Date: Tue, 7 Jul 2015 13:24:49 +0200
Message-ID: <20150707112449.GR3644@twins.programming.kicks-ass.net>
References: <1436197386-58635-1-git-send-email-Waiman.Long@hp.com>
 <1436197386-58635-5-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:49837 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756737AbbGGLYz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Jul 2015 07:24:55 -0400
Content-Disposition: inline
In-Reply-To: <1436197386-58635-5-git-send-email-Waiman.Long@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <Waiman.Long@hp.com>
Cc: Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On Mon, Jul 06, 2015 at 11:43:06AM -0400, Waiman Long wrote:
> Lock waiting in the qrwlock uses the spinlock (qspinlock for x86)
> as the waiting queue. This is slower than using MCS lock directly
> because of the extra level of indirection causing more atomics to
> be used as well as 2 waiting threads spinning on the lock cacheline
> instead of only one.

This needs a better explanation. Didn't we find with the qspinlock thing
that the pending spinner improved performance on light loads?

Taking it out seems counter intuitive, we could very much like these two
the be the same.

> --- a/kernel/locking/qrwlock.c
> +++ b/kernel/locking/qrwlock.c

> +static DEFINE_PER_CPU_ALIGNED(struct mcs_spinlock, _mcs_qnodes[4]);


> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -81,8 +81,9 @@
>   * Exactly fits one 64-byte cacheline on a 64-bit architecture.
>   *
>   * PV doubles the storage and uses the second cacheline for PV state.
> + * The MCS nodes are also shared with qrwlock.
>   */
> -static DEFINE_PER_CPU_ALIGNED(struct mcs_spinlock, mcs_nodes[MAX_NODES]);
> +DEFINE_PER_CPU_ALIGNED(struct mcs_spinlock, _mcs_qnodes[MAX_NODES]);

Except you don't... 
