From: Mike Travis <travis@sgi.com>
Subject: Re: [patch 02/41] cpu alloc: The allocator
Date: Wed, 04 Jun 2008 08:04:22 -0700
Message-ID: <4846AEF6.2020107@sgi.com>
References: <20080530035620.587204923@sgi.com> <20080530040011.084909898@sgi.com> <200805301546.49627.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:56911 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754856AbYFDPEZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Jun 2008 11:04:25 -0400
In-Reply-To: <200805301546.49627.rusty@rustcorp.com.au>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Christoph Lameter <clameter@sgi.com>, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Eric Dumazet <dada1@cosmosbay.com>, Peter Zijlstra <peterz@infradead.org>

Rusty Russell wrote:
> On Friday 30 May 2008 13:56:22 Christoph Lameter wrote:
>> The per cpu allocator allows dynamic allocation of memory on all
>> processors simultaneously. A bitmap is used to track used areas.
>> The allocator implements tight packing to reduce the cache footprint
>> and increase speed since cacheline contention is typically not a concern
>> for memory mainly used by a single cpu. Small objects will fill up gaps
>> left by larger allocations that required alignments.
> 
> Allocator seems nice and simple, similar to existing one in module.c (which 
> predates cool bitmap operators).
> 
> Being able to do per-cpu allocations in an interrupt handler seems like 
> encouraging a Bad Idea though: I'd be tempted to avoid the flags word, always 
> zero, and use a mutex instead of a spinlock.
> 
> Cheers,
> Rusty.

I haven't seen any further discussion on these aspects... is there a consensus
to remove the flags from CPU_ALLOC() and use a mutex?

Thanks,
Mike
