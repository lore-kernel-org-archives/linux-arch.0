From: Toshi Kani <toshi.kani@hpe.com>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Thu, 17 Mar 2016 16:44:53 -0600
Message-ID: <1458254693.6393.506.camel@hpe.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
	 <20160304094424.GA16228@gmail.com> <1457115514.15454.216.camel@hpe.com>
	 <20160305114012.GA7259@gmail.com> <1457370228.15454.311.camel@hpe.com>
	 <20160308121601.GA6573@gmail.com> <1457483385.15454.519.camel@hpe.com>
	 <20160309091525.GA11866@gmail.com> <1457734432.6393.199.camel@hpe.com>
	 <20160316014548.GK1990@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:40196 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935904AbcCQVwa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2016 17:52:30 -0400
In-Reply-To: <20160316014548.GK1990@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Ingo Molnar <mingo@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

On Wed, 2016-03-16 at 02:45 +0100, Luis R. Rodriguez wrote:
> On Fri, Mar 11, 2016 at 03:13:52PM -0700, Toshi Kani wrote:
> > On Wed, 2016-03-09 at 10:15 +0100, Ingo Molnar wrote:
> > > * Toshi Kani <toshi.kani@hpe.com> wrote:
> > >=20
> > > > On Tue, 2016-03-08 at 13:16 +0100, Ingo Molnar wrote:
> > > > > * Toshi Kani <toshi.kani@hpe.com> wrote:
> > > > >=20
=C2=A0:
> > > > Did you mean 'aliased' or 'aliased with different cache attribu=
te'?
> > > > =C2=A0The former check might be too strict.
> > >=20
> > > I'd say even 'same attribute' aliasing is probably relatively rar=
e.
> > >=20
> > > And 'different but compatible cache attribute' is in fact more of=
 a
> > > sign that the driver author does the aliasing for a valid _reason=
_:
> > > to have two different types of access methods to the same piece o=
f
> > > physical address space...
> >=20
> > Right. =C2=A0So, if we change to fail ioremap() on aliased cases, i=
t'd be
> > easier to start with the different attribute case first. =C2=A0This=
 case
> > should be rare enough that we can manage to identify such callers a=
nd
> > make them use a new API as necessary. =C2=A0If we go ahead to fail =
any
> > aliased cases, it'd be challenging to manage without a regression o=
r
> > two.
>=20
> From my experience on the ioremap_wc() crusade, I found that the need=
 for
> aliasing with different cache types would have been needed in only 3
> drivers. For these 3, the atyfb driver I did the proper split in MMIO=
 and
> framebuffer, but that was significant work.=C2=A0=C2=A0I did this wor=
k to demo and
> document such work. It wasn't easy. For other two, ivtv and ipath we =
left
> as requiring "nopat" to be used. The ipath driver is on its way out o=
f
> the kenrel now through staging, and ivtv, well I am not aware of sing=
le
> human being claiming to use it. The architecture of ivtv actually
> prohibits us from ever using PAT for write-combining on the framebuff=
er
> as the firmware is the only one who knows the write-combining area an=
d
> hides it from us.

At glace, there are 863 references to ioremap(), 329 references to
ioremap_nocache(), and only 68 references to ioremap_wc() on x86. =C2=A0=
There
are many more ioremap callers with UC mappings than WC mappings, and it=
 is
hard to say that they never get aliased.

> We might be able to use tools like Coccinelle to perhaps hunt for
> the use of aliasing on drivers with different cache attribute types
> to do a full assessment but I really think that will be really hard
> to accomplish.
>=20
> If we can learn anything from the ioremap_wc() crusade I'd say its th=
at
> the need for aliasing with different cache types obviously implies we
> should disable such drivers with PAT as what we'd really need is a pr=
oper
> split in maps, but history shows the split can be really hard. It sou=
nded
> like you guys were confirming we currently do not allow for aliasing =
with
> different attributes on x86, is that the case for all architectures?
>=20
> If aliasing with different cache attributes is not allowed for x86 an=
d
> if its also rare for other architectures that just leaves the hunt fo=
r
> valid aliasing uses. That still may be hard to hunt for, but I also
> suspect it may be rare.

Yes, I'd fail the different cache attribute case if we are to place mor=
e
strict check.

=C2=A0:
> >=20
> > I think the "set_memory_" prefix implies that their target is regul=
ar
> > memory only.
>=20
> I did not find any driver using set_memory_wc() on MMIO, its a good t=
hing
> as that does not work it seems even if it returns no error.=C2=A0=C2=A0=
I'm not sure
> of the use of other set_memory_*() on MMIO but I would suspect its no=
t
> used. A manual hunt may suffice to rule these out.

It's good to know that you did not find any case on MMIO. =C2=A0The thi=
ng is,
set_memory_wc() actually works on MMIO today... This is because __pa()
returns a bogus address, which skips the alias check in the memtype.

> I guess what I'm trying to say is I am not sure we have a need for
> set_cache_attr_*() APIs, unless of course we find such valid use.
>=20
> > > And at that point we could definitely argue that set_cache_attr_*=
()
> > > APIs should probably generate a warning for _RAM_, because they
> > > mostly make sense for MMIO type of physical addresses, right? Reg=
ular
> > > RAM should always be WB.
> > >=20
> > > Are there cases where we change the caching attribute of RAM for
> > > valid reasons, outside of legacy quirks?
> >=20
> > ati_create_page_map() is one example that it gets a RAM page
> > by=C2=A0__get_free_page(), and changes it to UC by calling=C2=A0set=
_memory_uc().
>=20
> Should we instead have an API that lets it ask for RAM and of UC type=
?
> That would seem a bit cleaner. BTW do you happen to know *why* it nee=
ds
> UC RAM types?

This RAM page is then shared between graphic card and CPU. =C2=A0I thin=
k this is
because graphic card cannot snoop the cache.

> >=C2=A0
=C2=A0:
> > > > =C2=A0- It only supports attribute transition of {WB -> NewType=
 -> WB}
> > > > for RAM. =C2=A0RAM is tracked differently that WB is treated as=
 "no
> > > > map". =C2=A0So, this transition does not cause a conflict on RA=
M. =C2=A0This
> > > > will causes a conflict on MMIO when it is tracked correctly. =C2=
=A0=C2=A0
> > >=20
> > > That looks like a bug?
> >=20
> > This is by design since set_memory_xx was introduced for RAM only. =
=C2=A0If
> > we extend it to MMIO, then we need to change how memtype manages MM=
IO.
>=20
> I'd be afraid to *want* to support this on MMIO as I would only expec=
t
> hacks from drivers.

Agreed, with the hope that they are not used on MMIO already...

Thanks,
-Toshi
