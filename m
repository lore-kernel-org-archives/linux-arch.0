Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:59402 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633AbbGNLiG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Jul 2015 07:38:06 -0400
Date: Tue, 14 Jul 2015 13:38:01 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/5] atomics: add acquire/release/relaxed variants of
 some atomic operations
Message-ID: <20150714113801.GK19282@twins.programming.kicks-ass.net>
References: <1436790687-11984-1-git-send-email-will.deacon@arm.com>
 <1436790687-11984-2-git-send-email-will.deacon@arm.com>
 <20150714102511.GI19282@twins.programming.kicks-ass.net>
 <20150714103220.GB16213@arm.com>
 <20150714105837.GJ19282@twins.programming.kicks-ass.net>
 <20150714110811.GE16213@arm.com>
 <20150714112420.GK3644@twins.programming.kicks-ass.net>
 <20150714113147.GF16213@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150714113147.GF16213@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Waiman.Long@hp.com" <Waiman.Long@hp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>
Message-ID: <20150714113801.ALdwe7HYbVa-bA6YssLLaHV9y0f3QDpFyZI7XKdT39w@z>

On Tue, Jul 14, 2015 at 12:31:47PM +0100, Will Deacon wrote:
> #ifndef atomic_add
> #define atomic_add(args...)	(void)atomic_add_return_relaxed(args);
> 
> It would mean a new architecture only has to define a barrier instruction
> and a handful of relaxed atomics for a bare-minimum atomic.h avoiding
> spinlocks.

Look at include/asm-generic/atomic.h, all you need is a cmpxchg().

We could easily change that to be cmpxchg_relaxed() and a few barriers.


