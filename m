From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Wed, 9 Mar 2016 10:15:25 +0100
Message-ID: <20160309091525.GA11866@gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com>
 <1457115514.15454.216.camel@hpe.com>
 <20160305114012.GA7259@gmail.com>
 <1457370228.15454.311.camel@hpe.com>
 <20160308121601.GA6573@gmail.com>
 <1457483385.15454.519.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37314 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702AbcCIJPa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 9 Mar 2016 04:15:30 -0500
Content-Disposition: inline
In-Reply-To: <1457483385.15454.519.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>


* Toshi Kani <toshi.kani@hpe.com> wrote:

> On Tue, 2016-03-08 at 13:16 +0100, Ingo Molnar wrote:
> > * Toshi Kani <toshi.kani@hpe.com> wrote:
> >=20
> > > > So where is the problem? The memtype implementation and hence m=
ost
> > > > ioremap() users are supposed to be safe. set_memory_*() APIs ar=
e
> > > > supposed
> > > > to be safe as well, as they too go via the memtype API.
> > >=20
> > > Let me try to summarize...
> > >=20
> > > The original issue Luis brought up was that drivers written to wo=
rk
> > > with MTRR may create a single ioremap range covering multiple cac=
he
> > > attributes since MTRR can overwrite cache attribute of a certain =
range.
> > > =A0Converting such drivers with PAT-based ioremap interfaces, i.e=
=2E
> > > ioremap_wc() and ioremap_nocache(), requires a separate ioremap m=
ap for
> > > each cache attribute, which can be challenging as it may result i=
n
> > > overlapping ioremap ranges (in his term) with different cache
> > > attributes.
> > >=20
> > > So, Luis asked about 'sematics of overlapping ioremap()' calls. =A0=
Hence,
> > > I responded that aliasing mapping itself is supported, but alias =
with
> > > different cache attribute is not. =A0We have checks in place to d=
etect
> > > such condition. =A0Overlapping ioremap calls with a different cac=
he
> > > attribute either fails or gets redirected to the existing cache
> > > attribute on x86.
> >=20
> > Ok, fair enough!
> >=20
> > So to go back to the original suggestion from Luis, I've quoted it,=
 but
> > with a s/overlapping/aliased substitution:
> >=20
> > > I had suggested long ago then that one possible resolution was fo=
r us
> > > to add an API that *enables* aliased ioremap() calls, and only us=
e it
> > > on select locations in the kernel. This means we only have to con=
vert a
> > > few users to that call to white list such semantics, and by defau=
lt
> > > we'd disable aliased calls. To kick things off -- is this strateg=
y
> > > agreeable for all other architectures?
> >=20
> > I'd say that since the overwhelming majority of ioremap() calls are=
 not
> > aliased, ever, thus making it 'harder' to accidentally alias is pro=
bably
> > a good idea.
>=20
> Did you mean 'aliased' or 'aliased with different cache attribute'? =A0=
The former=20
> check might be too strict.

I'd say even 'same attribute' aliasing is probably relatively rare.

And 'different but compatible cache attribute' is in fact more of a sig=
n that the=20
driver author does the aliasing for a valid _reason_: to have two diffe=
rent types=20
of access methods to the same piece of physical address space...

> > The memtype infrastructure of phyisical memory ranges in that case =
acts as a=20
> > security measure, to avoid unintended (not just physically incompat=
ible)=20
> > aliasing. I suspect it would be helpful during driver development a=
s well.
>=20
> The memtype infrastructure does not track caller interfaces. =A0So, i=
t will check=20
> against to any map, i.e. kernel & user map. =A0I assume a kernel map =
is created=20
> before user map, though.

I don't understand this, could you give me a specific example?

> > the other problem listed:
> >=20
> > > As another problem case, set_memor_*() will not fail on MMIO even
> > > though set_memor_*() is designed only for RAM.
> >=20
> > So what does this mean exactly? Having WB caching on MMIO area is n=
ot
> > good, but UC, WC and WB sure is still sensible in some cases, right=
?
>=20
> I responded to Luis in other email that:
> | Drivers use ioremap family with a right cache type when mapping MMI=
O
> | ranges, ex. ioremap_wc().=A0=A0They do not need to change the type =
to MMIO.
> | RAM is different since it's already mapped with WB at boot-time.
> | set_memory_*() allows us to change the type from WB, and put it bac=
k to
> | WB.

So there's two different uses here:

 - set_memory_x() to set the caching attribute
 - set_memory_x() to set any of the RWX access attributes

I'd in fact suggest we split these two uses to avoid confusion: keep=20
set_memory_x() APIs for the RWX access attributes uses, and introduce
a new API that sets caching attributes:

	set_cache_attr_wc()
	set_cache_attr_uc()
	set_cache_attr_wb()
	set_cache_attr_wt()

it has the same arguments, so it's basically just a rename initially.

And at that point we could definitely argue that set_cache_attr_*() API=
s should=20
probably generate a warning for _RAM_, because they mostly make sense f=
or MMIO=20
type of physical addresses, right? Regular RAM should always be WB.

Are there cases where we change the caching attribute of RAM for valid =
reasons,=20
outside of legacy quirks?

> > Basically if ioremap_uc() and ioremap_wc() is allowed on MMIO areas=
, then
> > I see no reason in principle why it should be invalid to change the=
 area
> > from UC to WC after it has been ioremap()ed.
>=20
> The current implementation does not support MMIO.
> =A0- It does not track cache attribute correctly for MMIO since it us=
es
> __pa().

Hm, so __pa() works on mmio addresses as well - at least on x86. The wh=
ole mmtype=20
tree is physical address based - which too is MMIO compatible in princi=
ple.

The only problem would be if it was fundamentally struct page * based -=
 but it's=20
not AFAICS. We have a few APIs that work on struct page * arrays, but t=
hose are=20
just vectored helper APIs AFAICS.

What am I missing?

> =A0- It only supports attribute transition of {WB -> NewType -> WB} f=
or RAM.
> =A0RAM is tracked differently that WB is treated as "no map". =A0So, =
this
> transition does not cause a conflict on RAM. =A0This will causes a co=
nflict
> on MMIO when it is tracked correctly. =A0=A0

That looks like a bug?

Thanks,

	Ingo
