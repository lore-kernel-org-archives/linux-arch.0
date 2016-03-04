From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Fri, 04 Mar 2016 14:39:10 -0700
Message-ID: <1457127550.15454.245.camel@hpe.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
	 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
	 <CAB=NE6VFGUjDToW5zHgXOgfm9y77DGePe+mGAj=jvHEb8bHcGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5008.houston.hp.com ([15.240.92.66]:50623 "EHLO
	g9t5008.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758993AbcCDUqf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2016 15:46:35 -0500
In-Reply-To: <CAB=NE6VFGUjDToW5zHgXOgfm9y77DGePe+mGAj=jvHEb8bHcGA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>, Dennis Dalessandro <dennis.dalessandro@intel.com>, Andy Walls <awalls@md.metrocast.net>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Julia Lawall <julia.lawall@lip6.fr>

On Fri, 2016-03-04 at 10:51 -0800, Luis R. Rodriguez wrote:
> On Fri, Mar 4, 2016 at 10:18 AM, Toshi Kani <toshi.kani@hpe.com> wrot=
e:
> > On Fri, 2016-03-04 at 10:44 +0100, Ingo Molnar wrote:
> > > * Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > >=20
> > > Could you outline a specific case where it's done intentionally -=
 and
> > > the purpose behind that intention?
> >=20
> > The term "overlapping" is a bit misleading.
>=20
> To the driver author its overlapping, its overlapping on the physical
> address.

Right, and I just wanted to state that there is no overlapping in VMA.

> > This is "alias" mapping -- a physical address range is mapped to
> > multiple virtual address ranges.=C2=A0=C2=A0There is no overlapping=
 in VMA.
>=20
> Meanwhile this is what happens behind the scenes, and because of this
> a driver developer may end up with two different offsets for
> overlapping physical addresses ranges, so long as they use the right
> offset they are *supposed* to get then the intended cache type
> effects. The resulting cache type effect will depend on architecture
> and intended cache type on the ioremap call. Furthermore there are
> modifiers possible, such as was MTRR (and fortunately now deprecated
> on kernel driver use), and those effects are now documented in
> Documentation/x86/pat.txt on a table for PAT/not-PAT systems, which
> I'll past here for convenience:

Thanks for updating the documentation!

> ---------------------------------------------------------------------=
-
> MTRR Non-PAT=C2=A0=C2=A0=C2=A0PAT=C2=A0=C2=A0=C2=A0=C2=A0Linux iorema=
p value=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Effective memory=
 type
> ---------------------------------------------------------------------=
-
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0Non-PAT |=C2=A0=C2=A0PAT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0PAT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|PCD
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0||PWT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0|||
> WC=C2=A0=C2=A0=C2=A0000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WB=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0_PAGE_CACHE_MODE_WB=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WC=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A0=C2=A0WC
> WC=C2=A0=C2=A0=C2=A0001=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WC=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0_PAGE_CACHE_MODE_WC=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0WC*=C2=A0=C2=A0|=C2=A0=C2=A0=
=C2=A0WC
> WC=C2=A0=C2=A0=C2=A0010=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UC-=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0_PAGE_CACHE_MODE_UC_MINUS=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0WC*=C2=A0=C2=A0|=C2=A0=C2=A0=C2=A0UC

In the above case, effective PAT is also WC.

> WC=C2=A0=C2=A0=C2=A0011=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UC=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0_PAGE_CACHE_MODE_UC=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0UC=C2=A0=C2=A0=C2=A0|=C2=A0=
=C2=A0=C2=A0UC
> ---------------------------------------------------------------------=
-
>=20
> > Such alias mappings are used by multiple modules.=C2=A0=C2=A0For in=
stance, a PMEM
> > range is mapped to the kernel and user spaces.=C2=A0=C2=A0/dev/mem =
is another
> > example that creates a user space mapping to a physical address whe=
re
> > other mappings may already exist.
>=20
> The above examples are IMHO perhaps valid uses, and for these perhaps
> we should add an API that enables overlapping on physical ranges. I
> believe this given that for regular device drivers, at least in revie=
w
> of write-combining, there were only exceptions I had found that were
> using overlapping ranges. The above table was used to devise a
> strategy to help phase MTRR in consideration for the overlapping uses
> on drivers. Below is a list of what was found:
>=20
> =C2=A0 * atyfb: I ended up splitting the overlapping ranges, it was q=
uite a
> bit of work, but I did this mostly to demo the effort needed on a
> device driver after a device driver already had used an overlapping
> range. To maintain the effective write-combining effects for non-PAT
> systems we added ioremap_uc() which can be used on the MMIO range,
> this would only be used on the MMIO area, meanwhile the framebuffer
> area used ioremap_wc(), the arch_phys_wc_add() call was then used to
> trigger write-combining on non-PAT systems due to the above tables.
>=20
> =C2=A0* ipath: while a split on ipath was possible the changes are qu=
ite
> significant, way more significant than what was on atyfb. Fortunately
> work on this driver for this triggered a discussion of eventually
> removing this device driver, so on v4.3-rc2 it was move to staging to
> phase it out. For completeness though I'll explain why the addressing
> the overlap was hard: apart from changing the driver to use different
> offset bases in different regions the driver also has a debug
> userspace filemap for the entire register map, the code there would
> need to be modified to use the right virtual address base depending o=
n
> the virtual address accessed. The qib driver already has logic which
> could be mimic'd for this fortunatley, but still - this is
> considerable work. One side hack I had hoped for was that overlapping
> ioremap*() calls with different page attribute types would work even
> if the 2nd returned __iomem address was not used, fortunately this
> does not work though, only using the right virtual address would
> ensure the right caching technique is used. Since this driver was
> being phased out, we decided to annotate it required pat to be
> disabled and warn the user if they booted with PAT enabled.
>=20
> =C2=A0 * ivtv: the driver does not have the PCI space mapped out
> separately, and in fact it actually does not do the math for the
> framebuffer, instead it lets
> the device's own CPU do that and assume where its at, see
> ivtvfb_get_framebuffer() and CX2341X_OSD_GET_FRAMEBUFFER, it has a ge=
t
> but not a setter. Its not clear if the firmware would make a split
> easy. As with ipath, we decided to just require PAT disabled. This wa=
s
> a reasonable compromise as the hardware was really old and we
> estimated perhaps only a few lost souls were using this device driver=
,
> and for them it should be reasonable to disable PAT.
>=20
> Fortunately in retrospect it was only old hardware devices that used
> overlapping ioremap() calls, but we can't be sure things will remain
> that way. It used to be that only framebuffer devices used
> write-combining, these days we are seeing infiniband (ipath was one,
> qib another) use write-combining for PIO TX for some sort of blast
> feature, I would not be surprised if in the future other device
> drivers found a quirky use for this. The ivtv case is the *worst*
> example we can expect where the firmware hides from us the exact
> ranges for write-combining, that we should somehow just hope no one
> will ever do again.
>=20
> > Hence, alias mapping itself is a supported use-case.=C2=A0=C2=A0How=
ever, alias
> > mapping with different cache types is not as it causes undefined
> > behavior.
>=20
> Just as-is at times some types of modifiers, such as was with MTRR.
>=20
> In retrospect, based on a cursory review through the phasing of MTRR,
> we only have ipath left (and that will be removed soon) and we just
> don't know what ivtv does. If we wanted a more in-depth analysis we
> might be able to use something like coccinelle to inspect for
> overlapping calls, but that may be a bit of a challenge in and of
> itself. It may be easier to phase that behavior out by first warning
> against it for a few cycles, and then just laying a hammer down and
> saying 'though shalt not do this', and only enable exceptions with a
> special API.

These are great work! =C2=A0I agree that we should phase out those old =
drivers
written to work with MTRR.

> > Therefore, PAT module protects from this case by tracking cache typ=
es
> > used for mapping physical ranges.=C2=A0=C2=A0When a different cache=
 type is
> > requested, is_new_memtype_allowed() checks if the request needs to =
be
> > failed or can be changed to the existing type.
>=20
> Do we have a map of what is allowed for PAT and non-PAT, similar to
> the one for MTRR effects above?=20

This type check and tracking code are part of PAT code, so there is no
check for the non-PAT case.

> It would seem we should want something similar for other architecture=
s ?=20

As far as I know, other architectures does not support alias maps with
different cache types, either. =C2=A0So, I agree that this is a common =
issue.

> But if there isn't much valid use for it, why not just rule this sort=
 of
> stuff out and only make it an exception, by only having a few uses be=
ing
> allowed?

I agree that it should fail in general. =C2=A0One exception is WB reque=
st, which
is allowed to be modified to any other type. =C2=A0I think this is need=
ed for
/dev/mem, which maps with WB without any knowledge of a target range.

> > I agree that the current implementation is fragile, and some interf=
aces
> > skip such check at all, ex. vm_insert_pfn().
>=20
> Ouch.
>=20
> > > > The problem is that without this it remains up to the developer=
 of
> > > > the driver to avoid overlapping calls, and a user may just get
> > > > sporadic errors if this happens.=C2=A0=C2=A0As another problem =
case,
> > > > set_memor_*() will not fail on MMIO even though set_memor_*() i=
s
> > > > designed only for RAM. If the above strategy on avoiding
> > > > overlapping is agreeable, could the next step, or an orthogonal
> > > > step be to error out on set_memory_*() on IO memory?
> > >=20
> > > So how do drivers set up WC or WB MMIO areas? Does none of our
> > > upstream video drivers do that?
> >=20
> > Drivers use ioremap family with a right cache type when mapping MMI=
O
> > ranges, ex. ioremap_wc().=C2=A0=C2=A0They do not need to change the=
 type to MMIO.
> > =C2=A0RAM is different since it's already mapped with WB at boot-ti=
me.
> > =C2=A0set_memory_*() allows us to change the type from WB, and put =
it back
> > to WB.
>=20
> Shouldn't set_memory_*() fail on IO memory? It does not today.

Agreed. =C2=A0It should have had such check to begin with.

Thanks,
-Toshi
