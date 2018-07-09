Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbeGIOtq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 10:49:46 -0400
Date: Mon, 9 Jul 2018 16:49:25 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Message-ID: <20180709144925.GU2476@hirez.programming.kicks-ass.net>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Message-ID: <20180709144925.utW2MVhRupXko-UTe8rCe1fahcTx2OvzszNio5qzu7M@z>

On Mon, Jul 09, 2018 at 02:33:26PM +0000, Alexey Brodkin wrote:
> > In fact, since alloc_dr() uses kmalloc() to allocate the entire thing,
> > it is impossible to guarantee a larger alignment than kmalloc does.
> 
> Well but 4-bytes [which is critical for atomic64_t] should be much less
> than a sane cache line length so above should work.

AFAICT ARCH_KMALLOC_MINALIGN ends up being 4 on x86_32 (it doesn't
define ARCH_DMA_MINALIGN and doesn't seem to otherwise override the
thing).

So unconditionally setting the alignment of devres::data to 8 seems
broken.
