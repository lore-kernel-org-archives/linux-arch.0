From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Tue, 08 Mar 2016 17:29:45 -0700
Message-ID: <1457483385.15454.519.camel@hpe.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
	 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
	 <20160305114012.GA7259@gmail.com> <1457370228.15454.311.camel@hpe.com>
	 <20160308121601.GA6573@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g9t5009.houston.hp.com ([15.240.92.67]:35118 "EHLO
	g9t5009.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbcCHXhO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2016 18:37:14 -0500
In-Reply-To: <20160308121601.GA6573@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

On Tue, 2016-03-08 at 13:16 +0100, Ingo Molnar wrote:
> * Toshi Kani <toshi.kani@hpe.com> wrote:
>=20
> > > So where is the problem? The memtype implementation and hence mos=
t
> > > ioremap() users are supposed to be safe. set_memory_*() APIs are
> > > supposed
> > > to be safe as well, as they too go via the memtype API.
> >=20
> > Let me try to summarize...
> >=20
> > The original issue Luis brought up was that drivers written to work
> > with MTRR may create a single ioremap range covering multiple cache
> > attributes since MTRR can overwrite cache attribute of a certain ra=
nge.
> > =C2=A0Converting such drivers with PAT-based ioremap interfaces, i.=
e.
> > ioremap_wc() and ioremap_nocache(), requires a separate ioremap map=
 for
> > each cache attribute, which can be challenging as it may result in
> > overlapping ioremap ranges (in his term) with different cache
> > attributes.
> >=20
> > So, Luis asked about 'sematics of overlapping ioremap()' calls. =C2=
=A0Hence,
> > I responded that aliasing mapping itself is supported, but alias wi=
th
> > different cache attribute is not. =C2=A0We have checks in place to =
detect
> > such condition. =C2=A0Overlapping ioremap calls with a different ca=
che
> > attribute either fails or gets redirected to the existing cache
> > attribute on x86.
>=20
> Ok, fair enough!
>=20
> So to go back to the original suggestion from Luis, I've quoted it, b=
ut
> with a s/overlapping/aliased substitution:
>=20
> > I had suggested long ago then that one possible resolution was for =
us
> > to add an API that *enables* aliased ioremap() calls, and only use =
it
> > on select locations in the kernel. This means we only have to conve=
rt a
> > few users to that call to white list such semantics, and by default
> > we'd disable aliased calls. To kick things off -- is this strategy
> > agreeable for all other architectures?
>=20
> I'd say that since the overwhelming majority of ioremap() calls are n=
ot
> aliased, ever, thus making it 'harder' to accidentally alias is proba=
bly
> a good idea.

Did you mean 'aliased' or 'aliased with different cache attribute'? =C2=
=A0The
former check might be too strict.

> The memtype infrastructure of phyisical memory ranges in that case ac=
ts
> as a security measure, to avoid unintended (not just physically
> incompatible) aliasing. I suspect it would be helpful during driver
> development as well.

The memtype infrastructure does not track caller interfaces. =C2=A0So, =
it will
check against to any map, i.e. kernel & user map. =C2=A0I assume a kern=
el map is
created before user map, though.

> What extra API are you thinking about to enable aliasing in the few c=
ases
> where it's justified?

I'll defer this for Luis...

> the other problem listed:
>=20
> > As another problem case, set_memor_*() will not fail on MMIO even
> > though set_memor_*() is designed only for RAM.
>=20
> So what does this mean exactly? Having WB caching on MMIO area is not
> good, but UC, WC and WB sure is still sensible in some cases, right?

I responded to Luis in other email that:
| Drivers use ioremap family with a right cache type when mapping MMIO
| ranges, ex. ioremap_wc().=C2=A0=C2=A0They do not need to change the t=
ype to MMIO.
| RAM is different since it's already mapped with WB at boot-time.
| set_memory_*() allows us to change the type from WB, and put it back =
to
| WB.

> > [...] If the above strategy on avoiding aliasing is agreeable, coul=
d
> > the next step, or an orthogonal step be to error out on set_memory_=
*()
> > on IO memory?
>=20
> Well, do we have drivers that nevertheless change caching attributes =
on
> MMIO areas?

Not sure. =C2=A0We will need to check all callers of set_memory_xx() if=
 we
change it to fail on MMIO.

> Basically if ioremap_uc() and ioremap_wc() is allowed on MMIO areas, =
then
> I see no reason in principle why it should be invalid to change the a=
rea
> from UC to WC after it has been ioremap()ed.

The current implementation does not support MMIO.
=C2=A0- It does not track cache attribute correctly for MMIO since it u=
ses
__pa().
=C2=A0- It only supports attribute transition of {WB -> NewType -> WB} =
for RAM.
=C2=A0RAM is tracked differently that WB is treated as "no map". =C2=A0=
So, this
transition does not cause a conflict on RAM. =C2=A0This will causes a c=
onflict
on MMIO when it is tracked correctly. =C2=A0=C2=A0

Thanks,
-Toshi
