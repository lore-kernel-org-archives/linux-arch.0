From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 02/41] cpu alloc: The allocator
Date: Thu, 29 May 2008 22:20:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0805292219220.12107@schroedinger.engr.sgi.com>
References: <20080530035620.587204923@sgi.com> <20080530040011.084909898@sgi.com>
 <483F8AF7.9000309@cosmosbay.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from netops-testserver-3-out.sgi.com ([192.48.171.28]:42119 "EHLO
	relay.sgi.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752771AbYE3FUq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 May 2008 01:20:46 -0400
In-Reply-To: <483F8AF7.9000309@cosmosbay.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Mike Travis <travis@sgi.com>

On Fri, 30 May 2008, Eric Dumazet wrote:

> > +static DEFINE_PER_CPU(UNIT_TYPE, area[UNITS]);
> >   
> area[] is not guaranteed to be aligned on anything but 4 bytes.
> 
> If someone then needs to call cpu_alloc(8, GFP_KERNEL, 8), it might get an non
> aligned result.
> 
> Either you should add an __attribute__((__aligned__(PAGE_SIZE))),
> or take into account the real address of area[] in cpu_alloc() to avoid waste
> of up to PAGE_SIZE bytes
> per cpu.

I think cacheline aligning should be sufficient. People should not 
allocate large page aligned objects here.
