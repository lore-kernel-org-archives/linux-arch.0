From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 07/31] lmb: Add reserve_lmb/free_lmb
Date: Tue, 30 Mar 2010 08:49:53 +1100
Message-ID: <1269899393.7101.34.camel@pasglop>
References: <1269830604-26214-1-git-send-email-yinghai@kernel.org>
	 <1269830604-26214-8-git-send-email-yinghai@kernel.org>
	 <1269865322.24620.42.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:35867 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847Ab0C2VvV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Mar 2010 17:51:21 -0400
In-Reply-To: <1269865322.24620.42.camel@concordia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michael@ellerman.id.au
Cc: Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Mon, 2010-03-29 at 23:22 +1100, Michael Ellerman wrote:
> ^ This is (sort of) what lmb.rmo_size represents. So maybe instead of
> adding this function, we could just say that the arch code needs to set
> rmo_size up with an appropriate value, and then use that below. Though
> maybe that's conflating things. 

Well... not quite.

The RMO (which really is the RMA, historical misnaming) is the region of
memory we can access very early during boot (in real mode on ppc64 but
I plan to use it to represent the boot-time fixed mapping on ppc32 at
some stage). It's not strictly equivalent to max lowmem. However, on
ppc64, it happens to be the size of the first added LMB entry/

In any case, the LMBs should really not care. They allocate where you
tell them to. 

IE. That stuff is arch specific enough that I suspect we should just
move it out, while the concept of max_lowmem is common enough (at least
for 32-bit archs) that I'm happy to have some provisions for it inside
the LMB core.

Maybe what we need is an arch call to set the allocation "limit". It
could be set in stages during boot. To the initial mapped memory (bolted
TLB) on ppc32 very early, and then pushed up to max_low_pfn as soon as
the full MMU setup is done for example. IE. All we need is an
lmb_set_alloc_limit() called by the arch in the right spots, that
defines the default allocation limit for lmb_alloc() though of course
lmb_alloc_base() can be used by callers to enforce explicit limits.

Cheers,
Ben.
