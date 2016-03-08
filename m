From: Ingo Molnar <mingo@kernel.org>
Subject: Re: Overlapping ioremap() calls, set_memory_*() semantics
Date: Tue, 8 Mar 2016 13:16:01 +0100
Message-ID: <20160308121601.GA6573@gmail.com>
References: <CAB=NE6VAaqshsO29nxvg-dmAiaf-tEpKwhPQHdNWkL5u8_cU7w@mail.gmail.com>
 <20160304094424.GA16228@gmail.com>
 <1457115514.15454.216.camel@hpe.com>
 <20160305114012.GA7259@gmail.com>
 <1457370228.15454.311.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38901 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932301AbcCHMQI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 8 Mar 2016 07:16:08 -0500
Content-Disposition: inline
In-Reply-To: <1457370228.15454.311.camel@hpe.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Toshi Kani <toshi.kani@hpe.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Toshi Kani <toshi.kani@hp.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Dave Airlie <airlied@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, X86 ML <x86@kernel.org>, Daniel Vetter <daniel.vetter@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>


* Toshi Kani <toshi.kani@hpe.com> wrote:

> > So where is the problem? The memtype implementation and hence most
> > ioremap() users are supposed to be safe. set_memory_*() APIs are su=
pposed
> > to be safe as well, as they too go via the memtype API.
>=20
> Let me try to summarize...
>=20
> The original issue Luis brought up was that drivers written to work w=
ith
> MTRR may create a single ioremap range covering multiple cache attrib=
utes
> since MTRR can overwrite cache attribute of a certain range. =A0Conve=
rting
> such drivers with PAT-based ioremap interfaces, i.e. ioremap_wc() and
> ioremap_nocache(), requires a separate ioremap map for each cache
> attribute, which can be challenging as it may result in overlapping i=
oremap
> ranges (in his term) with different cache attributes.
>=20
> So, Luis asked about 'sematics of overlapping ioremap()' calls. =A0He=
nce, I
> responded that aliasing mapping itself is supported, but alias with
> different cache attribute is not. =A0We have checks in place to detec=
t such
> condition. =A0Overlapping ioremap calls with a different cache attrib=
ute
> either fails or gets redirected to the existing cache attribute on x8=
6.

Ok, fair enough!

So to go back to the original suggestion from Luis, I've quoted it, but=
 with a=20
s/overlapping/aliased substitution:

> I had suggested long ago then that one possible resolution was for us=
 to add an=20
> API that *enables* aliased ioremap() calls, and only use it on select=
 locations=20
> in the kernel. This means we only have to convert a few users to that=
 call to=20
> white list such semantics, and by default we'd disable aliased calls.=
 To kick=20
> things off -- is this strategy agreeable for all other architectures?

I'd say that since the overwhelming majority of ioremap() calls are not=
 aliased,=20
ever, thus making it 'harder' to accidentally alias is probably a good =
idea.

The memtype infrastructure of phyisical memory ranges in that case acts=
 as a=20
security measure, to avoid unintended (not just physically incompatible=
) aliasing.=20
I suspect it would be helpful during driver development as well.

What extra API are you thinking about to enable aliasing in the few cas=
es where=20
it's justified?

the other problem listed:

> As another problem case, set_memor_*() will not fail on MMIO even tho=
ugh=20
> set_memor_*() is designed only for RAM.

So what does this mean exactly? Having WB caching on MMIO area is not g=
ood, but=20
UC, WC and WB sure is still sensible in some cases, right?

> [...] If the above strategy on avoiding aliasing is agreeable, could =
the next=20
> step, or an orthogonal step be to error out on set_memory_*() on IO m=
emory?

Well, do we have drivers that nevertheless change caching attributes on=
 MMIO=20
areas?

Basically if ioremap_uc() and ioremap_wc() is allowed on MMIO areas, th=
en I see no=20
reason in principle why it should be invalid to change the area from UC=
 to WC=20
after it has been ioremap()ed.

Thanks,

	Ingo
