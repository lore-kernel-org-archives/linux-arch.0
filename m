Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.187]:64530 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933297AbeGIPAg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 11:00:36 -0400
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH v3] devres: Explicitly align datai[] to 64-bit
Date: Mon, 9 Jul 2018 15:02:08 +0000
Message-ID: <dd7f96e4b08644769865adb302eb7d53@AcuMS.aculab.com>
References: <20180709134550.29541-1-abrodkin@synopsys.com>
 <20180709140717.GR2476@hirez.programming.kicks-ass.net>
 <20180709141056.GR2512@hirez.programming.kicks-ass.net>
 <44727d3cebda7bee5b68fb388bd2fecfc6dc7b89.camel@synopsys.com>
 <20180709144925.GU2476@hirez.programming.kicks-ass.net>
In-Reply-To: <20180709144925.GU2476@hirez.programming.kicks-ass.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Peter Zijlstra' <peterz@infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>
Message-ID: <20180709150208.npk4eOeHiKpwvezZLn2ajJVfKbrY826-56j1nxfVqMY@z>

From: Peter Zijlstra
> Sent: 09 July 2018 15:49
> On Mon, Jul 09, 2018 at 02:33:26PM +0000, Alexey Brodkin wrote:
> > > In fact, since alloc_dr() uses kmalloc() to allocate the entire thing,
> > > it is impossible to guarantee a larger alignment than kmalloc does.
> >
> > Well but 4-bytes [which is critical for atomic64_t] should be much less
> > than a sane cache line length so above should work.
> 
> AFAICT ARCH_KMALLOC_MINALIGN ends up being 4 on x86_32 (it doesn't
> define ARCH_DMA_MINALIGN and doesn't seem to otherwise override the
> thing).

That seems broken.

I wonder what the minimal alignment really is?
I suspect some code expects (and gets) 8-byte alignment.
The min alignment might even be 16 or 32 bytes.
There aren't many x86 instructions that fault on mis-aligned addresses,
but there are a few.
Mostly related to the fpu - probably including the fpu save area.

	David
