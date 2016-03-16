From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Wed, 16 Mar 2016 02:45:48 +0100
Message-ID: <20160316014548.GK1990@wotan.suse.de>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com>
 <1457115514.15454.216.camel@hpe.com>
 <20160305114012.GA7259@gmail.com>
 <1457370228.15454.311.camel@hpe.com>
 <20160308121601.GA6573@gmail.com>
 <1457483385.15454.519.camel@hpe.com>
 <20160309091525.GA11866@gmail.com>
 <1457734432.6393.199.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55059 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293AbcCPBqC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 15 Mar 2016 21:46:02 -0400
Content-Disposition: inline
In-Reply-To: <1457734432.6393.199.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Ingo Molnar <mingo@kernel.org>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

On Fri, Mar 11, 2016 at 03:13:52PM -0700, Toshi Kani wrote:
> Hi Ingo,
>=20
> My apology for the delay...
>=20
> On Wed, 2016-03-09 at 10:15 +0100, Ingo Molnar wrote:
> > * Toshi Kani <toshi.kani@hpe.com> wrote:
> >=20
> > > On Tue, 2016-03-08 at 13:16 +0100, Ingo Molnar wrote:
> > > > * Toshi Kani <toshi.kani@hpe.com> wrote:
> > > >=20
> > > > > > So where is the problem? The memtype implementation and hen=
ce
> > > > > > most ioremap() users are supposed to be safe. set_memory_*(=
) APIs
> > > > > > are supposed to be safe as well, as they too go via the mem=
type
> > > > > > API.
> > > > >=20
> > > > > Let me try to summarize...
> > > > >=20
> > > > > The original issue Luis brought up was that drivers written t=
o work
> > > > > with MTRR may create a single ioremap range covering multiple=
 cache
> > > > > attributes since MTRR can overwrite cache attribute of a cert=
ain
> > > > > range. =A0Converting such drivers with PAT-based ioremap inte=
rfaces,
> > > > > i.e. ioremap_wc() and ioremap_nocache(), requires a separate
> > > > > ioremap map for each cache attribute, which can be challengin=
g as
> > > > > it may result in overlapping ioremap ranges (in his term) wit=
h
> > > > > different cache attributes.
> > > > >=20
> > > > > So, Luis asked about 'sematics of overlapping ioremap()' call=
s.
> > > > > =A0Hence, I responded that aliasing mapping itself is support=
ed, but
> > > > > alias with different cache attribute is not. =A0We have check=
s in
> > > > > place to detect such condition. =A0Overlapping ioremap calls =
with a
> > > > > different cache attribute either fails or gets redirected to =
the
> > > > > existing cache attribute on x86.
> > > >=20
> > > > Ok, fair enough!
> > > >=20
> > > > So to go back to the original suggestion from Luis, I've quoted=
 it,
> > > > but with a s/overlapping/aliased substitution:
> > > >=20
> > > > > I had suggested long ago then that one possible resolution wa=
s for
> > > > > us to add an API that *enables* aliased ioremap() calls, and =
only
> > > > > use it on select locations in the kernel. This means we only =
have
> > > > > to convert a few users to that call to white list such semant=
ics,
> > > > > and by default we'd disable aliased calls. To kick things off=
 -- is
> > > > > this strategy agreeable for all other architectures?
> > > >=20
> > > > I'd say that since the overwhelming majority of ioremap() calls=
 are
> > > > not aliased, ever, thus making it 'harder' to accidentally alia=
s is
> > > > probably a good idea.
> > >=20
> > > Did you mean 'aliased' or 'aliased with different cache attribute=
'?
> > > =A0The former check might be too strict.
> >=20
> > I'd say even 'same attribute' aliasing is probably relatively rare.
> >=20
> > And 'different but compatible cache attribute' is in fact more of a=
 sign
> > that the driver author does the aliasing for a valid _reason_: to h=
ave
> > two different types of access methods to the same piece of physical
> > address space...
>=20
> Right. =A0So, if we change to fail ioremap() on aliased cases, it'd b=
e easier
> to start with the different attribute case first. =A0This case should=
 be rare
> enough that we can manage to identify such callers and make them use =
a new
> API as necessary. =A0If we go ahead to fail any aliased cases, it'd b=
e
> challenging to manage without a regression or two.

=46rom my experience on the ioremap_wc() crusade, I found that the need=
 for
aliasing with different cache types would have been needed in only 3 dr=
ivers.
=46or these 3, the atyfb driver I did the proper split in MMIO and fram=
ebuffer,
but that was significant work.  I did this work to demo and document su=
ch
work. It wasn't easy. For other two, ivtv and ipath we left as requirin=
g
"nopat" to be used. The ipath driver is on its way out of the kenrel no=
w
through staging, and ivtv, well I am not aware of single human being
claiming to use it. The architecture of ivtv actually prohibits us
from ever using PAT for write-combining on the framebuffer as the firmw=
are
is the only one who knows the write-combining area and hides it from us=
=2E

We might be able to use tools like Coccinelle to perhaps hunt for
the use of aliasing on drivers with different cache attribute types
to do a full assessment but I really think that will be really hard
to accomplish.

If we can learn anything from the ioremap_wc() crusade I'd say its that
the need for aliasing with different cache types obviously implies we
should disable such drivers with PAT as what we'd really need is a prop=
er
split in maps, but history shows the split can be really hard. It sound=
ed
like you guys were confirming we currently do not allow for aliasing wi=
th
different attributes on x86, is that the case for all architectures?

If aliasing with different cache attributes is not allowed for x86 and
if its also rare for other architectures that just leaves the hunt for
valid aliasing uses. That still may be hard to hunt for, but I also
suspect it may be rare.

> > > > The memtype infrastructure of phyisical memory ranges in that c=
ase
> > > > acts as a security measure, to avoid unintended (not just physi=
cally
> > > > incompatible) aliasing. I suspect it would be helpful during dr=
iver
> > > > development as well.
> > >=20
> > > The memtype infrastructure does not track caller interfaces. =A0S=
o, it
> > > will check against to any map, i.e. kernel & user map. =A0I assum=
e a
> > > kernel map is created before user map, though.
> >=20
> > I don't understand this, could you give me a specific example?
>=20
> Multiple pfn map interfaces use the memtype. =A0So, when ioremap() de=
tects an
> aliased map in the memtype, it may be created by ioremap(),
> remap_pfn_range(), or any pfn map that is tracked. =A0So, strictly sp=
eaking,
> we cannot check against other ioremap().
>=20
> > > > the other problem listed:
> > > >=20
> > > > > As another problem case, set_memor_*() will not fail on MMIO =
even
> > > > > though set_memor_*() is designed only for RAM.
> > > >=20
> > > > So what does this mean exactly? Having WB caching on MMIO area =
is not
> > > > good, but UC, WC and WB sure is still sensible in some cases, r=
ight?
> > >=20
> > > I responded to Luis in other email that:
> > > > Drivers use ioremap family with a right cache type when mapping=
 MMIO
> > > > ranges, ex. ioremap_wc().=A0=A0They do not need to change the t=
ype to
> > > > MMIO. RAM is different since it's already mapped with WB at boo=
t-
> > > > time. set_memory_*() allows us to change the type from WB, and =
put it
> > > > back to WB.
> >=20
> > So there's two different uses here:
> >=20
> > =A0- set_memory_x() to set the caching attribute
> > =A0- set_memory_x() to set any of the RWX access attributes
> >=20
> > I'd in fact suggest we split these two uses to avoid confusion: kee=
p=A0
> > set_memory_x() APIs for the RWX access attributes uses, and introdu=
ce
> > a new API that sets caching attributes:
> >=20
> > 	set_cache_attr_wc()
> > 	set_cache_attr_uc()
> > 	set_cache_attr_wb()
> > 	set_cache_attr_wt()
> >=20
> > it has the same arguments, so it's basically just a rename initiall=
y.
>=20
> I think the "set_memory_" prefix implies that their target is regular
> memory only.

I did not find any driver using set_memory_wc() on MMIO, its a good thi=
ng
as that does not work it seems even if it returns no error.  I'm not su=
re
of the use of other set_memory_*() on MMIO but I would suspect its not
used. A manual hunt may suffice to rule these out.

I guess what I'm trying to say is I am not sure we have a need for
set_cache_attr_*() APIs, unless of course we find such valid use.

> > And at that point we could definitely argue that set_cache_attr_*()=
 APIs
> > should probably generate a warning for _RAM_, because they mostly m=
ake
> > sense for MMIO type of physical addresses, right? Regular RAM shoul=
d
> > always be WB.
> >=20
> > Are there cases where we change the caching attribute of RAM for va=
lid
> > reasons, outside of legacy quirks?
>=20
> ati_create_page_map() is one example that it gets a RAM page
> by=A0__get_free_page(), and changes it to UC by calling=A0set_memory_=
uc().

Should we instead have an API that lets it ask for RAM and of UC type?
That would seem a bit cleaner. BTW do you happen to know *why* it needs
UC RAM types?

> Since RAM is already mapped with WB, the driver has to change its att=
ribute
> when it needs a different cache type. =A0For MMIO, drivers should be =
able to
> create a map with the right attribute since they own the ranges.

=46rom my own work so far I tend to agree here, but that's just because
I've seen how drivers can suck badly, and they can quickly think they
can use hacks for things which actually really need a full architectura=
l
proper solution in driver or firmware. In the worst case we have insane
firmware, but I think that's probably really uncommon and likely and it=
s
design was flawed given that at that time PAT was probably rare.

> > > > Basically if ioremap_uc() and ioremap_wc() is allowed on MMIO a=
reas,
> > > > then I see no reason in principle why it should be invalid to c=
hange
> > > > the area from UC to WC after it has been ioremap()ed.
> > >=20
> > > The current implementation does not support MMIO.
> > > =A0- It does not track cache attribute correctly for MMIO since i=
t uses
> > > __pa().
> >=20
> > Hm, so __pa() works on mmio addresses as well - at least on x86. Th=
e
> > whole mmtype tree is physical address based - which too is MMIO
> > compatible in principle.
> >
> > The only problem would be if it was fundamentally struct page * bas=
ed -
> > but it's not AFAICS. We have a few APIs that work on struct page *
> > arrays, but those are just vectored helper APIs AFAICS.
> >=20
> > What am I missing?
>=20
> I do not think __pa() returns the right physical address for an iorem=
ap'd
> virtual address since its virtual address is allocated from the vmall=
oc
> range. =A0But we can simply use=A0slow_virt_to_phys(), instead.
>=20
> > > =A0- It only supports attribute transition of {WB -> NewType -> W=
B} for
> > > RAM. =A0RAM is tracked differently that WB is treated as "no map"=
=2E =A0So,
> > > this transition does not cause a conflict on RAM. =A0This will ca=
uses a
> > > conflict on MMIO when it is tracked correctly. =A0=A0
> >=20
> > That looks like a bug?
>=20
> This is by design since set_memory_xx was introduced for RAM only. =A0=
If we
> extend it to MMIO, then we need to change how memtype manages MMIO.

I'd be afraid to *want* to support this on MMIO as I would only expect
hacks from drivers.

  Luis
