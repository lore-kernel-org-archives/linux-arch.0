From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Fri, 4 Mar 2016 10:44:24 +0100
Message-ID: <20160304094424.GA16228@gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36719 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758913AbcCDJof (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2016 04:44:35 -0500
Content-Disposition: inline
In-Reply-To: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>


* Luis R. Rodriguez <mcgrof@kernel.org> wrote:

> At kernel summit, during the semantics of ioremap() session, Paul
> mentioned we'd write something up to help get some notes out on what
> we need to do and help clarify things. I've run into an issue (just a
> warning) with a user on some odd system that I suspect may be the
> result of a driver using overlapping ioremap() calls on conflicting
> memory regions, so I'm a bit interested to see a resolution to some of
> these lingering discussions now.
> 
> Although we spoke of quite a bit of things, I raised in particular the
> 'semantics of overlapping ioremap()' calls as one item of interest we
> should address across architectures. At least on x86 it seems we would
> not get an error if this is done and in fact its expected behavior;
> Toshi had determined we could not enable error'ing out on overlapping
> ioremap() calls given we have a few users that use it intentionally,
> for instance the /dev/mem setup code. I had suggested long ago then
> that one possible resolution was for us to add an API that *enables*
> overlapping ioremap() calls, and only use it on select locations in
> the kernel. This means we only have to convert a few users to that
> call to white list such semantics, and by default we'd disable
> overlapping calls. To kick things off -- is this strategy agreeable
> for all other architectures?

So I'd say that since ioremap() in itself is fragile enough, we should work 
towards eliminating overlapping ranges.

The thing is, the whole vmap_area logic is based around non-overlapping ranges, 
sorted into the vmap_area_root rbtree.

Just check the logic in mm/vmalloc.c::alloc_vmap_area(): it's based on finding 
holes in the kernel-virtual allocations. 'Overlapping ranges' is very much not 
part of that logic, at least to my understanding.

How are overlapping ioremap()s even possible with that logic? The allocator 
searches for holes, not allowing for overlaps. What am I missing?

Could you outline a specific case where it's done intentionally - and the purpose 
behind that intention?

> The problem is that without this it remains up to the developer of the driver to 
> avoid overlapping calls, and a user may just get sporadic errors if this 
> happens.  As another problem case, set_memor_*() will not fail on MMIO even 
> though set_memor_*() is designed only for RAM. If the above strategy on avoiding 
> overlapping is agreeable, could the next step, or an orthogonal step be to error 
> out on set_memory_*() on IO memory?

So how do drivers set up WC or WB MMIO areas? Does none of our upstream video 
drivers do that?

Thanks,

	Ingo
