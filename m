From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 00/18] Cross-architecture definitions of relaxed MMIO
 accessors
Date: Fri, 18 Apr 2014 07:36:58 +1000
Message-ID: <1397770618.32730.81.camel@pasglop>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
	 <20140417140036.GK11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:60313 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbaDQVh5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 Apr 2014 17:37:57 -0400
In-Reply-To: <20140417140036.GK11096@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, monstr@monstr.eu, dhowells@redhat.com, broonie@linaro.org, paulmck@linux.vnet.ibm.com

On Thu, 2014-04-17 at 16:00 +0200, Peter Zijlstra wrote:

> So the non-relaxed ops already imply the expensive I/O barrier (mmiowb?)
> and therefore, PPC can drop it from spin_unlock()?

We play a trick. We set a per-cpu flag in writeX and test it in unlock
before doing the barrier. Still better than having the barrier in every
MMIO at this stage for us.

Whether we want to change that with then new scheme ... we'll see.

> Also, I read mmiowb() as MMIO-write-barrier(), what do we have to
> order/contain mmio-reads?
> 
> I have _0_ experience with MMIO, so I've no idea if ordering/containing
> reads is silly or not. 

I will review the rest when I'm back from vacation (or maybe this
week-end).

Thanks Will for picking that up, it's long overdue :)

Cheers,
Ben.
