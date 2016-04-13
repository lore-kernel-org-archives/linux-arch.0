From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Wed, 13 Apr 2016 23:16:38 +0200
Message-ID: <20160413211638.GF1990@wotan.suse.de>
References: <20160304094424.GA16228@gmail.com>
 <1457115514.15454.216.camel@hpe.com>
 <20160305114012.GA7259@gmail.com>
 <1457370228.15454.311.camel@hpe.com>
 <20160308121601.GA6573@gmail.com>
 <1457483385.15454.519.camel@hpe.com>
 <20160309091525.GA11866@gmail.com>
 <1457734432.6393.199.camel@hpe.com>
 <20160316014548.GK1990@wotan.suse.de>
 <1458254693.6393.506.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46403 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750899AbcDMVQl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Apr 2016 17:16:41 -0400
Content-Disposition: inline
In-Reply-To: <1458254693.6393.506.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>, "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Julia Lawall <julia.lawall@lip6.fr>, Ingo Molnar <mingo@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>

On Thu, Mar 17, 2016 at 04:44:53PM -0600, Toshi Kani wrote:
> On Wed, 2016-03-16 at 02:45 +0100, Luis R. Rodriguez wrote:
> > On Fri, Mar 11, 2016 at 03:13:52PM -0700, Toshi Kani wrote:
> > > On Wed, 2016-03-09 at 10:15 +0100, Ingo Molnar wrote:
> > > > * Toshi Kani <toshi.kani@hpe.com> wrote:
> > > >=20
> > > > > On Tue, 2016-03-08 at 13:16 +0100, Ingo Molnar wrote:
> > > > > > * Toshi Kani <toshi.kani@hpe.com> wrote:
> > > > > >=20
> =A0:
> > > > > Did you mean 'aliased' or 'aliased with different cache attri=
bute'?
> > > > > =A0The former check might be too strict.
> > > >=20
> > > > I'd say even 'same attribute' aliasing is probably relatively r=
are.
> > > >=20
> > > > And 'different but compatible cache attribute' is in fact more =
of a
> > > > sign that the driver author does the aliasing for a valid _reas=
on_:
> > > > to have two different types of access methods to the same piece=
 of
> > > > physical address space...
> > >=20
> > > Right. =A0So, if we change to fail ioremap() on aliased cases, it=
'd be
> > > easier to start with the different attribute case first. =A0This =
case
> > > should be rare enough that we can manage to identify such callers=
 and
> > > make them use a new API as necessary. =A0If we go ahead to fail a=
ny
> > > aliased cases, it'd be challenging to manage without a regression=
 or
> > > two.
> >=20
> > From my experience on the ioremap_wc() crusade, I found that the ne=
ed for
> > aliasing with different cache types would have been needed in only =
3
> > drivers. For these 3, the atyfb driver I did the proper split in MM=
IO and
> > framebuffer, but that was significant work.=A0=A0I did this work to=
 demo and
> > document such work. It wasn't easy. For other two, ivtv and ipath w=
e left
> > as requiring "nopat" to be used. The ipath driver is on its way out=
 of
> > the kenrel now through staging, and ivtv, well I am not aware of si=
ngle
> > human being claiming to use it. The architecture of ivtv actually
> > prohibits us from ever using PAT for write-combining on the framebu=
ffer
> > as the firmware is the only one who knows the write-combining area =
and
> > hides it from us.
>=20
> At glace, there are 863 references to ioremap(), 329 references to
> ioremap_nocache(), and only 68 references to ioremap_wc() on x86. =A0=
There
> are many more ioremap callers with UC mappings than WC mappings, and =
it is
> hard to say that they never get aliased.

We need to start somewhere. If we really want to vet / white list alias=
ing
we probably will need both semantic analysis but perhaps also manual ve=
tting,
and finally a phase where we help WARN on uses we did not white-list.

> > We might be able to use tools like Coccinelle to perhaps hunt for
> > the use of aliasing on drivers with different cache attribute types
> > to do a full assessment but I really think that will be really hard
> > to accomplish.
> >=20
> > If we can learn anything from the ioremap_wc() crusade I'd say its =
that
> > the need for aliasing with different cache types obviously implies =
we
> > should disable such drivers with PAT as what we'd really need is a =
proper
> > split in maps, but history shows the split can be really hard. It s=
ounded
> > like you guys were confirming we currently do not allow for aliasin=
g with
> > different attributes on x86, is that the case for all architectures=
?
> >=20
> > If aliasing with different cache attributes is not allowed for x86 =
and
> > if its also rare for other architectures that just leaves the hunt =
for
> > valid aliasing uses. That still may be hard to hunt for, but I also
> > suspect it may be rare.
>=20
> Yes, I'd fail the different cache attribute case if we are to place m=
ore
> strict check.

OK it seems this is a good starting point. How can we get a general
architecture consensus aliasing with different cache attributes is a te=
rrible
idea ? Perhaps a patch to WARN/error out and let architectures opt in t=
o this
piece of code?

> > > I think the "set_memory_" prefix implies that their target is reg=
ular
> > > memory only.
> >=20
> > I did not find any driver using set_memory_wc() on MMIO, its a good=
 thing
> > as that does not work it seems even if it returns no error.=A0=A0I'=
m not sure
> > of the use of other set_memory_*() on MMIO but I would suspect its =
not
> > used. A manual hunt may suffice to rule these out.
>=20
> It's good to know that you did not find any case on MMIO. =A0The thin=
g is,
> set_memory_wc() actually works on MMIO today... This is because __pa(=
)
> returns a bogus address, which skips the alias check in the memtype.

Ingo, are you happy with that ? I honestly do not see the need for
use of set_memory_wc() for the cases I reviewed, I think the case for
write-combining can simply be addressed currently with ioremap_wc().

> > I guess what I'm trying to say is I am not sure we have a need for
> > set_cache_attr_*() APIs, unless of course we find such valid use.
> >=20
> > > > And at that point we could definitely argue that set_cache_attr=
_*()
> > > > APIs should probably generate a warning for _RAM_, because they
> > > > mostly make sense for MMIO type of physical addresses, right? R=
egular
> > > > RAM should always be WB.
> > > >=20
> > > > Are there cases where we change the caching attribute of RAM fo=
r
> > > > valid reasons, outside of legacy quirks?
> > >=20
> > > ati_create_page_map() is one example that it gets a RAM page
> > > by=A0__get_free_page(), and changes it to UC by calling=A0set_mem=
ory_uc().
> >=20
> > Should we instead have an API that lets it ask for RAM and of UC ty=
pe?
> > That would seem a bit cleaner. BTW do you happen to know *why* it n=
eeds
> > UC RAM types?
>=20
> This RAM page is then shared between graphic card and CPU. =A0I think=
 this is
> because graphic card cannot snoop the cache.

Was this reason alone sufficient to open such APIs broadly for RAM?

> > > > > =A0- It only supports attribute transition of {WB -> NewType =
-> WB}
> > > > > for RAM. =A0RAM is tracked differently that WB is treated as =
"no
> > > > > map". =A0So, this transition does not cause a conflict on RAM=
=2E =A0This
> > > > > will causes a conflict on MMIO when it is tracked correctly. =
=A0=A0
> > > >=20
> > > > That looks like a bug?
> > >=20
> > > This is by design since set_memory_xx was introduced for RAM only=
=2E =A0If
> > > we extend it to MMIO, then we need to change how memtype manages =
MMIO.
> >=20
> > I'd be afraid to *want* to support this on MMIO as I would only exp=
ect
> > hacks from drivers.
>=20
> Agreed, with the hope that they are not used on MMIO already...

OK we'll need to review this.

  Luis
