From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/8] atomics: add acquire/release/relaxed variants of
 some atomic operations
Date: Mon, 27 Jul 2015 19:51:39 +0200
Message-ID: <20150727175139.GZ19282@twins.programming.kicks-ass.net>
References: <1437746681-2809-1-git-send-email-will.deacon@arm.com>
 <1437746681-2809-2-git-send-email-will.deacon@arm.com>
 <20150727091430.GP19282@twins.programming.kicks-ass.net>
 <20150727102106.GD3358@arm.com>
 <20150727163300.GL3358@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:55118 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753391AbbG0Rvs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2015 13:51:48 -0400
Content-Disposition: inline
In-Reply-To: <20150727163300.GL3358@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>

On Mon, Jul 27, 2015 at 05:33:00PM +0100, Will Deacon wrote:
> Something like below?
> 
> Will
> 
> --->8
> 
> diff --git a/include/linux/atomic.h b/include/linux/atomic.h
> index 899b4035569e..d2515c05e7c8 100644
> --- a/include/linux/atomic.h
> +++ b/include/linux/atomic.h
> @@ -14,6 +14,11 @@
>   * - Release: Provides RELEASE semantics, _release suffix.
>   * - Relaxed: No ordering guarantees, _relaxed suffix.
>   *
> + * For compound atomics performing both a load and a store, ACQUIRE
> + * semantics apply only to the load and RELEASE semantics only to the
> + * store portion of the operation. Note that a failed cmpxchg_acquire
> + * does -not- imply any memory ordering constraints.
> + *
>   * See Documentation/memory-barriers.txt for ACQUIRE/RELEASE definitions.
>   */

Yep, works for me.
