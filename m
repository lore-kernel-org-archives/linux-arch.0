From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 28/31] memblock: Export MEMBLOCK_ERROR again
Date: Tue, 27 Jul 2010 22:53:21 -0700
Message-ID: <4C4FC5D1.3070708@zytor.com>
References: <1279822864-17154-1-git-send-email-yinghai@kernel.org>	 <1279822864-17154-29-git-send-email-yinghai@kernel.org>	 <1280294128.1970.237.camel@pasglop> <1280294376.1970.239.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60584 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297Ab0G1FyM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 Jul 2010 01:54:12 -0400
In-Reply-To: <1280294376.1970.239.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 07/27/2010 10:19 PM, Benjamin Herrenschmidt wrote:
> 
> Screw it, I don't like it but I'll just split your patch in two for now
> and keep 0. It's a bit fishy but memblock does mostly top-down
> allocations and so shouldn't hit 0, and in practice the region at 0 is,
> I beleive, reserved, but we need to be extra careful and might need to
> revisit that a bit.
> 
> That's an area where I don't completely agree with Linus, ie, 0 is a
> perfectly valid physical address for memblock to return :-)
> 

On x86, physical address 0 contains the real-mode IVT and will thus be
reserved, at least for the forseeable future.  Other architectures may
very well have non-special RAM there.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
