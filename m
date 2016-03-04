From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Fri, 4 Mar 2016 10:51:50 -0800
Message-ID: <CAB=NE6VFGUjDToW5zHgXOgfm9y77DGePe+mGAj=jvHEb8bHcGA@mail.gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55266 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759462AbcCDSwS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 4 Mar 2016 13:52:18 -0500
In-Reply-To: <1457115514.15454.216.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: Ingo Molnar <mingo@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Andy Walls <awalls@md.metrocast.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Julia Lawall <julia.lawall@lip6.fr>

On Fri, Mar 4, 2016 at 10:18 AM, Toshi Kani <toshi.kani@hpe.com> wrote:
> On Fri, 2016-03-04 at 10:44 +0100, Ingo Molnar wrote:
>> * Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>>
>> Could you outline a specific case where it's done intentionally - and the
>> purpose behind that intention?
>
> The term "overlapping" is a bit misleading.

To the driver author its overlapping, its overlapping on the physical address.

> This is "alias" mapping -- a
> physical address range is mapped to multiple virtual address ranges.  There
> is no overlapping in VMA.

Meanwhile this is what happens behind the scenes, and because of this
a driver developer may end up with two different offsets for
overlapping physical addresses ranges, so long as they use the right
offset they are *supposed* to get then the intended cache type
effects. The resulting cache type effect will depend on architecture
and intended cache type on the ioremap call. Furthermore there are
modifiers possible, such as was MTRR (and fortunately now deprecated
on kernel driver use), and those effects are now documented in
Documentation/x86/pat.txt on a table for PAT/not-PAT systems, which
I'll past here for convenience:

----------------------------------------------------------------------
MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
----------------------------------------------------------------------
                                                  Non-PAT |  PAT
     PAT
     |PCD
     ||PWT
     |||
WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   UC
WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
----------------------------------------------------------------------

> Such alias mappings are used by multiple modules.  For instance, a PMEM
> range is mapped to the kernel and user spaces.  /dev/mem is another example
> that creates a user space mapping to a physical address where other
> mappings may already exist.

The above examples are IMHO perhaps valid uses, and for these perhaps
we should add an API that enables overlapping on physical ranges. I
believe this given that for regular device drivers, at least in review
of write-combining, there were only exceptions I had found that were
using overlapping ranges. The above table was used to devise a
strategy to help phase MTRR in consideration for the overlapping uses
on drivers. Below is a list of what was found:

  * atyfb: I ended up splitting the overlapping ranges, it was quite a
bit of work, but I did this mostly to demo the effort needed on a
device driver after a device driver already had used an overlapping
range. To maintain the effective write-combining effects for non-PAT
systems we added ioremap_uc() which can be used on the MMIO range,
this would only be used on the MMIO area, meanwhile the framebuffer
area used ioremap_wc(), the arch_phys_wc_add() call was then used to
trigger write-combining on non-PAT systems due to the above tables.

 * ipath: while a split on ipath was possible the changes are quite
significant, way more significant than what was on atyfb. Fortunately
work on this driver for this triggered a discussion of eventually
removing this device driver, so on v4.3-rc2 it was move to staging to
phase it out. For completeness though I'll explain why the addressing
the overlap was hard: apart from changing the driver to use different
offset bases in different regions the driver also has a debug
userspace filemap for the entire register map, the code there would
need to be modified to use the right virtual address base depending on
the virtual address accessed. The qib driver already has logic which
could be mimic'd for this fortunatley, but still - this is
considerable work. One side hack I had hoped for was that overlapping
ioremap*() calls with different page attribute types would work even
if the 2nd returned __iomem address was not used, fortunately this
does not work though, only using the right virtual address would
ensure the right caching technique is used. Since this driver was
being phased out, we decided to annotate it required pat to be
disabled and warn the user if they booted with PAT enabled.

  * ivtv: the driver does not have the PCI space mapped out
separately, and in fact it actually does not do the math for the
framebuffer, instead it lets
the device's own CPU do that and assume where its at, see
ivtvfb_get_framebuffer() and CX2341X_OSD_GET_FRAMEBUFFER, it has a get
but not a setter. Its not clear if the firmware would make a split
easy. As with ipath, we decided to just require PAT disabled. This was
a reasonable compromise as the hardware was really old and we
estimated perhaps only a few lost souls were using this device driver,
and for them it should be reasonable to disable PAT.

Fortunately in retrospect it was only old hardware devices that used
overlapping ioremap() calls, but we can't be sure things will remain
that way. It used to be that only framebuffer devices used
write-combining, these days we are seeing infiniband (ipath was one,
qib another) use write-combining for PIO TX for some sort of blast
feature, I would not be surprised if in the future other device
drivers found a quirky use for this. The ivtv case is the *worst*
example we can expect where the firmware hides from us the exact
ranges for write-combining, that we should somehow just hope no one
will ever do again.

> Hence, alias mapping itself is a supported use-case.  However, alias
> mapping with different cache types is not as it causes undefined behavior.

Just as-is at times some types of modifiers, such as was with MTRR.

In retrospect, based on a cursory review through the phasing of MTRR,
we only have ipath left (and that will be removed soon) and we just
don't know what ivtv does. If we wanted a more in-depth analysis we
might be able to use something like coccinelle to inspect for
overlapping calls, but that may be a bit of a challenge in and of
itself. It may be easier to phase that behavior out by first warning
against it for a few cycles, and then just laying a hammer down and
saying 'though shalt not do this', and only enable exceptions with a
special API.

> Therefore, PAT module protects from this case by tracking cache types used
> for mapping physical ranges.  When a different cache type is requested,
> is_new_memtype_allowed() checks if the request needs to be failed or can be
> changed to the existing type.

Do we have a map of what is allowed for PAT and non-PAT, similar to
the one for MTRR effects above? It would seem we should want something
similar for other architectures ? But if there isn't much valid use
for it, why not just rule this sort of stuff out and only make it an
exception, by only having a few uses being allowed?

> I agree that the current implementation is fragile, and some interfaces
> skip such check at all, ex. vm_insert_pfn().

Ouch.

>> > The problem is that without this it remains up to the developer of the
>> > driver to avoid overlapping calls, and a user may just get sporadic
>> > errors if this happens.  As another problem case, set_memor_*() will
>> > not fail on MMIO even though set_memor_*() is designed only for RAM. If
>> > the above strategy on avoiding overlapping is agreeable, could the next
>> > step, or an orthogonal step be to error out on set_memory_*() on IO
>> > memory?
>>
>> So how do drivers set up WC or WB MMIO areas? Does none of our upstream
>> video drivers do that?
>
> Drivers use ioremap family with a right cache type when mapping MMIO
> ranges, ex. ioremap_wc().  They do not need to change the type to MMIO.
>  RAM is different since it's already mapped with WB at boot-time.
>  set_memory_*() allows us to change the type from WB, and put it back to
> WB.

Shouldn't set_memory_*() fail on IO memory? It does not today.

 Luis
