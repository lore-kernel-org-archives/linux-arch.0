From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH 09/10] arch: introduce memremap()
Date: Thu, 23 Jul 2015 02:55:43 +0200
Message-ID: <20150723005543.GK30479@wotan.suse.de>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150720001822.30857.65670.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150721235848.GI30479@wotan.suse.de>
 <CAPcyv4jXyHzXUmr1LNL3vTzgced8Onrq9OZR2Ub1E85HnOru1Q@mail.gmail.com>
 <20150722225557.GJ30479@wotan.suse.de>
 <CAPcyv4hH7+Dr7NHYXcLfE_-QUwhE9b9tesjjcj4gk4pqJLajBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51457 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751236AbbGWAzr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Jul 2015 20:55:47 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4hH7+Dr7NHYXcLfE_-QUwhE9b9tesjjcj4gk4pqJLajBQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, Tony Luck <tony.luck@intel.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, X86 ML <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Kani, Toshimitsu" <toshi.kani@hp.com>, Ross Zwisler <ross.zwisler@linux.intel.com>, Christoph Hellwig <hch@lst.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Jul 22, 2015 at 04:15:41PM -0700, Dan Williams wrote:
> On Wed, Jul 22, 2015 at 3:55 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> > On Tue, Jul 21, 2015 at 09:04:22PM -0700, Dan Williams wrote:
> >> On Tue, Jul 21, 2015 at 4:58 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> >> > On Sun, Jul 19, 2015 at 08:18:23PM -0400, Dan Williams wrote:
> >> >> diff --git a/include/linux/io.h b/include/linux/io.h
> >> >> index 080a4fbf2ba4..2983b6e63970 100644
> >> >> --- a/include/linux/io.h
> >> >> +++ b/include/linux/io.h
> >> >> @@ -192,4 +192,15 @@ static inline int arch_phys_wc_index(int handle)
> >> >>  #endif
> >> >>  #endif
> >> >>
> >> >> +enum {
> >> >> +     MEMREMAP_WB = 1 << 0,
> >> >> +     MEMREMAP_WT = 1 << 1,
> >> >> +     MEMREMAP_WC = 1 << 2,
> >> >> +     MEMREMAP_STRICT = 1 << 3,
> >> >> +     MEMREMAP_CACHE = MEMREMAP_WB,
> >> >> +};
> >> >
> >> > A few things:
> >> >
> >> > 1) You'll need MEMREMAP_UC now as well now.
> >>
> >> Why?  I don't think it fits.  If there are any I/O areas (non-memory)
> >> in the range then it simply is not "memory" and should not be using
> >> memremap().  In other words it seems like you really do need to heed
> >> the __iomem annotation in the return value from ioremap_uc().
> >
> > One can use a similar argument for some areas of use of write-combining,
> > what litmus test are you using to add a flag above? Why would WC be OK
> > and not UC? WC is a cache hack on x86...
> 
> I should remove WC from the list for now, I'm not converting
> ioremap_wc() to memremap at this time.

Do you have plans to do so? If so can you elaborate on such plans ?

> That said it's not the same argument.  A driver calling ioremap_wc()
> is explicitly signing up to handle flushing the write-combine buffer
> and the expectation is that there are no I/O ranges in the mapping
> that would be affected by write combining.

The thing is the semantics even for write-combining need to be discussed
further, write-combining for kernel interfaces are screwed up for at least one
architecture becaues we didn't get things right or document expectations
correctly amongst other things, so the above is not sufficient to define
write-combining for now.

> An ioremap_uc() mapping says "careful there are I/O sensitive registers in this range".

Yes but we have ioremap_nocache(). I added ioremap_uc() and the goal behind ioremap_uc()
was to enable efficient use of absolutely no cache at all, and this was particularly
aimed at taking advantage of strong UC on PAT. This was also a compromise to help
with the transition over on x86 from UC- to UC in the long term as we also convert
all write-combining variant API users to (old mtrr_add(), now arch_phys_wc_add())
over from ioremap_nocache() to ioremap_wc() and ensure its MMIO registers use
keep using ioremap_nocache() -- but for corner cases with old MTRR hacks we need
ioremap_uc() to also avoid regressions when we do the flip on x86 fromr UC- to
UC. How we want to map this to other architectures remaisn to be discovered, but
perhaps they don't care.

Anyway so why is WB and WT allowed if you are going to remove WC and not add UC?

> >> > 2) as you are doing all this sweep over architectures on this please
> >> > also address the lack of ioremap_*() variant implemention to return
> >> > NULL, ie not supported, because we've decided for now that so long
> >> > as the semantics are not well defined we can't expect architectures
> >> > to get it right unless they are doing the work themselves, and the
> >> > old strategy of just #defin'ing a variant to iorempa_nocache() which
> >> > folks tended to just can lead to issues. In your case since you are
> >> > jumping to the flags implementation this might be knocking two birds
> >> > with one stone.
> >>
> >> I'm not going to do a general sweep for this as the expectation that
> >> ioremap silently falls back if a mapping type is not supported is
> >> buried all over the place.
> >
> > But it does not. It cannot. The reason, as I noted in a commit now merged
> > on tip, is that the default wrappers are nested under #ifndef CONFIG_MMU,
> > whereas really this should have just been used for ioremap() and iounmap().
> >
> > That is, the ioremap_*() variants should have a definition even for !CONFIG_MMU,
> > and since we actually don't want to enable sloppy defines of this the sensible
> > defaults should be to return NULL on variants -- for both !CONFIG_MMU
> > and for CONFIG_MMU. The way to fix then then is to move the default variant
> > definitions out from #ifndef CONFIG_MMU and have them return NULL. We may
> > be able to have them return something not-null by default always but we
> > first need to beat to death the topic of semantics with all architecture
> > folks to each that agreement. Until then the variants shoudl just return
> > NULL encouraging arch developers to supply a proper implementation.
> 
> That clean up is orthogonal to memremap.  memremap will return NULL
> for unsupported mapping types.

It can be if you are not doing a major long term cleanup...

> >> That said, new usages and conversions to
> >> memremap() can be strict about this. For now, I'm only handling
> >> ioremap_cache() and ioremap_wt() conversions.
> >
> > OK, if you are not going to do this let me know and I can do it.
> 
> Yes, go ahead.

OK..

> >> > 3) For the case that architectures have no MMU we currently do a direct
> >> > mapping such as what you try to describe to do with memremap(). I wonder
> >> > if its worth it to then enable that code to just map to memremap(). That
> >> > throws off your usage of CONFIG_ARCH_HAS_MEMREMAP if we want to repurpose
> >> > that implementation for no the MMU case, unless of course you just have a
> >> > __memremap() which does the default basic direct mapping implementation.
> >>
> >> Yes, in the next rev of this series I am having it fall back to direct
> >> mappings where it makes sense.
> >>
> >> > 4) Since we are all blaming semantics on our woes I'd like to ask for
> >> > some effort on semantics to be well defined. Semantics here sholud cover
> >> > some form of Documentation but also sparse annotation checks and perhaps
> >> > Coccinelle grammar rules for how things should be done. This should not only
> >> > cover general use but also if there are calls which depend on a cache
> >> > type to have been set. If we used sparse annotations it  may meen a
> >> > different return type for each cache type.  Not sure if we want this.
> >> > If we went with grammar rules I'm looking to for instance have in place
> >> > rules on scripts/coccinelle which would allow developers to use
> >>
> >> memremap() explicitly does not want get into arch semantics debates.
> >
> > Why? The ioremap() cluster fuck seems like a good example to learn from.
> >
> > I was also under the impression you are going to provide a new API with flags
> > to kill / make old ioremap() varaints use this new API with the flags passed?
> > Is that not the case ?
> 
> Yes, I'll post the new series shortly once 0day says there are no
> build regressions.

Then what API was it you intend on using for that ? My point is that semantics
shoudl matter then for that -- strongly.

> >> The pointer returned from memremap() is a "void *" that can be used as
> >> normal memory.  If it is a normal pointer I don't see the role for
> >> sparse annotation.
> >
> > Hrm, do we want to *prevent* certain to use the memory range when it is direct?
> 
> Can you give an example scenario?

arch_phys_wc_add(), set_memory_wc(), set_memory_*(). There may be others. The
mem region API Toshi just fixed is another.

> >> > make coccicheck M=foo/
> >> >
> >> > to find issues. I can perhaps help with this, but we'd need to do a good
> >> > sweep here to not only cover good territory but also get folks to agree
> >> > on things.
> >> >
> >> > 5) This may be related to 4), not sure. There are aligment requirements we
> >> > should probably iron out for architectures. How will we annotate these
> >> > requirements or allow architectures to be pedantic over these requirements?
> >>
> >> What requirements beyond PAGE_SIZE alignment would we need to worry about?
> >
> > That's a big concern some folks expressed, architecture folks would know more.
> >
> > One last thing: if you are providing a new API to replace a series of old
> > symbols that were used before (I though you were working towards this for all
> > ioremap_*() variants) we have to take care to ensure that any symbol that is
> > currently exported with EXPORT_SYMBOL_GPL() does not get an EXPORT_SYMBOL()
> > wrapper-escape since we do not want proprietary drivers to make use these
> > alternatives.
> 
> Yes, memremap() is inheriting the export level of ioremap_cache.

Like I said we need to take care to ensure EXPORT_SYMBOL_GPL() is not used
then by new wrappers to enable proprietary drivers to make use of those
symbosl through the new wrapper. One idea may be to work on symbol namespaces,
if we cannot address this through static inlines for old callers and just
making the new APIs EXPORT_SYMBOL_GPL().

  Luis
