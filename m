Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:37717 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752841AbcCGQLP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Mar 2016 11:11:15 -0500
Received: from g4t3428.houston.hp.com (g4t3428.houston.hp.com [15.201.208.56])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 973C467BB6
	for <linux-arch@vger.kernel.org>; Mon,  7 Mar 2016 16:11:14 +0000 (UTC)
Message-ID: <1457370228.15454.311.camel@hpe.com>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
From: Toshi Kani <toshi.kani@hpe.com>
Date: Mon, 07 Mar 2016 10:03:48 -0700
In-Reply-To: <20160305114012.GA7259@gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
	 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
	 <20160305114012.GA7259@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Message-ID: <20160307170348.l-MTT2DPWNcvEgOPZNp__be1e4RdE02DGayblmepQuw@z>

On Sat, 2016-03-05 at 12:40 +0100, Ingo Molnar wrote:
> * Toshi Kani <toshi.kani@hpe.com> wrote:
> 
> > > So I'd say that since ioremap() in itself is fragile enough, we
> > > should work towards eliminating overlapping ranges.
> > > 
> > > The thing is, the whole vmap_area logic is based around non-
> > > overlapping ranges, sorted into the vmap_area_root rbtree.
> > > 
> > > Just check the logic in mm/vmalloc.c::alloc_vmap_area(): it's based
> > > on finding holes in the kernel-virtual allocations. 'Overlapping
> > > ranges' is very much not part of that logic, at least to my
> > > understanding.
> > > 
> > > How are overlapping ioremap()s even possible with that logic? The
> > > allocator searches for holes, not allowing for overlaps. What am I
> > > missing?
> > > 
> > > Could you outline a specific case where it's done intentionally - and
> > > the purpose behind that intention?
> > 
> > The term "overlapping" is a bit misleading. [...]
> 
> A bit? It was totally misleading ...
> 
> You meant virtual aliases for the same physical address, and those of
> course are allowed, as long the cache attributes are compatible, that is
> what the whole memtype infrastructure is about, as you yourself note:
> 
> > [...]  This is "alias" mapping -- a physical address range is mapped to
> > multiple virtual address ranges.  There is no overlapping in VMA.
> > 
> > Such alias mappings are used by multiple modules.  For instance, a PMEM
> > range is mapped to the kernel and user spaces.  /dev/mem is another
> > example that creates a user space mapping to a physical address where
> > other mappings may already exist.
> > 
> > Hence, alias mapping itself is a supported use-case.  However, alias
> > mapping with different cache types is not as it causes undefined
> > behavior.  Therefore, PAT module protects from this case by tracking
> > cache types used for mapping physical ranges.  When a different cache
> > type is requested, is_new_memtype_allowed() checks if the request needs
> > to be failed or can be changed to the existing type.
> 
> So where is the problem? The memtype implementation and hence most
> ioremap() users are supposed to be safe. set_memory_*() APIs are supposed
> to be safe as well, as they too go via the memtype API.

Let me try to summarize...

The original issue Luis brought up was that drivers written to work with
MTRR may create a single ioremap range covering multiple cache attributes
since MTRR can overwrite cache attribute of a certain range.  Converting
such drivers with PAT-based ioremap interfaces, i.e. ioremap_wc() and
ioremap_nocache(), requires a separate ioremap map for each cache
attribute, which can be challenging as it may result in overlapping ioremap
ranges (in his term) with different cache attributes.

So, Luis asked about 'sematics of overlapping ioremap()' calls.  Hence, I
responded that aliasing mapping itself is supported, but alias with
different cache attribute is not.  We have checks in place to detect such
condition.  Overlapping ioremap calls with a different cache attribute
either fails or gets redirected to the existing cache attribute on x86.

> > I agree that the current implementation is fragile, and some interfaces
> > skip such check at all, ex. vm_insert_pfn().
> 
> Most of those are really just low level interfaces forl cases that skip the memtype infrastructure.

Yes, and I'm just stating the fact that some pfn map use-cases, such as
mmap, are not tracked in memtype.  For example, drm_gem_mmap()
-> drm_gem_mmap_obj() sets its VMA as WC attribute.  i915_gem_fault() then
creates a WC map with vm_insert_pfn() at fault.

Thanks,
-Toshi
