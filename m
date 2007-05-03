Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:59425
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753957AbXECHyJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 3 May 2007 03:54:09 -0400
Date: Thu, 03 May 2007 00:54:09 -0700 (PDT)
Message-Id: <20070503.005409.98686600.davem@davemloft.net>
Subject: Re: [PATCH] Increase slab redzone to 64bits.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1178178539.11120.139.camel@pmac.infradead.org>
References: <1178026980.2875.68.camel@pmac.infradead.org>
	<20070502220325.6cf210be.akpm@linux-foundation.org>
	<1178178539.11120.139.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: dwmw2@infradead.org
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 03 May 2007 08:48:59 +0100

> [PATCH] Increase slab redzone to 64 bits.
> 
> There are two problems with the existing redzone implementation.
> 
> Firstly, it's causing misalignment of structures which contain a 64-bit
> integer, such as netfilter's 'struct ipt_entry' -- causing netfilter
> modules to fail to load because of the misalignment. (In particular, the
> first check in net/ipv4/netfilter/ip_tables.c::check_entry_size_and_hooks())
> 
> I considered just fixing this by setting ARCH_KMALLOC_MINALIGN to
> __alignof__(uint64_t) in the default case where the architecture hasn't
> already set it -- but that would disable redzone checks on those
> architectures.
> 
> When investigating this, I noticed that on 64-bit platforms we're using
> a 32-bit value of RED_ACTIVE/RED_INACTIVE in the 64-bit memory location
> set aside for the redzone. Which means that the four bytes immediately
> either before or after the allocated object are 0x00,0x00,0x00,0x00 for 
> LE and BE machines, respectively. Which is probably not the most useful 
> choice of poison value.
> 
> One way to fix both of those at once is just to switch to 64-bit
> redzones in all cases. Patch below; better ideas on a postcard to...
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

This looks good to me, I hope this gets merged soon.

Signed-off-by: David S. Miller <davem@davemloft.net>
