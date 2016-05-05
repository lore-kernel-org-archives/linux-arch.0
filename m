Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56803 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756499AbcEEJhN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 May 2016 05:37:13 -0400
Date: Thu, 5 May 2016 11:37:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: kmap_atomic and preemption
Message-ID: <20160505093707.GL3448@twins.programming.kicks-ass.net>
References: <5729D0F4.9090907@synopsys.com>
 <20160504134729.GP3430@twins.programming.kicks-ass.net>
 <20160504191755.GV19428@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160504191755.GV19428@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, lkml <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20160505093707.A3xsBn4Pl6qglIbQxVpjgDjXANosSyTZni2CS-gSpgA@z>

On Wed, May 04, 2016 at 08:17:55PM +0100, Russell King - ARM Linux wrote:
> On Wed, May 04, 2016 at 03:47:29PM +0200, Peter Zijlstra wrote:
> > Traditionally kmap_atomic() disables preemption; and the reason is that
> > the returned pointer must stay valid. This had a side effect in that it
> > also disabled pagefaults.
> 
> A lowmem page should never change its page_address(), so that much is
> safe. 

Agreed..

> I think the question is whether there is any driver code which
> assumes that preemption is unconditionally disabled between a
> kmap_atomic() has been called.

right, this and consistency. Having the function disable preemption
sometimes is just plain weird.

> That wouldn't be an unreasonable assumption given the name of the
> function, so I'd suggest caution with making kmap_atomic() have these
> kinds of differing behaviours depending on whether we're asking to
> kmap a high or lowmem page.

So for -rt I did a preemptible kmap_atomic() for x86 (and maybe someone
did other archs too, I cannot remember), now -rt is funny wrt locking
anyway, but I cannot remember anything breaking because of this, so
there is some hope it will actually work.

> If we are going to allow this, I think it at least needs to be well
> documented.

Indeed.
