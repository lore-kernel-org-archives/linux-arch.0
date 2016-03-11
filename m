From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Fri, 11 Mar 2016 15:13:52 -0700
Message-ID: <1457734432.6393.199.camel@hpe.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
	 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
	 <20160305114012.GA7259@gmail.com> <1457370228.15454.311.camel@hpe.com>
	 <20160308121601.GA6573@gmail.com> <1457483385.15454.519.camel@hpe.com>
	 <20160309091525.GA11866@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3427.houston.hp.com ([15.201.208.55]:47684 "EHLO
	g4t3427.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbcCKVVV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Mar 2016 16:21:21 -0500
In-Reply-To: <20160309091525.GA11866@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

Hi Ingo,

My apology for the delay...

On Wed, 2016-03-09 at 10:15 +0100, Ingo Molnar wrote:
> * Toshi Kani <toshi.kani@hpe.com> wrote:
>=20
> > On Tue, 2016-03-08 at 13:16 +0100, Ingo Molnar wrote:
> > > * Toshi Kani <toshi.kani@hpe.com> wrote:
> > >=20
> > > > > So where is the problem? The memtype implementation and hence
> > > > > most ioremap() users are supposed to be safe. set_memory_*() =
APIs
> > > > > are supposed to be safe as well, as they too go via the memty=
pe
> > > > > API.
> > > >=20
> > > > Let me try to summarize...
> > > >=20
> > > > The original issue Luis brought up was that drivers written to =
work
> > > > with MTRR may create a single ioremap range covering multiple c=
ache
> > > > attributes since MTRR can overwrite cache attribute of a certai=
n
> > > > range. =C2=A0Converting such drivers with PAT-based ioremap int=
erfaces,
> > > > i.e. ioremap_wc() and ioremap_nocache(), requires a separate
> > > > ioremap map for each cache attribute, which can be challenging =
as
> > > > it may result in overlapping ioremap ranges (in his term) with
> > > > different cache attributes.
> > > >=20
> > > > So, Luis asked about 'sematics of overlapping ioremap()' calls.
> > > > =C2=A0Hence, I responded that aliasing mapping itself is suppor=
ted, but
> > > > alias with different cache attribute is not. =C2=A0We have chec=
ks in
> > > > place to detect such condition. =C2=A0Overlapping ioremap calls=
 with a
> > > > different cache attribute either fails or gets redirected to th=
e
> > > > existing cache attribute on x86.
> > >=20
> > > Ok, fair enough!
> > >=20
> > > So to go back to the original suggestion from Luis, I've quoted i=
t,
> > > but with a s/overlapping/aliased substitution:
> > >=20
> > > > I had suggested long ago then that one possible resolution was =
for
> > > > us to add an API that *enables* aliased ioremap() calls, and on=
ly
> > > > use it on select locations in the kernel. This means we only ha=
ve
> > > > to convert a few users to that call to white list such semantic=
s,
> > > > and by default we'd disable aliased calls. To kick things off -=
- is
> > > > this strategy agreeable for all other architectures?
> > >=20
> > > I'd say that since the overwhelming majority of ioremap() calls a=
re
> > > not aliased, ever, thus making it 'harder' to accidentally alias =
is
> > > probably a good idea.
> >=20
> > Did you mean 'aliased' or 'aliased with different cache attribute'?
> > =C2=A0The former check might be too strict.
>=20
> I'd say even 'same attribute' aliasing is probably relatively rare.
>=20
> And 'different but compatible cache attribute' is in fact more of a s=
ign
> that the driver author does the aliasing for a valid _reason_: to hav=
e
> two different types of access methods to the same piece of physical
> address space...

Right. =C2=A0So, if we change to fail ioremap() on aliased cases, it'd =
be easier
to start with the different attribute case first. =C2=A0This case shoul=
d be rare
enough that we can manage to identify such callers and make them use a =
new
API as necessary. =C2=A0If we go ahead to fail any aliased cases, it'd =
be
challenging to manage without a regression or two.

> > > The memtype infrastructure of phyisical memory ranges in that cas=
e
> > > acts as a security measure, to avoid unintended (not just physica=
lly
> > > incompatible) aliasing. I suspect it would be helpful during driv=
er
> > > development as well.
> >=20
> > The memtype infrastructure does not track caller interfaces. =C2=A0=
So, it
> > will check against to any map, i.e. kernel & user map. =C2=A0I assu=
me a
> > kernel map is created before user map, though.
>=20
> I don't understand this, could you give me a specific example?

Multiple pfn map interfaces use the memtype. =C2=A0So, when ioremap() d=
etects an
aliased map in the memtype, it may be created by ioremap(),
remap_pfn_range(), or any pfn map that is tracked. =C2=A0So, strictly s=
peaking,
we cannot check against other ioremap().

> > > the other problem listed:
> > >=20
> > > > As another problem case, set_memor_*() will not fail on MMIO ev=
en
> > > > though set_memor_*() is designed only for RAM.
> > >=20
> > > So what does this mean exactly? Having WB caching on MMIO area is=
 not
> > > good, but UC, WC and WB sure is still sensible in some cases, rig=
ht?
> >=20
> > I responded to Luis in other email that:
> > > Drivers use ioremap family with a right cache type when mapping M=
MIO
> > > ranges, ex. ioremap_wc().=C2=A0=C2=A0They do not need to change t=
he type to
> > > MMIO. RAM is different since it's already mapped with WB at boot-
> > > time. set_memory_*() allows us to change the type from WB, and pu=
t it
> > > back to WB.
>=20
> So there's two different uses here:
>=20
> =C2=A0- set_memory_x() to set the caching attribute
> =C2=A0- set_memory_x() to set any of the RWX access attributes
>=20
> I'd in fact suggest we split these two uses to avoid confusion: keep=C2=
=A0
> set_memory_x() APIs for the RWX access attributes uses, and introduce
> a new API that sets caching attributes:
>=20
> 	set_cache_attr_wc()
> 	set_cache_attr_uc()
> 	set_cache_attr_wb()
> 	set_cache_attr_wt()
>=20
> it has the same arguments, so it's basically just a rename initially.

I think the "set_memory_" prefix implies that their target is regular
memory only.

> And at that point we could definitely argue that set_cache_attr_*() A=
PIs
> should probably generate a warning for _RAM_, because they mostly mak=
e
> sense for MMIO type of physical addresses, right? Regular RAM should
> always be WB.
>=20
> Are there cases where we change the caching attribute of RAM for vali=
d
> reasons, outside of legacy quirks?

ati_create_page_map() is one example that it gets a RAM page
by=C2=A0__get_free_page(), and changes it to UC by calling=C2=A0set_mem=
ory_uc().
Since RAM is already mapped with WB, the driver has to change its attri=
bute
when it needs a different cache type. =C2=A0For MMIO, drivers should be=
 able to
create a map with the right attribute since they own the ranges.

> > > Basically if ioremap_uc() and ioremap_wc() is allowed on MMIO are=
as,
> > > then I see no reason in principle why it should be invalid to cha=
nge
> > > the area from UC to WC after it has been ioremap()ed.
> >=20
> > The current implementation does not support MMIO.
> > =C2=A0- It does not track cache attribute correctly for MMIO since =
it uses
> > __pa().
>=20
> Hm, so __pa() works on mmio addresses as well - at least on x86. The
> whole mmtype tree is physical address based - which too is MMIO
> compatible in principle.
>
> The only problem would be if it was fundamentally struct page * based=
 -
> but it's not AFAICS. We have a few APIs that work on struct page *
> arrays, but those are just vectored helper APIs AFAICS.
>=20
> What am I missing?

I do not think __pa() returns the right physical address for an ioremap=
'd
virtual address since its virtual address is allocated from the vmalloc
range. =C2=A0But we can simply use=C2=A0slow_virt_to_phys(), instead.

> > =C2=A0- It only supports attribute transition of {WB -> NewType -> =
WB} for
> > RAM. =C2=A0RAM is tracked differently that WB is treated as "no map=
". =C2=A0So,
> > this transition does not cause a conflict on RAM. =C2=A0This will c=
auses a
> > conflict on MMIO when it is tracked correctly. =C2=A0=C2=A0
>=20
> That looks like a bug?

This is by design since set_memory_xx was introduced for RAM only. =C2=A0=
If we
extend it to MMIO, then we need to change how memtype manages MMIO.

Thanks,
-Toshi
