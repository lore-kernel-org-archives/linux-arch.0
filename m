From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 28/31] memblock: Export MEMBLOCK_ERROR again
Date: Tue, 27 Jul 2010 23:01:20 -0700 (PDT)
Message-ID: <20100727.230120.43037767.davem@davemloft.net>
References: <1280294128.1970.237.camel@pasglop>
	<1280294376.1970.239.camel@pasglop>
	<4C4FC5D1.3070708@zytor.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:46659
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751894Ab0G1GBE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 28 Jul 2010 02:01:04 -0400
In-Reply-To: <4C4FC5D1.3070708@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: hpa@zytor.com
Cc: benh@kernel.crashing.org, yinghai@kernel.org, mingo@elte.hu, tglx@linutronix.de, akpm@linux-foundation.org, torvalds@linux-foundation.org, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
Date: Tue, 27 Jul 2010 22:53:21 -0700

> On 07/27/2010 10:19 PM, Benjamin Herrenschmidt wrote:
>> 
>> Screw it, I don't like it but I'll just split your patch in two for now
>> and keep 0. It's a bit fishy but memblock does mostly top-down
>> allocations and so shouldn't hit 0, and in practice the region at 0 is,
>> I beleive, reserved, but we need to be extra careful and might need to
>> revisit that a bit.
>> 
>> That's an area where I don't completely agree with Linus, ie, 0 is a
>> perfectly valid physical address for memblock to return :-)
>> 
> 
> On x86, physical address 0 contains the real-mode IVT and will thus be
> reserved, at least for the forseeable future.  Other architectures may
> very well have non-special RAM there.

0 is very much possible on sparc64
