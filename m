From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 09/10] arch: introduce memremap()
Date: Mon, 20 Jul 2015 16:56:04 +0100
Message-ID: <20150720155604.GD19239@leverpostej>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150720001822.30857.65670.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150720120040.GC19239@leverpostej>
 <CAPcyv4h+02J-GpJ+PC8f1M3O_yXXE0=W5=jg3P33nPesc+YPiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:56501 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752114AbbGTP4c (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Jul 2015 11:56:32 -0400
Content-Disposition: inline
In-Reply-To: <CAPcyv4h+02J-GpJ+PC8f1M3O_yXXE0=W5=jg3P33nPesc+YPiQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tony.luck@intel.com" <tony.luck@intel.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "arnd@arndb.de" <arnd@arndb.de>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "mcgrof@suse.com" <mcgrof@suse.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "toshi.kani@hp.com" <toshi.kani@hp.com>, "ross.zwisler@linux.intel.com" <ross.zwisler@linux.intel.com>, "hch@lst.de" <hch@lst.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Will Deacon <Will.Deacon@arm.com>

On Mon, Jul 20, 2015 at 03:39:44PM +0100, Dan Williams wrote:
> On Mon, Jul 20, 2015 at 5:00 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > Hi,
> >
> > On Mon, Jul 20, 2015 at 01:18:23AM +0100, Dan Williams wrote:
> >> Existing users of ioremap_cache() are mapping memory that is known in
> >> advance to not have i/o side effects.  These users are forced to cast
> >> away the __iomem annotation, or otherwise neglect to fix the sparse
> >> errors thrown when dereferencing pointers to this memory.  Provide
> >> memremap() as a non __iomem annotated ioremap_*() in the case when
> >> ioremap is otherwise a pointer to memory.
> >>
> >> The ARCH_HAS_MEMREMAP kconfig symbol is introduced for archs to assert
> >> that it is safe to recast / reuse the return value from ioremap as a
> >> normal pointer to memory.  In other words, archs that mandate specific
> >> accessors for __iomem are not memremap() capable and drivers that care,
> >> like pmem, can add a dependency to disable themselves on these archs.
> >>
> >> Note, that memremap is a break from the ioremap implementation pattern
> >> of adding a new memremap_<type>() for each mapping type.  Instead,
> >> the implementation defines flags that are passed to the central
> >> memremap() implementation.
> >>
> >> Outside of ioremap() and ioremap_nocache(), the expectation is that most
> >> calls to ioremap_<type>() are seeking memory-like semantics (e.g.
> >> speculative reads, and prefetching permitted).  These callsites can be
> >> moved to memremap() over time.
> >>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

[...]

> > Unfortunately, even with that fixed this patch breaks boot due to the
> > memremap_valid check. It's extremely likely that (portions of) the
> > tables are already in the linear mapping, and so page_is_ram will be
> > true.
> 
> Really, "portions of", not the entire table?

Yes, if a table straddles a page boundary (the spec doesn't seem to
disallow this). We might not map all of the required pages, e.g.

* If the kernel was loaded more than TEXT_OFFSET bytes above the table
  (the arm64 linear/direct mapping is currently tied to our text
  mapping, and we can't currently address anything below that).

  In this case the start isn't in the direct mapping, and we'll try to
  create a new mapping. That should work.

* If the kernel is built with a small VA range, and we have just the
  right amount of memory before the table begins (this is absurdly
  unlikely).

  In this case if the start is in the direct mapping, but the end isn't,
  we'll explode when accessing it.

* If the 'mem=' parameter is used, the direct mapping can be truncated.

  In this case if the start is in the direct mapping, but the end isn't,
  we'll explode when accessing it.

In the arm64 ioremap_cache we only check
pfn_valid(__phys_to_pfn(phys_addr)), and assume that if the start was
mapped, then the whole region is. In the cases above that's clearly not
true, so we should probably see about handling that.

> Is it too early to use the direct mapping like
> pfn_to_page(memmap.phys_map >> PAGE_SHIFT)?

I believe it's too early, as we haven't initialised the memmap yet. For
the cases above we will never have a page for the portion of the region
not in the direct mapping anyway.

> In any event this splat mandates splitting this memremap() enabling
> patch into per-instance conversions of ioremap_cache().
> 
> > At boot time I get the following:
> >
> > Remapping and enabling EFI services.
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 1 at kernel/resource.c:541 memremap+0xb0/0xbc()
> > memremap attempted on ram 0x00000009f9e4a018 size: 1200
> > Modules linked in:
> > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc3+ #201
> > Hardware name: ARM Juno development board (r0) (DT)
> > Call trace:
> > [<ffffffc000089954>] dump_backtrace+0x0/0x124
> > [<ffffffc000089a88>] show_stack+0x10/0x1c
> > [<ffffffc0005d15c8>] dump_stack+0x84/0xc8
> > [<ffffffc0000b3f44>] warn_slowpath_common+0x98/0xd0
> > [<ffffffc0000b3fc8>] warn_slowpath_fmt+0x4c/0x58
> > [<ffffffc0000b9470>] memremap+0xac/0xbc
> > [<ffffffc000814fe8>] arm64_enable_runtime_services+0x90/0x208
> > [<ffffffc000082864>] do_one_initcall+0x88/0x1a0
> > [<ffffffc000811a20>] kernel_init_freeable+0x8c/0x1f8
> > [<ffffffc0005ce370>] kernel_init+0xc/0xd8
> > ---[ end trace cb88537fdc8fa200 ]---
> > Failed to remap EFI memory map
> >
> >>         if (!memmap.map) {
> >>                 pr_err("Failed to remap EFI memory map\n");
> >>                 return -1;
> >> @@ -299,8 +298,8 @@ static int __init arm64_enable_runtime_services(void)
> >>         memmap.map_end = memmap.map + mapsize;
> >>         efi.memmap = &memmap;
> >>
> >> -       efi.systab = (__force void *)ioremap_cache(efi_system_table,
> >> -                                                  sizeof(efi_system_table_t));
> >> +       efi.systab = memremap(efi_system_table, sizeof(efi_system_table_t),
> >> +                       MEMREMAP_CACHE);
> >>         if (!efi.systab) {
> >>                 pr_err("Failed to remap EFI System Table\n");
> >>                 return -1;
> >> diff --git a/arch/arm64/kernel/smp_spin_table.c b/arch/arm64/kernel/smp_spin_table.c
> >> index aef3605a8c47..b9caf6cd44e6 100644
> >> --- a/arch/arm64/kernel/smp_spin_table.c
> >> +++ b/arch/arm64/kernel/smp_spin_table.c
> >> @@ -73,19 +73,19 @@ static int smp_spin_table_cpu_init(unsigned int cpu)
> >>
> >>  static int smp_spin_table_cpu_prepare(unsigned int cpu)
> >>  {
> >> -       __le64 __iomem *release_addr;
> >> +       __le64 *release_addr;
> >>
> >>         if (!cpu_release_addr[cpu])
> >>                 return -ENODEV;
> >>
> >>         /*
> >>          * The cpu-release-addr may or may not be inside the linear mapping.
> >> -        * As ioremap_cache will either give us a new mapping or reuse the
> >> -        * existing linear mapping, we can use it to cover both cases. In
> >> -        * either case the memory will be MT_NORMAL.
> >> +        * As memremap will either give us a new mapping or reuse the existing
> >> +        * linear mapping, we can use it to cover both cases. In either case
> >> +        * the memory will be MT_NORMAL.
> >>          */
> >> -       release_addr = ioremap_cache(cpu_release_addr[cpu],
> >> -                                    sizeof(*release_addr));
> >> +       release_addr = memremap(cpu_release_addr[cpu], sizeof(*release_addr),
> >> +                       MEMREMAP_CACHE);
> >
> > Likewise, the comment here is contradicted by the code in memremap_valid
> > (below). We'll fail to bring up secondaries if the release address fell
> > in the linear mapping.
> 
> Ah, so ARM's ioremap_cache() silently handles calls to remap RAM with
> a pointer to the direct mapping.  It think that's a useful property to
> carry in the generic implementation.  Especially if the direct mapping
> has established greater than PAGE_SIZE mappings.

That sounds good to me.

As mentioned above, I think we should test that the entire region we're
trying to map falls within the direct mapping before assuming we can use
it, though I'm not sure what the best way of doing that is.

Thanks,
Mark.
