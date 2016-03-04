Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:40275 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757077AbcCDRZ6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2016 12:25:58 -0500
Received: from g4t3428.houston.hp.com (g4t3428.houston.hp.com [15.201.208.56])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 4DDBA6331A
	for <linux-arch@vger.kernel.org>; Fri,  4 Mar 2016 17:25:57 +0000 (UTC)
Message-ID: <1457115514.15454.216.camel@hpe.com>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
From: Toshi Kani <toshi.kani@hpe.com>
Date: Fri, 04 Mar 2016 11:18:34 -0700
In-Reply-To: <20160304094424.GA16228@gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
	 <20160304094424.GA16228@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Message-ID: <20160304181834.UYGGX6-9IDjbEMilk32NIpDwyXNpwtP_m2GCK67ysI8@z>

On Fri, 2016-03-04 at 10:44 +0100, Ingo Molnar wrote:
> * Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> 
> > At kernel summit, during the semantics of ioremap() session, Paul
> > mentioned we'd write something up to help get some notes out on what
> > we need to do and help clarify things. I've run into an issue (just a
> > warning) with a user on some odd system that I suspect may be the
> > result of a driver using overlapping ioremap() calls on conflicting
> > memory regions, so I'm a bit interested to see a resolution to some of
> > these lingering discussions now.
> > 
> > Although we spoke of quite a bit of things, I raised in particular the
> > 'semantics of overlapping ioremap()' calls as one item of interest we
> > should address across architectures. At least on x86 it seems we would
> > not get an error if this is done and in fact its expected behavior;
> > Toshi had determined we could not enable error'ing out on overlapping
> > ioremap() calls given we have a few users that use it intentionally,
> > for instance the /dev/mem setup code. I had suggested long ago then
> > that one possible resolution was for us to add an API that *enables*
> > overlapping ioremap() calls, and only use it on select locations in
> > the kernel. This means we only have to convert a few users to that
> > call to white list such semantics, and by default we'd disable
> > overlapping calls. To kick things off -- is this strategy agreeable
> > for all other architectures?
> 
> So I'd say that since ioremap() in itself is fragile enough, we should
> work towards eliminating overlapping ranges.
> 
> The thing is, the whole vmap_area logic is based around non-overlapping
> ranges, sorted into the vmap_area_root rbtree.
> 
> Just check the logic in mm/vmalloc.c::alloc_vmap_area(): it's based on
> finding holes in the kernel-virtual allocations. 'Overlapping ranges' is
> very much not part of that logic, at least to my understanding.
> 
> How are overlapping ioremap()s even possible with that logic? The
> allocator searches for holes, not allowing for overlaps. What am I
> missing?
> 
> Could you outline a specific case where it's done intentionally - and the
> purpose behind that intention?

The term "overlapping" is a bit misleading.  This is "alias" mapping -- a
physical address range is mapped to multiple virtual address ranges.  There
is no overlapping in VMA.

Such alias mappings are used by multiple modules.  For instance, a PMEM
range is mapped to the kernel and user spaces.  /dev/mem is another example
that creates a user space mapping to a physical address where other
mappings may already exist.

Hence, alias mapping itself is a supported use-case.  However, alias
mapping with different cache types is not as it causes undefined behavior.
 Therefore, PAT module protects from this case by tracking cache types used
for mapping physical ranges.  When a different cache type is requested,
is_new_memtype_allowed() checks if the request needs to be failed or can be
changed to the existing type.

I agree that the current implementation is fragile, and some interfaces
skip such check at all, ex. vm_insert_pfn().


> > The problem is that without this it remains up to the developer of the
> > driver to avoid overlapping calls, and a user may just get sporadic
> > errors if this happens.  As another problem case, set_memor_*() will
> > not fail on MMIO even though set_memor_*() is designed only for RAM. If
> > the above strategy on avoiding overlapping is agreeable, could the next
> > step, or an orthogonal step be to error out on set_memory_*() on IO
> > memory?
> 
> So how do drivers set up WC or WB MMIO areas? Does none of our upstream
> video drivers do that?

Drivers use ioremap family with a right cache type when mapping MMIO
ranges, ex. ioremap_wc().  They do not need to change the type to MMIO.
 RAM is different since it's already mapped with WB at boot-time.
 set_memory_*() allows us to change the type from WB, and put it back to
WB.

Thanks,
-Toshi
